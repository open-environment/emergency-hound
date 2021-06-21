using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.Mvc;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundWeb.ViewModels
{
    /// <summary>
    /// Reusable drop-down helpers
    /// </summary>
    public static class ddlHelpers
    {
        public static IEnumerable<SelectListItem> getList_ddl_jurisdictions(int UserIDX)
        {
            return db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG(UserIDX, false).Select(x => new SelectListItem
            {
                Value = x.ORG_IDX.ToString(),
                Text = x.ORG_NAME
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_qual_type()
        {
            return db_Ref.GetT_EM_REF_QUAL_TYPE(null).Select(x => new SelectListItem
            {
                Value = x.QUAL_TYPE_IDX.ToString(),
                Text = x.QUAL_TYPE_NAME
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_doc_type()
        {
            return db_Ref.GetT_EM_REF_DOC_TYPE().Select(x => new SelectListItem
            {
                Value = x.DOC_TYPE,
                Text = x.DOC_TYPE
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_share_type()
        {
            return db_Ref.GetT_EM_REF_SHARE_TYPE().Select(x => new SelectListItem
            {
                Value = x.SHARE_TYPE,
                Text = x.SHARE_DESC
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_doc_status_type()
        {
            return db_Ref.GetT_EM_REF_DOC_STATUS_TYPE().Select(x => new SelectListItem
            {
                Value = x.DOC_STATUS_TYPE,
                Text = x.DOC_STATUS_TYPE
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_resource_type(int UserIDX)
        {
            return db_Ref.GetT_EM_REF_RESOURCE_TYPE_byUserIDX(UserIDX).Select(x => new SelectListItem
            {
                Value = x.RESOURCE_TYPE_IDX.ToString(),
                Text = x.RESOURCE_TYPE_NAME
            });
        }

        public static IEnumerable<SelectListItem> getList_ddl_incident_priority()
        {
            return db_Ref.GetT_EM_REF_INCIDENT_PRIORITY().Select(x => new SelectListItem
            {
                Value = x.INCIDENT_PRIORITY,
                Text = x.INCIDENT_PRIORITY
            });
        }

    }


    //**********************************************************************************************************
    //******************************* ADMIN ********************************************************************
    //**********************************************************************************************************
    public class vmAdminRoleEditViewModel
    {
        public T_OE_ROLES T_OE_ROLES { get; set; }
        public IEnumerable<SelectListItem> Users_In_Role { get; set; }
        public IEnumerable<string> Users_In_Role_Selected { get; set; }
        public IEnumerable<SelectListItem> Users_Not_In_Role { get; set; }
        public IEnumerable<string> Users_Not_In_Role_Selected { get; set; }
    }

    public class vmAdminSettingsViewModel
    {
        public List<T_OE_APP_SETTINGS> app_settings { get; set; }
        public T_OE_APP_SETTINGS edit_app_setting { get; set; }

        //initialize
        public vmAdminSettingsViewModel()
        {
            app_settings = db_Ref.GetT_OE_APP_SETTING_List();
        }
    }



    //**********************************************************************************************************
    //******************************* DASHBOARD ********************************************************************
    //**********************************************************************************************************
    public class vmDashboardViewModel
    {
        public List<UserOrgDisplayType> PendingUsers { get; set; }
        public SP_DASHBOARD_COUNTS_Result DashboardCounts { get; set; }
        public List<SP_RESOURCE_ADV_SEARCH_Result> sp_resource_adv_search { get; set; }
        public List<SP_INCIDENT_ADV_SEARCH_Result> t_em_incident { get; set; }
        public string MapType { get; set; }
        public List<V_EM_TIMELINE> v_em_timeline { get; set; }

    }


    //**********************************************************************************************************
    //******************************* DOCUMENTS ********************************************************************
    //**********************************************************************************************************
    public class vmDocumentListViewModel
    {
        public List<DocListType> t_em_documents { get; set; }
        public bool canAdd { get; set; }

        //initialize 
        public vmDocumentListViewModel() {}
        public vmDocumentListViewModel(int UserIDX)
        {
            canAdd = db_EmergencyHound.BelongsToOrg(UserIDX);
        }
    }

    public class vmDocumentEditViewModel
    {
        public T_EM_DOCUMENTS t_em_document { get; set; }
        public IEnumerable<SelectListItem> ddl_doc_type { get; set; }
        public IEnumerable<SelectListItem> ddl_share_type { get; set; }
        public IEnumerable<SelectListItem> ddl_doc_status_type { get; set; }
        public IEnumerable<SelectListItem> ddl_jurisdiction { get; set; }

        //initialize
        public vmDocumentEditViewModel() { }
        public vmDocumentEditViewModel(int UserIDX)
        {
            ddl_doc_type = ddlHelpers.getList_ddl_doc_type();
            ddl_share_type = ddlHelpers.getList_ddl_share_type();
            ddl_doc_status_type = ddlHelpers.getList_ddl_doc_status_type();
            ddl_jurisdiction = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
        }
    }


    //**********************************************************************************************************
    //******************************* INCIDENT ********************************************************************
    //**********************************************************************************************************
    public class vmIncidentIndexViewModel
    {
        public List<SP_INCIDENT_ADV_SEARCH_Result> t_em_incident { get; set; }
        public IEnumerable<SelectListItem> ddl_jurisdictions { get; set; }
        public Guid? selectOrgIDX { get; set; }
        public string selectOrgName { get; set; }
        public bool canAdd { get; set; }

        //initialize
        public vmIncidentIndexViewModel() { }
        public vmIncidentIndexViewModel(int UserIDX)
        {
            ddl_jurisdictions = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            canAdd = db_EmergencyHound.BelongsToOrg(UserIDX);      
        }
    }

    public class vmIncidentEditViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
        public IEnumerable<SelectListItem> ddl_Jurisdictions { get; set; }
        public IEnumerable<SelectListItem> ddl_ManagementTeam { get; set; }
        public IEnumerable<SelectListItem> ddl_ComplexLevel { get; set; }
        public IEnumerable<SelectListItem> ddl_ShareType { get; set; }
        public IEnumerable<SelectListItem> ddl_Priority { get; set; }


        public int? CurrTab { get; set; }

        //initialize
        public vmIncidentEditViewModel() { }
        public vmIncidentEditViewModel(int UserIDX)
        {
            ddl_Jurisdictions = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            ddl_ShareType = ddlHelpers.getList_ddl_share_type();
            ddl_ManagementTeam = db_Ref.GetT_EM_REF_MANAGEMENT_ORG().Select(x => new SelectListItem
            {
                Value = x.INC_MANAGEMENT_ORG_CD,
                Text = x.COMPLEX_LVL_DESC
            });
            ddl_Priority = ddlHelpers.getList_ddl_incident_priority();
        }
    }

    public class vmIncidentTeamModel
    {
        //incident being edited
        public Guid IncidentIDX { get; set; }
        //getting started - team template
        public string TeamType { get; set; }
        //getting started - selected commander
        public Guid? IncidentCommander { get; set; }
        //dropdown of individuals
        public IEnumerable<SelectListItem> ddl_Individuals { get; set; }
        //dropdown of teams
        public IEnumerable<SelectListItem> ddl_Teams { get; set; }
        //dropdown of who you could report to (which is just a listing of teal_dtl members
        public IEnumerable<SelectListItem> ddl_ReportsTo { get; set; }
        //listing of current team members
        public List<V_EM_INCIDENT_TEAM_DISPLAY> IncidentTeam { get; set; }
        //currently editing team member
        public T_EM_INCIDENT_TEAM_DTL editTeamMember { get; set;  }

        //initialize
        public vmIncidentTeamModel() { }
        public vmIncidentTeamModel(int UserIDX)
        {
            ddl_Individuals = db_EmergencyHound.GetT_EM_INDIVIDUALS_ByUserIDX(UserIDX, null, null).Select(x => new SelectListItem
            {
                Value = x.INDIVIDUAL_IDX.ToString(),
                Text = x.INDV_LAST_NAME + ", " + x.INDV_FIRST_NAME
            });
            ddl_Teams = db_EmergencyHound.GetT_EM_RESOURCE_TeamsByUserIDX(UserIDX).Select(x => new SelectListItem
            {
                Value = x.RESOURCE_IDX.ToString(),
                Text = x.T_EM_REF_RESOURCE_TYPE.RESOURCE_TYPE_NAME + " (" + x.RESOURCE_DESC + ")"
            });
        }
    }

    public class vmIncidentMapViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
        public string ImpactedArea { get; set; }
        public string ThreatenedArea { get; set; }
    }

    public class vmIncidentOpPeriodModel
    {
        public Guid IncidentIDX { get; set; }
        public List<T_EM_INCIDENT_OP_PERIOD> t_em_incident_op_period { get; set; }

        public string newOpPeriodName { get; set; }
        public DateTime? newStartDate { get; set; }
        public DateTime? newEndDate { get; set; }

    }

    public class vmIncidentOpPeriodEditModel
    {
        public T_EM_INCIDENT_OP_PERIOD t_em_incident_op_period { get; set; }
        public List<T_EM_INCIDENT_OBJECTIVES> t_em_incident_objectives { get; set; }
        public T_EM_INCIDENT_OBJECTIVES newObjective { get; set; }

        //initialize
        public vmIncidentOpPeriodEditModel()
        {
            newObjective = new T_EM_INCIDENT_OBJECTIVES();
        }

    }

    public class vmIncidentResourceModel
    {
        public Guid? incident_idx { get; set;}
        public List<T_EM_INCIDENT_RESOURCES> t_em_incident_resources { get; set; }
        public T_EM_INCIDENT_RESOURCES newIncidentResource { get; set; }
        public IEnumerable<SelectListItem> ddl_Resource { get; set; }

        //initialize
        public vmIncidentResourceModel()
        {
            newIncidentResource = new T_EM_INCIDENT_RESOURCES();
            newIncidentResource.INCIDENT_RESOURCE_IDX = Guid.NewGuid();
            newIncidentResource.RESOURCE_ORDERED_DT = System.DateTime.Now;
        }
    }

    public class vmIncidentStatusModel
    {
        public Guid IncidentIDX { get; set; }
        public IEnumerable<SelectListItem> ddl_incident_status_type_cd { get; set; }
        public List<T_EM_INCIDENT_STATUS> t_em_incident_statuses { get; set; }
        public T_EM_INCIDENT_STATUS new_t_em_incident_status { get; set; }

        //initialize
        public vmIncidentStatusModel()
        {
            ddl_incident_status_type_cd = db_Ref.GetT_EM_REF_INC_STATUS_TYPE().Select(x => new SelectListItem
            {
                Value = x.STATUS_TYPE_CD.ToString(),
                Text = x.STATUS_DESC
            });

            new_t_em_incident_status = new T_EM_INCIDENT_STATUS();
            new_t_em_incident_status.INC_STATUS_IDX = Guid.NewGuid();
            new_t_em_incident_status.STATUS_DT = System.DateTime.Now;
        }
    }

    public class vmIncidentTimelineViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
        public List<V_EM_TIMELINE> v_em_timeline { get; set; }
        public string IncidentCreator { get; set; }
    }



    //**********************************************************************************************************
    //******************************* INDIVIDUALS***************************************************************
    //**********************************************************************************************************
    public class vmIndividualListViewModel
    {
        public List<T_EM_INDIVIDUALS> t_em_individuals { get; set; }
        public string selectName { get; set; }
        public string selectQual { get; set; }
        public IEnumerable<SelectListItem> ddl_qualtypes { get; set; }
        public bool canAdd { get; set; }

        //initialize
        public vmIndividualListViewModel() { }
        public vmIndividualListViewModel(int UserIDX)
        {
            canAdd = db_EmergencyHound.BelongsToOrg(UserIDX);
            ddl_qualtypes = ddlHelpers.getList_ddl_qual_type();
        }
    }
        public class vmIndividualEditViewModel
    {
        //individual portion
        public T_EM_INDIVIDUALS t_em_individual { get; set; }
        public IEnumerable<SelectListItem> ddl_jurisdiction { get; set; }
        //certification portion
        public List<QualificationDisplayType> t_em_qualifications { get; set; }
        public IEnumerable<SelectListItem> ddl_qualtypes { get; set; }
        public T_EM_QUALIFICATIONS new_t_em_qualifications { get; set; }


        //initialize
        public vmIndividualEditViewModel() { }
        public vmIndividualEditViewModel(int UserIDX)
        {
            ddl_jurisdiction = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            ddl_qualtypes = ddlHelpers.getList_ddl_qual_type();
            new_t_em_qualifications = new T_EM_QUALIFICATIONS();
            new_t_em_qualifications.QUALIFICATION_IDX = Guid.NewGuid();
        }
    }



    //**********************************************************************************************************
    //******************************* JURISDICTIONS ********************************************************************
    //**********************************************************************************************************
    public class vmJurisdictionListViewModel
    {
        public List<T_OE_ORGANIZATIONS> t_oe_organizations { get; set; }

    }


    public class vmJurisdictionEditViewModel
    {
        public T_OE_ORGANIZATIONS t_oe_organizations { get; set; }
        public List<UserOrgDisplayType> userOrgDisplayType { get; set; }
        public IEnumerable<SelectListItem> ddl_usersNotInOrg { get; set; }
    }



    //**********************************************************************************************************
    //******************************* RESOURCES ********************************************************************
    //**********************************************************************************************************
    public class vmResourceIndexViewModel
    {
        public List<SP_RESOURCE_ADV_SEARCH_Result> sp_resource_adv_search { get; set; }
        public IEnumerable<SelectListItem> ddl_jurisdictions { get; set; }
        public IEnumerable<SelectListItem> ddl_status { get; set; }
        public IEnumerable<SelectListItem> ddl_kind { get; set; }
        public Guid? selectOrgIDX { get; set; }
        public string selectOrgName { get; set; }
        public string selectStatusCd { get; set; }
        public string selectStatusName { get; set; }
        public string selectKind { get; set; }
        public bool canAdd { get; set; }

        //initialize
        public vmResourceIndexViewModel() { }

        public vmResourceIndexViewModel(int UserIDX)
        {
            ddl_jurisdictions = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            ddl_status = db_Ref.GetT_EM_REF_RESOURCE_STATUS().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_STATUS_CD.ToString(),
                Text = x.RESOURCE_STATUS_NAME
            });
            ddl_kind = db_Ref.GetT_EM_REF_RESOURCE_KIND().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_KIND_DESC.ToString(),
                Text = x.RESOURCE_KIND_DESC
            });
            canAdd = db_EmergencyHound.BelongsToOrg(UserIDX);
        }


    }

    public class vmResourceEditViewModel
    {
        public System.Guid t_em_resource_RESOURCE_IDX { get; set; }
        public System.Guid t_em_resource_ORG_IDX { get; set; }
        public System.Guid t_em_resource_RESOURCE_TYPE_IDX { get; set; }
        public string t_em_resource_RESOURCE_COUNT { get; set; }
        public string t_em_resource_RESOURCE_UNIT { get; set; }
        public string t_em_resource_RESOURCE_DESC { get; set; }
        public Nullable<decimal> t_em_resource_RESOURCE_LAT { get; set; }
        public Nullable<decimal> t_em_resource_RESOURCE_LONG { get; set; }
        public string t_em_resource_SHARE_TYPE { get; set; }
        public Nullable<int> t_em_resource_FEMA_NIMS_TYPE { get; set; }
        public string t_em_resource_RESOURCE_STATUS_CD { get; set; }
        public Nullable<System.DateTime> t_em_resource_VERIFY_DT { get; set; }
        public string t_em_resource_t_em_ref_resource_type_name { get; set; }
        public string t_em_resource_t_em_ref_resource_type_kind { get; set; }
        public string t_em_resource_t_em_ref_resource_type_category { get; set; }
        public string t_em_resource_t_em_ref_resource_type_desc { get; set; }
        public Boolean canEdit { get; set; }

        public IEnumerable<SelectListItem> Jurisdictions { get; set; }
        public IEnumerable<SelectListItem> ResourceTypes { get; set; }
        public IEnumerable<SelectListItem> ShareTypes { get; set; }
        public IEnumerable<SelectListItem> StatusTypes { get; set; }
        public List<SP_RESOURCE_DTL_Result> sp_resource_dtl_result { get; set; }
        public T_EM_RESOURCE_VER_HIST t_em_resource_ver_hist { get; set; }

        //intialize
        public vmResourceEditViewModel()
        {
        }

        public vmResourceEditViewModel(int UserIDX)
        {
            Jurisdictions = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            ResourceTypes = ddlHelpers.getList_ddl_resource_type(UserIDX);
            ShareTypes = ddlHelpers.getList_ddl_share_type();
            StatusTypes = db_Ref.GetT_EM_REF_RESOURCE_STATUS().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_STATUS_CD.ToString(),
                Text = x.RESOURCE_STATUS_NAME
            });
        }


    }

    public class vmResourceAddViewModel
    {
        public T_EM_RESOURCE t_em_resource { get; set; }
        public IEnumerable<SelectListItem> Jurisdictions { get; set; }
        public IEnumerable<SelectListItem> ResourceTypes { get; set; }
        public IEnumerable<SelectListItem> ShareTypes { get; set; }
        public IEnumerable<SelectListItem> StatusTypes { get; set; }

        //intialize
        public vmResourceAddViewModel()
        {
        }
        public vmResourceAddViewModel(int UserIDX)
        {
            Jurisdictions = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
            ResourceTypes = ddlHelpers.getList_ddl_resource_type(UserIDX);
            ShareTypes = db_Ref.GetT_EM_REF_SHARE_TYPE().Select(x => new SelectListItem
            {
                Value = x.SHARE_TYPE.ToString(),
                Text = x.SHARE_DESC
            });
            StatusTypes = db_Ref.GetT_EM_REF_RESOURCE_STATUS().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_STATUS_CD.ToString(),
                Text = x.RESOURCE_STATUS_NAME
            });
        }
    }

    public class vmResourceTypeListViewModel
    {
        public List<T_EM_REF_RESOURCE_TYPE> t_em_ref_resource_types { get; set;  }
    }

    public class vmResourceTypeEditViewModel
    {
        public T_EM_REF_RESOURCE_TYPE t_em_ref_resource_type { get; set; }
        public List<T_EM_REF_RESOURCE_TYPE_DTL> t_em_ref_resource_type_dtl { get; set; }
        public T_EM_REF_RESOURCE_TYPE_DTL newResourceTypeDtl { get; set;  }
        public IEnumerable<SelectListItem> ddl_Category { get; set; }
        public IEnumerable<SelectListItem> ddl_Kind { get; set; }
        public IEnumerable<SelectListItem> ddl_CoreCapacity { get; set; }
        public IEnumerable<SelectListItem> ddl_Jurisdiction { get; set; }

        //initialize
        public vmResourceTypeEditViewModel() {}

        public vmResourceTypeEditViewModel(int UserIDX)
        {
            ddl_Category = db_Ref.GetT_EM_REF_RESOURCE_CAT().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_CAT_DESC.ToString(),
                Text = x.RESOURCE_CAT_DESC
            });
            ddl_Kind = db_Ref.GetT_EM_REF_RESOURCE_KIND().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_KIND_DESC.ToString(),
                Text = x.RESOURCE_KIND_DESC
            });
            ddl_CoreCapacity = db_Ref.GetT_EM_REF_RESOURCE_CORE_CAP().Select(x => new SelectListItem
            {
                Value = x.RESOURCE_CORE_CAP_DESC.ToString(),
                Text = x.RESOURCE_CORE_CAP_DESC
            });
            ddl_Jurisdiction = ddlHelpers.getList_ddl_jurisdictions(UserIDX);
        }

    }

    public class vmResourceVerificationHistoryViewModel
    {
        public Guid? ResourceIDX { get; set; }
        public List<T_EM_RESOURCE_VER_HIST> t_em_resource_ver_hist { get; set; }
    }

}
