using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.IO;
using EmergencyHoundModel.DataAccessLayer;
using System.ComponentModel;
using System.Security.Claims;

namespace EmergencyHoundWeb.App_Logic
{
    public static class Utils
    {

        /// <summary>
        /// Sends out an email from the application. Returns true if successful. Supports multiple CC, BCC
        /// </summary>
        /// <param name="from">Email address of sender. Leave null to use default.</param>
        /// <param name="to">Email address sending to</param>
        /// <param name="subj">Email subject</param>
        /// <param name="body">Email body</param>
        /// <param name="attach">Attachment as byte array</param>
        /// <param name="attachFileName">Attachment file name including extension e.g. test.doc</param>
        /// <returns></returns>
        public static bool SendEmail(string from, string to, string[] cc, string[] bcc, string subj, string body, byte[] attach, string attachFileName, bool createNotification = false, int fromUserIDX = 0, int toUserIDX = 0)
        {
            try
            {
                //*************SET MESSAGE CONTENTS *********************
                if (from == null)
                    from = db_Ref.GetT_OE_APP_SETTING("EMAIL_FROM");

                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                message.From = new System.Net.Mail.MailAddress(from);
                message.To.Add(to);
                if (cc != null)
                {
                    foreach (string cc1 in cc)
                        message.CC.Add(cc1);
                }
                if (bcc != null)
                {
                    foreach (string bcc1 in bcc)
                        message.Bcc.Add(bcc1);
                }

                message.Subject = subj;
                message.Body = body;
                //*************ATTACHMENT START**************************
                if (attach != null)
                {
                    System.Net.Mail.Attachment att = new System.Net.Mail.Attachment(new MemoryStream(attach), attachFileName);
                    message.Attachments.Add(att);
                }
                //*************ATTACHMENT END****************************


                //***************SET SMTP SERVER *************************
                string mailServer = System.Configuration.ConfigurationManager.AppSettings["emailServer"];
                if (mailServer == null || mailServer == "")
                    mailServer = db_Ref.GetT_OE_APP_SETTING("EMAIL_SERVER");

                string Port = System.Configuration.ConfigurationManager.AppSettings["emailPort"];
                if (Port == null || Port == "")
                    Port = db_Ref.GetT_OE_APP_SETTING("EMAIL_PORT");

                string smtpUser = System.Configuration.ConfigurationManager.AppSettings["emailUser"];
                if (smtpUser == null || smtpUser == "")
                    smtpUser = db_Ref.GetT_OE_APP_SETTING("EMAIL_SECURE_USER");

                string smtpUserPwd = System.Configuration.ConfigurationManager.AppSettings["emailUser"];
                if (smtpUserPwd == null || smtpUser == "")
                    smtpUserPwd = db_Ref.GetT_OE_APP_SETTING("EMAIL_SECURE_PWD");

                //create in-app notification if set to yes
                if (createNotification == true)
                    db_EmergencyHound.InsertUpdateT_EM_USER_NOTIFICATION(null, toUserIDX, System.DateTime.Now, "EMAIL", subj, body, false, fromUserIDX, true, 0);

                if (smtpUser.Length > 0)  //smtp server requires authentication
                {
                    var smtp = new System.Net.Mail.SmtpClient(mailServer, Port.ConvertOrDefault<int>())
                    {
                        Credentials = new System.Net.NetworkCredential(smtpUser, smtpUserPwd),
                        EnableSsl = true
                    };
                    smtp.Send(message);
                    return true;
                }
                else
                {
                    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(mailServer);
                    smtp.Send(message);
                    return true;
                }


            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                    db_Ref.InsertT_OE_SYS_LOG("EMAIL ERR", ex.InnerException.ToString());
                else if (ex.Message != null)
                    db_Ref.InsertT_OE_SYS_LOG("EMAIL ERR", ex.Message.ToString());
                else
                    db_Ref.InsertT_OE_SYS_LOG("EMAIL ERR", "Unknown error");

                return false;
            }
        }


        /// <summary>
        ///  Binds a dropdownlist to a datasource and adds a blank item at the beginning.
        /// </summary>
        public static void BindList(DropDownList list, ObjectDataSource datasource, string valueName, string textName)
        {
            list.Items.Clear();
            list.Items.Insert(0, "");
            list.AppendDataBoundItems = true;
            list.DataValueField = valueName;
            list.DataTextField = textName;
            list.DataSource = datasource;
            list.DataBind();
        }

