using System.Web;
using System.Web.Mvc;

namespace EmergencyHoundWeb
{
    public class FilterConfig
    {
        public class SessionExpireFilterAttribute : ActionFilterAttribute
        {
            public override void OnActionExecuting(ActionExecutingContext filterContext)
            {
                HttpContext ctx = HttpContext.Current;

                // check if session is supported
                if (ctx.Session != null)
                {
                    // check if a new session id was generated
                    if (ctx.Session.IsNewSession)
                    {
                        // If it says it is a new session, but an existing cookie exists, then it must have timed out
                        string sessionCookie = ctx.Request.Headers["Cookie"];
                        if ((null != sessionCookie) && (sessionCookie.IndexOf("ASP.NET_SessionId") >= 0 && sessionCookie != "reset"))
                        {
                            filterContext.Result = new RedirectResult("~/Account/Login");
                            //ctx.Response.Redirect("~/Account/Login");
                        }
                    }
                    base.OnActionExecuting(filterContext);
                }

            }
        }

        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
