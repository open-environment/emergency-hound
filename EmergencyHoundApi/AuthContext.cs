using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EmergencyHoundApi
{
    /// <summary>
    ///  this class inherits from “IdentityDbContext” class, you can think about this class as special version of the traditional “DbContext” Class, it will provide all of the Entity Framework code-first mapping and DbSet properties needed to manage the identity tables in SQL Server. 
    /// </summary>
    public class AuthContext : IdentityDbContext<IdentityUser>
    {
        public AuthContext()
            : base("EMERG_DBEntities")
        { }
    }
}