        public static void BindList(DropDownList list, ObjectDataSource datasource, string valueName, string textName, Boolean dontAdd)
        {
            list.DataValueField = valueName;
            list.DataTextField = textName;
            list.DataSource = datasource;
            list.DataBind();
        }


        /// <summary>
        ///  Helper method to convert a string value to a nullable DateTime
        /// </summary>
        public static DateTime? ConvertStringToDate(string dt, DateTime? defaultVal)
        {
            DateTime? newDt = null;

            try
            {
                newDt = Convert.ToDateTime(dt);
            }
            catch
            {
                if (defaultVal == null)
                    newDt = null;
                else
                    newDt = defaultVal;
            }

            return newDt;
        }

        public static byte[] ConvertStreamToByteArray(System.IO.MemoryStream stream)
        {
            long originalPosition = 0;

            if (stream.CanSeek)
            {
                originalPosition = stream.Position;
                stream.Position = 0;
            }

            try
            {
                byte[] readBuffer = new byte[4096];

                int totalBytesRead = 0;
                int bytesRead;

                while ((bytesRead = stream.Read(readBuffer, totalBytesRead, readBuffer.Length - totalBytesRead)) > 0)
                {
                    totalBytesRead += bytesRead;

                    if (totalBytesRead == readBuffer.Length)
                    {
                        int nextByte = stream.ReadByte();
                        if (nextByte != -1)
                        {
                            byte[] temp = new byte[readBuffer.Length * 2];
                            Buffer.BlockCopy(readBuffer, 0, temp, 0, readBuffer.Length);
                            Buffer.SetByte(temp, totalBytesRead, (byte)nextByte);
                            readBuffer = temp;
                            totalBytesRead++;
                        }
                    }
                }

                byte[] buffer = readBuffer;
                if (readBuffer.Length != totalBytesRead)
                {
                    buffer = new byte[totalBytesRead];
                    Buffer.BlockCopy(readBuffer, 0, buffer, 0, totalBytesRead);
                }
                return buffer;
            }
            finally
            {
                if (stream.CanSeek)
                {
                    stream.Position = originalPosition;
                }
            }
        }

        public static byte[] ConvertGenericStreamToByteArray(System.IO.Stream stream)
        {
            long originalPosition = 0;

            if (stream.CanSeek)
            {
                originalPosition = stream.Position;
                stream.Position = 0;
            }

            try
            {
                byte[] readBuffer = new byte[4096];

                int totalBytesRead = 0;
                int bytesRead;

                while ((bytesRead = stream.Read(readBuffer, totalBytesRead, readBuffer.Length - totalBytesRead)) > 0)
                {
                    totalBytesRead += bytesRead;

                    if (totalBytesRead == readBuffer.Length)
                    {
                        int nextByte = stream.ReadByte();
                        if (nextByte != -1)
                        {
                            byte[] temp = new byte[readBuffer.Length * 2];
                            Buffer.BlockCopy(readBuffer, 0, temp, 0, readBuffer.Length);
                            Buffer.SetByte(temp, totalBytesRead, (byte)nextByte);
                            readBuffer = temp;
                            totalBytesRead++;
                        }
                    }
                }

                byte[] buffer = readBuffer;
                if (readBuffer.Length != totalBytesRead)
                {
                    buffer = new byte[totalBytesRead];
                    Buffer.BlockCopy(readBuffer, 0, buffer, 0, totalBytesRead);
                }
                return buffer;
            }
            finally
            {
                if (stream.CanSeek)
                {
                    stream.Position = originalPosition;
                }
            }
        }


