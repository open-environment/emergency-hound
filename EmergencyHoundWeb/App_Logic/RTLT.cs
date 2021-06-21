using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundWeb.App_Logic
{
    public class RTLT
    {
        public static int CallRTLTService()
        {
            try
            {
                var client = new org.preptoolkit.rtlt.WebService();

                int recCount = 50;
                int page = 1;

                do
                {
                    org.preptoolkit.rtlt.ResourceDefinitionSet resources = client.GetResources(null, null, "2013-10-20 18:08:11", "2022-12-28 18:08:11", null, null, null, null, page, true);

                    foreach (org.preptoolkit.rtlt.ResourceDefinition resource in resources.Definitions)
                    {
                        Guid? ResourceIdx = db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE(null, resource.Id, resource.Name, resource.Description, resource.OverallFunction,
                            resource.Category, resource.Kind, null, resource.PrimaryCoreCapability, resource.CompositionOrdering, resource.Capabilities[0].Types.Count(), null, true, 0);

                        //******************* INSERT CAPABILITIES FOR EACH RESOURCE TYPE *************************
                        foreach (org.preptoolkit.rtlt.ResourceCapability cap in resource.Capabilities)
                        {
                            Guid? SuccInd = db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL(null, ResourceIdx, cap.Component, cap.Metric, cap.Ability, cap.Notes, cap.Order, 0, true);
                            if (SuccInd != null)
                            {
                                //******************* INSERT CAPABILITY REFERENCE DATA FOR EACH RESOURCE TYPE CAPABILITY *************************
                                foreach (org.preptoolkit.rtlt.ResourceCapabilityType captype in cap.Types)
                                    db_Ref.InsertUpdateT_EM_REF_RESOURCE_TYPE_DTL_DATA(SuccInd.ConvertOrDefault<Guid>(), captype.Order, captype.Attribute, 0);
                            }
                        }
                    }
                    page += 1;
                    recCount = resources.Definitions.Count();
                } while (recCount == 25);

                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

    }
}