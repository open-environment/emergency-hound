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
    
    public partial class T_OE_SYS_EMAIL_LOG
    {
        public int EMAIL_LOG_ID { get; set; }
        public Nullable<System.DateTime> LOG_DT { get; set; }
        public string LOG_FROM { get; set; }
        public string LOG_TO { get; set; }
        public string LOG_CC { get; set; }
        public string LOG_SUBJ { get; set; }
        public string LOG_MSG { get; set; }
        public string EMAIL_TYPE { get; set; }
    }
}
