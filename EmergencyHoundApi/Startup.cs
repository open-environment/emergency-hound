using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using Microsoft.Owin;
using Owin;

//the assembly attribute states which class to fire on start-up
[assembly: OwinStartup(typeof(EmergencyHoundApi.Startup))]
namespace EmergencyHoundApi
{
    public class Startup
    {
        /// <summary>
        ///  The “Configuration” method accepts parameter of type “IAppBuilder” this parameter will be supplied by the host at run-time. 
        /// </summary>
        /// <param name="app">This “app” parameter is an interface which will be used to compose the application for our Owin server.</param>
        public void Configuration(IAppBuilder app)
        {
            //The “HttpConfiguration” object is used to configure API routes, so we pass this object to method “Register” in “WebApiConfig” class.
            HttpConfiguration config = new HttpConfiguration();
            WebApiConfig.Register(config);
            //Lastly, we’ll pass the “config” object to the extension method “UseWebApi” which will be responsible to wire up ASP.NET Web API to our Owin server pipeline.
            app.UseWebApi(config);
        }

        //public void ConfigureOAuth(IAppBuilder app)
        //{
        //    OAuthAuthorizationServerOptions OAuthServerOptions = new OAuthAuthorizationServerOptions()
        //    {
        //        AllowInsecureHttp = true,
        //        TokenEndpointPath = new PathString("/token"),
        //        AccessTokenExpireTimeSpan = TimeSpan.FromDays(1),
        //        Provider = new SimpleAuthorizationServerProvider()
        //    };

        //    //Token Generation
        //    app.UseOAuthAuthorizationServer(OAuthServerOptions);
        //    app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions());
        //}
    }
}