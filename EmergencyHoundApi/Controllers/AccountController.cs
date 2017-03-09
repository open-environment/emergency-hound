using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundApi.Controllers
{
    public class ValidateUserReturnType
    {
        public string IsValid { get; set; }
        public Guid AuthToken { get; set; } 
        public int UserIDX { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
        public string UserPhone { get; set; }
        public bool TrackInd { get; set; }
    }


    [RoutePrefix("api/Account")]
    public class AccountController : ApiController
    {
        public string CustomerName { get; set; }

        [HttpGet]
        public ValidateUserReturnType ValidateUser(string username, string password)
        {
            ValidateUserReturnType v = new ValidateUserReturnType();

            //check if password matches hashed/salted password
            T_OE_USERS u = db_Accounts.GetT_OE_USERSByID(username);
            if (u != null)
            {
                v.UserIDX = u.USER_IDX;

                //fail if user is inactive
                if (u.ACT_IND == false)
                    v.IsValid = "false";

                if (CheckPassword(password, u.PWD_HASH, u.PWD_SALT))
                {
                    //System.Web.HttpContext.Current.Session.Add("iidx", u.CURR_INCIDENT_IDX);
                    v.IsValid = "true";
                    v.AuthToken = Guid.NewGuid();

                    v.UserFirstName = u.FNAME;
                    v.UserLastName = u.LNAME;
                    v.UserPhone = u.PHONE;
                    v.TrackInd = u.TRACK_IND;

                    //log the new token
                    db_Accounts.InsertUpdateT_OE_USER_TOKENS(u.USER_IDX, v.AuthToken);
                }
                else
                {
                    //db_Accounts.UpdateT_OE_USERS(u.USER_IDX, null, null, null, null, null, u.LOG_ATMPT.ConvertOrDefault<int>() < MaxInvalidPasswordAttempts, null, null, null, null, null, null, u.LOG_ATMPT.ConvertOrDefault<int>() + 1);

                    //user account is locked due to too many invalid login attempts
                    //if (u.LOG_ATMPT.ConvertOrDefault<int>() + 1 > MaxInvalidPasswordAttempts)
                    //    Utils.SendEmail(null, u.EMAIL, null, null, "Emergency Hound account locked.", "Your Emergency Hound user account has been locked due to too many incorrect login attempts. Please contact the system administrator to reset your user account.", null, "");

                    v.IsValid = "false";
                }
            }
            else
                v.IsValid = "false";


            return v;

        }

        private string HashPassword(string pass, string salt)
        {
                SHA256Managed hash = new SHA256Managed();
                byte[] utf8 = UTF8Encoding.UTF8.GetBytes(pass + salt);
                StringBuilder s = new StringBuilder(hash.ComputeHash(utf8).Length * 2);
                foreach (byte b in hash.ComputeHash(utf8))
                    s.Append(b.ToString("x2"));
                return s.ToString();
        }

        public bool CheckPassword(string password, string correctHash, string correctsalt)
        {
            string hashpass = HashPassword(password, correctsalt);
            return (correctHash == hashpass);
        }

        // UPDATE THE USER PROFILE
        public string SetUserData(string token, [FromBody]UserDisplayType userData)
        {
            Guid tokenG = new Guid(token);

            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                if (UserIDX > 0)
                {
                    int SuccID = db_Accounts.UpdateT_OE_USERS(UserIDX, null, null, userData.USER_FNAME, userData.USER_LNAME, null, null, null, null, null, userData.USER_PHONE, null, null, null, userData.TRACK_IND);

                    if (SuccID > 0)
                        return "true";
                    else
                        return "false";
                }
            }

            return "false";
        }



        // UPDATE THE USERS LOCATION
        public string SetLocation(string token, [FromBody]LocationDisplayType location)
        {
            try
            {
               Guid tokenG = new Guid(token);

                if (tokenG != Guid.Empty)
                {
                    int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                    if (UserIDX > 0)
                    {
                        Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_USER_LOCATION(UserIDX, location.LATITUDE, location.LONGITUDE);

                        return (SuccID != null ? "true" : "false");
                    }
                }
            }
            catch { }

            return "false";
        }

        // GET LISTING OF ALL USER LOCATIONS
        public IEnumerable<LocationDisplayType> GetAllUserLocations(string token)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

            if (UserIDX > 0)
                return db_EmergencyHound.GetT_EM_USER_LOCATION();
            else
                return null;
        }



    }
}
