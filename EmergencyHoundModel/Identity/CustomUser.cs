using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Security.Claims;

namespace EmergencyHoundModel
{
    public class CustomUser : IdentityUser<int, CustomLogin, CustomUserRole, CustomClaim>
    {
        //custom properties here... that identity doesn't use by default
    //    public string ActivitationToken { get; set; }
    //    public string PasswordAnswer { get; set; }
 //       public string PasswordQuestion { get; set; }

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(CustomUserManager userManager)
        {
            var userIdentity = await userManager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }
}
