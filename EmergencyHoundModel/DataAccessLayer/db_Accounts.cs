using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using EmergencyHoundModel.Utils;


namespace EmergencyHoundModel.DataAccessLayer
{
    public class UserDisplayType
    {
        public int USER_IDX { get; set; }
        public string USER_NAME { get; set; }
        public string USER_FNAME { get; set; }
        public string USER_LNAME { get; set; }
        public string USER_PHONE { get; set; }
        public bool? TRACK_IND { get; set; }
    }

    public class db_Accounts
    {
        //*****************USERS **********************************
        public static int CreateT_OE_USERS(string uSER_ID, string pWD_HASH, string pWD_SALT, string fNAME, string lNAME, string eMAIL, bool aCT_IND, bool iNITAL_PWD_FLAG, 
            DateTime? lASTLOGIN_DT, string pHONE, string pHONE_EXT, int? cREATE_USERIDX, string pORTAL_ID = null)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USERS u = new T_OE_USERS();
                    u.USER_ID = uSER_ID;
                    u.PWD_HASH = pWD_HASH;
                    u.PWD_SALT = pWD_SALT;
                    u.FNAME = fNAME;
                    u.LNAME = lNAME;
                    u.EMAIL = eMAIL;
                    u.ACT_IND = aCT_IND;
                    u.INITAL_PWD_FLAG = iNITAL_PWD_FLAG;
                    u.EFFECTIVE_DT = System.DateTime.Now;
                    u.LASTLOGIN_DT = lASTLOGIN_DT;
                    u.PHONE = pHONE;
                    u.PHONE_EXT = pHONE_EXT;
                    u.CREATE_DT = System.DateTime.Now;
                    u.CREATE_USERIDX = cREATE_USERIDX;
                    if (pORTAL_ID != null)
                        u.PORTAL_ID = pORTAL_ID;

                    ctx.T_OE_USERS.Add(u);
                    ctx.SaveChanges();
                    return u.USER_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static List<T_OE_USERS> GetT_OE_USERS()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_USERS.ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static List<UserDisplayType> GetT_OE_USERSDisplay()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return (
                        from s in ctx.T_OE_USERS
                        where s.ACT_IND == true
                        orderby s.FNAME ascending
                        select new UserDisplayType
                        {
                            USER_IDX = s.USER_IDX,
                            USER_NAME = s.FNAME + " " + s.LNAME
                        }).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static T_OE_USERS GetT_OE_USERSByIDX(int idx)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_USERS.FirstOrDefault(usr => usr.USER_IDX == idx);
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static T_OE_USERS GetT_OE_USERSByID(string id)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_USERS.FirstOrDefault(usr => usr.USER_ID.ToUpper() == id.ToUpper());
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static T_OE_USERS GetT_OE_USERByEmail(string email)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_USERS.FirstOrDefault(usr => usr.EMAIL.ToUpper() == email.ToUpper());
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static string GetT_OE_USER_GetNameByID(string UserID)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var b = (from a in ctx.T_OE_USERS
                             where a.USER_ID == UserID
                             select a).FirstOrDefault();

