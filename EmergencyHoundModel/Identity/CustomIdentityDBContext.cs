using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace EmergencyHoundModel
{
    public class CustomIdentityDBContext : IdentityDbContext<CustomUser, CustomRole, int, CustomLogin, CustomUserRole, CustomClaim>
    {
        public CustomIdentityDBContext() : base("IdentityConnection")
        {
        }

        public static CustomIdentityDBContext Create()
        {
            return new CustomIdentityDBContext();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            
            // Map Entities to their tables.
            modelBuilder.Entity<CustomUser>().ToTable("T_OE_USERS");
            modelBuilder.Entity<CustomRole>().ToTable("T_OE_ROLES");
            modelBuilder.Entity<CustomClaim>().ToTable("T_OE_CLAIM");
            modelBuilder.Entity<CustomLogin>().ToTable("T_OE_LOGIN");
            modelBuilder.Entity<CustomUserRole>().ToTable("T_OE_USER_ROLES");
            
            // Set AutoIncrement-Properties
            modelBuilder.Entity<CustomUser>().Property(r => r.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            modelBuilder.Entity<CustomClaim>().Property(r => r.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            modelBuilder.Entity<CustomRole>().Property(r => r.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            // Override column mappings that do not match our default
            //USERS table
            modelBuilder.Entity<CustomUser>().Property(r => r.Id).HasColumnName("USER_IDX");   //Id --> USER_IDX
            modelBuilder.Entity<CustomUser>().Property(r => r.UserName).HasColumnName("USER_ID");  //UserName --> USER_ID
            modelBuilder.Entity<CustomUser>().Property(r => r.Email).HasColumnName("EMAIL");  // Email --> EMAIL
            modelBuilder.Entity<CustomUser>().Property(r => r.EmailConfirmed).HasColumnName("INITIAL_PWD_FLAG");  //EmailConfirmed --> INITIAL_PWD_FLAG
            modelBuilder.Entity<CustomUser>().Property(r => r.PasswordHash).HasColumnName("PWD_HASH");  //PasswordHash --> PWD_HASH
            modelBuilder.Entity<CustomUser>().Property(r => r.SecurityStamp).HasColumnName("SECURITY_STAMP");  //
            modelBuilder.Entity<CustomUser>().Property(r => r.PhoneNumber).HasColumnName("PHONE");  //
            modelBuilder.Entity<CustomUser>().Property(r => r.PhoneNumberConfirmed).HasColumnName("");  //
            modelBuilder.Entity<CustomUser>().Property(r => r.TwoFactorEnabled).HasColumnName("TWO_FACTOR_ENABLED");  //
            modelBuilder.Entity<CustomUser>().Property(r => r.LockoutEndDateUtc).HasColumnName("LOCKOUT_END_DATE_UTC");  //
            modelBuilder.Entity<CustomUser>().Property(r => r.LockoutEnabled).HasColumnName("LOCKOUT_ENABLED");
            modelBuilder.Entity<CustomUser>().Property(r => r.AccessFailedCount).HasColumnName("LOG_ATMPT");
            //ROLE
            modelBuilder.Entity<CustomRole>().Property(r => r.Id).HasColumnName("ROLE_IDX");   //Id --> ROLE_IDX
            modelBuilder.Entity<CustomRole>().Property(r => r.Name).HasColumnName("ROLE_NAME");   //Id --> ROLE_NAME
            //CLAIMS
            modelBuilder.Entity<CustomClaim>().Property(r => r.UserId).HasColumnName("USER_IDX");   //UserId --> USER_IDX
            //LOGIN
            modelBuilder.Entity<CustomLogin>().Property(r => r.UserId).HasColumnName("USER_IDX");   //UserId --> USER_IDX
            //USER_ROLES
            modelBuilder.Entity<CustomUserRole>().Property(r => r.UserId).HasColumnName("USER_IDX");   //UserId --> USER_IDX
            modelBuilder.Entity<CustomUserRole>().Property(r => r.RoleId).HasColumnName("ROLE_IDX");   //UserId --> USER_IDX



            //not mappped
            //FNAME , LNAME, EFFECTIVE_DT, LASTLOGIN_DT, PHONE_EXT, USER_AVATAR, CURR_INCIDENT_IDX, ACT_IND, CREATE_USERIDX, CREATE_DT, MODIFY_USERIDX, MODIFY_DT
        }


    }
}
