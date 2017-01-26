using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.App_Logic;
using EmergencyHoundWeb.ViewModels;
using System.IO;
using System.Data.Entity;


namespace EmergencyHoundWeb.Controllers
{
    [Authorize]
    public class IncidentController : Controller
    {
        public ActionResult Index(Guid? selectOrgIDX, string submitButton)
        {
            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
            string OrgName = "";
            if (selectOrgIDX != null)
            {
                T_OE_ORGANIZATIONS org = db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByOrgIDX(selectOrgIDX.ConvertOrDefault<Guid>());
                if (org != null)
                    OrgName = org.ORG_NAME;
            }

            //populate view model
            var model = new vmIncidentIndexViewModel
            {
                selectOrgIDX = selectOrgIDX,
                selectOrgName = OrgName,
                t_em_incident = db_EmergencyHound.GetSP_INCIDENT_ADV_SEARCH(UserIDX, selectOrgIDX)
            };

            if (submitButton == "Report")
                return View("RptList", model);
            else
                return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Guid? id)
        {
            int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

            //make inactive
            Guid? SuccIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT(id, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,
                null, null, null, null, false, UserIDX, null, null);

            if (SuccIDX != null)
                TempData["Success"] = "Deleted successfully.";
            else
                TempData["Error"] = "Unable to delete incident.";

            return RedirectToAction("Index");
        }


        public ActionResult Create()
        {
            //populate view model
            var model = new vmIncidentEditViewModel
            {
                t_em_incident = new T_EM_INCIDENT()
            };

            model.t_em_incident.INCIDENT_IDX = Guid.NewGuid();

            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(vmIncidentEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_INCIDENT(null, model.t_em_incident.ORG_IDX, model.t_em_incident.INCIDENT_ID, model.t_em_incident.INCIDENT_NAME,
                    model.t_em_incident.INCIDENT_DESC, model.t_em_incident.INC_MANAGEMENT_ORG_CD, model.t_em_incident.INCIDENT_START_DT, model.t_em_incident.INCIDENT_END_DT,
                    model.t_em_incident.INCIDENT_COMPLEX_LVL, null, null, null, null, null, null, null, null, null, null, null, null, null, null, true, UserIDX, model.t_em_incident.SHARE_TYPE, model.t_em_incident.INCIDENT_PRIORITY);

                if (SuccID != null)
                    return RedirectToAction("Edit", new { id = SuccID });
            }

            //if got this far, there is an error
            TempData["Error"] = "Unable to create incident.";
            return View(model);
        }


        public ActionResult Edit(Guid? id, int? CurrTab)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("Edit", "Incident", new { id = id });
            }


            if (id != null)
            {
                //set session and save current incident
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
                Session["iidx"] = id.ToString();
                db_Accounts.UpdateT_OE_USERS_CurrentIncident(UserIDX, id);

                //populate view model
                var model = new vmIncidentEditViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(id)
                };

                if (model.t_em_incident == null)
                    return RedirectToAction("Index", "Incident");

