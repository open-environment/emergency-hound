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
    
    public partial class T_EM_REF_QUAL_TYPE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_EM_REF_QUAL_TYPE()
        {
            this.T_EM_QUALIFICATIONS = new HashSet<T_EM_QUALIFICATIONS>();
            this.T_EM_REF_QUAL_TYPE_REQ = new HashSet<T_EM_REF_QUAL_TYPE_REQ>();
        }
    
        public System.Guid QUAL_TYPE_IDX { get; set; }
        public System.Guid QUAL_CAT_IDX { get; set; }
        public string QUAL_TYPE_CD { get; set; }
        public string QUAL_TYPE_NAME { get; set; }
        public string QUAL_TYPE_DESC { get; set; }
        public Nullable<System.Guid> ORG_IDX { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_QUALIFICATIONS> T_EM_QUALIFICATIONS { get; set; }
        public virtual T_EM_REF_QUAL_CATEGORY T_EM_REF_QUAL_CATEGORY { get; set; }
        public virtual T_OE_ORGANIZATIONS T_OE_ORGANIZATIONS { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_EM_REF_QUAL_TYPE_REQ> T_EM_REF_QUAL_TYPE_REQ { get; set; }
    }
}
