using System;
using System.Web.Mvc;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.ViewModels;
using EmergencyHoundWeb.App_Logic;
using EmergencyHoundModel;

namespace EmergencyHoundWeb.Controllers
{
    public class DashboardController : Controller
    {
        // GET: /Dashboard/
        [FilterConfig.SessionExpireFilter]
        [Authorize]
        public ActionResult Index(string m)
        {
            int UserIDX = Utils.GetUserIDX(User);

            var model = new vmDashboardViewModel
            {
                PendingUsers = (User.IsInRole("Admins")) ? db_EmergencyHound.GetAllPendingUsers() : db_EmergencyHound.GetMyPendingUsers(UserIDX),
                DashboardCounts = db_EmergencyHound.GetSP_DASHBOARD_COUNTS(UserIDX)
            };

            if (m == "r")
                model.sp_resource_adv_search = db_EmergencyHound.GetSP_RESOURCE_ADV_SEARCH(UserIDX, null, null, null, null, null, null, null, "A");
            else
                model.t_em_incident = db_EmergencyHound.GetSP_INCIDENT_ADV_SEARCH(UserIDX, null);

            model.MapType = m == "r" ? "r" : "i";

            //timeline (may remove)
            if (Session["iidx"].ConvertOrDefault<Guid?>() != null)
                model.v_em_timeline = db_EmergencyHound.GetV_EM_TIMELINE_ByIncident(Session["iidx"].ConvertOrDefault<Guid?>().ToGuid());

            return View(model);
        }


        [HttpPost]
        public ActionResult AllowJuris(int uidx, Guid oidx, string role)
        {
            int MyUserIDX = Utils.GetUserIDX(User);

            T_OE_USERS uu = db_Accounts.GetT_OE_USERSByIDX(uidx);
            if (uu != null)
            {
                //approve association (and set role)
                db_EmergencyHound.InsertUpdateT_EM_USER_ORG(uidx, oidx, role != null ? role : "U", "A", MyUserIDX);

                //create an INDIVIDUAL account 
                db_EmergencyHound.InsertUpdateT_EM_INDIVIDUALS(null, oidx, uu.FNAME, null, uu.LNAME,
                    null, uu.PHONE, uu.EMAIL, null, null, null, null, uidx, null, true, MyUserIDX);

                //send out email (and notification)
                Utils.SendEmail(null, uu.USER_ID, null, null, "Request Approved", "Your request to join the " + "" + " jurisdiction in Emergency Hound has been approved. You can now view and enter information for this jurisdiction.", null, null, true, MyUserIDX, uidx);
            }

            return RedirectToAction("Index", "Dashboard");

        }


        public ActionResult RejectJuris(int uidx, Guid oidx)
        {

            int MyUserIDX = Utils.GetUserIDX(User);

            T_OE_USERS uu = db_Accounts.GetT_OE_USERSByIDX(uidx);
            if (uu != null)
            {
                //reject association
                db_EmergencyHound.InsertUpdateT_EM_USER_ORG(uidx, oidx, null, "R", MyUserIDX);

                //send out email (and notification)
                Utils.SendEmail(null, uu.USER_ID, null, null, "Request Rejected", "Your request to join the " + "" + " jurisdiction in Emergency Hound has been rejected.", null, null, true, MyUserIDX, uidx);
            }

            return RedirectToAction("Index", "Dashboard");
        }


        [HttpPost]
        public ActionResult Feedback(string name, string message, string email)
        {
            Utils.SendEmail(null, "doug.timms@open-environment.org", null, null, name, message, null, null);

            return View();

        }


    }
}