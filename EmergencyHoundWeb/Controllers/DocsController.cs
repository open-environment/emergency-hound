using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EmergencyHoundWeb.ViewModels;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundModel;
using System.IO;

namespace EmergencyHoundWeb.Controllers
{
    public class DocsController : Controller
    {
        // GET: Docs
        public ActionResult Index()
        {
            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
            var model = new vmDocumentListViewModel();
            model.t_em_documents = db_EmergencyHound.GetT_EM_DOCUMENTS(UserIDX);
            return View(model);
        }

        public ActionResult Edit(Guid? id)
        {
            var model = new vmDocumentEditViewModel();
            model.t_em_document = db_EmergencyHound.GetT_EM_DOCUMENTS_byIDX(id);

            //insert case
            if (model.t_em_document == null)
            {
                model.t_em_document = new EmergencyHoundModel.T_EM_DOCUMENTS();
                model.t_em_document.ACT_IND = true;
                model.t_em_document.DOC_STATUS_TYPE = "Current";
                model.t_em_document.SHARE_TYPE = "Jurisdiction";
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Edit(vmDocumentEditViewModel model, HttpPostedFileBase uploadFile)
        {
            //handling file
            byte[] fileBytes = null;

            if (uploadFile != null)
            {
                using (Stream inputStream = uploadFile.InputStream)
                {
                    MemoryStream memoryStream = inputStream as MemoryStream;
                    if (memoryStream == null)
                    {
                        memoryStream = new MemoryStream();
                        inputStream.CopyTo(memoryStream);
                    }
                    fileBytes = memoryStream.ToArray();

                    //set file name and size
                    model.t_em_document.DOC_NAME = uploadFile.FileName;
                    model.t_em_document.DOC_SIZE = uploadFile.ContentLength;
                    model.t_em_document.DOC_FILE_TYPE = uploadFile.ContentType;
                }


            }

            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;


            Guid? d = db_EmergencyHound.InsertUpdateT_EM_DOCUMENTS(model.t_em_document.DOC_IDX, model.t_em_document.ORG_IDX, fileBytes, model.t_em_document.DOC_NAME,
                model.t_em_document.DOC_TYPE, model.t_em_document.DOC_FILE_TYPE, model.t_em_document.DOC_SIZE, model.t_em_document.DOC_COMMENT, model.t_em_document.DOC_AUTHOR, model.t_em_document.SHARE_TYPE, model.t_em_document.DOC_STATUS_TYPE, true, UserIDX);
            if (d == null)
                TempData["Error"] = "Unable to upload file";
            else
                TempData["Success"] = "Upload successful";

            return RedirectToAction("Edit", "Docs", new { id = d } );
        }

        public ActionResult Download(Guid? id)
        {
            try
            {
                T_EM_DOCUMENTS doc = db_EmergencyHound.GetT_EM_DOCUMENTS_byIDX(id);
                var cd = new System.Net.Mime.ContentDisposition
                {
                    FileName = doc.DOC_NAME,
                    Inline = false
                };

                Response.AppendHeader("Content-Disposition", cd.ToString());
                if (doc.DOC_CONTENT != null)
                    return File(doc.DOC_CONTENT, doc.DOC_FILE_TYPE ?? "");
            }
            catch { }

            TempData["Error"] = "Unable to download document.";
            return RedirectToAction("Index", "Docs");
        }


        public ActionResult DeleteDoc(Guid? id)
        {
            int SuccID = db_EmergencyHound.DeleteT_EM_DOCUMENTS(id);
            if (SuccID == 1)
                TempData["Success"] = "Data sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete data.";

            return RedirectToAction("Index", "Docs");
        }
    }
}