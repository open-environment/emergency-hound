using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;

namespace EmergencyHoundModel
{
    public class CustomUserManager : UserManager<CustomUser, int>
    {
        #region constructors and destructors

        public CustomUserManager(IUserStore<CustomUser, int> store) : base(store)
        {
        }

        #endregion

        #region methods

        public static CustomUserManager Create(IdentityFactoryOptions<CustomUserManager> options, IOwinContext context)
        {
            //var manager = new CustomUserManager(new UserStore<CustomUser, CustomRole, int, CustomLogin, CustomUserRole, CustomClaim>(context.Get<CustomIdentityDBContext>()));
            var manager = new CustomUserManager(new UserStore<CustomUser, CustomRole, int, CustomLogin, CustomUserRole, CustomClaim>(context.Get<CustomIdentityDBContext>()));

            // Configure validation logic for usernames
            manager.UserValidator = new UserValidator<CustomUser, int>(manager)
            {
                AllowOnlyAlphanumericUserNames = false,
                RequireUniqueEmail = true
            };

            // Configure validation logic for passwords
            manager.PasswordValidator = new PasswordValidator
            {
                RequiredLength = 6,
                RequireNonLetterOrDigit = true,
                RequireDigit = true,
                RequireLowercase = true,
                RequireUppercase = true,
            };

            // Register two factor authentication providers. This application uses Phone and Emails as a step of receiving a code for verifying the user
            // You can write your own provider and plug in here.
            manager.RegisterTwoFactorProvider(
                "PhoneCode",
                new PhoneNumberTokenProvider<CustomUser, int>
                {
                    MessageFormat = "Your security code is: {0}"
                });

            manager.RegisterTwoFactorProvider(
                "EmailCode",
                new EmailTokenProvider<CustomUser, int>
                {
                    Subject = "Security Code",
                    BodyFormat = "Your security code is: {0}"
                });

            manager.EmailService = new EmailService();
            manager.SmsService = new SmsService();
            var dataProtectionProvider = options.DataProtectionProvider;
            if (dataProtectionProvider != null)
            {
                manager.UserTokenProvider = new DataProtectorTokenProvider<CustomUser, int>(dataProtectionProvider.Create("ASP.NET Identity"));
            }
            return manager;
        }
        


        #endregion
    }
}
