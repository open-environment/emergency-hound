//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EmergencyHoundModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class T_EM_USER_LOCATION
    {
        public System.Guid USER_LOC_IDX { get; set; }
        public int USER_IDX { get; set; }
        public Nullable<decimal> LATITUDE { get; set; }
        public Nullable<decimal> LONGITUDE { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_OE_USERS T_OE_USERS { get; set; }
    }
}
