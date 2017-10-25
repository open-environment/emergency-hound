using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OpenIdConnect;
using Owin;
using System.Collections.Generic;
using System.IdentityModel.Tokens;
using System.Configuration;
using System.Threading.Tasks;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using System.Security.Claims;

[assembly: OwinStartup(typeof(EmergencyHoundWeb.Startup))]

namespace EmergencyHoundWeb
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //IdentityServer configuration settings
            if (ConfigurationManager.AppSettings["UseIdentityServer"] == "true")
            {
                JwtSecurityTokenHandler.InboundClaimTypeMap = new Dictionary<string, string>();

                app.UseCookieAuthentication(new CookieAuthenticationOptions
                {
                    AuthenticationType = "Cookies",
                    ExpireTimeSpan = System.TimeSpan.FromMinutes(60),
                });


                app.UseOpenIdConnectAuthentication(new OpenIdConnectAuthenticationOptions
                {
                    //IMPLICIT 
                    ClientId = "emergency_hound",
                    Authority = ConfigurationManager.AppSettings["IdentityServerAuthority"],      
                    RedirectUri = ConfigurationManager.AppSettings["IdentityServerRedirectURI"],  
                    PostLogoutRedirectUri =  ConfigurationManager.AppSettings["IdentityServerPostLogoutURI"], 
                    ResponseType = "id_token",
                    UseTokenLifetime = false,

                    SignInAsAuthenticationType = "Cookies",
                    Scope = "openid profile email",
                    
                    TokenValidationParameters = {
                        NameClaimType = "name"
                    },
                    Notifications = new OpenIdConnectAuthenticationNotifications()
                    {
                        SecurityTokenValidated = (context) =>
                        {
                            //grab information about User
                            ClaimsIdentity _identity = context.AuthenticationTicket.Identity;
                            var UserID_portal = _identity.FindFirst("sub").Value;
                            int UserIDX = 0;

                            //check if user with this email already in system
                            T_OE_USERS t = db_Accounts.GetT_OE_USERByEmail(_identity.Name);
                            if (t == null)
                            {
                                //insert new USERS table if not yet there
                                UserIDX = db_Accounts.CreateT_OE_USERS(_identity.Name, "unused", "unused", "temp", "temp", _identity.Name, true, false, System.DateTime.Now, null, null, 0, UserID_portal);

                                //Add user to GENERAL USER Role
                                db_Accounts.CreateT_OE_USER_ROLE(2, UserIDX, 0);
                            }
                            else
                            {
                                //update existing user record
                                UserIDX = t.USER_IDX;
                                db_Accounts.UpdateT_OE_USERS(t.USER_IDX, null, null, null, null, null, null, null, null, System.DateTime.Now, null, null, null, null, null, UserID_portal);
                            }

                            //now add UserIDX to claims
                            if (UserIDX > 0)
                            {
                                Claim userIDXClaim = new Claim("UserIDX", UserIDX.ToString(), ClaimValueTypes.Integer, "LocalAuthority");
                                context.AuthenticationTicket.Identity.AddClaim(userIDXClaim);
                            }
                            else
                                throw new System.IdentityModel.Tokens.SecurityTokenValidationException();


                            //set all orgs for this user to Inactive
                            db_EmergencyHound.SetT_EM_USER_ORG_Inactive(UserIDX);

                            //now handling jurisdiction associations
                            var authorizedOrgs = _identity.FindAll("emergency_hound");
                            foreach (var org in authorizedOrgs)
                            {
                                string[] org_array = org.Value.Split(';');

                                T_OE_ORGANIZATIONS o = db_EmergencyHound.GetT_OE_ORGANIZATIONS_BYOrgName(org_array[0]);

                                if (o != null)
                                {
                                    db_EmergencyHound.InsertUpdateT_EM_USER_ORG(UserIDX, o.ORG_IDX, org_array[1] == "True" ? "A" : "U", org_array[2]);
                                }
                            }

                            return Task.FromResult(0);
                        }
                    }

                });

            }

        }
    }
}
