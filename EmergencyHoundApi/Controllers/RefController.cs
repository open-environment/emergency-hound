using System;
using System.Collections.Generic;
using System.Web.Http;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundApi.Controllers
{
    [RoutePrefix("api/Ref")]
    public class RefController : ApiController
    {

        // GET LISTING OF RESOURCE STATUS
        public IEnumerable<T_EM_REF_RESOURCE_STATUS> GetRefResourceStatus(DateTime dt)
        {
            return db_Ref.GetT_EM_REF_RESOURCE_STATUS(dt);
        }


        // GET LISTING OF RESOURCE TYPES (by userIDX)
        public IEnumerable<T_EM_REF_RESOURCE_TYPE> GetRefResourceTypeByUserIDX(string token, DateTime dt)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
            return db_Ref.GetT_EM_REF_RESOURCE_TYPE_byUserIDX_noOrgName(UserIDX, dt);
        }


        // GET LISTING OF RESOURCE TYPE DETAIL  (by UserIDX)
        public IEnumerable<T_EM_REF_RESOURCE_TYPE_DTL> GetRefResourceTypeDtlByUserIDX(string token, DateTime dt)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

            return db_Ref.GetT_EM_REF_RESOURCE_TYPE_DTL_byUserIDX_noOrgName(UserIDX, dt);
        }


        // GET LISTING OF QUAL TYPE 
        public IEnumerable<T_EM_REF_QUAL_TYPE> GetRefQualTypeByUserIDX(string token, DateTime dt)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

            return db_Ref.GetT_EM_REF_QUAL_TYPE_byUserIDX(UserIDX, dt);
        }


        // GET LISTING OF SHARE TYPES
        public IEnumerable<T_EM_REF_SHARE_TYPE> GetRefShareTypes()
        {
            return db_Ref.GetT_EM_REF_SHARE_TYPE();
        }


        // GET LISTING OF INCIDENT PRIORITY
        public IEnumerable<T_EM_REF_INCIDENT_PRIORITY> GetRefIncidentPriority(DateTime dt)
        {
            return db_Ref.GetT_EM_REF_INCIDENT_PRIORITY(dt);
        }


        // GET LISTING OF JURISDICTIONS
        public List<T_OE_ORGANIZATIONS> GetJurisdictionsMine(string token)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
            return db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG_All(UserIDX);
        }


        // GET LISTING OF JURISDICTIONS
        public List<T_OE_ORGANIZATIONS> GetJurisdictionsMineEditable(string token)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
            return db_EmergencyHound.GetT_OE_ORGANIZATIONS_ByUSERIDX_ORG(UserIDX, false);
        }

    }
}
