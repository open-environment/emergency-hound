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
    
    public partial class T_EM_REF_RESOURCE_TYPE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_EM_REF_RESOURCE_TYPE()
        {
            this.T_EM_REF_RESOURCE_TYPE_DTL = new HashSet<T_EM_REF_RESOURCE_TYPE_DTL>();
            this.T_EM_RESOURCE = new HashSet<T_EM_RESOURCE>();
        }
    
        public System.Guid RESOURCE_TYPE_IDX { get; set; }
        public string RESOURCE_FEMA_ID { get; set; }
        public string RESOURCE_TYPE_NAME { get; set; }
        public string RESOURCE_TYPE_DESC { get; set; }
        public string RESOURCE_FUNCTION { get; set; }
        public string RESOURCE_CATEGORY { get; set; }
        public string RESOURCE_KIND { get; set; }
        public string RESOURCE_DISCIPLINE { get; set; }
        public string RESOURCE_CORE_CAP { get; set; }
        public string RESOURCE_ORDERING_INST { get; set; }
        public Nullable<int> RESOURCE_FLAVOR_COUNT { get; set; }
        public Nullable<System.Guid> ORG_IDX { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_OE_ORGANIZATIONS T_OE_ORGANIZATIONS { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_REF_RESOURCE_TYPE_DTL> T_EM_REF_RESOURCE_TYPE_DTL { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_RESOURCE> T_EM_RESOURCE { get; set; }
    }
}
