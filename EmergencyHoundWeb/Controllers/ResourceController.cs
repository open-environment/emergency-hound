using System;
using System.Linq;
using System.Web.Mvc;
using EmergencyHoundModel;
using EmergencyHoundWeb.ViewModels;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.App_Logic;

namespace EmergencyHoundWeb.Controllers
{
    [Authorize]
    public class ResourceController : Controller
    {
        //********************************************** RESOURCE LISTING**********************************************************
        public ActionResult Index(Guid? selectOrgIDX, string selectKind, string selectStatusCd, string submitButton)
        {
            int UserIDX = Utils.GetUserIDX(User);
            string OrgName = "";
            if (selectOrgIDX != null)
            {
                T_OE_ORGANIZATIONS org = db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByOrgIDX(selectOrgIDX.ConvertOrDefault<Guid>());
                if (org != null)
                    OrgName = org.ORG_NAME;
            }

            //populate view model
            var model = new vmResourceIndexViewModel(UserIDX)
            {
                selectOrgIDX = selectOrgIDX,
                selectOrgName = OrgName,
                selectKind = selectKind,
                selectStatusCd = selectStatusCd,
                selectStatusName = selectStatusCd,
                sp_resource_adv_search = db_EmergencyHound.GetSP_RESOURCE_ADV_SEARCH(UserIDX, selectOrgIDX, "", null, null, null, null, selectKind, selectStatusCd)
            };

            if (submitButton == "Report")
                return View("Report", model);
            else
                return View(model);

        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Guid id)
        {
            int SuccID = db_EmergencyHound.DeleteT_EM_RESOURCE(id);
            if (SuccID == 1)
                TempData["Success"] = "Data sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete data.";

            return RedirectToAction("Index");
        }



        //********************************************** RESOURCE EDITING**********************************************************
        public ActionResult Add()
        {
            int UserIDX = Utils.GetUserIDX(User);
            var model = new vmResourceAddViewModel(UserIDX);
            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add(T_EM_RESOURCE t_em_resource)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = Utils.GetUserIDX(User);
                Guid? ResourceIDX = db_EmergencyHound.InsertUpdateT_EM_RESOURCE(null, t_em_resource.ORG_IDX, t_em_resource.RESOURCE_TYPE_IDX, t_em_resource.RESOURCE_COUNT, t_em_resource.RESOURCE_UNIT,
                    t_em_resource.RESOURCE_DESC, t_em_resource.RESOURCE_LAT, t_em_resource.RESOURCE_LONG, t_em_resource.SHARE_TYPE, t_em_resource.FEMA_NIMS_TYPE, t_em_resource.RESOURCE_STATUS_CD, true, UserIDX);
                if (ResourceIDX != null)
                    return RedirectToAction("Edit", "Resource", new { id = ResourceIDX });
            }

            //if got this far, something failed
            TempData["Error"] = "Unable to save record. Please correct and resubmit.";
            return View();

        }


