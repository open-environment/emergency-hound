using System;
using System.Data.Entity.Validation;
using System.ComponentModel;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundModel.Utils
{
    public static class db_Util
    {
        public static void LogEFException(Exception ex)
        {
            string err = "";

            if (ex is DbEntityValidationException)
            {
                DbEntityValidationException dbex = (DbEntityValidationException)ex;
                foreach (var eve in dbex.EntityValidationErrors)
                {
                    err += "Entity error type" + eve.Entry.Entity.GetType().Name;  //maybe add eve.Entry.State too
                    foreach (var ve in eve.ValidationErrors)
                        err += " property: " + ve.PropertyName + " error: " + ve.ErrorMessage;
                }
            }
            else
                err = (ex.InnerException != null ? ex.InnerException.Message : "");

            db_Ref.InsertT_OE_SYS_LOG("ERROR", err.SubStringPlus(0,2000));

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

    }
}