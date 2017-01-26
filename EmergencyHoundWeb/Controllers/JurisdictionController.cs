using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EmergencyHoundWeb.ViewModels;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.App_Logic;

namespace EmergencyHoundWeb.Controllers
{
    [Authorize]
    public class JurisdictionController : Controller
    {
        // GET: /Jurisdiction/
        public ActionResult Index()
        {
            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

            var model = new vmJurisdictionListViewModel();
            model.t_oe_organizations = (User.IsInRole("Admins") ? 
                db_EmergencyHound.GetT_OE_ORGANIZATIONS() : 
                db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG(UserIDX, true) );
            return View(model);
        }


        // GET: /Jurisdiction/Edit/5
        public ActionResult Edit(Guid? id = null)
        {
            //populate view model
            var model = new vmJurisdictionEditViewModel
            {
                t_oe_organizations = db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByOrgIDX(id),
                userOrgDisplayType = db_EmergencyHound.GetT_EM_USER_ORG_ByOrgID(id.ConvertOrDefault<Guid>(), null),
                ddl_usersNotInOrg = db_EmergencyHound.GetT_EM_USER_ORG_allUsersNotInOrg(id).Select(x => new SelectListItem
                {
                    Value = x.USER_IDX.ToString(),
                    Text = x.EMAIL
                })
        };

            //add case
            if (model.t_oe_organizations == null)
            {
                model.t_oe_organizations = new T_OE_ORGANIZATIONS();
                model.t_oe_organizations.ORG_IDX = Guid.NewGuid();
                model.t_oe_organizations.ACT_IND = true;
                model.t_oe_organizations.ALLOW_JOIN_IND = true;
            }

            return View(model);
        }


        // POST: /Jurisdiction/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(T_OE_ORGANIZATIONS t_oe_organizations)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
                Guid? SuccID = db_EmergencyHound.InsertUpdateT_OE_ORGANIZATIONS(t_oe_organizations.ORG_IDX, t_oe_organizations.ORG_NAME, t_oe_organizations.ORG_DESC, t_oe_organizations.ALLOW_JOIN_IND, t_oe_organizations.ACT_IND, UserIDX);
                if (SuccID != null)
                    return RedirectToAction("Index");
                else
                {
                    ModelState.AddModelError("Error", "Unable to save record.");
                    return View();
                }
            }
            return View();
        }



        // POST: /Jurisdiction/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteJurisdiction(Guid id)
        {
            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
            Guid? SuccID = db_EmergencyHound.InsertUpdateT_OE_ORGANIZATIONS(id, null, null, null, false, UserIDX);

            if (SuccID != null)
                TempData["Success"] = "Organization has been inactivated.";
            else
                TempData["Error"] = "Unable to inactivate jurisdiction.";

            return RedirectToAction("Index");
        }


        [HttpPost]
        public ActionResult AddUserOrg(string uidx, Guid oidx, string role)
        {
            if (ModelState.IsValid)
            {
                int MyUserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                T_OE_USERS uu = db_Accounts.GetT_OE_USERSByIDX(uidx.ConvertOrDefault<int>());
                if (uu != null)
                {
                    Guid? newUserOrdID = db_EmergencyHound.InsertUpdateT_EM_USER_ORG(uidx.ConvertOrDefault<int>(), oidx, role, "A", MyUserIDX);



                    //create an INDIVIDUAL account 
                    db_EmergencyHound.InsertUpdateT_EM_INDIVIDUALS(null, oidx, uu.FNAME, null, uu.LNAME, null, uu.PHONE, uu.EMAIL, null, null, null, null, uidx.ConvertOrDefault<int>(), null, true, MyUserIDX);

                    //send out email (and notification)
                    Utils.SendEmail(null, uu.USER_ID, null, null, "Added to Jurisdiction", "You have been added to the " + "" + " jurisdiction in Emergency Hound. You can now view and enter information for this jurisdiction.", null, null, true, MyUserIDX, uidx.ConvertOrDefault<int>());

                    if (newUserOrdID != null)
                        TempData["Success"] = "Record successfully added";
                    else
                        TempData["Error"] = "Error adding user";
                }
                else
                    TempData["Error"] = "Error adding user";
            }

            return RedirectToAction("Edit", "Jurisdiction", new { id = oidx });
        }

        // POST: /Jurisdiction/DeleteUser/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteUserOrg(Guid id)
        {
            int SuccID = db_EmergencyHound.DeleteT_EM_USER_ORG(id);
            if (SuccID > 0)
                TempData["Success"] = "Organization has been inactivated.";
            else
                TempData["Error"] = "Unable to inactivate jurisdiction.";

            return RedirectToAction("Edit", new { id = id });
        }


    }
}