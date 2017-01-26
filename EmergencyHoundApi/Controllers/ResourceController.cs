using System;
using System.Collections.Generic;
using System.Web.Http;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;


namespace EmergencyHoundApi.Controllers
{
    [RoutePrefix("api/Resource")]
    public class ResourceController : ApiController
    {
        // GET LISTING OF RESOURCES USER HAS ACCESS TO        
        public IEnumerable<SP_RESOURCE_ADV_SEARCH_Result> GetAllResources(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetSP_RESOURCE_ADV_SEARCH(UserIDX, null, "", null, null, null, null, null, null);
            }
            else
                return null;
        }


        //GET LISTING OF RESOURCE DETAILS USER HAS ACCESS TO
        public IEnumerable<SP_RESOURCE_DTL_ADV_SEARCH_Result> GetAllResourceDetails(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {

                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetSP_RESOURCE_DTL_ADV_SEARCH(UserIDX);
            }
            else
                return null;
        }

        // GET LISTING OF RESOURCE VERIFY 
        public IEnumerable<SP_RESOURCE_DTL_ADV_SEARCH_Result> GetAllResourceVerify(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {

                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetSP_RESOURCE_DTL_ADV_SEARCH(UserIDX);
            }
            else
                return null;
        }

        // GET LISTING OF PEOPLE 
        public IEnumerable<IndividualDisplayType> GetAllPeople(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetT_EM_INDIVIDUALS_Display_ByUserIDX(UserIDX);
            }
            else
                return null;
        }


        // GET LISTING OF QUALIFICATIONS
        public IEnumerable<T_EM_QUALIFICATIONS> GetAllQualifications(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetT_EM_QUALIFICATIONS_ByUserIDX(UserIDX);
            }
            else
                return null;
        }



        // SAVE RESOURCE TO SERVER
        public string SetResources(string token, [FromBody]SP_RESOURCE_ADV_SEARCH_Result resource)
        {
            try
            {
                Guid tokenG = new Guid(token);

                if (tokenG != Guid.Empty)
                {
                    int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                    if (UserIDX > 0)
                    {
                        if (resource.ACT_IND == true)
                        {
                            Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_RESOURCE(resource.RESOURCE_IDX, resource.ORG_IDX, resource.RESOURCE_TYPE_IDX, resource.RESOURCE_COUNT,
                                resource.RESOURCE_UNIT, resource.RESOURCE_DESC, resource.RESOURCE_LAT, resource.RESOURCE_LONG, resource.SHARE_TYPE, null, resource.RESOURCE_STATUS_CD, resource.ACT_IND,
                                UserIDX, true, resource.RESOURCE_EXP_DT);

                            return SuccID != null ? "true" : "false";
                        }
                        else
                        {
                            int SuccID = db_EmergencyHound.DeleteT_EM_RESOURCE(resource.RESOURCE_IDX);
                            return SuccID == 1 ? "true" : "false";
                        }

                    }
                }
            }
            catch {}

            return "false";
        }


        // SAVE PERSON TO SERVER
        public string SetIndividual(string token, [FromBody]IndividualDisplayType person)
        {
            try
            {
                Guid tokenG = new Guid(token);

                if (tokenG != Guid.Empty)
                {
                    int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                    if (UserIDX > 0)
                    {
                        Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_INDIVIDUALS(person.INDIVIDUAL_IDX, person.ORG_IDX, person.INDV_FIRST_NAME, person.INDV_MID_NAME,
                            person.INDV_LAST_NAME, person.INDV_DOB, person.INDV_PHONE, person.INDV_EMAIL, person.ADD_LINE_ADR, person.ADD_CITY, person.ADD_STATE, person.ADD_ZIP, UserIDX,
                            person.INDV_AFFILIATION, person.ACT_IND, UserIDX);

                        return SuccID != null ? "true" : "false";
                    }
                }
            }
            catch { }

            return "false";
        }

        // SAVE PERSON TO SERVER
        public string SetQualification(string token, [FromBody]T_EM_QUALIFICATIONS qual)
        {
            try
            {
                Guid tokenG = new Guid(token);

                if (tokenG != Guid.Empty)
                {
                    int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                    if (UserIDX > 0)
                    {
                        Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_QUALIFICATIONS(qual.QUALIFICATION_IDX, qual.ORG_IDX, qual.INDIVIDUAL_IDX, qual.QUAL_TYPE_IDX,
                            qual.EFF_DATE, qual.EXP_DATE, qual.ACT_IND, UserIDX);

                        return SuccID != null ? "true" : "false";
                    }
                }
            }
            catch { }

            return "false";
        }



    }
}
