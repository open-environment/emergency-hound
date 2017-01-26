using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using EmergencyHoundModel.Utils;

namespace EmergencyHoundModel.DataAccessLayer
{
    public class UserOrgDisplayType
    {
        public Guid USER_ORG_IDX { get; set; }
        public int USER_IDX { get; set; }
        public Guid ORG_IDX { get; set; }
        public string ORG_NAME { get; set; }
        public string USER_NAME { get; set; }
        public string ROLE_CD { get; set; }
        public DateTime? CREATE_DT { get; set; }
    }

    public class QualificationDisplayType
    {
        public Guid ORG_IDX { get; set; }
        public Guid INDIVIDUAL_IDX { get; set; }
        public string INDV_FIRST_NAME { get; set; }
        public string INDV_LAST_NAME { get; set; }
        public string ORG_NAME { get; set; }
        public Guid QUALIFICATION_IDX { get; set; }
        public Guid? QUAL_TYPE_IDX { get; set; }
        public DateTime? EFF_DATE { get; set; }
        public DateTime? EXP_DATE { get; set; }
        public string CREATE_USERIDX { get; set; }
        public DateTime? CREATE_DT { get; set; }
        public string MODIFY_USERIDX { get; set; }
        public DateTime? MODIFY_DT { get; set; }
        public string QUAL_TYPE_NAME { get; set; }
    }

    public class IndividualDisplayType
    {
        public Guid INDIVIDUAL_IDX{ get; set; }
        public Guid ORG_IDX { get; set; }
        public string INDV_FIRST_NAME { get; set; }
        public string INDV_MID_NAME { get; set; }
        public string INDV_LAST_NAME { get; set; }
        public DateTime? INDV_DOB { get; set; }
        public string INDV_PHONE { get; set; }
        public string INDV_EMAIL { get; set; }
        public string ADD_LINE_ADR { get; set; }
        public string ADD_CITY { get; set; }
        public string ADD_STATE { get; set; }
        public string ADD_ZIP { get; set; }
        public int? MODIFY_USERIDX { get; set; }
        public DateTime? MODIFY_DT { get; set; }
        public string INDV_AFFILIATION { get; set; }
        public bool ACT_IND { get; set; }
    }

    public class IncidentDisplayType
    {
        public Guid INCIDENT_IDX { get; set; }
        public string INCIDENT_ID { get; set; }
        public string INCIDENT_NAME { get; set; }
        public Guid ORG_IDX { get; set;  }
        public string ORG_NAME { get; set; }
        public string INCIDENT_DESC { get; set; }
        public string INC_MANAGEMENT_ORG_CD { get; set; }
        public DateTime? INCIDENT_START_DT { get; set; }
        public string INCIDENT_LOC_DESC { get; set; }
        public Decimal? INCIDENT_LAT { get; set; }
        public Decimal? INCIDENT_LONG { get; set; }
        public string INCIDENT_STATE { get; set; }
        public int? INCIDENT_CNTY { get; set; }
        public string INCIDENT_CITY { get; set; }
        public string ImpactedArea { get; set; }
        public string ThreatenedArea { get; set; }
    }

    public class DocListType
    {
        public Guid DOC_IDX { get; set; }
        public Guid ORG_IDX { get; set; }
        public string ORG_NAME { get; set; }
        public string DOC_NAME { get; set; }
        public string DOC_TYPE { get; set; }
        public string DOC_FILE_TYPE { get; set; }
        public string DOC_COMMENT { get; set; }
        public string DOC_AUTHOR { get; set; }
        public string SHARE_TYPE { get; set; }
        public string DOC_STATUS_TYPE { get; set; }
        public int? CREATE_USERIDX { get; set; }
        public DateTime? CREATE_DT { get; set; }
        public bool CanEdit { get; set; }
    }

    public class AttachDisplayType
    {
        public Guid ATTACH_IDX { get; set; }
        public Guid INCIDENT_IDX { get; set; }
        public string ATTACH_TYPE { get; set; }
        public string ATTACH_NAME { get; set; }
        public string ATTACH_DESC { get; set; }
    }

