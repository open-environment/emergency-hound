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
    
    public partial class T_EM_INCIDENT_STATUS
    {
        public System.Guid INC_STATUS_IDX { get; set; }
        public System.Guid INCIDENT_IDX { get; set; }
        public System.DateTime STATUS_DT { get; set; }
        public string STATUS_TYPE_CD { get; set; }
        public string STATUS_DESC { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_EM_INCIDENT T_EM_INCIDENT { get; set; }
        public virtual T_EM_REF_INC_STATUS_TYPE T_EM_REF_INC_STATUS_TYPE { get; set; }
    }
}
