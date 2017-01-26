using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Owin;
using EmergencyHoundModel;

namespace EmergencyHoundWeb
{
    public partial class Startup
    {
        public void ConfigureAuth(IAppBuilder app)
        {
            // Configure the db context and user manager to use a single instance per request
            app.CreatePerOwinContext(CustomIdentityDBContext.Create);
            app.CreatePerOwinContext<CustomUserManager>(CustomUserManager.Create);

            // Enable the application to use a cookie to store information for the signed in user
            // and to use a cookie to temporarily store information about a user logging in with a third party login provider
            // Configure the sign in cookie
            app.UseCookieAuthentication(
                new CookieAuthenticationOptions
                {
                    AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                    LoginPath = new PathString("/Account/Login")//,
                    //Provider = new CookieAuthenticationProvider
                    //{
                    //    OnValidateIdentity =
                    //        SecurityStampValidator.OnValidateIdentity<CustomUserManager, CustomUser, int>(
                    //            TimeSpan.FromMinutes(30),
                    //            (manager, user) => user.GenerateUserIdentityAsync(manager),
                    //            identity => int.Parse(identity.GetUserId()))
                    //}
                });

            //app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

        }


    }
}