        /// <summary>
        ///  Generic data type converter 
        /// </summary>
        public static bool TryConvert<T>(object value, out T result)
        {
            result = default(T);
            if (value == null || value == DBNull.Value) return false;

            if (typeof(T) == value.GetType())
            {
                result = (T)value;
                return true;
            }

            string typeName = typeof(T).Name;

            try
            {
                if (typeName.IndexOf(typeof(System.Nullable).Name, StringComparison.Ordinal) > -1 ||
                    typeof(T).BaseType.Name.IndexOf(typeof(System.Enum).Name, StringComparison.Ordinal) > -1)
                {
                    TypeConverter tc = TypeDescriptor.GetConverter(typeof(T));
                    result = (T)tc.ConvertFrom(value);
                }
                else
                    result = (T)Convert.ChangeType(value, typeof(T));
            }
            catch
            {
                return false;
            }

            return true;
        }

        /// <summary>
        ///  Converts to another datatype or returns default value
        /// </summary>
        public static T ConvertOrDefault<T>(this object value)
        {
            T result = default(T);
            TryConvert<T>(value, out result);
            return result;
        }

        public static Guid ToGuid(this Guid? source)
        {
            return source ?? Guid.Empty;
        }

        /// <summary>
        ///  Better than built-in SubString by handling cases where string is too short
        /// </summary>
        public static string SubStringPlus(this string str, int index, int length)
        {
            if (index >= str.Length)
                return String.Empty;

            if (index + length > str.Length)
                return str.Substring(index);

            return str.Substring(index, length);
        }

        /// <summary>
        /// Remove HTML tags from string using char array.
        /// </summary>
        public static string StripTagsCharArray(string source)
        {
            char[] array = new char[source.Length];
            int arrayIndex = 0;
            bool inside = false;

            for (int i = 0; i < source.Length; i++)
            {
                char let = source[i];
                if (let == '<')
                {
                    inside = true;
                    continue;
                }
                if (let == '>')
                {
                    inside = false;
                    continue;
                }
                if (!inside)
                {
                    array[arrayIndex] = let;
                    arrayIndex++;
                }
            }
            return new string(array, 0, arrayIndex);
        }

        /// <summary>
        /// Better implementation of split when parsing CSV files - this handles situations where there are commas inside of quotes
        /// </summary>
        /// <param name="csvString">one line of csv file</param>
        /// <returns></returns>
        public static IEnumerable<string> SplitCSV(string csvString)
        {
            var sb = new System.Text.StringBuilder();
            bool quoted = false;

            foreach (char c in csvString)
            {
                if (quoted)
                {
                    if (c == '"')
                        quoted = false;
                    else
                        sb.Append(c);
                }
                else
                {
                    if (c == '"')
                    {
                        quoted = true;
                    }
                    else if (c == ',')
                    {
                        yield return sb.ToString();
                        sb.Length = 0;
                    }
                    else
                    {
                        sb.Append(c);
                    }
                }
            }

            if (quoted)
                throw new ArgumentException("csvString", "Unterminated quotation mark.");

            yield return sb.ToString();
        }

        /// <summary>
        /// Returns a more friendly version of timespan
        /// </summary>
        /// <param name="ts"></param>
        /// <returns></returns>
        public static string TimespanFriendly(this TimeSpan ts)
        {
            if (ts.TotalDays > 1) return ts.TotalDays.ConvertOrDefault<int>().ToString() + " days";
            else if (ts.TotalHours > 1) return ts.TotalHours.ConvertOrDefault<int>().ToString() + " hours";
            else return ts.TotalMinutes.ConvertOrDefault<int>().ToString() + " minutes";
        }


        /// <summary>
        /// Returns the internal ID of the authenticated user. If using membership, returns membership user. If using external ID provider, returns IPrincipal USERIDX claim
        /// </summary>
        /// <param name="User"></param>
        /// <returns></returns>
        public static int GetUserIDX(System.Security.Principal.IPrincipal User)
        {
            try
            {
                if (System.Configuration.ConfigurationManager.AppSettings["UseIdentityServer"] == "true")
                {
                    var identity = (ClaimsIdentity)User.Identity;
                    IEnumerable<Claim> claims2 = identity.Claims;
                    var UserIDXLoc = (from p in claims2 where p.Type == "UserIDX" select p.Value).FirstOrDefault();
                    return UserIDXLoc.ConvertOrDefault<int>();
                }
                else
                    return (int)System.Web.Security.Membership.GetUser().ProviderUserKey;
            }
            catch {
                //if fails, we don't care why, but need to return 0 to indicate not authenticated
                return 0;
            }
        }

    }
}