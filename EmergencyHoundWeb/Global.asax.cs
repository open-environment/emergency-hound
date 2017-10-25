using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Helpers;


namespace EmergencyHoundWeb
{
    public class MvcApplication : System.Web.HttpApplication
    {
        //this line added to overcome Katana middleware infinite redirect issue
        protected void Session_Start() { }  

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //Added for integration with IdentityServer
            AntiForgeryConfig.UniqueClaimTypeIdentifier = "sub";
            //ClaimTypes.NameIdentifier;
        }
    }
}
