using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.IO;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.ViewModels;
using EmergencyHoundWeb.App_Logic;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Security.Claims;

namespace EmergencyHoundWeb.Controllers
{
    public class Account_ProfileViewModel
    {
        public int UserIDX { get; set; }
        public string UserID { get; set; }
        public string FName { get; set; }
        public string LName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string PhoneExt { get; set; }
        public bool TrackInd { get; set; }
        public HttpPostedFileBase UploadImage { get; set; }
        public byte[] GetImage { get; set; }
        public List<UserOrgDisplayType> MyOrgs { get; set; }
    }



    [AllowAnonymous]
    public class AccountController : Controller
    {
        // GET: /Account/Login
        public ActionResult Login(string returnUrl)
        {
            string UserName = User.Identity.Name;
            System.Security.Principal.IIdentity ii = User.Identity; 

            //auto pass forward to dashboard if logged in
            if (User.Identity.Name != "")
            {
                T_OE_USERS u = db_Accounts.GetT_OE_USERSByID(User.Identity.Name);
                if (u != null)
                {
                    if (u.ACT_IND == true)
                    {
                        System.Web.HttpContext.Current.Session.Add("iidx", u.CURR_INCIDENT_IDX);
                        return RedirectToAction("Index", "Dashboard");
                    }
                }
            }

            ViewBag.ReturnUrl = returnUrl;
            return View("Login", "_LayoutPub");
        }


        // POST: /Account/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model, string returnUrl)
        {
            Session.Clear();

            if (ModelState.IsValid)
            {
                if (Membership.ValidateUser(model.UserName, model.Password))
                {
                    System.Web.Security.FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);

                    T_OE_USERS u = db_Accounts.GetT_OE_USERSByID(model.UserName);
                    if (u.INITAL_PWD_FLAG)
                        return RedirectToAction("SetPermPassword");
                    else
                    {
                        db_Accounts.UpdateT_OE_USERS(u.USER_IDX, null, null, null, null, null, null, null, null, System.DateTime.Now, null, null, null, 0, null);
                        return RedirectToAction("Index", "Dashboard");
                    }

                }
            }

            // If we got this far, something failed, redisplay form
            ModelState.AddModelError("", "The user name or password provided is incorrect.");
            return View(model);
        }



        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();

            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            Request.GetOwinContext().Authentication.SignOut();