                return View(model);
            }
            else
                return RedirectToAction("Index", "Dashboard");


        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(vmIncidentEditViewModel model, string submitButton)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                Guid? SuccIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT(model.t_em_incident.INCIDENT_IDX, model.t_em_incident.ORG_IDX, model.t_em_incident.INCIDENT_ID,
                    model.t_em_incident.INCIDENT_NAME, model.t_em_incident.INCIDENT_DESC, model.t_em_incident.INC_MANAGEMENT_ORG_CD, model.t_em_incident.INCIDENT_START_DT,
                    model.t_em_incident.INCIDENT_END_DT, model.t_em_incident.INCIDENT_COMPLEX_LVL, model.t_em_incident.INCIDENT_LOC_DESC, model.t_em_incident.INCIDENT_LAT,
                    model.t_em_incident.INCIDENT_LONG, model.t_em_incident.INCIDENT_STATE, model.t_em_incident.INCIDENT_CNTY, model.t_em_incident.INCIDENT_CITY,
                    model.t_em_incident.INCIDENT_LAND_SURVEY, model.t_em_incident.INCIDENT_SIZE, model.t_em_incident.INCIDENT_SIZE_UNIT, model.t_em_incident.INCIDENT_PCT_CONTAINED,
                    model.t_em_incident.INCIDENT_HAZ_MAT, model.t_em_incident.INCIDENT_WEATHER, model.t_em_incident.INCIDENT_COSTS,
                    model.t_em_incident.INCIDENT_TOTAL_COSTS, true, UserIDX, model.t_em_incident.SHARE_TYPE, model.t_em_incident.INCIDENT_PRIORITY);

                if (SuccIDX != null)
                {
                    if (submitButton == "Save")
                    {
                        TempData["Success"] = "Saved successfully.";
                        return RedirectToAction("Edit", new { id = model.t_em_incident.INCIDENT_IDX });
                    }
                    else if (submitButton == "Continue")
                        return RedirectToAction("Map", new { id = model.t_em_incident.INCIDENT_IDX });
                }
            }

            TempData["Error"] = "Unable to save data.";                 
            return View(model);
        }


        public ActionResult Map(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("Map", "Incident", new { id = id });
            }

            if (id != null)
            {
                Session["iidx"] = id.ToString();

                //populate view model
                var model = new vmIncidentMapViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(id),
                    ImpactedArea = db_EmergencyHound.GetT_EM_INCIDENT_LOC_AREA_byIncidentAndType(id, "Impacted Area"),
                    ThreatenedArea = db_EmergencyHound.GetT_EM_INCIDENT_LOC_AREA_byIncidentAndType(id, "Threatened Area")
                };

                if (model.t_em_incident == null)
                    return RedirectToAction("Index", "Incident");

                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");

        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Map(vmIncidentMapViewModel model, string submitButton)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                //update incident
                Guid? SuccIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT(model.t_em_incident.INCIDENT_IDX, null, model.t_em_incident.INCIDENT_ID,
                    null, null, null, null, null, null, model.t_em_incident.INCIDENT_LOC_DESC, model.t_em_incident.INCIDENT_LAT,
                    model.t_em_incident.INCIDENT_LONG, model.t_em_incident.INCIDENT_STATE, model.t_em_incident.INCIDENT_CNTY, model.t_em_incident.INCIDENT_CITY,
                    model.t_em_incident.INCIDENT_LAND_SURVEY, model.t_em_incident.INCIDENT_SIZE, model.t_em_incident.INCIDENT_SIZE_UNIT, model.t_em_incident.INCIDENT_PCT_CONTAINED,
                    model.t_em_incident.INCIDENT_HAZ_MAT, null, null, null, true, UserIDX, null, null);

                //update Impacted Area
                if (model.ImpactedArea != null)
                    if (model.ImpactedArea.Length > 0)
                    SuccIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_LOC_AREA(null, model.t_em_incident.INCIDENT_IDX, "Impacted Area", model.ImpactedArea, true, UserIDX);

                //update Threatened Area
                if (model.ThreatenedArea != null)
                    if (model.ThreatenedArea.Length > 0)
                        SuccIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_LOC_AREA(null, model.t_em_incident.INCIDENT_IDX, "Threatened Area", model.ThreatenedArea, true, UserIDX);


                if (SuccIDX != null)
                {
                    if (submitButton == "Save")
                        return RedirectToAction("Map", new { id = model.t_em_incident.INCIDENT_IDX });
                    else if (submitButton == "Continue")
                        return RedirectToAction("Team", new { id = model.t_em_incident.INCIDENT_IDX });
                    else if (submitButton == "Continue")
                        return RedirectToAction("Map", new { id = model.t_em_incident.INCIDENT_IDX });
                    else if (submitButton == "Team")
                        return RedirectToAction("Team", new { id = model.t_em_incident.INCIDENT_IDX });
                    else if (submitButton == "Status")
                        return RedirectToAction("Status", new { id = model.t_em_incident.INCIDENT_IDX });
                    else if (submitButton == "OpPeriods")
                        return RedirectToAction("OpPeriods", new { id = model.t_em_incident.INCIDENT_IDX });
                }
            }

            TempData["Error"] = "Unable to save data.";
            return View(model);
        }


        public ActionResult Team(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("Team", "Incident", new { id = id });
            }

            if (id != null)
            {
                //populate view model
                var model = new vmIncidentTeamModel
                {
                    IncidentIDX = id.ConvertOrDefault<Guid>(),
                    IncidentTeam = db_EmergencyHound.GetV_EM_INCIDENT_TEAM_DISPLAY_byIncidentIDX(id),
                };

                if (model.IncidentTeam != null)
                    model.ddl_ReportsTo = model.IncidentTeam.Select(x => new SelectListItem
                    {
                        Value = x.INCIDENT_TEAM_DTL_IDX.ToString(),
                        Text = x.INDIVIDUAL_IDX != null ? x.INDV_FIRST_NAME + " " + x.INDV_LAST_NAME + " (" + x.ROLE_NAME + ")" : x.RESOURCE_IDX != null ? x.RESOURCE_TYPE_NAME : x.ROLE_NAME
                    });

                return View(model);
            }
            else
                return RedirectToAction("Index", "Dashboard");

        }


        [HttpPost]
        public ActionResult Team1(vmIncidentTeamModel model)
        {
            if (ModelState.IsValid)
            {
                //************* validation ***************************
                if (model.IncidentCommander == null || model.TeamType == null)
                {
                    TempData["Error"] = "You must supply all required information";
                    return RedirectToAction("Team", "Incident", new { id = model.IncidentIDX });
                }

                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                // ************* initialize the team scenario **********************************
                if (model.TeamType != null && model.IncidentTeam == null)
                {
                    //TYPE 5
                    Guid? IncCommanderIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, null, model.IncidentCommander, null, "Incident Commander", null, 1, null, null, null, true, UserIDX);

                    if (IncCommanderIDX == null)
                        TempData["Error"] = "Unable to save team";

                    //TYPE 4
                    if (model.TeamType == "Type 4")
                    {
                        db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Specify Role", null, 1, null, null, null, true, UserIDX);
                        db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Specify Role", null, 2, null, null, null, true, UserIDX);
                    }

                    //TYPE 3
                    if (model.TeamType == "Type 3")
                    {
                        Guid? opIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Operations Section", null, 1, null, null, null, true, UserIDX);
                        Guid? planIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Planning Section", null, 2, null, null, null, true, UserIDX);
                        Guid? LogIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Logistics Section", null, 3, null, null, null, true, UserIDX);
                        Guid? FinIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Finance/Admin Section", null, 4, null, null, null, true, UserIDX);
                        Guid? safIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Safety Officer", null, 5, null, null, null, true, UserIDX);
                        Guid? LiaIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Liaison Officer", null, 6, null, null, null, true, UserIDX);
                        Guid? InfoIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Public Info Officer", null, 7, null, null, null, true, UserIDX);

                        Guid? opIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, opIDX, null, null, "Operations Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? opIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, opIDX, null, null, "Operations Unit B", null, 2, null, null, null, true, UserIDX);

                        Guid? planIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, planIDX, null, null, "Planning Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? planIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, planIDX, null, null, "Planning Unit B", null, 2, null, null, null, true, UserIDX);

                        Guid? logIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, LogIDX, null, null, "Logistics Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? logIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, LogIDX, null, null, "Logistics Unit B", null, 2, null, null, null, true, UserIDX);

                    }

                    //TYPE 3
                    if (model.TeamType == "Type 2")
                    {
                        Guid? opIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Operations Section", null, 1, null, null, null, true, UserIDX);
                        Guid? planIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Planning Section", null, 2, null, null, null, true, UserIDX);
                        Guid? LogIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Logistics Section", null, 3, null, null, null, true, UserIDX);
                        Guid? FinIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Finance/Admin Section", null, 4, null, null, null, true, UserIDX);
                        Guid? safIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Safety Officer", null, 5, null, null, null, true, UserIDX);
                        Guid? LiaIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Liaison Officer", null, 6, null, null, null, true, UserIDX);
                        Guid? InfoIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, IncCommanderIDX, null, null, "Public Info Officer", null, 7, null, null, null, true, UserIDX);

                        Guid? opIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, opIDX, null, null, "Operations Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? opIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, opIDX, null, null, "Operations Unit B", null, 2, null, null, null, true, UserIDX);

                        Guid? planIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, planIDX, null, null, "Planning Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? planIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, planIDX, null, null, "Planning Unit B", null, 2, null, null, null, true, UserIDX);

                        Guid? logIDX_1 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, LogIDX, null, null, "Logistics Unit A", null, 1, null, null, null, true, UserIDX);
                        Guid? logIDX_2 = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(null, null, model.IncidentIDX, LogIDX, null, null, "Logistics Unit B", null, 2, null, null, null, true, UserIDX);
                    }



                    return RedirectToAction("Team", "Incident", new { id = model.IncidentIDX });
                }
            }


            return RedirectToAction("Team", "Incident", new { id = model.IncidentIDX });

        }


        [HttpPost]
        public ActionResult Team(vmIncidentTeamModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.editTeamMember != null)
                {
                    int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                    Guid? EditTeamDtlIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_TEAM_DTL(model.editTeamMember.INCIDENT_TEAM_DTL_IDX, null, model.IncidentIDX,
                        model.editTeamMember.REPORTS_TO_TEAM_DTL_IDX, model.editTeamMember.INDIVIDUAL_IDX, model.editTeamMember.RESOURCE_IDX,
                        model.editTeamMember.ROLE_NAME, model.editTeamMember.AGENCY, 1, model.editTeamMember.TRAINEE_IND, model.editTeamMember.CONTACT_TYPE,
                        model.editTeamMember.CONTACT_INFO, true, UserIDX);

                    if (EditTeamDtlIDX != null)
                    {
                        TempData["Success"] = "Data saved";
                        return RedirectToAction("Team", "Incident", new { id = model.IncidentIDX });
                    }
                }
            }

            //if got this far, something went wrong
            TempData["Error"] = "Unable to save data";
            return RedirectToAction("Team", "Incident", new { id = model.IncidentIDX });
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteTeamDtl(Guid? id)
        {
            //delete
            int SuccIDX = db_EmergencyHound.DeleteT_EM_INCIDENT_TEAM_DTL(id.ConvertOrDefault<Guid>());

            if (SuccIDX > 0)
            {
                TempData["Success"] = "Deleted successfully.";
                ModelState.Clear();
            }
            else
                TempData["Error"] = "Unable to delete incident.";

            return RedirectToAction("Team", "Incident");
        }



        public ActionResult IncResource(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("IncResource", "Incident", new { id = id });
            }

            T_EM_INCIDENT ii = db_EmergencyHound.GetT_EM_INCIDENT(id);
            if (ii != null)
            {
                int userIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                var model = new vmIncidentResourceModel();
                model.incident_idx = id;
                model.newIncidentResource.INCIDENT_IDX = id.ConvertOrDefault<Guid>();
                model.t_em_incident_resources = db_EmergencyHound.GetT_EM_INCIDENT_RESOURCES_byIncidentIDX(id);
                model.ddl_Resource = db_EmergencyHound.GetSP_RESOURCE_ADV_SEARCH(userIDX, ii.ORG_IDX, null, null, null, null, null, null, null).Select(x => new SelectListItem
                {
                    Value = x.RESOURCE_IDX.ToString(),
                    Text = x.RESOURCE_TYPE_NAME + (x.RESOURCE_DESC != null ? " (" + x.RESOURCE_DESC + ")" : "")
                }); 


                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");
        }


        [HttpPost]
        public ActionResult IncResource(vmIncidentResourceModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                db_EmergencyHound.InsertUpdateT_EM_INCIDENT_RESOURCES(model.newIncidentResource.INCIDENT_RESOURCE_IDX, model.newIncidentResource.INCIDENT_IDX,
                    model.newIncidentResource.RESOURCE_IDX, model.newIncidentResource.RESOURCE_COUNT, model.newIncidentResource.RESOURCE_ORDERED_DT, model.newIncidentResource.RESOURCE_ETA_DT,
                    model.newIncidentResource.RESOURCE_ARRIVED_IND, model.newIncidentResource.RESOURCE_NOTES, model.newIncidentResource.RESOURCE_ASSIGNED_TO, model.newIncidentResource.RESOURCE_ASSIGNED_PERSONS_COUNT,
                    true, UserIDX);

                return RedirectToAction("IncResource", new { id = model.newIncidentResource.INCIDENT_IDX });
            }

            TempData["Error"] = "Unable to save data.";
            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteIncResource(Guid? id)
        {
            //delete
            int SuccIDX = db_EmergencyHound.DeleteT_EM_INCIDENT_RESOURCES(id.ConvertOrDefault<Guid>());

            if (SuccIDX > 0)
            {
                TempData["Success"] = "Deleted successfully.";
                ModelState.Clear();
            }
            else
                TempData["Error"] = "Unable to delete resource.";

            return RedirectToAction("Team", "Incident");
        }



        public ActionResult Status(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("IncResource", "Incident", new { id = id });
            }

            if (id != null)
            {
                //set session if null
                if (Session["iidx"] == null) Session["iidx"] = id.ToString();

                var model = new vmIncidentStatusModel();
                model.IncidentIDX = id.ConvertOrDefault<Guid>();
                model.new_t_em_incident_status.INCIDENT_IDX = model.IncidentIDX;
                model.t_em_incident_statuses = db_EmergencyHound.GetT_EM_INCIDENT_STATUS_byIncidentIDX(id);
                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");

        }


        [HttpPost]
        public ActionResult Status(vmIncidentStatusModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                Guid? StatusIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_STATUS(model.new_t_em_incident_status.INC_STATUS_IDX, model.new_t_em_incident_status.INCIDENT_IDX,
                    model.new_t_em_incident_status.STATUS_TYPE_CD, model.new_t_em_incident_status.STATUS_DESC, model.new_t_em_incident_status.STATUS_DT, true, UserIDX);

                //update is successful
                if (StatusIDX != null)
                {
                    TempData["Success"] = "Data saved.";
                    return RedirectToAction("Status", new { id = model.new_t_em_incident_status.INCIDENT_IDX });
                }
            }


            TempData["Error"] = "Unable to save data.";
            return View(model);

        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteStatus(Guid? id)
        {
            //delete
            int SuccIDX = db_EmergencyHound.DeleteT_EM_INCIDENT_STATUS(id.ConvertOrDefault<Guid>());

            if (SuccIDX > 0)
            {
                TempData["Success"] = "Deleted successfully.";
                ModelState.Clear();
            }
            else
                TempData["Error"] = "Unable to delete status.";

            return RedirectToAction("Team", "Incident");
        }


        public ActionResult OpPeriods(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("OpPeriods", "Incident", new { id = id });
            }

            if (id != null)
            {
                //populate view model
                var model = new vmIncidentOpPeriodModel
                {
                    IncidentIDX = id.ConvertOrDefault<Guid>(),
                    t_em_incident_op_period = db_EmergencyHound.GetT_EM_INCIDENT_OP_PERIOD_byIncidentIDX(id)
                };

                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");

        }


        [HttpPost]
        public ActionResult OpPeriods(vmIncidentOpPeriodModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                if (model.newOpPeriodName != null && model.newStartDate != null)
                    db_EmergencyHound.InsertUpdateT_EM_INCIDENT_OP_PERIOD(null, model.IncidentIDX, model.newOpPeriodName, model.newStartDate, model.newEndDate, null, null, null, UserIDX);

                return RedirectToAction("OpPeriods", new { id = model.IncidentIDX });
            }


            return View(model);
        }


        public ActionResult OpPeriodEdit(Guid? id)
        {
            if (id != null)
            {
                var model = new vmIncidentOpPeriodEditModel
                {
                    t_em_incident_op_period = db_EmergencyHound.GetT_EM_INCIDENT_OP_PERIOD_byIDX(id),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(id)
                };

                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");
        }


        [HttpPost]
        public ActionResult OpPeriodEdit(vmIncidentOpPeriodEditModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                Guid? OpPeriodIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_OP_PERIOD(model.t_em_incident_op_period.INCIDENT_OP_PERIOD_IDX, null, 
                    model.t_em_incident_op_period.OP_PERIOD_NAME, model.t_em_incident_op_period.OP_PERIOD_START_DT, model.t_em_incident_op_period.OP_PERIOD_END_DT,
                    model.t_em_incident_op_period.OP_PERIOD_COMMAND_EMPHASIS, model.t_em_incident_op_period.OP_PERIOD_SIT_AWARENESS, model.t_em_incident_op_period.OP_PERIOD_PLANNED_ACTION,
                    UserIDX);

                //update is successful
                if (OpPeriodIDX != null)
                {
                    TempData["Success"] = "Data saved.";
                    return RedirectToAction("OpPeriodEdit", new { id = OpPeriodIDX });
                }
            }

            TempData["Error"] = "Unable to save record";
            return View(model);
        }


        [HttpPost]
        public ActionResult Objective(vmIncidentOpPeriodEditModel model)
        {
            if (ModelState.IsValid)
            {
                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                //handle insert or update cases
                Guid? ObjectiveIDX = model.newObjective.INCIDENT_OBJECTIVE_IDX == Guid.Empty ? null : model.newObjective.INCIDENT_OBJECTIVE_IDX.ConvertOrDefault<Guid?>();

                ObjectiveIDX = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_OBJECTIVES(ObjectiveIDX, model.t_em_incident_op_period.INCIDENT_OP_PERIOD_IDX, 
                    model.newObjective.INCIDENT_OBJECTIVE, model.newObjective.OBJECTIVE_PRIORITY, true, UserIDX);

                //insert/update is successful
                if (ObjectiveIDX != null)
                {
                    TempData["Success"] = "Data saved.";
                    return RedirectToAction("OpPeriodEdit", new { id = model.t_em_incident_op_period.INCIDENT_OP_PERIOD_IDX });
                }
            }

            TempData["Error"] = "Unable to save record";
            return RedirectToAction("OpPeriodEdit", new { id = model.t_em_incident_op_period.INCIDENT_OP_PERIOD_IDX });
        }



        // GET: /Incident/Attachments/
        public ActionResult Attachments(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("Attachments", "Incident", new { id = id });
            }

            if (id != null)
            {
                //populate view model
                var model = db_EmergencyHound.GetT_EM_INCIDENT_ATTACH_byIncidentIDX(id);
                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");

        }


        [HttpPost]
        public ActionResult AttachImageUpload(HttpPostedFileBase file)
        {
            Guid? id = null;

            if (file != null)
            {
                //grab from session if available
                if (id == null && Session["iidx"] != null)
                {
                    id = Session["iidx"].ConvertOrDefault<Guid?>();
                }

                if (id == null)
                    return RedirectToAction("Edit", "Incident", new { id = id });



                byte[] buffer;
                using (Stream inputStream = file.InputStream)
                {
                    MemoryStream memoryStream = inputStream as MemoryStream;
                    if (memoryStream == null)
                    {
                        memoryStream = new MemoryStream();
                        inputStream.CopyTo(memoryStream);
                    }
                    buffer = memoryStream.ToArray();
                }

                int UserIDX = (int)System.Web.Security.Membership.GetUser().ProviderUserKey;

                db_EmergencyHound.InsertUpdateT_EM_INCIDENT_ATTACH(null, id, buffer, "image", "", "", UserIDX);
            }

            return RedirectToAction("Attachments", "Incident");
        }



        // GET: /Incident/Timeline/
        public ActionResult Timeline(Guid? id)
        {
            //grab from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
                return RedirectToAction("Timeline", "Incident", new { id = id });
            }


            if (id != null)
            {
                //set session if null
                if (Session["iidx"]==null) Session["iidx"] = id.ToString();

                //populate view model
                var model = new vmIncidentTimelineViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(id),
                    v_em_timeline = db_EmergencyHound.GetV_EM_TIMELINE_ByIncident(id.ConvertOrDefault<Guid>())
                };

                T_OE_USERS u = db_Accounts.GetT_OE_USERSByIDX(model.t_em_incident.CREATE_USERIDX.ConvertOrDefault<int>());
                if (u != null)
                    model.IncidentCreator = u.FNAME + " " + u.LNAME;

                if (model.t_em_incident == null)
                    return RedirectToAction("Index", "Incident");

                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");
        }


        // GET: Report
        public ActionResult Reports(Guid? id)
        {
            //grab incident from session if available
            if (id == null && Session["iidx"] != null)
            {
                id = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (id != null)
            {
                var model = new vmReportIndex();
                model.ddl_OpPeriods = db_EmergencyHound.GetT_EM_INCIDENT_OP_PERIOD_byIncidentIDX(id).Select(x => new SelectListItem
                {
                    Value = x.INCIDENT_OP_PERIOD_IDX.ToString(),
                    Text = x.OP_PERIOD_NAME
                });
                model.IncidentIDX = id;

                return View(model);
            }
            else
                return RedirectToAction("Index", "Incident");

        }


        [HttpPost]
        public ActionResult RptFema201(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema201ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");

        }

        public ActionResult RptFema202(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema202ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema203(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema201ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema204(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema201ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema205(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema201ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema205a(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema201ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                    t_em_incident_objectives = db_EmergencyHound.GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(model.selOpPeriod.ConvertOrDefault<Guid?>())
                };

                if (model2.t_em_incident_objectives == null)
                    model2.t_em_incident_objectives = new List<T_EM_INCIDENT_OBJECTIVES>();

                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema207(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema207ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                };


                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema208(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema208ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                };


                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

        public ActionResult RptFema209(vmReportIndex model)
        {
            //grab from session if available
            if (model.IncidentIDX == null && Session["iidx"] != null)
            {
                model.IncidentIDX = Session["iidx"].ConvertOrDefault<Guid?>();
            }

            if (model.IncidentIDX != null && model.selOpPeriod != null)
            {
                //populate report model
                var model2 = new vmReportfema209ViewModel
                {
                    t_em_incident = db_EmergencyHound.GetT_EM_INCIDENT(model.IncidentIDX),
                };


                return View(model2);
            }
            else
                return RedirectToAction("Reports");
        }

    }
}