        public ActionResult Edit(Guid? id)
        {
            int UserIDX = Utils.GetUserIDX(User);

            //populate view model
            var model = new vmResourceEditViewModel(UserIDX)
            {
                t_em_resource_ver_hist = db_EmergencyHound.GetT_EM_RESOURCE_VER_HIST_LatestByResourceIDX(id),
                sp_resource_dtl_result = db_EmergencyHound.GetSP_RESOURCE_DTL(id.ConvertOrDefault<Guid>())
            };
            
            //set resource stuff
            T_EM_RESOURCE r = db_EmergencyHound.GetT_EM_RESOURCE_ByResourceIDX(id.ConvertOrDefault<Guid>());
            if (r != null)
            {
                model.t_em_resource_RESOURCE_IDX = r.RESOURCE_IDX;
                model.t_em_resource_ORG_IDX = r.ORG_IDX;
                model.t_em_resource_RESOURCE_TYPE_IDX = r.RESOURCE_TYPE_IDX;
                model.t_em_resource_RESOURCE_COUNT = r.RESOURCE_COUNT;
                model.t_em_resource_RESOURCE_UNIT = r.RESOURCE_UNIT;
                model.t_em_resource_RESOURCE_DESC = r.RESOURCE_DESC;
                model.t_em_resource_RESOURCE_LAT = r.RESOURCE_LAT;
                model.t_em_resource_RESOURCE_LONG = r.RESOURCE_LONG;
                model.t_em_resource_SHARE_TYPE = r.SHARE_TYPE;
                model.t_em_resource_FEMA_NIMS_TYPE = r.FEMA_NIMS_TYPE;
                model.t_em_resource_RESOURCE_STATUS_CD = r.RESOURCE_STATUS_CD;
                model.t_em_resource_VERIFY_DT = r.VERIFY_DT;
                model.t_em_resource_t_em_ref_resource_type_name = r.T_EM_REF_RESOURCE_TYPE.RESOURCE_TYPE_NAME;
                model.t_em_resource_t_em_ref_resource_type_kind = r.T_EM_REF_RESOURCE_TYPE.RESOURCE_KIND;
                model.t_em_resource_t_em_ref_resource_type_category = r.T_EM_REF_RESOURCE_TYPE.RESOURCE_CATEGORY;
                model.t_em_resource_t_em_ref_resource_type_desc = r.T_EM_REF_RESOURCE_TYPE.RESOURCE_TYPE_DESC;

                //determine if user can edit
                model.canEdit = db_EmergencyHound.GetT_EM_USER_ORG_ByUserAndOrgID(model.t_em_resource_ORG_IDX, UserIDX, true);

            }



            if (model.t_em_resource_ver_hist == null)
                model.t_em_resource_ver_hist = new T_EM_RESOURCE_VER_HIST();

            if (model.t_em_resource_RESOURCE_IDX == null && id != null)
                return RedirectToAction("Index", "Resource");

            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(vmResourceEditViewModel model, string submitButton)
        {

            if (ModelState.IsValid)
            {
                Guid? ResourceIDX = model.t_em_resource_RESOURCE_IDX;
                int UserIDX = Utils.GetUserIDX(User);

                if (submitButton == "Edit")
                {
                    ResourceIDX = db_EmergencyHound.InsertUpdateT_EM_RESOURCE(model.t_em_resource_RESOURCE_IDX, model.t_em_resource_ORG_IDX, model.t_em_resource_RESOURCE_TYPE_IDX, model.t_em_resource_RESOURCE_COUNT,
                        model.t_em_resource_RESOURCE_UNIT, model.t_em_resource_RESOURCE_DESC, model.t_em_resource_RESOURCE_LAT, model.t_em_resource_RESOURCE_LONG, model.t_em_resource_SHARE_TYPE,
                        model.t_em_resource_FEMA_NIMS_TYPE, model.t_em_resource_RESOURCE_STATUS_CD, true, UserIDX);

                    if (ResourceIDX != null)
                    {
                        if (model.sp_resource_dtl_result != null)
                        {
                            for (int i = 0; i < model.sp_resource_dtl_result.Count(); i++)
                            {
                                db_EmergencyHound.InsertUpdateT_EM_RESOURCE_DTL(model.sp_resource_dtl_result[i].RESOURCE_DTL_IDX, ResourceIDX, model.sp_resource_dtl_result[i].RESOURCE_TYPE_DTL_IDX,
                                    model.sp_resource_dtl_result[i].VALUE, UserIDX);
                            }
                        }

                        TempData["Success"] = "Data Saved.";
                    }
                    else 
                        TempData["Error"] = "Data Not Saved.";
                }
                else if (submitButton == "Verify")
                {
                    Guid? verIDX = db_EmergencyHound.InsertUpdateT_EM_RESOURCE_VER_HIST(null, model.t_em_resource_RESOURCE_IDX, System.DateTime.Now, UserIDX, true, UserIDX);
                    if (verIDX != null)
                        TempData["Success"] = "Verification Saved.";
                    else
                        TempData["Error"] = "Unable to save verification.";
                }

                return RedirectToAction("Edit", "Resource", new { id = ResourceIDX });
            }
            else
                return View(model);

        }



        //********************************************** RESOURCE VERIFICATION**********************************************************
        public ActionResult VerificationHistory(Guid? id)
        {
            //validation
            if (id == null)
                return RedirectToAction("Index", "Resource");


            //populate view model
            var model = new vmResourceVerificationHistoryViewModel
            {
                ResourceIDX = id,
                t_em_resource_ver_hist = db_EmergencyHound.GetT_EM_RESOURCE_VER_HIST_ByResourceIDX(id.ConvertOrDefault<Guid>())
            };

            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteVerification(Guid id)
        {
            int SuccID = db_EmergencyHound.DeleteT_EM_RESOURCE_VER_HIST(id);
            if (SuccID == 1)
                TempData["Success"] = "Data sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete data.";

            return RedirectToAction("VerificationHistory", new { id = id });
        }



        //********************************************** RESOURCE TYPES **********************************************************
        public ActionResult ResourceType(Guid? orgID)
        {
            int UserIDX = Utils.GetUserIDX(User);

            var model = new vmResourceTypeListViewModel
            {
                t_em_ref_resource_types = db_Ref.GetT_EM_REF_RESOURCE_TYPE_byUserIDX(UserIDX)
            };

            return View(model);
        }

        public ActionResult ResourceTypeEdit(Guid? id)
        {
            int UserIDX = Utils.GetUserIDX(User);
            var model = new vmResourceTypeEditViewModel(UserIDX);

            model.t_em_ref_resource_type = db_Ref.GetT_EM_REF_RESOURCE_TYPE_byIDX(id);
            if (model.t_em_ref_resource_type != null)
                model.t_em_ref_resource_type_dtl = db_Ref.GetT_EM_REF_RESOURCE_TYPE_DTL_byTypeIDX(id);

            //add new resource type case
            if (model.t_em_ref_resource_type == null)
            {
                model.t_em_ref_resource_type = new T_EM_REF_RESOURCE_TYPE();
                model.t_em_ref_resource_type.RESOURCE_TYPE_IDX = Guid.NewGuid();
            }
            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResourceTypeEdit(vmResourceTypeEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = Utils.GetUserIDX(User);

                Guid? ResourceTypeIDX = db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE(model.t_em_ref_resource_type.RESOURCE_TYPE_IDX, model.t_em_ref_resource_type.RESOURCE_FEMA_ID,
                    model.t_em_ref_resource_type.RESOURCE_TYPE_NAME, model.t_em_ref_resource_type.RESOURCE_TYPE_DESC, model.t_em_ref_resource_type.RESOURCE_FUNCTION,
                    model.t_em_ref_resource_type.RESOURCE_CATEGORY, model.t_em_ref_resource_type.RESOURCE_KIND, null, model.t_em_ref_resource_type.RESOURCE_CORE_CAP,
                    model.t_em_ref_resource_type.RESOURCE_ORDERING_INST, 0, model.t_em_ref_resource_type.ORG_IDX, true, UserIDX);

                if (ResourceTypeIDX != null)
                    TempData["Success"] = "Data Saved.";
                else
                    TempData["Error"] = "Unable to save data.";

                return RedirectToAction("ResourceTypeEdit", "Resource", new { id = ResourceTypeIDX });
            }
            else
                return View(model);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResourceTypeDelete(Guid id)
        {
            int UserIDX = Utils.GetUserIDX(User);

            int SuccID = db_Ref.DeleteT_EM_REF_RESOURCE_TYPE(id, UserIDX);
            if (SuccID == 1)
                TempData["Success"] = "Data sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete data.";

            return RedirectToAction("ResourceType");
        }

        [HttpPost]
        public ActionResult ResourceTypeDtl(vmResourceTypeEditViewModel model)
        {
            int UserIDX = Utils.GetUserIDX(User);
            int PropCount = db_Ref.GetT_EM_REF_RESOURCE_TYPE_DTL_CountbyTypeIDX(model.t_em_ref_resource_type.RESOURCE_TYPE_IDX);

            //set new Guid
            if (model.newResourceTypeDtl.RESOURCE_TYPE_DTL_IDX == Guid.Empty)
                model.newResourceTypeDtl.RESOURCE_TYPE_DTL_IDX = Guid.NewGuid();

            Guid? ResourceTypeDtlIDX = db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL(model.newResourceTypeDtl.RESOURCE_TYPE_DTL_IDX,
                model.t_em_ref_resource_type.RESOURCE_TYPE_IDX, model.newResourceTypeDtl.COMPONENT, model.newResourceTypeDtl.METRIC,
                model.newResourceTypeDtl.CAPABILITY, model.newResourceTypeDtl.COMMENTS, PropCount + 1, UserIDX, true);

            if (ResourceTypeDtlIDX != null)
                TempData["Success"] = "Data Saved.";
            else
                TempData["Error"] = "Unable to save data.";

            return RedirectToAction("ResourceTypeEdit", "Resource", new { id = model.t_em_ref_resource_type.RESOURCE_TYPE_IDX });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResourceTypeDtlDelete(Guid id)
        {
            int UserIDX = Utils.GetUserIDX(User);

            int SuccID = db_Ref.DeleteT_EM_REF_RESOURCE_TYPE_DTL(id, UserIDX);
            if (SuccID == 1)
                TempData["Success"] = "Data sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete data.";

            return RedirectToAction("ResourceTypeEdit", new { id = id});
        }




        //********************************************** PEOPLE  **********************************************************
        public ActionResult People(string selectName, string selectQual, string submitButton)
        {
            int UserIDX = Utils.GetUserIDX(User);

            var model = new vmIndividualListViewModel(UserIDX) {
                t_em_individuals = db_EmergencyHound.GetT_EM_INDIVIDUALS_ByUserIDX(UserIDX, selectName, selectQual),
                selectName = selectName,
                selectQual = selectQual
            };


            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteIndividual(Guid id)
        {
            int UserIDX = Utils.GetUserIDX(User);
            Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_INDIVIDUALS(id, null, null, null, null, null, null, null, null, null, null, null, null, null, false, UserIDX);

            if (SuccID != null)
                TempData["Success"] = "Person sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete person.";

            return RedirectToAction("People", new { id = id });
        }


        public ActionResult PeopleEdit(Guid? id)
        {
            int UserIDX = Utils.GetUserIDX(User);

            var model = new vmIndividualEditViewModel(UserIDX)
            {
                t_em_individual = db_EmergencyHound.GetT_EM_INDIVIDUAL_ByID(id),
                t_em_qualifications = db_EmergencyHound.GetT_EM_QUALIFICATIONS_ByIndividualIDX(id)

            };

            if (model.t_em_individual == null)
            {
                model.t_em_individual = new T_EM_INDIVIDUALS();
                model.t_em_individual.INDIVIDUAL_IDX = Guid.NewGuid();
            }

            model.new_t_em_qualifications.INDIVIDUAL_IDX = model.t_em_individual.INDIVIDUAL_IDX;
            return View(model);

        }


        [HttpPost]
        public ActionResult PeopleEdit(vmIndividualEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = Utils.GetUserIDX(User);

                Guid? IndividualIDX = db_EmergencyHound.InsertUpdateT_EM_INDIVIDUALS(model.t_em_individual.INDIVIDUAL_IDX, model.t_em_individual.ORG_IDX,
                    model.t_em_individual.INDV_FIRST_NAME, model.t_em_individual.INDV_MID_NAME, model.t_em_individual.INDV_LAST_NAME, model.t_em_individual.INDV_DOB,
                    model.t_em_individual.INDV_PHONE, model.t_em_individual.INDV_EMAIL, model.t_em_individual.ADD_LINE_ADR, model.t_em_individual.ADD_CITY,
                    model.t_em_individual.ADD_STATE, model.t_em_individual.ADD_ZIP, null, model.t_em_individual.INDV_AFFILIATION, true, UserIDX);

                if (IndividualIDX != null)
                    TempData["Success"] = "Data Saved.";
                else
                    TempData["Error"] = "Unable to save data.";

                return RedirectToAction("PeopleEdit", "Resource", new { id = IndividualIDX });
            }
            else
                return View(model);

        }


        //********************************************** QUALIFICATONS  **********************************************************
        [HttpPost]
        public ActionResult PersonQualEdit(vmIndividualEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = Utils.GetUserIDX(User);

                Guid? QualIDX = db_EmergencyHound.InsertUpdateT_EM_QUALIFICATIONS(model.new_t_em_qualifications.QUALIFICATION_IDX, model.t_em_individual.ORG_IDX, 
                    model.new_t_em_qualifications.INDIVIDUAL_IDX, model.new_t_em_qualifications.QUAL_TYPE_IDX, model.new_t_em_qualifications.EFF_DATE, model.new_t_em_qualifications.EXP_DATE, true, UserIDX);

                if (QualIDX != null)
                    TempData["Success"] = "Data Saved.";
                else
                    TempData["Error"] = "Unable to save data.";

                return RedirectToAction("PeopleEdit", "Resource", new { id = model.new_t_em_qualifications.INDIVIDUAL_IDX });

            }
            else
                return RedirectToAction("People", "Resource");
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PeopleQualDelete(Guid id)
        {
            int UserIDX = Utils.GetUserIDX(User);
            int SuccID = db_EmergencyHound.DeleteT_EM_QUALIFICATIONS(id);
            if (SuccID > 0)
                TempData["Success"] = "Person sucessfully deleted.";
            else
                TempData["Error"] = "Unable to delete person.";

            return RedirectToAction("PeopleEdit", new { id = id });
        }

    }
}