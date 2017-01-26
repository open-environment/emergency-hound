using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace EmergencyHoundModel
{
    [MetadataType(typeof(MetaDataT_EM_REF_RESOURCE_TYPE))]
    public partial class T_EM_REF_RESOURCE_TYPE { }

    public class MetaDataT_EM_REF_RESOURCE_TYPE
    {
        [Display(Name = "Resource Type Name")]
        [Required]
        [StringLength(100)]
        public String RESOURCE_TYPE_NAME { get; set; }

        [StringLength(1000)]
        public String RESOURCE_TYPE_DESC { get; set; }

        [Display(Name = "Resource Type Category")]
        [StringLength(50)]
        [Required]
        public String RESOURCE_CATEGORY { get; set; }

        [Display(Name = "Resource Kind")]
        [StringLength(50)]
        [Required]
        public String RESOURCE_KIND { get; set; }
    }
}
