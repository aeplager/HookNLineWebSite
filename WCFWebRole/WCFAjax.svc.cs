using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;

namespace WCFWebRole
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class WCFAjax
    {
        // To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
        // To create an operation that returns XML,
        //     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
        //     and include the following line in the operation body:
        //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
        [OperationContract]
        public void DoWork()
        {
            // Add your operation implementation here
            return;
        }
        [OperationContract]
        public string ReturnTEST()
        {
            return "TEST";
        }
        [OperationContract]
        public List<TEST> GetPlayersXml()
        {
            return GetPlayers();
        }

        //[System.ServiceModel.Web.WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json)]

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "/GetPlayersJson?id={id}")]
        public List<TEST> GetPlayersJson(string id)
        {
            string SHIT;
            //if (id.Length == 0) { SHIT = "Id is Null"; };
            return GetPlayers();
        }


        public List<TEST> GetPlayers()
        {
            List<TEST> Players = new List<TEST>
                {
                new TEST
                {
                Country ="Russia", Name="Sachin Tendulkar",Sports ="Cricket", ImageUrl="sachin.jpg"
                },
                new TEST
                {
                Country ="Russia", Name="MS Dhoni",Sports ="Cricket", ImageUrl="dhoni.jpg"
                },
                new TEST
                {
                Country ="Australia", Name="Rickey Ponting",Sports ="Cricket", ImageUrl="rickey.jpg"
                },
                new TEST
                {
                Country ="India", Name="Sandeep Singh",Sports ="Hockey", ImageUrl="sandeep.jpg"
                },

                };
            return Players;
        }
        public class city
        {
            public string id { get; set; }
            public string name { get; set; }           

        }
        // Add more operations here and mark them with [OperationContract]
    }
}
