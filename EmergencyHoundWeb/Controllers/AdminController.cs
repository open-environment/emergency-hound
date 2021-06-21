using System.Linq;
using System.Web.Mvc;
using EmergencyHoundWeb.App_Logic;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.ViewModels;

namespace EmergencyHoundWeb.Controllers
{
    [Authorize(Roles = "Admins")]
    public class AdminController : Controller
    {
        //************************************* USERS ************************************************************
        // GET: /Admin/Users
        public ActionResult Users()
        {
            return View(db_Accounts.GetT_OE_USERS());
        }

        public ActionResult UserEdit()
        {
            return View();
        }


        // POST: /Admin/DeleteUser/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteUser(int? id)
        {
            db_Accounts.DeleteT_OE_USERS(id ?? -1);
            return RedirectToAction("Users");
        }


        //************************************* ROLES ************************************************************
        // GET: /Admin/Roles
        public ActionResult Roles()
        {
            return View(db_Accounts.GetT_OE_ROLES());
        }


        public ActionResult RoleEdit(int id)
        {
            var model = new vmAdminRoleEditViewModel
            {
                T_OE_ROLES = db_Accounts.GetT_OE_ROLEByIDX(id),
                Users_In_Role = db_Accounts.GetT_OE_USERSInRole(id).Select(x => new SelectListItem
                {
                    Value = x.USER_IDX.ToString(),
                    Text = x.USER_ID
                }),
                Users_Not_In_Role = db_Accounts.GetT_OE_USERSNotInRole(id).Select(x => new SelectListItem
                {
                    Value = x.USER_IDX.ToString(),
                    Text = x.USER_ID
                })
            };
            return View(model);
        }


        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult RoleEdit(vmAdminRoleEditViewModel model, string submitButton)
        {
            int SuccID = 0;
            int UserIDX = Utils.GetUserIDX(User);

            // UPDATING ROLE
            if (submitButton == "Edit")
            {
                SuccID = db_Accounts.UpdateT_OE_ROLE(model.T_OE_ROLES.ROLE_IDX, model.T_OE_ROLES.ROLE_NAME, model.T_OE_ROLES.ROLE_DESC, UserIDX);
                if (SuccID > 0)
                {
                    TempData["RoleEdit_Success"] = "Update successful.";
                    return RedirectToAction("RoleEdit", new { id = SuccID });
                }
                else
                {
                    TempData["RoleEdit_Error"] = "Error updating data.";
                    return View(model);
                }
            }
            // ADDING USER TO ROLE
            else if (submitButton == "Add")
            {
                foreach (string u in model.Users_Not_In_Role_Selected)
                {
                    SuccID = db_Accounts.CreateT_OE_USER_ROLE(model.T_OE_ROLES.ROLE_IDX, u.ConvertOrDefault<int>(), UserIDX);
                }

                if (SuccID > 0)
                    TempData["Success"] = "Update successful.";

                //return View(model);
                return RedirectToAction("RoleEdit", new { id = model.T_OE_ROLES.ROLE_IDX });

            }
            // REMOVE USER FROM ROLE
            else if (submitButton == "Remove")
            {
                foreach (string u in model.Users_In_Role_Selected)
                {
                    SuccID = db_Accounts.DeleteT_OE_USER_ROLE(u.ConvertOrDefault<int>(), model.T_OE_ROLES.ROLE_IDX);
                }

                if (SuccID > 0)
                    TempData["Success"] = "Update successful.";

                return RedirectToAction("RoleEdit", new { id = model.T_OE_ROLES.ROLE_IDX });
            }
            else
                return View(model);
        }


        // POST: /Admin/DeleteRole/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteRole(int id)
        {
            db_Accounts.DeleteT_OE_ROLE(id);
            return RedirectToAction("Roles");
        }


        //************************************* SETTINGS ************************************************************

        public ActionResult Settings()
        {
            var model = new vmAdminSettingsViewModel();
            return View(model);
        }

        [HttpPost]
        public ActionResult Settings(vmAdminSettingsViewModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = Utils.GetUserIDX(User);

                int SuccID = db_Ref.InsertUpdateT_OE_APP_SETTING(model.edit_app_setting.SETTING_IDX, model.edit_app_setting.SETTING_NAME, model.edit_app_setting.SETTING_VALUE, false, null, UserIDX);
                if (SuccID > 0)
                    TempData["Success"] = "Data Saved.";
                else
                    TempData["Error"] = "Data Not Saved.";
            }

            return RedirectToAction("Settings", "Admin");
        }

        // GET: /Admin/Tasks
        public ActionResult Tasks()
        {
            return View();
        }

        // GET: /Admin/TaskPullFromRTLT
        public ActionResult TaskPullFromRTLT()
        {
            int SuccID = RTLT.CallRTLTService();
            if (SuccID == 0)
                TempData["Error"] = "Unable to pull data from RTLT service.";
            else
                TempData["Success"] = "Data successfully pulled.";
            return RedirectToAction("Tasks", "Admin");
        }


    }
}