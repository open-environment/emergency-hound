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
    
    public partial class T_EM_DOCUMENTS
    {
        public System.Guid DOC_IDX { get; set; }
        public System.Guid ORG_IDX { get; set; }
        public byte[] DOC_CONTENT { get; set; }
        public string DOC_NAME { get; set; }
        public string DOC_TYPE { get; set; }
        public string DOC_FILE_TYPE { get; set; }
        public Nullable<int> DOC_SIZE { get; set; }
        public string DOC_COMMENT { get; set; }
        public string DOC_AUTHOR { get; set; }
        public string SHARE_TYPE { get; set; }
        public string DOC_STATUS_TYPE { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
    
        public virtual T_EM_REF_DOC_STATUS_TYPE T_EM_REF_DOC_STATUS_TYPE { get; set; }
        public virtual T_EM_REF_DOC_TYPE T_EM_REF_DOC_TYPE { get; set; }
        public virtual T_OE_ORGANIZATIONS T_OE_ORGANIZATIONS { get; set; }
        public virtual T_EM_REF_SHARE_TYPE T_EM_REF_SHARE_TYPE { get; set; }
    }
}