            // Invalidate the Cache on the Client Side
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            return RedirectToAction("Index", "Home");
        }

        public void SignoutCleanup(string sid)
        {
            var cp = (ClaimsPrincipal)User;
            var sidClaim = cp.FindFirst("sid");
            if (sidClaim != null && sidClaim.Value == sid)
            {
                Request.GetOwinContext().Authentication.SignOut("Cookies");
            }
        }


        // GET: /Account/Register
        public ActionResult Register()
        {
            //if using IdentityServer, then redirect to 

            var model = new vmAccountRegisterModel();
            return View("Register", "_LayoutPub", model);
        }


        // POST: /Account/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(vmAccountRegisterModel model)
        {
            if (ModelState.IsValid)
            {
                if (model != null)
                {
                    MembershipCreateStatus status;

                    try
                    {
                        //create user and send out verification email
                        Membership.Provider.CreateUser(model.UserName, "", model.UserName, null, null, false, null, out status);

                        if (status == MembershipCreateStatus.Success)
                        {
                            int UserIDX = (int)Membership.GetUser(model.UserName).ProviderUserKey;

                            //update first name, last name
                            db_Accounts.UpdateT_OE_USERS(UserIDX, null, null, model.FirstName, model.LastName, model.UserName, null, null, null, null, null, null, null, null, null);

                            //create an in-app notification
                            db_EmergencyHound.InsertUpdateT_EM_USER_NOTIFICATION(null, UserIDX, System.DateTime.Now, "EMAIL", "Welcome to Emergency Hound", "Welcome to Emergency Hound. This area displays notifications you may receive from the system or other users.", false, 0, true, 0);

                            //jurisdiction association (role=user / status=pending)
                            Guid? SuccID = null;
                            if (model.intSelOrgIDX != null)
                            {
                                SuccID = db_EmergencyHound.InsertUpdateT_EM_USER_ORG(UserIDX, model.intSelOrgIDX.ConvertOrDefault<Guid>(), "U", "P", null);

                                //notify jurisdiction admins (via email and notification)
                                if (SuccID != null)
                                {
                                    List<UserOrgDisplayType> OrgAdmins = db_EmergencyHound.GetT_EM_USER_ORG_ByOrgID(model.intSelOrgIDX.ConvertOrDefault<Guid>(), "A");
                                    foreach (UserOrgDisplayType OrgAdmin in OrgAdmins)
                                    {
                                        Utils.SendEmail(null, OrgAdmin.USER_NAME, null, null, "Someone has requested access to your Jurisdiction", "The user " + model.UserName + " has requested to join your jurisdiciton. Please go to the dashboard in Emergency Hound to approve or deny their request.", null, "", true, OrgAdmin.USER_IDX, UserIDX);
                                    }
                                }

                            }
                            else
                                TempData["Success"] = "Success";




                            //display successful registration message
                            if (SuccID != null)
                                TempData["Success"] = "Success";
                        }
                        else
                        {
                            if (status.ToString() == "DuplicateUserName")
                                TempData["Error"] = "An account has already been created with that email address. Please recover lost password.";
                            else if (status.ToString() == "InvalidEmail")
                                TempData["Error"] = "Unable to send verification email. Please try again later.";
                            else
                                TempData["Error"] = status;
                        }

                    }
                    catch (MembershipCreateUserException e)
                    {
                        ModelState.AddModelError("", ErrorCodeToString(e.StatusCode));
                    }
                }
            }


            // Redisplay form showing error or success message
            return View(model);
        }


        // GET: /Account/RegisterSuccess
        public ActionResult RegisterSuccess()
        {
            return View();
        }


        // GET: /Account/MyProfile
        public ActionResult MyProfile()
        {
            var model = new Account_ProfileViewModel();
            T_OE_USERS u = db_Accounts.GetT_OE_USERSByID(User.Identity.Name);
            if (u != null)
            {
                model.UserIDX = u.USER_IDX;
                model.UserID = u.USER_ID;
                model.FName = u.FNAME;
                model.LName = u.LNAME;
                model.Email = u.EMAIL;
                model.Phone = u.PHONE;
                model.PhoneExt = u.PHONE_EXT;
                model.TrackInd = u.TRACK_IND;
                model.GetImage = u.USER_AVATAR;

                model.MyOrgs = db_EmergencyHound.GetT_EM_USER_ORG_byUSER_IDX(u.USER_IDX);
            }

            return View(model);
        }


        // POST: /Account/MyProfile
        [HttpPost]
        public ActionResult MyProfile(Account_ProfileViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.UserIDX > 0)
                {
                    var strippedPhone = Regex.Replace(model.Phone, "[^0-9]", "");

                    db_Accounts.UpdateT_OE_USERS(model.UserIDX, null, null, model.FName, model.LName, model.Email, null, null, null, null, strippedPhone, model.PhoneExt, null, null, model.TrackInd);

                    //avatar handling
                    if (model.UploadImage != null)
                    {
                        byte[] buffer;
                        using (Stream inputStream = model.UploadImage.InputStream)
                        {
                            MemoryStream memoryStream = inputStream as MemoryStream;
                            if (memoryStream == null)
                            {
                                memoryStream = new MemoryStream();
                                inputStream.CopyTo(memoryStream);
                            }
                            buffer = memoryStream.ToArray();
                        }
                        db_Accounts.UpdateT_OE_USERS_Avatar(model.UserIDX, buffer);
                    }
                }


            }

            return RedirectToAction("MyProfile");
