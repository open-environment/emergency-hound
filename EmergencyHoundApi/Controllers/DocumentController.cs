using System;
using System.Collections.Generic;
using System.Web.Http;
using EmergencyHoundModel;
using EmergencyHoundModel.DataAccessLayer;

namespace EmergencyHoundApi.Controllers
{
    [RoutePrefix("api/Document")]
    public class DocumentController : ApiController
    {
        // GET LISTING OF DOCUMENTS USER HAS ACCESS TO
        public IEnumerable<DocListType> GetDocuments(string token)
        {
            Guid tokenG = new Guid(token);
            int UserIDX = db_Accounts.GetT_OE_USER_TOKEN_byToken(tokenG);
            return db_EmergencyHound.GetT_EM_DOCUMENTS(UserIDX);
        }



    }
}
