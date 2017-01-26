using System;
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
                //fail if user is inactive
                if (u.ACT_IND == false)
                    v.IsValid = "false";

                if (CheckPassword(password, u.PWD_HASH, u.PWD_SALT))
                {
                    //System.Web.HttpContext.Current.Session.Add("iidx", u.CURR_INCIDENT_IDX);
                    v.IsValid = "true";
                    v.AuthToken = Guid.NewGuid();

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

    }
}