//            return View(model);
        }


        public ActionResult ResetPassword()
        {
            return View();
        }


        //POST: /Account/ResetPassword
        [HttpPost]
        public ActionResult ResetPassword(vmAccountLostPasswordModel model)
        {
            if (ModelState.IsValid)
            {
                MembershipUser u = Membership.GetUser(model.Email, false);
                if (u != null)
                {
                    string SuccInd = u.ResetPassword();
                    if (SuccInd.Substring(0, 5) != "Error")
                    {
                        TempData["Success"] = SuccInd;
                        return View();
                    }
                    else
                        TempData["Error"] = SuccInd;
                }
            }

            //if got this far, error
            TempData["Error"] = "Error resetting password.";
            return View();
        }


        [Authorize]
        public ActionResult SetPermPassword()
        {
            var model = new vmAccountChangePasswordModel();
            return View(model);
        }

        [Authorize]
        [HttpPost]
        public ActionResult SetPermPassword(vmAccountChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    int UserIDX = (int)Membership.GetUser().ProviderUserKey;
                    T_OE_USERS u = db_Accounts.GetT_OE_USERSByIDX(UserIDX);
                    if (u != null)
                    {
                        if (Membership.ValidateUser(u.USER_ID, model.OldPassword) == true)
                        {
                            if (Membership.Provider.ChangePassword(u.USER_ID, model.OldPassword, model.Password))
                            {
                                FormsAuthentication.SetAuthCookie(u.USER_ID, true);
                                return RedirectToAction("Index", "Dashboard");
                            }
                        }
                    }
                }
                catch { }

            }

            //if got this far, failed
            TempData["Error"] = "Change password failed.";
            return View(model);
        }



        // GET: /Account/Verify     USED TO SET PERMANENT PASSWORD
        public ActionResult Verify(string oauthcrd)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    //decrypt oauth string
                    string oauthDecode = System.Web.HttpUtility.UrlDecode(oauthcrd);
                    oauthDecode = oauthDecode.Replace(" ", "+");   //fix situations where spaces and plus get mixed up
                    string decryptStr = new SimpleAES().Decrypt(oauthDecode);

                    //split into password and username
                    string[] s = System.Text.RegularExpressions.Regex.Split(decryptStr, "\\|\\|");

                    if (Membership.ValidateUser(s[1], s[0]) == false)
                        TempData["Error"] = "Verification failed.";
                }
                catch
                {
                    TempData["Error"] = "Verification failed.";
                }
            }

            var model = new vmAccountVerifyModel
            {
                OAuth = oauthcrd
            };

            return View(model);
        }


        [HttpPost]
        public ActionResult Verify(vmAccountVerifyModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    //decrypt oauth string
                    string oauthDecode = System.Web.HttpUtility.UrlDecode(model.OAuth);
                    oauthDecode = oauthDecode.Replace(" ", "+");   //fix situations where spaces and plus get mixed up
                    string decryptStr = new SimpleAES().Decrypt(oauthDecode);

                    //split into password and username
                    string[] s = System.Text.RegularExpressions.Regex.Split(decryptStr, "\\|\\|");

                    if (Membership.ValidateUser(s[1], s[0]) == true)
                    {
                        if (Membership.Provider.ChangePassword(s[1], s[0], model.Password))
                        {
                            System.Web.Security.FormsAuthentication.SetAuthCookie(s[1], true);
                            return RedirectToAction("Index", "Dashboard");
                        }
                    }
                }
                catch { }

                TempData["Error"] = "Change password failed.";

            }
            else
                TempData["Error"] = "Change password failed.";

            return View(model);
        }


        // GET: /Account/Notifications
        [Authorize]
        public ActionResult Notifications(Guid? id)
        {
            int UserIDX = (int)Membership.GetUser(User.Identity.Name).ProviderUserKey;

            var model = new vmAccountNotificationViewModel();
            model.t_em_user_notifications = db_EmergencyHound.GetT_EM_USER_NOTIFICATION_byUserIDX(UserIDX);
            return View(model);
        }


        // POST: /Account/Delete/5
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteNotify(Guid id)
        {
            db_EmergencyHound.DeleteT_EM_USER_NOTIFICATION(id);
            return RedirectToAction("Notifications");
        }


        #region Helpers
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion

    }
}