                    return b.FNAME + " " + b.LNAME;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return "";
                }
            }
        }

        public static T_OE_USERS GetT_OE_USERByPortalID(string portalID)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_USERS.FirstOrDefault(usr => usr.PORTAL_ID.ToUpper() == portalID.ToUpper());
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static int UpdateT_OE_USERS(int idx, string newPWD_HASH, string newPWD_SALT, string newFNAME, string newLNAME, string newEMAIL, bool? newACT_IND, bool? newINIT_PWD_FLG, DateTime? newEFF_DATE, DateTime? newLAST_LOGIN_DT, string newPHONE, string newPHONE_EXT, int? newMODIFY_USR, int? LogAtmpt, bool? TrackInd, string pORTAL_ID = null)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USERS row = new T_OE_USERS();
                    row = (from c in ctx.T_OE_USERS where c.USER_IDX == idx select c).First();

                    if (newPWD_HASH != null) row.PWD_HASH = newPWD_HASH;
                    if (newPWD_SALT != null) row.PWD_SALT = newPWD_SALT;
                    if (newFNAME != null) row.FNAME = newFNAME;
                    if (newLNAME != null) row.LNAME = newLNAME;
                    if (newEMAIL != null) row.EMAIL = newEMAIL;
                    if (newACT_IND != null) row.ACT_IND = (bool)newACT_IND;
                    if (newINIT_PWD_FLG != null) row.INITAL_PWD_FLAG = (bool)newINIT_PWD_FLG;
                    if (newEFF_DATE != null) row.EFFECTIVE_DT = (DateTime)newEFF_DATE;
                    if (newLAST_LOGIN_DT != null) row.LASTLOGIN_DT = (DateTime)newLAST_LOGIN_DT;
                    if (newPHONE != null) row.PHONE = newPHONE;
                    if (newPHONE_EXT != null) row.PHONE_EXT = newPHONE_EXT;
                    if (newMODIFY_USR != null) row.MODIFY_USERIDX = newMODIFY_USR;
                    if (LogAtmpt != null) row.LOG_ATMPT = LogAtmpt;
                    if (TrackInd != null) row.TRACK_IND = TrackInd.ConvertOrDefault<bool>();
                    if (pORTAL_ID != null) row.PORTAL_ID = pORTAL_ID;

                    row.MODIFY_DT = System.DateTime.Now;

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

        public static int UpdateT_OE_USERS_CurrentIncident(int idx, Guid? IncidentIdx)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USERS row = (from c in ctx.T_OE_USERS where c.USER_IDX == idx select c).First();
                    row.CURR_INCIDENT_IDX = IncidentIdx;
                    ctx.SaveChanges();
                    return row.USER_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int UpdateT_OE_USERS_Avatar(int idx, Byte[] UserAvatar)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USERS row = (from c in ctx.T_OE_USERS where c.USER_IDX == idx select c).First();
                    if (UserAvatar != null) row.USER_AVATAR = UserAvatar;
                    ctx.SaveChanges();
                    return row.USER_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int DeleteT_OE_USERS(int idx)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USERS row = ctx.T_OE_USERS.First(i => i.USER_IDX == idx);
                    ctx.T_OE_USERS.Remove(row);
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


        //*****************ROLES **********************************
        public static int CreateT_OE_ROLES(global::System.String rOLE_NAME, global::System.String rOLE_DESC, int? cREATE_USER = 0)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_ROLES r = new T_OE_ROLES();
                    r.ROLE_NAME = rOLE_NAME;
                    r.ROLE_DESC = rOLE_DESC;
                    r.CREATE_DT = System.DateTime.Now;
                    r.CREATE_USERIDX = cREATE_USER;

                    ctx.T_OE_ROLES.Add(r);
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

        public static List<T_OE_ROLES> GetT_OE_ROLES()
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_ROLES.ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static T_OE_ROLES GetT_OE_ROLEByName(string rolename)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_ROLES.FirstOrDefault(role => role.ROLE_NAME.ToUpper() == rolename.ToUpper());
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static T_OE_ROLES GetT_OE_ROLEByIDX(int idx)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    return ctx.T_OE_ROLES.FirstOrDefault(role => role.ROLE_IDX == idx);
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    throw ex;
                }
            }
        }

        public static int UpdateT_OE_ROLE(int idx, string newROLE_NAME, string newROLE_DESC, int? newMODIFY_USR)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_ROLES row = new T_OE_ROLES();
                    row = (from c in ctx.T_OE_ROLES where c.ROLE_IDX == idx select c).First();

                    if (newROLE_NAME != null)
                        row.ROLE_NAME = newROLE_NAME;

                    if (newROLE_DESC != null)
                        row.ROLE_DESC = newROLE_DESC;

                    if (newMODIFY_USR != null)
                        row.MODIFY_USERIDX = newMODIFY_USR;

                    row.MODIFY_DT = System.DateTime.Now;

                    ctx.SaveChanges();
                    return row.ROLE_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

        public static int DeleteT_OE_ROLE(int idx)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_ROLES row = new T_OE_ROLES();
                    row = (from c in ctx.T_OE_ROLES where c.ROLE_IDX == idx select c).First();
                    ctx.T_OE_ROLES.Remove(row);
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

        //*****************ROLE / USER RELATIONSHIP **********************************
        public static List<T_OE_USERS> GetT_OE_USERSInRole(int roleID)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var users = from itemA in ctx.T_OE_USERS
                                join itemB in ctx.T_OE_USER_ROLES on itemA.USER_IDX equals itemB.USER_IDX
                                where itemB.ROLE_IDX == roleID
                                orderby itemA.USER_ID
                                select itemA;

                    return users.ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_USERS> GetT_OE_USERSNotInRole(int roleID)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //first get all users 
                    var allUsers = (from itemA in ctx.T_OE_USERS select itemA);

                    //next get all users in role
                    var UsersInRole = (from itemA in ctx.T_OE_USERS
                                       join itemB in ctx.T_OE_USER_ROLES on itemA.USER_IDX equals itemB.USER_IDX
                                       where itemB.ROLE_IDX == roleID
                                       select itemA);

                    //then get exclusions
                    var usersNotInRole = allUsers.Except(UsersInRole);

                    return usersNotInRole.OrderBy(a => a.USER_ID).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ROLES> GetT_OE_ROLESNotInUser(int userIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //first get all roles 
                    var allUsers = (from itemA in ctx.T_OE_ROLES select itemA);

                    //next get all roles assigned to user
                    var UsersInRole = (from itemA in ctx.T_OE_ROLES
                                       join itemB in ctx.T_OE_USER_ROLES on itemA.ROLE_IDX equals itemB.ROLE_IDX
                                       where itemB.USER_IDX == userIDX
                                       select itemA);

                    //then get exclusions
                    var usersNotInRole = allUsers.Except(UsersInRole);

                    return usersNotInRole.OrderBy(a => a.ROLE_NAME).ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ROLES> GetT_OE_ROLESInUser(int userIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var roles = from itemA in ctx.T_OE_ROLES
                                join itemB in ctx.T_OE_USER_ROLES on itemA.ROLE_IDX equals itemB.ROLE_IDX
                                where itemB.USER_IDX == userIDX
                                select itemA;

                    return roles.ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static List<T_OE_ROLES> GetT_OE_ROLESInUserName(string userName)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    var roles = from itemA in ctx.T_OE_ROLES
                                join itemB in ctx.T_OE_USER_ROLES on itemA.ROLE_IDX equals itemB.ROLE_IDX
                                join itemC in ctx.T_OE_USERS on itemB.USER_IDX equals itemC.USER_IDX
                                where itemC.USER_ID.ToUpper() == userName.ToUpper()
                                select itemA;

                    return roles.ToList();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }


        public static int CreateT_OE_USER_ROLE(global::System.Int32 rOLE_IDX, global::System.Int32 uSER_IDX, int? cREATE_USER = 0)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USER_ROLES ur = new T_OE_USER_ROLES();
                    ur.ROLE_IDX = rOLE_IDX;
                    ur.USER_IDX = uSER_IDX;
                    ur.CREATE_DT = System.DateTime.Now;
                    ur.CREATE_USERIDX = cREATE_USER;
                    ctx.T_OE_USER_ROLES.Add(ur);
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

        public static int DeleteT_OE_USER_ROLE(int UserIDX, int RoleIDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    T_OE_USER_ROLES row = (from c in ctx.T_OE_USER_ROLES
                                           where c.ROLE_IDX == RoleIDX && c.USER_IDX == UserIDX
                                           select c).FirstOrDefault();
                    ctx.T_OE_USER_ROLES.Remove(row);
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

        public static bool checkIfUserHasRole(string UserID, string RoleName)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //next get all users in role
                    int UsersInRole = (from u in ctx.T_OE_USERS
                                       join ur in ctx.T_OE_USER_ROLES on u.USER_IDX equals ur.USER_IDX
                                       join r in ctx.T_OE_ROLES on ur.ROLE_IDX equals r.ROLE_IDX
                                       where r.ROLE_NAME == RoleName
                                       && u.USER_ID == UserID
                                       select ur).Count();

                    //then get exclusions
                    if (UsersInRole > 0)
                        return true;
                    else
                        return false;

                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return false;
                }
            }
        }


        //******************* USER_TOKEN (mobile only) *******************************************
        public static Guid? InsertUpdateT_OE_USER_TOKENS(int uSER_IDX, Guid uSER_TOKEN_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    Boolean insInd = false;

                    T_OE_USER_TOKENS e = (from c in ctx.T_OE_USER_TOKENS
                                              where c.USER_IDX == uSER_IDX
                                              && c.USER_TOKEN_IDX == uSER_TOKEN_IDX
                                              select c).FirstOrDefault();

                    if (e == null)
                    {
                        insInd = true;
                        e = new T_OE_USER_TOKENS();
                    }

                    e.USER_IDX = uSER_IDX;
                    e.USER_TOKEN_IDX = uSER_TOKEN_IDX.ConvertOrDefault<Guid>();
                    e.CREATE_DT = System.DateTime.Now;

                    if (insInd)
                        ctx.T_OE_USER_TOKENS.Add(e);

                    ctx.SaveChanges();
                    return e.USER_TOKEN_IDX;
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return null;
                }
            }
        }

        public static int GetT_OE_USER_TOKEN_byToken(Guid uSER_TOKEN_IDX)
        {
            using (EMERG_DBEntities ctx = new EMERG_DBEntities())
            {
                try
                {
                    //next get all users in role
                    int? UserIDX = (from u in ctx.T_OE_USER_TOKENS
                                       where u.USER_TOKEN_IDX == uSER_TOKEN_IDX
                                       select u.USER_IDX).FirstOrDefault();


                    return UserIDX.ConvertOrDefault<int>();
                }
                catch (Exception ex)
                {
                    db_Util.LogEFException(ex);
                    return 0;
                }
            }
        }

    }
}
