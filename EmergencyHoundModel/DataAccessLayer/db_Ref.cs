using System;
using System.Collections.Generic;
using System.Linq;
using EmergencyHoundModel.Utils;

namespace EmergencyHoundModel.DataAccessLayer
{
    public class db_Ref
    {
        //*****************APP SETTINGS**********************************
        public static string GetT_OE_APP_SETTING(string settingName)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_OE_APP_SETTINGS
                            where a.SETTING_NAME == settingName
                            select a).FirstOrDefault().SETTING_VALUE;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return "";
                }
            }
        }

        public static List<T_OE_APP_SETTINGS> GetT_OE_APP_SETTING_List()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_OE_APP_SETTINGS
                            orderby a.SETTING_IDX
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int InsertUpdateT_OE_APP_SETTING(int sETTING_IDX, string sETTING_NAME, string sETTING_VALUE, bool? eNCRYPT_IND, string sETTING_VALUE_SALT, int? cREATE_USER = 0)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_OE_APP_SETTINGS e = (from c in ctx.T_OE_APP_SETTINGS
                                       where c.SETTING_IDX == sETTING_IDX
                                       select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_OE_APP_SETTINGS();
                    }

                    if (sETTING_NAME != null) e.SETTING_NAME = sETTING_NAME;
                    if (sETTING_VALUE != null) e.SETTING_VALUE = sETTING_VALUE;

                    e.MODIFY_DT = System.DateTime.Now;
                    e.MODIFY_USERIDX = cREATE_USER;

                    if (insInd)
                        ctx.T_OE_APP_SETTINGS.Add(e);

                    ctx.SaveChanges();
                    return e.SETTING_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        
        //*****************SYS_LOG**********************************
        public static int InsertT_OE_SYS_LOG(string logType, string logMsg)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_SYS_LOG e = new T_OE_SYS_LOG();
                    e.LOG_TYPE = logType;
                    e.LOG_MSG = logMsg;
                    e.LOG_DT = System.DateTime.Now;

                    ctx.T_OE_SYS_LOG.Add(e);
                    ctx.SaveChanges();
                    return e.SYS_LOG_ID;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }


        //********************T_EM_REF_DOC_TYPE************************************
        public static List<T_EM_REF_DOC_TYPE> GetT_EM_REF_DOC_TYPE()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_DOC_TYPE
                            where a.ACT_IND == true 
                            orderby a.DOC_TYPE
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_REF_DOC_STATUS_TYPE> GetT_EM_REF_DOC_STATUS_TYPE()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_DOC_STATUS_TYPE
                            where a.ACT_IND == true
                            orderby a.DOC_STATUS_TYPE
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_SHARE_TYPE************************************
        public static List<T_EM_REF_INCIDENT_PRIORITY> GetT_EM_REF_INCIDENT_PRIORITY(DateTime? dt = null)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    if (dt == null) dt = new DateTime(1970, 1, 1);

                    return (from a in ctx.T_EM_REF_INCIDENT_PRIORITY
                            where (a.CREATE_DT >= dt || a.MODIFY_DT >= dt)
                            orderby a.SORT_ORD
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }




        //********************T_EM_REF_QUAL_CATEGORY************************************
        public static List<T_EM_REF_INC_STATUS_TYPE> GetT_EM_REF_INC_STATUS_TYPE()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_INC_STATUS_TYPE
                            orderby a.STATUS_TYPE_CD
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_QUAL_CATEGORY************************************
        public static List<T_EM_REF_MANAGEMENT_ORG> GetT_EM_REF_MANAGEMENT_ORG()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_MANAGEMENT_ORG
                            orderby a.INC_MANAGEMENT_ORG_CD
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_QUAL_CATEGORY************************************
        public static List<T_EM_REF_QUAL_CATEGORY> GetT_EM_REF_QUAL_CATEGORY()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_QUAL_CATEGORY
                            orderby a.QUAL_CAT_NAME
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_QUAL_TYPE************************************
        public static List<T_EM_REF_QUAL_TYPE> GetT_EM_REF_QUAL_TYPE(Guid? QualCategory)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_QUAL_TYPE
                            where (QualCategory == null ? true : a.QUAL_CAT_IDX == QualCategory)
                            orderby a.QUAL_TYPE_NAME
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_REF_QUAL_TYPE> GetT_EM_REF_QUAL_TYPE_byUserIDX(int UserIDX, DateTime? changeDt)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    var x1 = (from r in ctx.T_EM_REF_QUAL_TYPE
                              where r.ACT_IND == true
                              && r.ORG_IDX == null
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);


                    var x2 = (from r in ctx.T_EM_REF_QUAL_TYPE
                              join uo in ctx.T_EM_USER_ORG on r.ORG_IDX equals uo.ORG_IDX
                              where r.ACT_IND == true
                              && uo.STATUS_CD == "A"
                              && uo.USER_IDX == UserIDX
                              && (uo.ORG_IDX != null)
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);

                    var xtot = x1.Union(x2).OrderBy(a => a.QUAL_TYPE_NAME).ToList();

                    return xtot;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }




        //********************T_EM_REF_RESOURCE_CAT************************************
        public static List<T_EM_REF_RESOURCE_CAT> GetT_EM_REF_RESOURCE_CAT()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_CAT
                            orderby a.RESOURCE_CAT_DESC
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_RESOURCE_CORE_CAP************************************
        public static List<T_EM_REF_RESOURCE_CORE_CAP> GetT_EM_REF_RESOURCE_CORE_CAP()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_CORE_CAP
                            orderby a.RESOURCE_CORE_CAP_DESC
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_RESOURCE_KIND************************************
        public static List<T_EM_REF_RESOURCE_KIND> GetT_EM_REF_RESOURCE_KIND()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_KIND
                            orderby a.RESOURCE_KIND_DESC
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_RESOURCE_STATUS************************************
        public static List<T_EM_REF_RESOURCE_STATUS> GetT_EM_REF_RESOURCE_STATUS(DateTime? dt = null)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    if (dt == null) dt = new DateTime(1970, 1, 1);

                    return (from a in ctx.T_EM_REF_RESOURCE_STATUS
                            where (a.CREATE_DT >= dt || a.MODIFY_DT >= dt)

                            orderby a.RESOURCE_STATUS_CD
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        //********************T_EM_REF_RESOURCE_TYPE************************************
        public static Guid? InsertUpdateT_EM_REF_RESOURCE_TYPE(Guid? rESOURCE_TYPE_IDX, string rESOURCE_FEMA_ID, string rESOURCE_TYPE_NAME, string rESOURCE_TYPE_DESC,
            string rESOURCE_FUNCTION, string rESOURCE_CATEGORY, string rESOURCE_KIND, string rESOURCE_DISCIPLINE, string rESOURCE_CORE_CAP, string rESOURCE_ORDERING_INST,
            int rESOURCE_FLAVOR_COUNT, Guid? oRG_IDX, Boolean? aCT_IND, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_REF_RESOURCE_TYPE e = (from c in ctx.T_EM_REF_RESOURCE_TYPE
                                                where c.RESOURCE_TYPE_IDX == rESOURCE_TYPE_IDX
                                                select c).FirstOrDefault();

                    //grab based on FEMA ID if not on IDX
                    if (e == null && rESOURCE_FEMA_ID != null)
                        e = (from c in ctx.T_EM_REF_RESOURCE_TYPE
                             where c.RESOURCE_FEMA_ID == rESOURCE_FEMA_ID
                             select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_REF_RESOURCE_TYPE();
                        e.RESOURCE_TYPE_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }


                    if (rESOURCE_FEMA_ID != null) e.RESOURCE_FEMA_ID = rESOURCE_FEMA_ID;
                    if (rESOURCE_TYPE_NAME != null) e.RESOURCE_TYPE_NAME = rESOURCE_TYPE_NAME;
                    if (rESOURCE_TYPE_DESC != null) e.RESOURCE_TYPE_DESC = rESOURCE_TYPE_DESC;
                    if (rESOURCE_FUNCTION != null) e.RESOURCE_FUNCTION = rESOURCE_FUNCTION;
                    if (rESOURCE_CATEGORY != null) e.RESOURCE_CATEGORY = rESOURCE_CATEGORY;
                    if (rESOURCE_KIND != null) e.RESOURCE_KIND = rESOURCE_KIND;
                    if (rESOURCE_DISCIPLINE != null) e.RESOURCE_DISCIPLINE = rESOURCE_DISCIPLINE;
                    if (rESOURCE_CORE_CAP != null) e.RESOURCE_CORE_CAP = rESOURCE_CORE_CAP;
                    if (rESOURCE_ORDERING_INST != null) e.RESOURCE_ORDERING_INST = rESOURCE_ORDERING_INST;
                    e.RESOURCE_FLAVOR_COUNT = rESOURCE_FLAVOR_COUNT;
                    if (oRG_IDX != null) e.ORG_IDX = oRG_IDX;
                    e.ACT_IND = true;

                    if (insInd)
                        ctx.T_EM_REF_RESOURCE_TYPE.Add(e);

                    ctx.SaveChanges();
                    return e.RESOURCE_TYPE_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_REF_RESOURCE_TYPE> GetT_EM_REF_RESOURCE_TYPE_byOrgIDX(Guid? OrgIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_TYPE.Include("T_OE_ORGANIZATIONS")
                            where a.ACT_IND == true
                            && (OrgIDX == null || a.ORG_IDX == OrgIDX)
                            orderby a.RESOURCE_TYPE_NAME
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_REF_RESOURCE_TYPE> GetT_EM_REF_RESOURCE_TYPE_byUserIDX(int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    var x1 = (from r in ctx.T_EM_REF_RESOURCE_TYPE.Include("T_OE_ORGANIZATIONS")
                              where r.ACT_IND == true
                              && r.ORG_IDX == null
                              select r);


                    var x2 = (from r in ctx.T_EM_REF_RESOURCE_TYPE.Include("T_OE_ORGANIZATIONS")
                              join uo in ctx.T_EM_USER_ORG on r.ORG_IDX equals uo.ORG_IDX
                            where r.ACT_IND == true
                            && uo.STATUS_CD == "A"
                            && uo.USER_IDX == UserIDX
                            && (uo.ORG_IDX != null)
                            select r);

                    var xtot = x1.Union(x2).OrderBy(a => a.RESOURCE_TYPE_NAME).ToList();
               
                    return xtot;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        public static List<T_EM_REF_RESOURCE_TYPE> GetT_EM_REF_RESOURCE_TYPE_byUserIDX_noOrgName(int UserIDX, DateTime changeDt)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    var x1 = (from r in ctx.T_EM_REF_RESOURCE_TYPE
                              where r.ACT_IND == true
                              && r.ORG_IDX == null
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);


                    var x2 = (from r in ctx.T_EM_REF_RESOURCE_TYPE
                              join uo in ctx.T_EM_USER_ORG on r.ORG_IDX equals uo.ORG_IDX
                              where r.ACT_IND == true
                              && uo.STATUS_CD == "A"
                              && uo.USER_IDX == UserIDX
                              && (uo.ORG_IDX != null)
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);

                    var xtot = x1.Union(x2).OrderBy(a => a.RESOURCE_TYPE_NAME).ToList();

                    return xtot;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        public static T_EM_REF_RESOURCE_TYPE GetT_EM_REF_RESOURCE_TYPE_byIDX(Guid? id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_TYPE
                            where a.RESOURCE_TYPE_IDX == id 
                            select a).FirstOrDefault();
                }
                catch (Exception ex)
                {

                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int DeleteT_EM_REF_RESOURCE_TYPE(Guid id, int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //first check if any resources use this resource type
                    int iCount = db_EmergencyHound.GetT_EM_RESOURCE_ByResourceTypeIDX(id);

                    if (iCount == 0)
                    {
                        T_EM_REF_RESOURCE_TYPE rec = ctx.T_EM_REF_RESOURCE_TYPE.Find(id);
                        ctx.T_EM_REF_RESOURCE_TYPE.Remove(rec);
                        ctx.SaveChanges();
                    }
                    else
                        db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE(id, null, null, null, null, null, null, null, null, null, 0, null, false, UserIDX );

                    return 1;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int DeleteT_EM_REF_RESOURCE_TYPE_DTL(Guid id, int UserIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //first check if any resources use this resource type detail
                    int iCount = db_EmergencyHound.GetT_EM_RESOURCE_ByResourceTypeIDX(id);

                    if (iCount == 0)
                    {
                        T_EM_REF_RESOURCE_TYPE_DTL rec = ctx.T_EM_REF_RESOURCE_TYPE_DTL.Find(id);
                        ctx.T_EM_REF_RESOURCE_TYPE_DTL.Remove(rec);
                        ctx.SaveChanges();
                    }
                    else
                        db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL(id, null, null, null, null, null, 0, UserIDX, false);

                    return 1;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }




        //********************T_EM_REF_RESOURCE_TYPE_DTL************************************
        public static Guid? InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL(Guid? rESOURCE_TYPE_DTL_IDX, Guid? rESOURCE_TYPE_IDX, string cOMPONENT, string mETRIC, string cAPABILITY, string cOMMENTS,
            int oRDERING_SEQ, int? cREATE_USER, Boolean aCT_IND)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    if (mETRIC != null) mETRIC = mETRIC.SubStringPlus(0, 149);

                    T_EM_REF_RESOURCE_TYPE_DTL e = (from c in ctx.T_EM_REF_RESOURCE_TYPE_DTL
                                                    where c.RESOURCE_TYPE_DTL_IDX == rESOURCE_TYPE_DTL_IDX
                                                    select c).FirstOrDefault();

                    if (e == null)
                        e = (from c in ctx.T_EM_REF_RESOURCE_TYPE_DTL
                             where c.RESOURCE_TYPE_IDX == rESOURCE_TYPE_IDX
                             && c.COMPONENT == cOMPONENT
                             && c.CAPABILITY == cAPABILITY
                             && c.METRIC == mETRIC
                             select c).FirstOrDefault();


                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_REF_RESOURCE_TYPE_DTL();
                        e.RESOURCE_TYPE_DTL_IDX = Guid.NewGuid();
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (rESOURCE_TYPE_IDX != null) e.RESOURCE_TYPE_IDX = rESOURCE_TYPE_IDX.ConvertOrDefault<Guid>();
                    e.COMPONENT = cOMPONENT;
                    if (mETRIC != null) e.METRIC = mETRIC;
                    e.CAPABILITY = cAPABILITY;
                    if (cOMMENTS != null) e.COMMENTS = cOMMENTS;
                    e.ORDERING_SEQ = oRDERING_SEQ;
                    e.ACT_IND = aCT_IND;

                    if (insInd)
                        ctx.T_EM_REF_RESOURCE_TYPE_DTL.Add(e);

                    ctx.SaveChanges();
                    return e.RESOURCE_TYPE_DTL_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_EM_REF_RESOURCE_TYPE_DTL> GetT_EM_REF_RESOURCE_TYPE_DTL_byTypeIDX(Guid? ResourceTypeIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_TYPE_DTL
                            where a.ACT_IND == true
                            && a.RESOURCE_TYPE_IDX == ResourceTypeIDX
                            orderby a.ORDERING_SEQ, a.COMPONENT
                            select a).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        public static int GetT_EM_REF_RESOURCE_TYPE_DTL_CountbyTypeIDX(Guid? ResourceTypeIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (from a in ctx.T_EM_REF_RESOURCE_TYPE_DTL
                            where a.ACT_IND == true
                            && a.RESOURCE_TYPE_IDX == ResourceTypeIDX
                            select a).Count();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }



        public static List<T_EM_REF_RESOURCE_TYPE_DTL> GetT_EM_REF_RESOURCE_TYPE_DTL_byUserIDX_noOrgName(int UserIDX, DateTime changeDt)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    var x1 = (from r in ctx.T_EM_REF_RESOURCE_TYPE
                              where r.ACT_IND == true
                              && r.ORG_IDX == null
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);


                    var x2 = (from r in ctx.T_EM_REF_RESOURCE_TYPE
                              join uo in ctx.T_EM_USER_ORG on r.ORG_IDX equals uo.ORG_IDX
                              where r.ACT_IND == true
                              && uo.STATUS_CD == "A"
                              && uo.USER_IDX == UserIDX
                              && (uo.ORG_IDX != null)
                              && (r.CREATE_DT >= changeDt || r.MODIFY_DT >= changeDt)
                              select r);

                    var xtot = x1.Union(x2).OrderBy(a => a.RESOURCE_TYPE_NAME);


                    var dtl = (from r in ctx.T_EM_REF_RESOURCE_TYPE_DTL
                               join xxx in xtot on r.RESOURCE_TYPE_IDX equals xxx.RESOURCE_TYPE_IDX
                               select r).ToList();

                    return dtl;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        //********************T_EM_REF_RESOURCE_TYPE_DTL_DATA************************************
        public static int InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL_DATA(Guid rESOURCE_TYPE_DTL_IDX, int tYPE_INT, string vALUE, int? cREATE_USER)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_EM_REF_RESOURCE_TYPE_DTL_DATA e = (from c in ctx.T_EM_REF_RESOURCE_TYPE_DTL_DATA
                                                         where c.RESOURCE_TYPE_DTL_IDX == rESOURCE_TYPE_DTL_IDX
                                                         && c.TYPE_INT == tYPE_INT
                                                         select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_EM_REF_RESOURCE_TYPE_DTL_DATA();
                        e.RESOURCE_TYPE_DTL_IDX = rESOURCE_TYPE_DTL_IDX;
                        e.TYPE_INT = tYPE_INT;
                        e.CREATE_DT = System.DateTime.Now;
                        e.CREATE_USERIDX = cREATE_USER;
                    }
                    else
                    {
                        e.MODIFY_DT = System.DateTime.Now;
                        e.MODIFY_USERIDX = cREATE_USER;
                    }

                    if (vALUE != null) e.VALUE = vALUE;
                    e.ACT_IND = true;

                    if (insInd)
                        ctx.T_EM_REF_RESOURCE_TYPE_DTL_DATA.Add(e);

                    ctx.SaveChanges();
                    return 1;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }


        //********************T_EM_REF_SHARE_TYPE************************************
        public static List<T_EM_REF_SHARE_TYPE> GetT_EM_REF_SHARE_TYPE()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    ctx.Configuration.ProxyCreationEnabled = false;

                    return (from a in ctx.T_EM_REF_SHARE_TYPE
                            orderby a.SHARE_TYPE
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
