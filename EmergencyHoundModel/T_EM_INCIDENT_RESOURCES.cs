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
    
    public partial class T_EM_INCIDENT_RESOURCES
    {
        public System.Guid INCIDENT_RESOURCE_IDX { get; set; }
        public System.Guid INCIDENT_IDX { get; set; }
        public System.Guid RESOURCE_IDX { get; set; }
        public string RESOURCE_COUNT { get; set; }
        public Nullable<System.DateTime> RESOURCE_ORDERED_DT { get; set; }
        public Nullable<System.DateTime> RESOURCE_ETA_DT { get; set; }
        public Nullable<bool> RESOURCE_ARRIVED_IND { get; set; }
        public string RESOURCE_NOTES { get; set; }
        public string RESOURCE_ASSIGNED_TO { get; set; }
        public Nullable<int> RESOURCE_ASSIGNED_PERSONS_COUNT { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_EM_INCIDENT T_EM_INCIDENT { get; set; }
        public virtual T_EM_RESOURCE T_EM_RESOURCE { get; set; }
    }
}