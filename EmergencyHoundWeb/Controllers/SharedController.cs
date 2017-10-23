using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.App_Logic;

namespace EmergencyHoundWeb.Controllers
{
    public class IncidentHeaderViewModel
    {
        public Guid? IncIDX { get; set; }
        public string IncName { get; set; }
        public string IncDate { get; set; }
        public int IncStatusCount { get; set; }
        public int IncResponderCount { get; set; }
        public int IncResourceCount { get; set; }
        public string LeadResponder { get; set; }
    }

    public class NotificationHeaderViewModel
    {
        public int NotifyCount { get; set; }
        public List<T_EM_USER_NOTIFICATION> Notifications { get; set; }
    }

    public class vm_LeftMenuViewModel
    {
        public string IncCount { get; set; }
        public string ResourceCount { get; set; }
    }

    public class SharedController : Controller
    {
        public ActionResult _PartialHeadIncident()
        {
            var model = new IncidentHeaderViewModel();

            if (Session["iidx"] != null)
            {
                Guid? id = Session["iidx"].ToString().ConvertOrDefault<Guid?>();
                T_EM_INCIDENT ii = db_EmergencyHound.GetT_EM_INCIDENT(id);
                if (ii != null)
                {
                    model.IncIDX = ii.INCIDENT_IDX;
                    model.IncName = ii.INCIDENT_NAME;
                    model.IncDate = ii.INCIDENT_START_DT.ConvertOrDefault<DateTime>().ToShortDateString();
                    model.LeadResponder = db_EmergencyHound.GetT_EM_INCIDENT_TEAM_DTL_CommanderName(id);

                    //counts
                    model.IncResponderCount = db_EmergencyHound.GetT_EM_INCIDENT_TEAM_DTL_CountbyIncidentIDX(id);
                    model.IncResourceCount = db_EmergencyHound.GetT_EM_INCIDENT_RESOURCES_CountbyIncidentIDX(id);
                    model.IncStatusCount = db_EmergencyHound.GetT_EM_INCIDENT_STATUS_CountbyIncidentIDX(id);
                }
                else
                {
                    //can't find incident, so clear session and remove from user
                    int UserIDX = Utils.GetUserIDX(User);
                    db_Accounts.UpdateT_OE_USERS_CurrentIncident(UserIDX, null);
                    Session.Remove("iidx");
                }
            }

            return PartialView(model);
        }

        public ActionResult _PartialHeadNotification()
        {
            var model = new NotificationHeaderViewModel();

            int UserIDX = Utils.GetUserIDX(User);

            if (UserIDX > 0)
            {
                model.Notifications = db_EmergencyHound.GetT_EM_USER_NOTIFICATION_byUserIDX(UserIDX);
                model.NotifyCount = model.Notifications == null ? 0 : model.Notifications.Count;
            }

            return PartialView(model);
        }

        public ActionResult _LeftMenu()
        {
            var model = new vm_LeftMenuViewModel();

            int UserIDX = Utils.GetUserIDX(User);

            if (UserIDX > 0)
            {
                SP_DASHBOARD_COUNTS_Result res = db_EmergencyHound.GetSP_DASHBOARD_COUNTS(UserIDX);
                if (res != null)
                {
                    model.IncCount = res.IncidentCount.ToString();
                    model.ResourceCount = res.ResourceCount.ToString();
                }
            }

            return PartialView(model);
        }
    }
}