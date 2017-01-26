using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using EmergencyHoundWeb.App_Logic;

namespace EmergencyHoundWeb.ViewModels
{
    public class vmReportIndex
    {
        public IEnumerable<SelectListItem> ddl_OpPeriods { get; set; }
        public string selOpPeriod { get; set; }
        public Guid? IncidentIDX { get; set; }

    }

    public class vmReportfema201ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
        public List<T_EM_INCIDENT_OBJECTIVES> t_em_incident_objectives { get; set; }
    }


    public class vmReportfema202ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
        public List<T_EM_INCIDENT_OBJECTIVES> t_em_incident_objectives { get; set; }
    }

    public class vmReportfema203ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema204ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema205ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema205aViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema206ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema207ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema208ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema209ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema210ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

    public class vmReportfema211ViewModel
    {
        public T_EM_INCIDENT t_em_incident { get; set; }
    }

}
