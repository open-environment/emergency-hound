using System;
using System.Collections.Generic;
using System.Web.Http;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;
using System.Net.Http;
using System.Net;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace EmergencyHoundApi.Controllers
{
    [RoutePrefix("api/Incident")]
    public class IncidentController : ApiController
    {
        // GET LISTING OF INCIDENTS USER HAS ACCESS TO
        public IEnumerable<SP_INCIDENT_ADV_SEARCH_Result> GetAllIncidents(string token)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
            return db_EmergencyHound.GetSP_INCIDENT_ADV_SEARCH(UserIDX, null);
        }

        // UPDATE THE INCIDENT INFORMATIOn
        public string SetIncidents(string token, [FromBody]SP_INCIDENT_ADV_SEARCH_Result incident)
        {
            Guid tokenG = new Guid(token);

            if (tokenG != Guid.Empty)
            {
                //Guid tokenG = new Guid("8D586F57-D503-44A3-AC9F-333229D3EAC7");
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                if (UserIDX > 0)
                {
                    Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_INCIDENT(incident.INCIDENT_IDX, incident.ORG_IDX, incident.INCIDENT_ID, incident.INCIDENT_NAME, incident.INCIDENT_DESC,
                        incident.INC_MANAGEMENT_ORG_CD, incident.INCIDENT_START_DT, incident.INCIDENT_END_DT, incident.INCIDENT_COMPLEX_LVL, incident.INCIDENT_LOC_DESC,
                        incident.INCIDENT_LAT, incident.INCIDENT_LONG, incident.INCIDENT_STATE, incident.INCIDENT_CNTY, incident.INCIDENT_CITY, incident.INCIDENT_LAND_SURVEY,
                        incident.INCIDENT_SIZE, incident.INCIDENT_SIZE_UNIT, incident.INCIDENT_PCT_CONTAINED, incident.INCIDENT_HAZ_MAT, incident.INCIDENT_WEATHER,
                        incident.INCIDENT_COSTS, incident.INCIDENT_TOTAL_COSTS, incident.ACT_IND, UserIDX, incident.SHARE_TYPE, incident.INCIDENT_PRIORITY, true);

                    if (SuccID != null)
                        return "true";
                    else
                        return "false";
                }
            }

            return "false";
        }

        //GET LISTING OF INCIDENT STATUSES USER HAS ACCESS TO
        public IEnumerable<SP_INCIDENT_STATUS_QUERY_Result> GetAllIncidentStatuses(string token)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {

                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                return db_EmergencyHound.GetSP_INCIDENT_STATUS_QUERY(UserIDX, null);
            }
            else
                return null;
        }

        // UPDATE THE INCIDENT STATUS
        public string SetIncidentStatus(string token, [FromBody]SP_INCIDENT_STATUS_QUERY_Result incStatus)
        {
            Guid tokenG = new Guid(token);

            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);

                if (UserIDX > 0)
                {
                    Guid? SuccID = db_EmergencyHound.InsertUpdateT_EM_INCIDENT_STATUS(incStatus.INC_STATUS_IDX, incStatus.INCIDENT_IDX, incStatus.STATUS_TYPE_CD,
                        incStatus.STATUS_DESC, incStatus.STATUS_DT, incStatus.ACT_IND, UserIDX);

                    if (SuccID != null)
                        return "true";
                    else
                        return "false";
                }
            }

            return "false";
        }



        // ATTACHMENTS

        // GET THE SELECTED INCIDENT ATTACHMENT
        public HttpResponseMessage GetIncImage(Guid AttachIDX) {
            var response = new HttpResponseMessage();

            T_EM_INCIDENT_ATTACH att = db_EmergencyHound.GetT_EM_INCIDENT_ATTACH_byAttachIDX(AttachIDX);
            if (att != null)
            {
                var pictureBytes = att.ATTACH_CONTENT;

                if (pictureBytes == null)
                    response.StatusCode = HttpStatusCode.NotFound;
                else
                {
                    response.Content = new ByteArrayContent(pictureBytes);
                    //response.Content.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");
                    response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
                    response.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment");
                    response.Content.Headers.ContentDisposition.FileName = "test.jpg";
                }
            }
            else
                response.StatusCode = HttpStatusCode.NotFound;

            return response;
        }

        // GET LISTING OF INCIDENT ATTACHMENTS
        public IEnumerable<AttachDisplayType> GetIncidentAttaches(string token, Guid IncidentIDX)
        {
            Guid tokenG = new Guid(token);
            if (tokenG != Guid.Empty)
            {
                int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
                if (UserIDX == 0)
                    return null;
                else
                {
                    return db_EmergencyHound.GetT_EM_INCIDENT_ATTACH_byIncidentIDX_Abbrev(IncidentIDX);
                }
            }
            else
                return null;

        }

        [HttpPost]
        public async Task<IHttpActionResult> AttachImageUpload()
        {
            if (!Request.Content.IsMimeMultipartContent())
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);

            var provider = new MultipartMemoryStreamProvider();
            await Request.Content.ReadAsMultipartAsync(provider);

            Guid id = new Guid("88544B02-CF6B-4F8C-A23D-235A177947F5");

            foreach (var file in provider.Contents)
            {
                try
                {
                    var buffer = await file.ReadAsByteArrayAsync();

                    if (buffer.Length > 100)
                    {
                        //                    var filename = file.Headers.ContentDisposition.FileName.Trim('\"');
                        //                    db_Ref.InsertT_OE_SYS_LOG("LOG6", filename.ToString());
                        //                Guid id = new Guid("D67FC075-522F-4DC8-8EA5-4561CE775911");
                        db_EmergencyHound.InsertUpdateT_EM_INCIDENT_ATTACH(null, id, buffer, "image", "", "", 24);
                        db_Ref.InsertT_OE_SYS_LOG("1", "file");
                    }
                    else
                    {
                        string tempID = System.Text.Encoding.Default.GetString(buffer);
                        if (tempID.Length == 36)
                        {
                            db_Ref.InsertT_OE_SYS_LOG("1", tempID);
                            id = new Guid(tempID);
                        }
                    }
                 
                }
                catch (Exception e)
                {
                    db_Ref.InsertT_OE_SYS_LOG("ERR", e.Message.Substring(0,1999));
                    throw new HttpResponseException(HttpStatusCode.BadRequest);
                }
            }

            return Ok();

        }



    }

}
