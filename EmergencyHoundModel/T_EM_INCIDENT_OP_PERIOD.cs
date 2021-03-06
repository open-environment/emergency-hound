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
    
    public partial class T_EM_INCIDENT_OP_PERIOD
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_EM_INCIDENT_OP_PERIOD()
        {
            this.T_EM_INCIDENT_ACTIONS = new HashSet<T_EM_INCIDENT_ACTIONS>();
            this.T_EM_INCIDENT_OBJECTIVES = new HashSet<T_EM_INCIDENT_OBJECTIVES>();
            this.T_EM_INCIDENT_TEAM_DTL = new HashSet<T_EM_INCIDENT_TEAM_DTL>();
        }
    
        public System.Guid INCIDENT_OP_PERIOD_IDX { get; set; }
        public System.Guid INCIDENT_IDX { get; set; }
        public string OP_PERIOD_NAME { get; set; }
        public Nullable<System.DateTime> OP_PERIOD_START_DT { get; set; }
        public Nullable<System.DateTime> OP_PERIOD_END_DT { get; set; }
        public string OP_PERIOD_COMMAND_EMPHASIS { get; set; }
        public string OP_PERIOD_SIT_AWARENESS { get; set; }
        public string OP_PERIOD_PLANNED_ACTION { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_EM_INCIDENT T_EM_INCIDENT { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_INCIDENT_ACTIONS> T_EM_INCIDENT_ACTIONS { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_INCIDENT_OBJECTIVES> T_EM_INCIDENT_OBJECTIVES { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_INCIDENT_TEAM_DTL> T_EM_INCIDENT_TEAM_DTL { get; set; }
    }
}