    public class db_EmergencyHound
    {
        //********************T_EM_DOCUMENTS************************************
        public static List<DocListType> GetT_EM_DOCUMENTS(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //get list of orgs user has rights to
                    var uos = (from uo in ctx.T_EM_USER_ORG
                               where uo.USER_IDX == UserIDX
                               && uo.STATUS_CD == "A"
                               select uo.ORG_IDX).ToList();


                    return (from a in ctx.T_EM_DOCUMENTS
                            //join uo in ctx.T_EM_USER_ORG on a.ORG_IDX equals uo.ORG_IDX
                            join o in ctx.T_OE_ORGANIZATIONS on a.ORG_IDX equals o.ORG_IDX
                            where a.ACT_IND == true
                            && (a.SHARE_TYPE != "Jurisdiction" || uos.Contains(a.ORG_IDX))
                            select new DocListType
                            {
                                DOC_IDX = a.DOC_IDX,
                                ORG_IDX = a.ORG_IDX,
                                ORG_NAME = o.ORG_NAME,
                                DOC_NAME = a.DOC_NAME, 
                                DOC_TYPE = a.DOC_TYPE,
                                DOC_FILE_TYPE = a.DOC_FILE_TYPE,
                                DOC_COMMENT = a.DOC_COMMENT,
                                DOC_AUTHOR = a.DOC_AUTHOR,
                                SHARE_TYPE = a.SHARE_TYPE,
                                DOC_STATUS_TYPE = a.DOC_STATUS_TYPE,
                                CREATE_USERIDX = a.CREATE_USERIDX,
                                CREATE_DT = a.CREATE_DT,
                                CanEdit = (UserIDX == a.CREATE_USERIDX)
                            }).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static T_EM_DOCUMENTS GetT_EM_DOCUMENTS_byIDX(Guid? id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_DOCUMENTS
                            where a.ACT_IND == true
                            && a.DOC_IDX == id
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_DOCUMENTS(Guid? dOC_IDX, Guid? oRG_IDX, byte[] dOC_CONTENT, string dOC_NAME, string dOC_TYPE, string dOC_FILE_TYPE, 
            int? dOC_FILE_SIZE, string dOC_COMMENT, string dOC_AUTHOR, string sHARE_TYPE, string dOC_STATUS_TYPE, bool aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    if (dOC_IDX == Guid.Empty) dOC_IDX = null;

                    T_EM_DOCUMENTS e = (from c in ctx.T_EM_DOCUMENTS
                                        where c.DOC_IDX == dOC_IDX
                                       select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_DOCUMENTS();
                        e.DOC_IDX = Guid.NewGuid();
                        if (sHARE_TYPE == null) sHARE_TYPE = "Jurisdiction";  //set sharing if none set
                        if (dOC_STATUS_TYPE == null) dOC_STATUS_TYPE = "Current";  //set sharing if none set
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX.ConvertOrDefault<Guid>();
                    if (dOC_CONTENT != null) e.DOC_CONTENT = dOC_CONTENT;
                    if (dOC_NAME != null) e.DOC_NAME = dOC_NAME;
                    if (dOC_TYPE != null) e.DOC_TYPE = dOC_TYPE;
                    if (dOC_FILE_TYPE != null) e.DOC_FILE_TYPE = dOC_FILE_TYPE;
                    if (dOC_FILE_SIZE != null) e.DOC_SIZE = dOC_FILE_SIZE;
                    if (dOC_COMMENT != null) e.DOC_COMMENT = dOC_COMMENT;
                    if (dOC_AUTHOR != null) e.DOC_AUTHOR = dOC_AUTHOR;
                    if (sHARE_TYPE != null) e.SHARE_TYPE = sHARE_TYPE;
                    if (dOC_STATUS_TYPE != null) e.DOC_STATUS_TYPE = dOC_STATUS_TYPE;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_DOCUMENTS.Add(e);

                    ctx.SaveChanges();
                    return e.DOC_IDX;
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_DOCUMENTS(Guid? id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_DOCUMENTS rec = ctx.T_EM_DOCUMENTS.Find(id);
                    ctx.T_EM_DOCUMENTS.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //********************T_EM_INCIDENT************************************
        public static T_EM_INCIDENT GetT_EM_INCIDENT(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_INCIDENT> GetT_EM_INCIDENT()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_INCIDENT
                            where a.ACT_IND == true
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<IncidentDisplayType> GetT_EM_INCIDENT_AdvSearch(Guid? OrgIDX, int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //get list of orgs user has rights to
                    var uos = (from uo in ctx.T_EM_USER_ORG
                             where uo.USER_IDX == UserIDX
                             && uo.STATUS_CD == "A"
                             select uo.ORG_IDX).ToList();

                    return (from a in ctx.T_EM_INCIDENT.Include("T_OE_ORGANIZATIONS")
                            join ia in ctx.T_EM_INCIDENT_LOC_AREA on new { a.INCIDENT_IDX, LOCATION_AREA_TYPE = "Impacted Area" } equals new { ia.INCIDENT_IDX, ia.LOCATION_AREA_TYPE } into ImpactedArea
                            from ImpactedLeft in ImpactedArea.DefaultIfEmpty()
                            join ia2 in ctx.T_EM_INCIDENT_LOC_AREA on new { a.INCIDENT_IDX, LOCATION_AREA_TYPE = "Threatened Area" } equals new { ia2.INCIDENT_IDX, ia2.LOCATION_AREA_TYPE } into ThreatenedArea
                            from ThreatenedLeft in ThreatenedArea.DefaultIfEmpty()
                            where a.ACT_IND == true
                            && (OrgIDX != null ? a.ORG_IDX == OrgIDX : true)
                            && (a.SHARE_TYPE != "Jurisdiction" || uos.Contains(a.ORG_IDX)) 
                            select new IncidentDisplayType {
                                INCIDENT_IDX = a.INCIDENT_IDX,
                                INCIDENT_ID = a.INCIDENT_ID,
                                INCIDENT_NAME = a.INCIDENT_NAME,
                                ORG_IDX = a.ORG_IDX,
                                ORG_NAME = a.T_OE_ORGANIZATIONS.ORG_NAME,
                                INCIDENT_DESC = a.INCIDENT_DESC,
                                INC_MANAGEMENT_ORG_CD = a.INC_MANAGEMENT_ORG_CD,
                                INCIDENT_START_DT = a.INCIDENT_START_DT,
                                INCIDENT_LOC_DESC = a.INCIDENT_LOC_DESC,
                                INCIDENT_LAT = a.INCIDENT_LAT,
                                INCIDENT_LONG = a.INCIDENT_LONG,
                                INCIDENT_STATE = a.INCIDENT_STATE,
                                INCIDENT_CNTY = a.INCIDENT_CNTY,
                                INCIDENT_CITY = a.INCIDENT_CITY,
                                ImpactedArea = ImpactedLeft.LOCATION_PERIMETER,
                                ThreatenedArea = ThreatenedLeft.LOCATION_PERIMETER
                            }).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INCIDENT(Guid? iNCIDENT_IDX, Guid? oRG_IDX, string iNCIDENT_ID, string iNCIDENT_NAME, string iNCIDENT_DESC, 
            string iNC_MANAGEMENT_ORG_CD, DateTime? iNCIDENT_START_DT, DateTime? iNCIDENT_END_DT, string iNCIDENT_COMPLEX_LVL, string iNCIDENT_LOC_DESC, 
            decimal? iNCIDENT_LAT, decimal? iNCIDENT_LONG, string iNCIDENT_STATE, int? iNCIDENT_CNTY, string iNCIDENT_CITY, string iNCIDENT_LAND_SURVEY, 
            string iNCIDENT_SIZE, string iNCIDENT_SIZE_UNIT, decimal? iNCIDENT_PCT_CONTAINED, string iNCIDENT_HAZ_MAT, string iNCIDENT_WEATHER, 
            decimal? iNCIDENT_COSTS, decimal? iNCIDENT_TOTAL_COSTS, bool aCT_IND, int? cREATE_USER, string sHARE_TYPE, string pRIORITY, bool mobileInd = false)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT e = (from c in ctx.T_EM_INCIDENT
                                              where c.INCIDENT_IDX == iNCIDENT_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT();

                        if (mobileInd == false)  //set new GUID but not for mobile, which sets its own
                            e.INCIDENT_IDX = Guid.NewGuid();
                        else
                            e.INCIDENT_IDX = iNCIDENT_IDX.ConvertOrDefault<Guid>();

                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX.ConvertOrDefault<Guid>();
                    if (iNCIDENT_ID != null) e.INCIDENT_ID = iNCIDENT_ID;
                    if (iNCIDENT_NAME != null) e.INCIDENT_NAME = iNCIDENT_NAME;
                    if (iNCIDENT_DESC != null) e.INCIDENT_DESC = iNCIDENT_DESC;
                    if (iNC_MANAGEMENT_ORG_CD != null) e.INC_MANAGEMENT_ORG_CD = iNC_MANAGEMENT_ORG_CD;
                    if (iNCIDENT_START_DT != null) e.INCIDENT_START_DT = iNCIDENT_START_DT;
                    if (iNCIDENT_END_DT != null) e.INCIDENT_END_DT = iNCIDENT_END_DT;
                    if (iNCIDENT_COMPLEX_LVL != null) e.INCIDENT_COMPLEX_LVL = iNCIDENT_COMPLEX_LVL;
                    if (iNCIDENT_LOC_DESC != null) e.INCIDENT_LOC_DESC = iNCIDENT_LOC_DESC;
                    if (iNCIDENT_LAT != null) e.INCIDENT_LAT = iNCIDENT_LAT;
                    if (iNCIDENT_LONG != null) e.INCIDENT_LONG = iNCIDENT_LONG;
                    if (iNCIDENT_STATE != null) e.INCIDENT_STATE = iNCIDENT_STATE;
                    if (iNCIDENT_CNTY != null) e.INCIDENT_CNTY = iNCIDENT_CNTY;
                    if (iNCIDENT_CITY != null) e.INCIDENT_CITY = iNCIDENT_CITY;
                    if (iNCIDENT_LAND_SURVEY != null) e.INCIDENT_LAND_SURVEY = iNCIDENT_LAND_SURVEY;
                    if (iNCIDENT_SIZE != null) e.INCIDENT_SIZE = iNCIDENT_SIZE;
                    if (iNCIDENT_SIZE_UNIT != null) e.INCIDENT_SIZE_UNIT = iNCIDENT_SIZE_UNIT;
                    if (iNCIDENT_PCT_CONTAINED != null) e.INCIDENT_PCT_CONTAINED = iNCIDENT_PCT_CONTAINED;
                    if (iNCIDENT_HAZ_MAT != null) e.INCIDENT_HAZ_MAT = iNCIDENT_HAZ_MAT;
                    if (iNCIDENT_WEATHER != null) e.INCIDENT_WEATHER = iNCIDENT_WEATHER;
                    if (iNCIDENT_COSTS != null) e.INCIDENT_COSTS = iNCIDENT_COSTS;
                    if (iNCIDENT_TOTAL_COSTS != null) e.INCIDENT_TOTAL_COSTS = iNCIDENT_TOTAL_COSTS;
                    if (sHARE_TYPE != null) e.SHARE_TYPE = sHARE_TYPE;
                    if (e.SHARE_TYPE == null) e.SHARE_TYPE = "Jurisdiction"; //set sharing to only jurisdiction if it is not already set
                    if (pRIORITY != null) e.INCIDENT_PRIORITY = pRIORITY;
                    if (e.INCIDENT_PRIORITY == null) e.INCIDENT_PRIORITY = "Medium"; //set incident priority to medium if not already set

                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INCIDENT.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_IDX;
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //********************T_EM_INCIDENT_ATTACH************************************
        public static Guid? InsertUpdateT_EM_INCIDENT_ATTACH(Guid? aTTACH_IDX, Guid? iNCIDENT_IDX, byte[] aTTACH_CONTENT, string aTTACH_TYPE, string aTTACH_NAME, string aTTACH_DESC, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_ATTACH e = (from c in ctx.T_EM_INCIDENT_ATTACH
                                              where c.ATTACH_IDX == aTTACH_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_ATTACH();
                        e.ATTACH_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX.ConvertOrDefault<Guid>();
                    if (aTTACH_CONTENT != null) e.ATTACH_CONTENT = aTTACH_CONTENT;
                    if (aTTACH_TYPE != null) e.ATTACH_TYPE = aTTACH_TYPE;
                    if (aTTACH_NAME != null) e.ATTACH_NAME = aTTACH_NAME;
                    if (aTTACH_DESC != null) e.ATTACH_DESC = aTTACH_DESC;

                    if (insInd)
                        ctx.T_EM_INCIDENT_ATTACH.Add(e);

                    ctx.SaveChanges();
                    return e.ATTACH_IDX;
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_INCIDENT_ATTACH> GetT_EM_INCIDENT_ATTACH_byIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_ATTACH
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<AttachDisplayType> GetT_EM_INCIDENT_ATTACH_byIncidentIDX_Abbrev(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_ATTACH
                            where a.INCIDENT_IDX == IncidentIDX
                            select new AttachDisplayType
                            {
                                ATTACH_IDX = a.ATTACH_IDX,
                                ATTACH_TYPE = a.ATTACH_TYPE,
                                ATTACH_NAME = a.ATTACH_NAME,
                                ATTACH_DESC = a.ATTACH_DESC
                            }).ToList();

                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static T_EM_INCIDENT_ATTACH GetT_EM_INCIDENT_ATTACH_byAttachIDX(Guid? AttachIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (AttachIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_ATTACH
                            where a.ATTACH_IDX == AttachIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //********************T_EM_INCIDENT_LOC_AREA ************************************
        public static string GetT_EM_INCIDENT_LOC_AREA_byIncidentAndType(Guid? IncidentIDX, string LocAreaType)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return "";

                    return (from a in ctx.T_EM_INCIDENT_LOC_AREA
                            where a.INCIDENT_IDX == IncidentIDX
                            && a.LOCATION_AREA_TYPE == LocAreaType
                            select a).FirstOrDefault().LOCATION_PERIMETER;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return "";
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INCIDENT_LOC_AREA(Guid? iNCIDENT_LOC_AREA_IDX, Guid? iNCIDENT_IDX, string lOCATION_AREA_TYPE, string lOCATION_PERIMETER, 
            bool aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_LOC_AREA e = (from c in ctx.T_EM_INCIDENT_LOC_AREA
                                                where c.INCIDENT_LOC_AREA_IDX == iNCIDENT_LOC_AREA_IDX
                                       select c).FirstOrDefault();

                    //if no result, try to grab from Incident ID and Type
                    if (e == null && iNCIDENT_IDX != null)
                        e = (from c in ctx.T_EM_INCIDENT_LOC_AREA
                             where c.INCIDENT_IDX == iNCIDENT_IDX
                             && c.LOCATION_AREA_TYPE == lOCATION_AREA_TYPE
                             select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_LOC_AREA();
                        e.INCIDENT_LOC_AREA_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX.ConvertOrDefault<Guid>();
                    if (lOCATION_AREA_TYPE != null) e.LOCATION_AREA_TYPE = lOCATION_AREA_TYPE;
                    if (lOCATION_PERIMETER != null) e.LOCATION_PERIMETER = lOCATION_PERIMETER;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INCIDENT_LOC_AREA.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_LOC_AREA_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //********************T_EM_INCIDENT_OBJECTIVES ************************************
        public static List<T_EM_INCIDENT_OBJECTIVES> GetT_EM_INCIDENT_OBJECTIVES_byOpPeriodIDX(Guid? OpPeriodIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (OpPeriodIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_OBJECTIVES
                            where a.INCIDENT_OP_PERIOD_IDX == OpPeriodIDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INCIDENT_OBJECTIVES(Guid? iNCIDENT_OBJECTIVE_IDX, Guid iNCIDENT_OP_PERIOD_IDX, string iNCIDENT_OBJECTIVE, string oBJECTIVE_PRIORITY, 
            bool aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_OBJECTIVES e = (from c in ctx.T_EM_INCIDENT_OBJECTIVES
                                                  where c.INCIDENT_OBJECTIVE_IDX == iNCIDENT_OBJECTIVE_IDX
                                                  select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_OBJECTIVES();
                        e.INCIDENT_OBJECTIVE_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_OP_PERIOD_IDX != null) e.INCIDENT_OP_PERIOD_IDX = iNCIDENT_OP_PERIOD_IDX;
                    if (iNCIDENT_OBJECTIVE != null) e.INCIDENT_OBJECTIVE = iNCIDENT_OBJECTIVE;
                    if (oBJECTIVE_PRIORITY != null) e.OBJECTIVE_PRIORITY = oBJECTIVE_PRIORITY;

                    if (insInd)
                        ctx.T_EM_INCIDENT_OBJECTIVES.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_OBJECTIVE_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //********************T_EM_INCIDENT_OP_PERIOD ************************************
        public static List<T_EM_INCIDENT_OP_PERIOD> GetT_EM_INCIDENT_OP_PERIOD_byIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_OP_PERIOD
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static T_EM_INCIDENT_OP_PERIOD GetT_EM_INCIDENT_OP_PERIOD_byIDX(Guid? OpPeriodIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_INCIDENT_OP_PERIOD
                            where a.INCIDENT_OP_PERIOD_IDX == OpPeriodIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INCIDENT_OP_PERIOD(Guid? iNC_OP_PERIOD_IDX, Guid? iNCIDENT_IDX, string oP_PERIOD_NAME, DateTime? oP_PERIOD_START_DT, DateTime? oP_PERIOD_END_DT, 
            string oP_PERIOD_COMMAND_EMPHASIS, string oP_PERIOD_SIT_AWARENESS, string oP_PERIOD_PLANNED_ACTION, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_OP_PERIOD e = (from c in ctx.T_EM_INCIDENT_OP_PERIOD
                                              where c.INCIDENT_OP_PERIOD_IDX == iNC_OP_PERIOD_IDX
                                                 select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_OP_PERIOD();
                        e.INCIDENT_OP_PERIOD_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX.ConvertOrDefault<Guid>();
                    if (oP_PERIOD_NAME != null) e.OP_PERIOD_NAME = oP_PERIOD_NAME;
                    if (oP_PERIOD_START_DT != null) e.OP_PERIOD_START_DT = oP_PERIOD_START_DT;
                    if (oP_PERIOD_END_DT != null) e.OP_PERIOD_END_DT = oP_PERIOD_END_DT;
                    if (oP_PERIOD_COMMAND_EMPHASIS != null) e.OP_PERIOD_COMMAND_EMPHASIS = oP_PERIOD_COMMAND_EMPHASIS;
                    if (oP_PERIOD_SIT_AWARENESS != null) e.OP_PERIOD_SIT_AWARENESS = oP_PERIOD_SIT_AWARENESS;
                    if (oP_PERIOD_PLANNED_ACTION != null) e.OP_PERIOD_PLANNED_ACTION = oP_PERIOD_PLANNED_ACTION;

                    if (insInd)
                        ctx.T_EM_INCIDENT_OP_PERIOD.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_OP_PERIOD_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_INCIDENT_RESOURCE************************************
        public static int GetT_EM_INCIDENT_RESOURCES_CountbyIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return 0;

                    return (from a in ctx.T_EM_INCIDENT_RESOURCES
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int GetT_EM_INCIDENT_RESOURCES_CountbyResourceIDX(Guid? ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (ResourceIDX == null)
                        return 0;

                    return (from a in ctx.T_EM_INCIDENT_RESOURCES
                            where a.RESOURCE_IDX == ResourceIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static List<T_EM_INCIDENT_RESOURCES> GetT_EM_INCIDENT_RESOURCES_byIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_RESOURCES.Include("T_EM_RESOURCE").Include("T_EM_RESOURCE.T_EM_REF_RESOURCE_TYPE")
                            where a.INCIDENT_IDX == IncidentIDX
                            orderby a.CREATE_DT descending
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INCIDENT_RESOURCES(Guid? iNCIDENT_RESOURCE_IDX, Guid iNCIDENT_IDX, Guid? rESOURCE_IDX, string rESOURCE_COUNT, DateTime? rESOURCE_ORDERED_DT, 
            DateTime? rESOURCE_ETA_DT, bool? rESOURCE_ARRIVED_IND, string rESOURCE_NOTES, string rESOURCE_ASSIGNED_TO, int? rESOURCE_ASSIGNED_PERSONS_COUNT, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_RESOURCES e = (from c in ctx.T_EM_INCIDENT_RESOURCES
                                                 where c.INCIDENT_RESOURCE_IDX == iNCIDENT_RESOURCE_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_RESOURCES();
                        if (iNCIDENT_RESOURCE_IDX == Guid.Empty)
                            e.INCIDENT_RESOURCE_IDX = Guid.NewGuid();
                        else
                            e.INCIDENT_RESOURCE_IDX = iNCIDENT_RESOURCE_IDX.ConvertOrDefault<Guid>();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX;
                    if (rESOURCE_IDX != null) e.RESOURCE_IDX = rESOURCE_IDX.ConvertOrDefault<Guid>();
                    if (rESOURCE_COUNT != null) e.RESOURCE_COUNT = rESOURCE_COUNT;
                    if (rESOURCE_ORDERED_DT != null) e.RESOURCE_ORDERED_DT = rESOURCE_ORDERED_DT;
                    if (rESOURCE_ETA_DT != null) e.RESOURCE_ETA_DT = rESOURCE_ETA_DT;
                    if (rESOURCE_ARRIVED_IND != null) e.RESOURCE_ARRIVED_IND = rESOURCE_ARRIVED_IND;
                    if (rESOURCE_NOTES != null) e.RESOURCE_NOTES = rESOURCE_NOTES;
                    if (rESOURCE_ASSIGNED_TO != null) e.RESOURCE_ASSIGNED_TO = rESOURCE_ASSIGNED_TO;
                    if (rESOURCE_ASSIGNED_PERSONS_COUNT != null) e.RESOURCE_ASSIGNED_PERSONS_COUNT = rESOURCE_ASSIGNED_PERSONS_COUNT;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INCIDENT_RESOURCES.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_RESOURCE_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_INCIDENT_RESOURCES(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_INCIDENT_RESOURCES rec = ctx.T_EM_INCIDENT_RESOURCES.Find(id);
                    ctx.T_EM_INCIDENT_RESOURCES.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //********************T_EM_INCIDENT_STATUS************************************
        public static Guid? InsertUpdateT_EM_INCIDENT_STATUS(Guid? iNC_STATUS_IDX, Guid iNCIDENT_IDX, string sTATUS_TYPE_CD, string sTATUS_DESC, DateTime sTATUS_DT, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INCIDENT_STATUS e = (from c in ctx.T_EM_INCIDENT_STATUS
                                              where c.INC_STATUS_IDX == iNC_STATUS_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_STATUS();
                        if (iNC_STATUS_IDX == Guid.Empty)
                            e.INC_STATUS_IDX = Guid.NewGuid();
                        else
                            e.INC_STATUS_IDX = iNC_STATUS_IDX.ConvertOrDefault<Guid>();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX;
                    if (sTATUS_TYPE_CD != null) e.STATUS_TYPE_CD = sTATUS_TYPE_CD;
                    if (sTATUS_DESC != null) e.STATUS_DESC = sTATUS_DESC;
                    e.STATUS_DT = sTATUS_DT;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INCIDENT_STATUS.Add(e);

                    ctx.SaveChanges();
                    return e.INC_STATUS_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_INCIDENT_STATUS> GetT_EM_INCIDENT_STATUS_byIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.T_EM_INCIDENT_STATUS
                            where a.INCIDENT_IDX == IncidentIDX
                            && a.ACT_IND == true
                            orderby a.STATUS_DT descending
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int GetT_EM_INCIDENT_STATUS_CountbyIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return 0;

                    return (from a in ctx.T_EM_INCIDENT_STATUS
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int DeleteT_EM_INCIDENT_STATUS(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_INCIDENT_STATUS rec = ctx.T_EM_INCIDENT_STATUS.Find(id);
                    ctx.T_EM_INCIDENT_STATUS.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //********************T_EM_INCIDENT_TEAM************************************
        public static List<V_EM_INCIDENT_TEAM_DISPLAY> GetV_EM_INCIDENT_TEAM_DISPLAY_byIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    return (from a in ctx.V_EM_INCIDENT_TEAM_DISPLAY
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static string GetT_EM_INCIDENT_TEAM_DTL_CommanderName(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return null;

                    var x = (from a in ctx.T_EM_INCIDENT_TEAM_DTL
                             join b in ctx.T_EM_INDIVIDUALS on a.INCIDENT_IDX equals b.INDIVIDUAL_IDX
                             where a.INCIDENT_IDX == IncidentIDX
                             && a.REPORTS_TO_TEAM_DTL_IDX == null
                             select b).FirstOrDefault();

                    if (x != null)
                        return x.INDV_FIRST_NAME + " " + x.INDV_LAST_NAME;
                    else
                        return "";
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return "";
                }
            }
        }

        public static int GetT_EM_INCIDENT_TEAM_DTL_CountbyIncidentIDX(Guid? IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (IncidentIDX == null)
                        return 0;

                    return (from a in ctx.T_EM_INCIDENT_TEAM_DTL
                            where a.INCIDENT_IDX == IncidentIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int GetT_EM_INCIDENT_TEAM_DTL_CountbyResourceIDX(Guid? ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (ResourceIDX == null)
                        return 0;

                    return (from a in ctx.T_EM_INCIDENT_TEAM_DTL
                            where a.RESOURCE_IDX == ResourceIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }


        public static Guid? InsertUpdateT_EM_INCIDENT_TEAM_DTL(Guid? iNCIDENT_TEAM_DTL_IDX, Guid? iNCIDENT_OP_PERIOD_IDX, Guid? iNCIDENT_IDX, Guid? rEPORTS_TO_TEAM_DTL_IDX,
            Guid? iNDIVIDUAL_IDX, Guid? rESOURCE_IDX, string rOLE_NAME, string aGENCY, int? sEQ_NO, string tRAINEE_IND, string cONTACT_TYPE, string cONTACT_INFO, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    //first try to grab from TEAM_DTL
                    T_EM_INCIDENT_TEAM_DTL e = (from c in ctx.T_EM_INCIDENT_TEAM_DTL
                                              where c.INCIDENT_TEAM_DTL_IDX == iNCIDENT_TEAM_DTL_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INCIDENT_TEAM_DTL();
                        e.INCIDENT_TEAM_DTL_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (iNCIDENT_OP_PERIOD_IDX != null) e.INCIDENT_OP_PERIOD_IDX = iNCIDENT_OP_PERIOD_IDX.ConvertOrDefault<Guid>();
                    if (iNCIDENT_IDX != null) e.INCIDENT_IDX = iNCIDENT_IDX.ConvertOrDefault<Guid>();
                    if (rEPORTS_TO_TEAM_DTL_IDX != null) e.REPORTS_TO_TEAM_DTL_IDX = rEPORTS_TO_TEAM_DTL_IDX;
                    if (iNDIVIDUAL_IDX != null) e.INDIVIDUAL_IDX = iNDIVIDUAL_IDX;
                    if (rESOURCE_IDX != null) e.RESOURCE_IDX = rESOURCE_IDX;
                    if (rOLE_NAME != null) e.ROLE_NAME = rOLE_NAME;
                    if (aGENCY != null) e.AGENCY = aGENCY;
                    if (sEQ_NO != null) e.SEQ_NO = sEQ_NO;
                    if (tRAINEE_IND != null) e.TRAINEE_IND = tRAINEE_IND;
                    if (cONTACT_TYPE != null) e.CONTACT_TYPE = cONTACT_TYPE;
                    if (cONTACT_INFO != null) e.CONTACT_INFO = cONTACT_INFO;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INCIDENT_TEAM_DTL.Add(e);

                    ctx.SaveChanges();
                    return e.INCIDENT_TEAM_DTL_IDX;
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_INCIDENT_TEAM_DTL(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_INCIDENT_TEAM_DTL rec = ctx.T_EM_INCIDENT_TEAM_DTL.Find(id);
                    ctx.T_EM_INCIDENT_TEAM_DTL.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }


        //********************T_EM_INDIVIDUAL************************************
        public static List<T_EM_INDIVIDUALS> GetT_EM_INDIVIDUALS_ByUserIDX(int UserIDX, string _name, string qualType)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (_name == "") _name = null;

                    return (from a in ctx.T_EM_INDIVIDUALS
                            join o in ctx.T_EM_USER_ORG on a.ORG_IDX equals o.ORG_IDX
                            where o.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && (_name == null ? true : a.INDV_LAST_NAME.Contains(_name))
                            orderby a.INDV_LAST_NAME
                            select a).Include("T_OE_ORGANIZATIONS").ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<IndividualDisplayType> GetT_EM_INDIVIDUALS_Display_ByUserIDX(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_INDIVIDUALS
                            join o in ctx.T_EM_USER_ORG on a.ORG_IDX equals o.ORG_IDX
                            where o.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && o.STATUS_CD == "A"
                            orderby a.INDV_LAST_NAME
                            select new IndividualDisplayType {
                                INDIVIDUAL_IDX = a.INDIVIDUAL_IDX,
                                ORG_IDX = a.ORG_IDX, 
                                INDV_FIRST_NAME = a.INDV_FIRST_NAME, 
                                INDV_MID_NAME = a.INDV_MID_NAME,
                                INDV_LAST_NAME = a.INDV_LAST_NAME,
                                INDV_DOB = a.INDV_DOB,
                                INDV_PHONE = a.INDV_PHONE,
                                INDV_EMAIL = a.INDV_EMAIL,
                                ADD_LINE_ADR = a.ADD_LINE_ADR,
                                ADD_CITY = a.ADD_CITY,
                                ADD_STATE = a.ADD_STATE,
                                ADD_ZIP = a.ADD_ZIP,
                                MODIFY_USERIDX = a.MODIFY_USERIDX,
                                MODIFY_DT = a.MODIFY_DT,
                                INDV_AFFILIATION = a.INDV_AFFILIATION,
                                ACT_IND = a.ACT_IND                                
                            }).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_QUALIFICATIONS> GetT_EM_QUALIFICATIONS_ByUserIDX(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    return (from a in ctx.T_EM_INDIVIDUALS
                            join o in ctx.T_EM_USER_ORG on a.ORG_IDX equals o.ORG_IDX
                            join q in ctx.T_EM_QUALIFICATIONS on a.INDIVIDUAL_IDX equals q.INDIVIDUAL_IDX
                            where o.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && q.ACT_IND == true
                            && o.STATUS_CD == "A"
                            select q).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        public static T_EM_INDIVIDUALS GetT_EM_INDIVIDUAL_ByID(Guid? id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_INDIVIDUALS
                            where a.INDIVIDUAL_IDX == id
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_INDIVIDUALS(Guid? iNDIVIDUAL_IDX, Guid? oRG_IDX, string iNDV_FIRST_NAME, string iNDV_MID_NAME, string iNDV_LAST_NAME, DateTime? iNDV_DOB, 
            string iNDV_PHONE, string iNDV_EMAIL, string aDD_LINE_ADR, string aDD_CITY, string aDD_STATE, string aDD_ZIP, int? lINKED_USERIDX, string iNDV_AFFILIATION, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_INDIVIDUALS e = null;

                    e = (from c in ctx.T_EM_INDIVIDUALS
                         where c.INDIVIDUAL_IDX == iNDIVIDUAL_IDX
                         select c).FirstOrDefault();

                    //now try to grab from name and email
                    if (e == null)
                    {
                        e = (from c in ctx.T_EM_INDIVIDUALS
                             where c.INDV_LAST_NAME.ToUpper() == iNDV_LAST_NAME.ToUpper()
                             && c.INDV_EMAIL.ToUpper() == iNDV_EMAIL.ToUpper()
                             select c).FirstOrDefault();
                    }

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_INDIVIDUALS();
                        e.INDIVIDUAL_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX.ConvertOrDefault<Guid>();
                    if (iNDV_FIRST_NAME != null) e.INDV_FIRST_NAME = iNDV_FIRST_NAME;
                    if (iNDV_MID_NAME != null) e.INDV_MID_NAME = iNDV_MID_NAME;
                    if (iNDV_LAST_NAME != null) e.INDV_LAST_NAME = iNDV_LAST_NAME;
                    if (iNDV_DOB != null) e.INDV_DOB = iNDV_DOB;
                    if (iNDV_PHONE != null) e.INDV_PHONE = iNDV_PHONE;
                    if (iNDV_EMAIL != null) e.INDV_EMAIL = iNDV_EMAIL;
                    if (aDD_LINE_ADR != null) e.ADD_LINE_ADR = aDD_LINE_ADR;
                    if (aDD_CITY != null) e.ADD_CITY = aDD_CITY;
                    if (aDD_STATE != null) e.ADD_STATE = aDD_STATE;
                    if (aDD_ZIP != null) e.ADD_ZIP = aDD_ZIP;
                    if (lINKED_USERIDX != null) e.LINKED_USERIDX = lINKED_USERIDX;
                    if (iNDV_AFFILIATION != null) e.INDV_AFFILIATION = iNDV_AFFILIATION;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_INDIVIDUALS.Add(e);

                    ctx.SaveChanges();
                    return e.INDIVIDUAL_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //********************T_EM_QUALIFICATIONS************************************
        public static List<QualificationDisplayType> GetT_EM_QUALIFICATIONSAdvSearch(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_QUALIFICATIONS
                            join uo in ctx.T_EM_USER_ORG on a.ORG_IDX equals uo.ORG_IDX
                            join o in ctx.T_OE_ORGANIZATIONS on uo.ORG_IDX equals o.ORG_IDX
                            join i in ctx.T_EM_INDIVIDUALS on a.INDIVIDUAL_IDX equals i.INDIVIDUAL_IDX
                            join qt in ctx.T_EM_REF_QUAL_TYPE on a.QUAL_TYPE_IDX equals qt.QUAL_TYPE_IDX
                            where uo.USER_IDX == UserIDX
                            select new QualificationDisplayType
                            {
                                ORG_IDX = a.ORG_IDX,
                                INDIVIDUAL_IDX = a.INDIVIDUAL_IDX,
                                ORG_NAME = o.ORG_NAME,
                                INDV_FIRST_NAME = i.INDV_FIRST_NAME,
                                INDV_LAST_NAME = i.INDV_LAST_NAME,
                                QUALIFICATION_IDX = a.QUALIFICATION_IDX,
                                EXP_DATE = a.EXP_DATE,
                                CREATE_USERIDX = "",
                                CREATE_DT = a.CREATE_DT,
                                MODIFY_USERIDX = "",
                                MODIFY_DT = a.MODIFY_DT,
                                QUAL_TYPE_NAME = qt.QUAL_TYPE_NAME
                            }).ToList();

                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }
        
        public static List<QualificationDisplayType> GetT_EM_QUALIFICATIONS_ByIndividualIDX(Guid? IndIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_QUALIFICATIONS
                            join qt in ctx.T_EM_REF_QUAL_TYPE on a.QUAL_TYPE_IDX equals qt.QUAL_TYPE_IDX
                            where a.INDIVIDUAL_IDX == IndIDX
                            && a.ACT_IND == true
                            select
                            new QualificationDisplayType
                            {
                                ORG_IDX = a.ORG_IDX,
                                INDIVIDUAL_IDX = a.INDIVIDUAL_IDX,
                                ORG_NAME = null,
                                INDV_FIRST_NAME = null,
                                INDV_LAST_NAME = null,
                                QUAL_TYPE_IDX = a.QUAL_TYPE_IDX,
                                QUALIFICATION_IDX = a.QUALIFICATION_IDX,
                                EFF_DATE = a.EFF_DATE,
                                EXP_DATE = a.EXP_DATE,
                                CREATE_USERIDX = "",
                                CREATE_DT = a.CREATE_DT,
                                MODIFY_USERIDX = "",
                                MODIFY_DT = a.MODIFY_DT,
                                QUAL_TYPE_NAME = qt.QUAL_TYPE_NAME
                            }).ToList();

                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_QUALIFICATIONS(Guid? qUALIFICATION_IDX, Guid? oRG_IDX, Guid? iNDIVIDUAL_IDX, Guid? qUAL_TYPE_IDX, DateTime? eFF_DATE, DateTime? eXP_DATE, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_QUALIFICATIONS e = (from c in ctx.T_EM_QUALIFICATIONS
                                             where c.QUALIFICATION_IDX == qUALIFICATION_IDX
                                             select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_QUALIFICATIONS();
                        e.QUALIFICATION_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX.ConvertOrDefault<Guid>();
                    if (iNDIVIDUAL_IDX != null) e.INDIVIDUAL_IDX = iNDIVIDUAL_IDX.ConvertOrDefault<Guid>();
                    if (qUAL_TYPE_IDX != null) e.QUAL_TYPE_IDX = qUAL_TYPE_IDX.ConvertOrDefault<Guid>();
                    if (eFF_DATE != null) e.EFF_DATE = eFF_DATE;
                    if (eXP_DATE != null) e.EXP_DATE = eXP_DATE;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_QUALIFICATIONS.Add(e);

                    ctx.SaveChanges();
                    return e.QUALIFICATION_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_QUALIFICATIONS(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_QUALIFICATIONS rec = ctx.T_EM_QUALIFICATIONS.Find(id);
                    ctx.T_EM_QUALIFICATIONS.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //*****************T_EM_RESOURCE ***************************************        
        public static Guid? InsertUpdateT_EM_RESOURCE(Guid? rESOURCE_IDX, Guid? oRG_IDX, Guid? rESOURCE_TYPE_IDX, string rESOURCE_COUNT, string rESOURCE_UNIT, string rESOURCE_DESC,
            decimal? rESOURCE_LAT, decimal? rESOURCE_LONG, string rESOURCE_SHARE_TIER, int? fEMA_NIMS_TYPE, string rESOURCE_STATUS_CD, bool aCT_IND, int? cREATE_USER, Boolean mobileInd = false, DateTime? ResourceExpDt = null)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_RESOURCE e = (from c in ctx.T_EM_RESOURCE
                                       where c.RESOURCE_IDX == rESOURCE_IDX
                                       select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_RESOURCE();
                        if (mobileInd == false)  //set new GUID but not for mobile, which sets its own
                            e.RESOURCE_IDX = Guid.NewGuid();
                        else
                            e.RESOURCE_IDX = rESOURCE_IDX.ConvertOrDefault<Guid>();

                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX.ConvertOrDefault<Guid>();
                    if (rESOURCE_TYPE_IDX != null) e.RESOURCE_TYPE_IDX = rESOURCE_TYPE_IDX.ConvertOrDefault<Guid>();
                    if (rESOURCE_COUNT != null) e.RESOURCE_COUNT = rESOURCE_COUNT;
                    if (rESOURCE_UNIT != null) e.RESOURCE_UNIT = rESOURCE_UNIT;
                    if (rESOURCE_DESC != null) e.RESOURCE_DESC = rESOURCE_DESC;
                    if (rESOURCE_LAT != null) e.RESOURCE_LAT = rESOURCE_LAT;
                    if (rESOURCE_LONG != null) e.RESOURCE_LONG = rESOURCE_LONG;
                    if (rESOURCE_SHARE_TIER != null) e.SHARE_TYPE = rESOURCE_SHARE_TIER;
                    if (fEMA_NIMS_TYPE != null) e.FEMA_NIMS_TYPE = fEMA_NIMS_TYPE;
                    if (rESOURCE_STATUS_CD != null) e.RESOURCE_STATUS_CD = rESOURCE_STATUS_CD;
                    if (ResourceExpDt != null) e.RESOURCE_EXP_DT = ResourceExpDt;
                    e.ACT_IND = aCT_IND;


                    if (insInd)
                        ctx.T_EM_RESOURCE.Add(e);

                    ctx.SaveChanges();
                    return e.RESOURCE_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static T_EM_RESOURCE GetT_EM_RESOURCE_ByResourceIDX(Guid ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_RESOURCE.Include("T_EM_REF_RESOURCE_TYPE")
                            where a.RESOURCE_IDX == ResourceIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int GetT_EM_RESOURCE_ByResourceTypeIDX(Guid ResourceTypeIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_RESOURCE
                            where a.RESOURCE_TYPE_IDX == ResourceTypeIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static List<T_EM_RESOURCE> GetT_EM_RESOURCE_TeamsByUserIDX(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_RESOURCE
                            join uo in ctx.T_EM_USER_ORG on a.ORG_IDX equals uo.ORG_IDX
                            join rt in ctx.T_EM_REF_RESOURCE_TYPE on a.RESOURCE_TYPE_IDX equals rt.RESOURCE_TYPE_IDX
                            where uo.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && rt.RESOURCE_KIND == "Team"
                            select a).Include("T_EM_REF_RESOURCE_TYPE").ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_RESOURCE(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //if resource has been used as an Incident Resource or Incident Team, cannot delete
                    int iCount = GetT_EM_INCIDENT_RESOURCES_CountbyResourceIDX(id);
                    if (GetT_EM_INCIDENT_RESOURCES_CountbyResourceIDX(id) > 0 || GetT_EM_INCIDENT_TEAM_DTL_CountbyResourceIDX(id) > 0)
                    {
                        InsertUpdateT_EM_RESOURCE(id, null, null, null, null, null, null, null, null, null, null, false, 0);
                    }
                    else
                    {
                        T_EM_RESOURCE rec = ctx.T_EM_RESOURCE.Find(id);
                        ctx.T_EM_RESOURCE.Remove(rec);
                        ctx.SaveChanges();
                    }
                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //*****************T_EM_RESOURCE_DTL ***************************************        
        public static Guid? InsertUpdateT_EM_RESOURCE_DTL(Guid? rESOURCE_DTL_IDX, Guid? rESOURCE_IDX, Guid? rESOURCE_TYPE_DTL_IDX, string vALUE, int? cREATE_USER, Boolean aCT_IND = true)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_RESOURCE_DTL e = (from c in ctx.T_EM_RESOURCE_DTL
                                           where c.RESOURCE_DTL_IDX == rESOURCE_DTL_IDX
                                           select c).FirstOrDefault();

                    //if IDX is not supplied, try to grab based on Resource and Resource Type 
                    if (e == null)
                        e = (from c in ctx.T_EM_RESOURCE_DTL
                             where c.RESOURCE_IDX == rESOURCE_IDX
                             && c.RESOURCE_TYPE_DTL_IDX == rESOURCE_TYPE_DTL_IDX
                             select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_RESOURCE_DTL();
                        e.RESOURCE_DTL_IDX = Guid.NewGuid();
                        e.RESOURCE_IDX = rESOURCE_IDX.ConvertOrDefault<Guid>();
                        e.RESOURCE_TYPE_DTL_IDX = rESOURCE_TYPE_DTL_IDX.ConvertOrDefault<Guid>();
                        e.CREATE_USERIDX = cREATE_USER;
                        e.CREATE_DT = System.DateTime.Now;
                        e.ACT_IND = aCT_IND;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (vALUE != null) e.VALUE = vALUE;

                    if (insInd)
                        ctx.T_EM_RESOURCE_DTL.Add(e);

                    ctx.SaveChanges();
                    return e.RESOURCE_DTL_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        //*****************T_EM_RESOURCE_VER_HIST ***************************************        
        public static Guid? InsertUpdateT_EM_RESOURCE_VER_HIST(Guid? rESOURCE_VER_HIST_IDX, Guid? rESOURCE_IDX, DateTime? vERIFICATION_DT, int? vERIFIED_BY_IDX, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_RESOURCE_VER_HIST e = (from c in ctx.T_EM_RESOURCE_VER_HIST
                                           where c.RESOURCE_VER_HIST_IDX == rESOURCE_VER_HIST_IDX
                                           select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_RESOURCE_VER_HIST();
                        e.RESOURCE_VER_HIST_IDX = Guid.NewGuid();
                        e.RESOURCE_IDX = rESOURCE_IDX.ConvertOrDefault<Guid>();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }

                    if (vERIFICATION_DT != null) e.VERIFICATION_DT = vERIFICATION_DT;
                    if (vERIFIED_BY_IDX != null) e.VERIFIED_BY_IDX = vERIFIED_BY_IDX;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_RESOURCE_VER_HIST.Add(e);

                    ctx.SaveChanges();
                    return e.RESOURCE_VER_HIST_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_RESOURCE_VER_HIST> GetT_EM_RESOURCE_VER_HIST_ByResourceIDX(Guid ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_RESOURCE_VER_HIST.Include("T_OE_USERS")
                            where a.RESOURCE_IDX == ResourceIDX 
                            orderby a.VERIFICATION_DT
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static T_EM_RESOURCE_VER_HIST GetT_EM_RESOURCE_VER_HIST_LatestByResourceIDX(Guid? ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var rec = (from a in ctx.T_EM_RESOURCE_VER_HIST.Include("T_OE_USERS")
                            where a.RESOURCE_IDX == ResourceIDX
                            select a).ToList();

                    rec.OrderByDescending(t => t.VERIFICATION_DT);

                    return rec.FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_RESOURCE_VER_HIST(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_RESOURCE_VER_HIST rec = ctx.T_EM_RESOURCE_VER_HIST.Find(id);
                    ctx.T_EM_RESOURCE_VER_HIST.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //*****************T_EM_USER_ORG ***************************************        
        public static Guid? InsertUpdateT_EM_USER_ORG(int uSER_IDX, Guid oRG_IDX, string rOLE_CD, string sTATUS_CD, int? cREATE_USER = 0)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_USER_ORG e = (from c in ctx.T_EM_USER_ORG
                                       where c.USER_IDX == uSER_IDX
                                       && c.ORG_IDX == oRG_IDX
                                       select c).FirstOrDefault();
                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_USER_ORG();
                        e.USER_ORG_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    e.USER_IDX = uSER_IDX;
                    e.ORG_IDX = oRG_IDX;
                    e.ACT_IND = true;
                    if (rOLE_CD != null) e.ROLE_CD = rOLE_CD;
                    if (sTATUS_CD != null) e.STATUS_CD = sTATUS_CD;

                    if (insInd)
                        ctx.T_EM_USER_ORG.Add(e);

                    ctx.SaveChanges();
                    return e.USER_ORG_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        /// <summary>
        /// Returns all people who are pending approval for organizations which I am an administrator for
        /// </summary>
        /// <param name="uSER_IDX"></param>
        /// <returns></returns>
        public static List<UserOrgDisplayType> GetMyPendingUsers(int uSER_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var x = (from auo in ctx.T_EM_USER_ORG
                            join uuo in ctx.T_EM_USER_ORG on auo.ORG_IDX equals uuo.ORG_IDX
                            join u in ctx.T_OE_USERS on uuo.USER_IDX equals u.USER_IDX
                            join o in ctx.T_OE_ORGANIZATIONS on uuo.ORG_IDX equals o.ORG_IDX
                            where uuo.STATUS_CD == "P"
                            && auo.ROLE_CD == "A"
                            && auo.STATUS_CD == "A"
                            && auo.USER_IDX == uSER_IDX
                            select new UserOrgDisplayType
                            {
                                USER_ORG_IDX = uuo.USER_ORG_IDX,
                                USER_IDX = uuo.USER_IDX,
                                ORG_IDX = uuo.ORG_IDX,
                                ORG_NAME = o.ORG_NAME,
                                ROLE_CD = uuo.ROLE_CD,
                                CREATE_DT = uuo.CREATE_DT,
                                USER_NAME = u.USER_ID
                            }).ToList();

                    if (x == null)
                        x = new List<UserOrgDisplayType>();

                    return x;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return new List<UserOrgDisplayType>();
                }
            }
        }

        /// <summary>
        /// For global admins, shows all pending users
        /// </summary>
        /// <returns></returns>
        public static List<UserOrgDisplayType> GetAllPendingUsers()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var x = (from uo in ctx.T_EM_USER_ORG
                             join u in ctx.T_OE_USERS on uo.USER_IDX equals u.USER_IDX
                             join o in ctx.T_OE_ORGANIZATIONS on uo.ORG_IDX equals o.ORG_IDX
                             where uo.STATUS_CD == "P"
                             select new UserOrgDisplayType
                             {
                                 USER_ORG_IDX = uo.USER_ORG_IDX,
                                 USER_IDX = uo.USER_IDX,
                                 ORG_IDX = uo.ORG_IDX,
                                 ORG_NAME = o.ORG_NAME,
                                 ROLE_CD = uo.ROLE_CD,
                                 CREATE_DT = uo.CREATE_DT,
                                 USER_NAME = u.USER_ID
                             }).ToList();

                    if (x == null)
                        x = new List<UserOrgDisplayType>();

                    return x;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return new List<UserOrgDisplayType>();
                }
            }
        }

        public static List<UserOrgDisplayType> GetT_EM_USER_ORG_ByOrgID(Guid oRG_IDX, string rOLE_CD)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_OE_ORGANIZATIONS
                            join b in ctx.T_EM_USER_ORG on a.ORG_IDX equals b.ORG_IDX
                            join c in ctx.T_OE_USERS on b.USER_IDX equals c.USER_IDX
                            where a.ORG_IDX == oRG_IDX
                            && b.STATUS_CD == "A"
                            && (rOLE_CD == null ? true : b.ROLE_CD == rOLE_CD)
                            select new UserOrgDisplayType
                            {
                                USER_ORG_IDX = b.USER_ORG_IDX,
                                USER_IDX = c.USER_IDX,
                                ORG_IDX = a.ORG_IDX,
                                ROLE_CD = b.ROLE_CD,
                                CREATE_DT = b.CREATE_DT,
                                USER_NAME = c.USER_ID
                            }).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_USER_ORG(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_EM_USER_ORG rec = ctx.T_EM_USER_ORG.Find(id);
                    ctx.T_EM_USER_ORG.Remove(rec);
                    ctx.SaveChanges();

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }

        /// <summary>
        /// Checks if the user is an admin of any organization
        /// </summary>
        /// <param name="uSER_IDX"></param>
        /// <returns></returns>
        public static bool IsAnOrgAdmin(int uSER_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    int iCount = (from a in ctx.T_EM_USER_ORG
                             where a.USER_IDX == uSER_IDX
                             && a.ROLE_CD == "A"
                             && a.STATUS_CD == "A"
                             select a).Count();

                    return iCount > 0;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return false;
                }
            }
        }

        /// <summary>
        /// Checks if the user belongs to any organization
        /// </summary>
        /// <param name="uSER_IDX"></param>
        /// <returns></returns>
        public static bool BelongsToOrg(int uSER_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    int iCount = (from a in ctx.T_EM_USER_ORG
                                  where a.USER_IDX == uSER_IDX
                                  && a.STATUS_CD == "A"
                                  select a).Count();

                    return iCount > 0;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return false;
                }
            }
        }

        /// <summary>
        /// Lists all organizations which a user has been approved for
        /// </summary>
        /// <param name="uSER_IDX"></param>
        /// <returns></returns>
        public static List<UserOrgDisplayType> GetT_EM_USER_ORG_byUSER_IDX(int uSER_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var x = (from uuo in ctx.T_EM_USER_ORG 
                             join u in ctx.T_OE_USERS on uuo.USER_IDX equals u.USER_IDX
                             join o in ctx.T_OE_ORGANIZATIONS on uuo.ORG_IDX equals o.ORG_IDX
                             where uuo.STATUS_CD == "A"
                             && uuo.USER_IDX == uSER_IDX
                             select new UserOrgDisplayType
                             {
                                 USER_ORG_IDX = uuo.USER_ORG_IDX,
                                 USER_IDX = uuo.USER_IDX,
                                 ORG_IDX = uuo.ORG_IDX,
                                 ORG_NAME = o.ORG_NAME,
                                 ROLE_CD = uuo.ROLE_CD,
                                 CREATE_DT = uuo.CREATE_DT,
                                 USER_NAME = u.USER_ID
                             }).ToList();

                    if (x == null)
                        x = new List<UserOrgDisplayType>();

                    return x;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return new List<UserOrgDisplayType>();
                }
            }
        }

        /// <summary>
        /// Lists all users who do not currently belong to org
        /// </summary>
        /// <param name="uSER_IDX"></param>
        /// <returns></returns>
        public static List<T_OE_USERS> GetT_EM_USER_ORG_allUsersNotInOrg(Guid? oRG_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //first get all users 
                    var allUsers = (from itemA in ctx.T_OE_USERS
                                    where itemA.ACT_IND == true
                                    select itemA);

                    //next get all users in org
                    var UsersInOrg = (from itemA in ctx.T_OE_USERS
                                       join itemB in ctx.T_EM_USER_ORG on itemA.USER_IDX equals itemB.USER_IDX
                                       where itemB.ORG_IDX == oRG_IDX
                                      select itemA);

                    //then get exclusions
                    var usersNotInOrg = allUsers.Except(UsersInOrg);

                    return usersNotInOrg.OrderBy(a => a.EMAIL).ToList();
               }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return new List<T_OE_USERS>();
                }
            }
        }

        /// <summary>
        /// Will return true if the supplied user belongs to the org
        /// </summary>
        public static bool GetT_EM_USER_ORG_ByUserAndOrgID(Guid oRG_IDX, int uSER_IDX, bool excludePending)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var x = (from a in ctx.T_EM_USER_ORG 
                            where a.ORG_IDX == oRG_IDX
                            && a.USER_IDX == uSER_IDX
                            && (excludePending == true ? a.STATUS_CD == "A" : true)
                            select a).Count();

                    return x > 0 ? true : false;

                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return false;
                }
            }
        }



        //******************T_EM_USER_NOTIFICATION*******************************
        public static T_EM_USER_NOTIFICATION GetT_EM_USER_NOTIFICATION_byID(Guid? NotificationIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_USER_NOTIFICATION
                            where a.NOTIFICATION_IDX == NotificationIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_USER_NOTIFICATION> GetT_EM_USER_NOTIFICATION_byUserIDX(int? UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (UserIDX == null) return null;

                    return (from a in ctx.T_EM_USER_NOTIFICATION
                            where a.USER_IDX == UserIDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_EM_USER_NOTIFICATION(Guid? nOTIFICATION_IDX, int uSER_IDX, DateTime? nOTIFY_DT, string nOTIFY_TYPE, string nOTIFY_TITLE, 
            string nOTIFY_DESC, Boolean rEAD_IND, int? fROM_USER_IDX, Boolean aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_USER_NOTIFICATION e = (from c in ctx.T_EM_USER_NOTIFICATION
                                                where c.NOTIFICATION_IDX == nOTIFICATION_IDX
                                                select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_USER_NOTIFICATION();
                        e.NOTIFICATION_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    e.USER_IDX = uSER_IDX;
                    if (nOTIFY_DT != null) e.NOTIFY_DT = nOTIFY_DT.ConvertOrDefault<DateTime>();
                    if (nOTIFY_TYPE != null) e.NOTIFY_TYPE = nOTIFY_TYPE;
                    if (nOTIFY_TITLE != null) e.NOTIFY_TITLE = nOTIFY_TITLE;
                    if (nOTIFY_DESC != null) e.NOTIFY_DESC = nOTIFY_DESC;
                    e.READ_IND = rEAD_IND;
                    if (fROM_USER_IDX != null) e.FROM_USER_IDX = fROM_USER_IDX;

                    if (insInd)
                        ctx.T_EM_USER_NOTIFICATION.Add(e);

                    ctx.SaveChanges();
                    return e.NOTIFICATION_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_USER_NOTIFICATION(Guid id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Database.ExecuteSqlCommand("DELETE FROM T_EM_USER_NOTIFICATION where NOTIFICATION_IDX = {0}", id);

                    return 1;
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }



        //*****************T_OE_ORGANIZATIONS********************************         
        public static List<T_OE_ORGANIZATIONS> GetT_OE_ORGANIZATIONS()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_OE_ORGANIZATIONS
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ORGANIZATIONS> GetT_OE_ORGANIZATIONS_AllowJoin()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_OE_ORGANIZATIONS
                            where a.ALLOW_JOIN_IND == true
                            && a.ACT_IND == true
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ORGANIZATIONS> GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG(int UserIDX, bool AdminOnly = false)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    return (from a in ctx.T_OE_ORGANIZATIONS
                            join b in ctx.T_EM_USER_ORG on a.ORG_IDX equals b.ORG_IDX
                            where b.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && (AdminOnly == true ? b.ROLE_CD == "A" : true)
                            && b.STATUS_CD == "A"
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ORGANIZATIONS> GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG_All(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    var tbl1 = (from a in ctx.T_OE_ORGANIZATIONS
                            join b in ctx.T_EM_USER_ORG on a.ORG_IDX equals b.ORG_IDX
                            where b.USER_IDX == UserIDX
                            && a.ACT_IND == true
                            && b.STATUS_CD == "A"
                            select a);

                    var tbl2 = (from a in ctx.T_OE_ORGANIZATIONS
                                join b in ctx.T_EM_RESOURCE on a.ORG_IDX equals b.ORG_IDX
                                where b.ACT_IND == true
                                && (b.SHARE_TYPE == "All Jurisdictions" || b.SHARE_TYPE == "Public")
                                select a);

                    var tbl3 = (from a in ctx.T_OE_ORGANIZATIONS
                                join b in ctx.T_EM_INCIDENT on a.ORG_IDX equals b.ORG_IDX
                                where b.ACT_IND == true
                                && (b.SHARE_TYPE == "All Jurisdictions" || b.SHARE_TYPE == "Public")
                                select a);

                    var xtot = tbl1.Union(tbl2).Union(tbl3).OrderBy(a => a.ORG_NAME).ToList();

                    return xtot;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }



        public static T_OE_ORGANIZATIONS GetT_OE_ORGANIZATIONS_ByOrgIDX(Guid? OrgIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    if (OrgIDX == null)
                        return null;

                    return (from a in ctx.T_OE_ORGANIZATIONS
                            where a.ORG_IDX == OrgIDX
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static Guid? InsertUpdateT_OE_ORGANIZATIONS(Guid oRG_IDX, string oRG_NAME, string oRG_DESC, bool? aLLOW_JOIN_IND, bool aCT_IND, int? cREATE_USER = 0)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_OE_ORGANIZATIONS e = (from c in ctx.T_OE_ORGANIZATIONS
                                            where c.ORG_IDX == oRG_IDX
                                            select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_OE_ORGANIZATIONS();
                        e.ORG_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (oRG_NAME != null) e.ORG_NAME = oRG_NAME;
                    if (oRG_DESC != null) e.ORG_DESC = oRG_DESC;
                    if (aLLOW_JOIN_IND != null) e.ALLOW_JOIN_IND = aLLOW_JOIN_IND;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_OE_ORGANIZATIONS.Add(e);

                    ctx.SaveChanges();
                    return e.ORG_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //******************SP_INCIDENT_ADV_SEARCH*******************************
        public static List<SP_INCIDENT_ADV_SEARCH_Result> GetSP_INCIDENT_ADV_SEARCH(int userIDX, Guid? orgIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_INCIDENT_ADV_SEARCH(userIDX, orgIDX).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }

        //******************SP_INCIDENT_STATUS_QUERY*******************************
        public static List<SP_INCIDENT_STATUS_QUERY_Result> GetSP_INCIDENT_STATUS_QUERY(int userIDX, Guid? orgIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_INCIDENT_STATUS_QUERY(userIDX, orgIDX).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }



        //******************SP_RESOURCE_ADV_SEARCH*******************************
        public static List<SP_RESOURCE_ADV_SEARCH_Result> GetSP_RESOURCE_ADV_SEARCH(int userIDX, Guid? orgIDX, string resourceStr, decimal? latMax, decimal? latMin, decimal? longMax, decimal? longMin, string kind, string status)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_RESOURCE_ADV_SEARCH(userIDX, orgIDX, resourceStr, latMax, latMin, longMax, longMin, kind, status).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }


        //******************SP_RESOURCE_DTL_ADV_SEARCH*******************************
        public static List<SP_RESOURCE_DTL_ADV_SEARCH_Result> GetSP_RESOURCE_DTL_ADV_SEARCH(int userIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_RESOURCE_DTL_ADV_SEARCH(userIDX).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }



        ////******************SP_RESOURCE_DTL*******************************
        public static List<SP_RESOURCE_DTL_Result> GetSP_RESOURCE_DTL(Guid ResourceIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_RESOURCE_DTL(ResourceIDX).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }


        //******************SP_DASHBOARD_COUNTS*******************************
        public static SP_DASHBOARD_COUNTS_Result GetSP_DASHBOARD_COUNTS(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.SP_DASHBOARD_COUNTS(UserIDX).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }


        //******************V_EM_TIMELINE*******************************
        public static List<V_EM_TIMELINE> GetV_EM_TIMELINE_ByIncident(Guid IncidentIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.V_EM_TIMELINE
                            where a.INCIDENT_IDX == IncidentIDX
                            orderby a.TIMELINE_DT
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }

        }



    }
}
