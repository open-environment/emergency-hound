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
    
    public partial class SP_RESOURCE_ADV_SEARCH_Result
    {
        public System.Guid RESOURCE_IDX { get; set; }
        public System.Guid ORG_IDX { get; set; }
        public System.Guid RESOURCE_TYPE_IDX { get; set; }
        public string RESOURCE_COUNT { get; set; }
        public string RESOURCE_UNIT { get; set; }
        public string RESOURCE_DESC { get; set; }
        public Nullable<decimal> RESOURCE_LAT { get; set; }
        public Nullable<decimal> RESOURCE_LONG { get; set; }
        public string SHARE_TYPE { get; set; }
        public string RESOURCE_STATUS_CD { get; set; }
        public Nullable<System.DateTime> VERIFY_DT { get; set; }
        public bool ACT_IND { get; set; }
        public Nullable<int> CREATE_USERIDX { get; set; }
        public Nullable<System.DateTime> CREATE_DT { get; set; }
        public Nullable<int> MODIFY_USERIDX { get; set; }
        public Nullable<System.DateTime> MODIFY_DT { get; set; }
        public string RESOURCE_TYPE_NAME { get; set; }
        public string RESOURCE_TYPE_DESC { get; set; }
        public string RESOURCE_KIND { get; set; }
        public string RESOURCE_CATEGORY { get; set; }
        public string ORG_NAME { get; set; }
        public string RESOURCE_STATUS_NAME { get; set; }
        public Nullable<int> CAN_EDIT { get; set; }
        public Nullable<System.DateTime> RESOURCE_EXP_DT { get; set; }
    }
}