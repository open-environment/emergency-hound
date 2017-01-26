using System.ComponentModel.DataAnnotations;
using EmergencyHoundModel;
using System.Collections.Generic;
using System;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundWeb.ViewModels
{
    public class LocalPasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class LoginModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        public bool RememberMe { get; set; }
    }

    public class vmAccountNotificationViewModel
    {
        public List<T_EM_USER_NOTIFICATION> t_em_user_notifications { get; set; }
    }

    public class vmAccountRegisterModel
    {
        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email address")]
        public string UserName { get; set; }

        [Compare("UserName", ErrorMessage = "The email and confirmation email do not match.")]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Confirm email address")]
        public string ConfirmUserName { get; set; }

        [Required]
        [Display(Name = "First name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last name")]
        public string LastName { get; set; }

        //[Required(ErrorMessage = "You must select a jurisdiction.")]
        public Guid? intSelOrgIDX { get; set; }

        //public bool CreateIndiv { get; set; }

        public List<T_OE_ORGANIZATIONS> OrgList { get; set; }

        //initialize
        public vmAccountRegisterModel()
        {
            //CreateIndiv = true;
            OrgList = db_EmergencyHound.GetT_OE_ORGANIZATIONS_AllowJoin();
        }

    }

    public class vmAccountVerifyModel
    {
        [Required]
        [Display(Name = "Oauth")]
        public string OAuth { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        [StringLength(20, MinimumLength = 8)]
        public string Password { get; set; }

        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class vmAccountChangePasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Old Password")]
        public string OldPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "New Password")]
        [StringLength(20, MinimumLength = 8)]
        public string Password { get; set; }

        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class vmAccountLostPasswordModel
    {
        [Required]
        [Display(Name = "Email address")]
        public string Email { get; set; }
    }


}
