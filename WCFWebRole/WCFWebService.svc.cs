using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Data;//
using System.Configuration;
using System.Data.SqlClient;
using GemBox.Email;
using GemBox.Email.Smtp;


using System.Threading.Tasks;
using System.Net;
using System.Runtime.Serialization.Json;

using System.Collections;
using System.Xml;
using GemBox.Email.Mime;
using GemBox.Email.Pop;
using GemBox.Email.Security;
using GemBox.Email.Imap;

//using GemBox.Email.Pop;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;

using System.IO;


namespace WCFWebRole
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "WCFWebService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select WCFWebService.svc or WCFWebService.svc.cs at the Solution Explorer and start debugging.
    public class WCFWebService : IWCFWebService
    {


        public List<WayPoints> SpecificWayPointGetInfo(double Latitude, double Longitude, int MapDefinition)
        {

            List<WayPoints> SelectionItemsinfo = new List<WayPoints>();
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    //string SqlCommandText = "[WebSite].[SpecificWayPointsGetInfo]";
                    string SqlCommandText = "SELECT	TOP 1 [WayPointsID], [WayPointName], [Latitude], [Longitude], [FishingText], [BestWindText], [TypeOfFishingText]";
                    //SqlCommandText = SqlCommandText + ",geography::STGeomFromText('POINT(-94.9328333326 29.5049999747)', 4326).STDistance([GeoLocation])  as Distance";
                    //SqlCommandText = SqlCommandText + ",WT.[WayPointTypeID],[WayPointTypeName]";
                    //SqlCommandText = SqlCommandText + ",geography::STGeomFromText('POINT(" + Latitude + " " + Longitude + ")', 4326).STDistance([GeoLocation])  as Distance";
                    //SqlCommandText = SqlCommandText + " FROM	[WebSite].[WayPoints] W";
                    //SqlCommandText = SqlCommandText + " INNER JOIN WebSite.WayPointType WT ON W.[WayPointTypeID] = WT.[WayPointTypeID]";
                    //SqlCommandText = SqlCommandText + " ORDER BY geography::STGeomFromText('POINT(" + Latitude + " " + Longitude + ")', 4326).STDistance([GeoLocation])";
                    //SqlCommandText = SqlCommandText + " ORDER BY geography::STGeomFromText('POINT(-94.9328333326 29.5049999747)', 4326).STDistance([GeoLocation])";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "[WebSite].[SpecificWayPointGetInfo]";
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Lat", Latitude);
                    cmd.Parameters.AddWithValue("@Lng", Longitude);
                    cmd.Parameters.AddWithValue("@MapDefinition", MapDefinition);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            SelectionItemsinfo.Add(new WayPoints
                            {
                                WayPointID = Convert.ToInt32(dr["WayPointsID"]),
                                WayPointName = dr["WayPointName"].ToString(),
                                Latitude = Convert.ToDouble(dr["Latitude"]),
                                Longitude = Convert.ToDouble(dr["Longitude"]),
                                FishingText = dr["FishingText"].ToString(),
                                BestWindText = dr["BestWindText"].ToString(),
                                TypeOfFishingText = dr["TypeOfFishingText"].ToString(),
                                WayPointTypeID = Convert.ToInt32(dr["WayPointTypeID"]),
                                WayPointTypeName = dr["WayPointTypeName"].ToString(),
                            });
                        }
                    }
                }
            }
            return SelectionItemsinfo;
        }
        public RealTimeWeather RealTimeWeatherGetInfo()
        {
            RealTimeWeather SelectionItemsinfo = new RealTimeWeather();
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[WeatherRealTimeGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {

                            SelectionItemsinfo.WeatherStationID = Convert.ToInt32(dr["WeatherStationID"]);
                            SelectionItemsinfo.InsertDate = Convert.ToDateTime(dr["InsertDate"]);
                            SelectionItemsinfo.RecordedTime = Convert.ToDateTime(dr["RecordedTime"]);
                            //SelectionItemsinfo.RecordedTime = SelectionItemsinfo.RecordedTime.AddHours(-5);
                            SelectionItemsinfo.RecordedTimeFormatted = SelectionItemsinfo.RecordedTime.ToString("MMMM dd, yyyy H:mm");
                            SelectionItemsinfo.TempUnit = dr["TempUnit"].ToString();
                            SelectionItemsinfo.TempValue = Convert.ToDouble(dr["TempValueF"]);
                            SelectionItemsinfo.TempValueFormatted = SelectionItemsinfo.TempValue.ToString("N2");
                            Random rnd1 = new Random();
                            SelectionItemsinfo.WaterTempValue = Convert.ToDouble(dr["WaterTemp"]);
                            SelectionItemsinfo.WaterTempValueFormatted = SelectionItemsinfo.WaterTempValue.ToString("N2");
                            SelectionItemsinfo.TempMin = Convert.ToDouble(dr["TempMinF"]);
                            SelectionItemsinfo.TempMax = Convert.ToDouble(dr["TempMaxF"]);
                            SelectionItemsinfo.HumidityValue = Convert.ToDouble(dr["HumidityValue"]);
                            SelectionItemsinfo.HumidityUnit = dr["HumidityUnit"].ToString();
                            SelectionItemsinfo.PressUnit = dr["PressUnit"].ToString();
                            SelectionItemsinfo.PressValue = Convert.ToDouble(dr["PressValue"]);
                            SelectionItemsinfo.WindSpeed = Convert.ToDouble(dr["WindSpeed"]);
                            SelectionItemsinfo.WindSpeedDesc = dr["WindSpeedDesc"].ToString();
                            SelectionItemsinfo.WindCode = dr["WindCode"].ToString();
                            SelectionItemsinfo.WindDescription = dr["WindDescription"].ToString();
                            SelectionItemsinfo.WindDir = Convert.ToInt32(dr["WindDir"]);
                            SelectionItemsinfo.CloudsValue = dr["CloudsValue"].ToString();
                            SelectionItemsinfo.WeatherValue = dr["WeatherValue"].ToString();
                        }
                    }
                }
            }
            return SelectionItemsinfo;

        }

        public List<WeatherForecast> WeatherForecastGetInfo()
        {
            List<WeatherForecast> SelectionItemsinfo = new List<WeatherForecast>();
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[WeatherForecastGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            SelectionItemsinfo.Add(new WeatherForecast
                            {
                                DateOfForecast = String.Format("{0:g}", dr["DateOfForecastCST"]),
                                //ForecastDate = String.Format("{0:MM/dd/yyyy hh:mm tt}", dr["ForecastDateTimeCST"]),
                                ForecastDate = String.Format("{0:hh:mm tt}", dr["ForecastDateTimeCST"]),
                                ForecastStatus = dr["WeatherCondition"].ToString(),
                                ForecastTemp = String.Format("{0:0.00}", dr["TempValue"]),

                            });
                        }
                    }
                }
            }
            return SelectionItemsinfo;

        }
        public List<WayPoints> AllWayPointsGetInfo(int MapSelection)
        {
            string MapDefinition;
            MapDefinition = "1";
            MapDefinition = MapSelection.ToString();
            string mystring = "" + (char)34;
            MapDefinition = MapDefinition.Replace(mystring, "");
            mystring = "" + (char)47;
            MapDefinition = MapDefinition.Replace(mystring, "");
            mystring = "" + (char)92;
            MapDefinition = MapDefinition.Replace(mystring, "");
            //MapDefinition = "1";
            List<WayPoints> SelectionItemsinfo = new List<WayPoints>();
            DataSet ds = new DataSet();
            int iMapDefinition = Convert.ToInt32(MapDefinition);
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[AllWayPointsGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@MapDefinition", iMapDefinition);
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            SelectionItemsinfo.Add(new WayPoints
                            {
                                WayPointID = Convert.ToInt32(dr["WayPointsID"]),
                                WayPointName = dr["WayPointName"].ToString(),
                                Latitude = Convert.ToDouble(dr["Latitude"]),
                                Longitude = Convert.ToDouble(dr["Longitude"]),
                                FishingText = dr["FishingText"].ToString(),
                                BestWindText = dr["BestWindText"].ToString(),
                                TypeOfFishingText = dr["TypeOfFishingText"].ToString(),

                            });
                        }
                    }
                }
            }
            return SelectionItemsinfo;
        }

        public string LoginValidation(string UserName, string Password)
        {
            string StatusPasswordSet;
            StatusPasswordSet = "FAIL";
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[LoginValidationGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@UserName", UserName);
                    cmd.Parameters.AddWithValue("@Password", Password);
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            StatusPasswordSet = dr["Status"].ToString();
                            break;
                        }
                    }
                }
            }
            return StatusPasswordSet;
        }

        public int UserNameValidation(string UserName)
        {
            int UserNameVal = 0;
            
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[UserNameResetGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@UserName", UserName);                    
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            UserNameVal = System.Convert.ToInt32(dr["CountOfUserNames"].ToString());
                            break;
                        }
                    }
                }
            }
            return UserNameVal;
        }

        public List<UserPurchases> UserPurchasesGetInfo(string UserName)
        {
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            List<UserPurchases> SelectionItemsinfo = new List<UserPurchases>();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[UserPurchasesGetInfo]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@UserName", UserName);                    
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            SelectionItemsinfo.Add(new UserPurchases
                            {
                                UserName = dr["UserName"].ToString(),
                                MapSelectionsID = Convert.ToInt32(dr["MapSelectionsID"]),
                                MapSelectionsName = dr["MapSelectionsName"].ToString()
                            });
                        }
                    }
                }
            }
            return SelectionItemsinfo;
        }


        public string SendEmailForNewPassword(string UserName)
        {
            string RestChar;
            RestChar = "FAIL";
            DataSet ds = new DataSet();
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[UserNameSetupUpsert]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@UserName", UserName);
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            RestChar = dr["RandChar"].ToString();
                            break;
                        }
                    }
                }
            }
            try
            {
                ComponentInfo.SetLicense("FREE-LIMITED-KEY");
                //Console.WriteLine("Creating message...");
                MailMessage message = new MailMessage(new MailAddress("info@hooknline.net", "Joe Trombley"), new MailAddress(UserName, "Adam Plager"));
                message.Subject = "Hook N Line Reset Password";
                string url = "https://hooknline.azurewebsites.net/";
                message.BodyText = "Please go to the following URL to reset your password:   " + url + "HookNLinePasswordReset.html?" + RestChar;
                using (SmtpClient smtp = new SmtpClient("smtp.office365.com"))
                {
                    smtp.Connect();
                    //Console.WriteLine("Connected.");
                    smtp.Authenticate("info@hooknline.net", "Trombley#12");
                    smtp.SendMessage(message);
                }
                return RestChar;
            }
            catch (Exception Ex)
            {
                return Ex.ToString();
            }
        }
        
        public int TestOfEntryRunningScheduler()
        {
            string ConnectionString = ReturnConnectionString();
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "INSERT INTO [dbo].[TestCall] VALUES (1, GETDATE())";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = SqlCommandText;                    
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            //RestChar = dr["RandChar"].ToString();
                            break;
                        }
                    }
                }
            }

            return 1;
        }
        public int RunHookNLineStuff()
        {
            try
            { 
                DateTime WeatherDateCheck = System.DateTime.Now.AddDays(-1);
                String WeatherDataString;
                string ConnectionString = ReturnConnectionString();

                DataTable DT = ReturnDataTableStoredProcedure("WebSite.CheckWeatherGetInfo");                
                foreach (DataRow row in DT.Rows) // Loop over the rows.
                {
                    Console.WriteLine("--- Row ---"); // Print separator.
                    foreach (var item in row.ItemArray) // Loop over the items.
                    {
                        WeatherDataString = item.ToString();
                        WeatherDateCheck = System.Convert.ToDateTime(WeatherDataString);
                        //Console.Write("Item: "); // Print label.
                        //Console.WriteLine(item); // Invokes ToString abstract method.
                    }
                }
                string EmailUserName = ConfigurationManager.AppSettings["EmailUserName"];
                string EmailUserPSW = ConfigurationManager.AppSettings["EmailPSW"];
                //SHIT
                // GemBox
                ComponentInfo.SetLicense("MCC5-EH7C-9M80-S5TO");
                using (ImapClient imap = new ImapClient("outlook.office365.com"))
                {
                    // Established Database Calls
                    Console.WriteLine("Connected.");
                    //DatabaseCalls dbHelper = new DatabaseCalls();
                    string Environment = "HookNLine";
                    string RetrievalVariable = "ConnectionString" + Environment;

                    imap.Connect();
                    Console.WriteLine("Connected.");
                    imap.Authenticate(EmailUserName, EmailUserPSW);
                    Console.WriteLine("Authenticated.");
                    // Select the Appropriate Folder
                    //imap.SelectFolder("HookNLineOrders", false);
                    imap.SelectFolder(@"GoDaddy/New Orders", false);
                    string DateSearchString = "SINCE 18-NOV-2011";
                    DateTime SearchDate = System.DateTime.Now.AddDays(-3);
                    DateSearchString = "SINCE " + SearchDate.ToString("dd-MMM-yyyy");
                    // List folder flags for INBOX
                    IList<int> messages = imap.SearchMessageNumbers(DateSearchString);
                    Console.WriteLine("Number of messages with 'Test' string in subject: " + messages.Count);
                    foreach (int uid in messages)
                    {
                        // Header Information
                        MailMessage CurrentEmail = imap.GetMessage(uid);

                        //Console.WriteLine(CurrentEmail.BodyHtml);
                        //Console.WriteLine(CurrentEmail.BodyText);
                        if (CurrentEmail.Subject == "New Order #R962075881")
                        {
                            Console.WriteLine("Found Original File");
                        }
                        if (CurrentEmail.To.ToString() == "brandon.jarnagin@gmail.com")
                        {
                            Console.WriteLine("TEST");
                        }
                        if (CurrentEmail.Subject.Length > 11)  // Weeding out emails that are too small
                        {
                            String OrderNumber = CurrentEmail.Subject.Substring(11, CurrentEmail.Subject.Length - 11);
                            String TstSubjectName = CurrentEmail.Subject.Substring(0, 11);

                            if ((CurrentEmail.To.ToString() == EmailUserName) && (TstSubjectName == "New Order #"))
                            {

                                String Subject = CurrentEmail.Subject;
                                Console.WriteLine(Subject);
                                String Body = CurrentEmail.BodyHtml;

                                //File.WriteAllText(@"C:\Temp\Body.HTML", Body);
                                int FindName = 0;
                                int FindEnd = 0;
                                //String FindFile = "New order: ";
                                String FindFile = "New order";
                                FindName = Body.IndexOf(FindFile);
                                FindEnd = Body.IndexOf("</td>", FindName);
                                String ClientEmail = Body.Substring(FindName, FindEnd - FindName);
                                //File.WriteAllText(@"C:\Temp\TestScript.HTML", ClientEmail);
                                int FindLine = ClientEmail.IndexOf("|");
                                ClientEmail = ClientEmail.Substring(FindLine, ClientEmail.Length - FindLine);
                                ClientEmail = ClientEmail.Replace("|", "");
                                ClientEmail = ClientEmail.Replace("</p>", "");
                                ClientEmail = ClientEmail.Trim();
                                if (ClientEmail.ToString() == "awkelley4@gmail.com")
                                {
                                    Console.WriteLine("TEST");
                                }
                                FindName = Body.IndexOf("New order from");
                                FindEnd = Body.IndexOf("</p", FindName);
                                String FullName = Body.Substring(FindName, FindEnd - FindName);
                                FullName = FullName.Replace("New order from:", "");
                                FullName = FullName.Trim();
                                
                                bool BodySearch = false;

                                //AzureHookNLineDbTableAdapters.UserPurchasesGetInfoAllTableAdapter AllMapsPurchased;
                                //AllMapsPurchased = new AzureHookNLineDbTableAdapters.UserPurchasesGetInfoAllTableAdapter();
                                //AzureHookNLineDb.UserPurchasesGetInfoAllDataTable AllMapDT;
                                //AllMapDT = AllMapsPurchased.GetData(ClientEmail);
                                String StoredProc = "WebSite.UserPurchasesGetInfoAll '" + ClientEmail + "'";
                                DataTable AllMapDT = ReturnDataTableStoredProcedure(StoredProc);
                                
                                DateTime DtReceivedDate = CurrentEmail.Date;
                                bool SendEmail = false;
                                bool SendNewEmail = false;
                                bool PreviousMapOwner = false;
                                if (AllMapDT.Rows.Count > 1) { PreviousMapOwner = true; }

                                List<MapsToPrint> MapsToPrintLst = new List<MapsToPrint>();

                                //List<WayPoints> SelectionItemsinfo = new List<WayPoints>();
                                String NewPassword = "Password01";
                                // Checking the F-102 is a purchase
                                // Initial Maps 

                                if ((Body.IndexOf("F102-A Galveston Bay Boat Fishing Online Map App") > 0))
                                {
                                    // Add F102 - A                                    
                                    //AzureHookNLineDbTableAdapters.UserPurchasesUpsertTableAdapter LoginPurchasor;
                                    //LoginPurchasor = new AzureHookNLineDbTableAdapters.UserPurchasesUpsertTableAdapter();
                                    //AzureHookNLineDb.UserPurchasesUpsertDataTable UserPurchasorDT;
                                    //UserPurchasorDT = LoginPurchasor.GetData(ClientEmail, 1, NewPassword, DtReceivedDate);                                    
                                    StoredProc = "WebSite.UserPurchasesUpsert '" + ClientEmail + "',1,'" + NewPassword + "','" + DtReceivedDate + "'";
                                    DataTable UserPurchasorDT = ReturnDataTableStoredProcedure(StoredProc);

                                    foreach (DataRow row in UserPurchasorDT.Rows) // Loop over the rows.
                                    {
                                        Console.WriteLine("--- Row ---"); // Print separator.                                    
                                        int AddMap = System.Convert.ToInt32(row["AddMap"].ToString());
                                        if (AddMap == 1)
                                        {
                                            SendEmail = true;
                                            MapsToPrintLst.Add(new MapsToPrint() { MapName = row["MapName"].ToString(), MapSelectionID = 1 });
                                            //SendNewEmail 
                                            int ReturnStatus = System.Convert.ToInt32(row["ReturnStatus"].ToString());
                                            if (ReturnStatus != 3)
                                            {
                                                SendNewEmail = true;
                                            }
                                        }
                                    }
                                }
                                // Checking the F-103 is a purchase
                                if ((Body.IndexOf("F103-A Galveston Bay Wade") > 0))
                                {
                                    // Add F102 - A       

                                    int CountOfCurrentRecords = 0;

                                    //AzureHookNLineDbTableAdapters.UserPurchasesUpsertTableAdapter LoginPurchasor;
                                    //LoginPurchasor = new AzureHookNLineDbTableAdapters.UserPurchasesUpsertTableAdapter();
                                    //AzureHookNLineDb.UserPurchasesUpsertDataTable UserPurchasorDT;
                                    //UserPurchasorDT = LoginPurchasor.GetData(ClientEmail, 5, NewPassword, DtReceivedDate);

                                    StoredProc = "WebSite.UserPurchasesUpsert '" + ClientEmail + "',5,'" + NewPassword + "','" + DtReceivedDate + "'";
                                    DataTable UserPurchasorDT = ReturnDataTableStoredProcedure(StoredProc);

                                    foreach (DataRow row in UserPurchasorDT.Rows) // Loop over the rows.
                                    {
                                        //Console.WriteLine("--- Row ---"); // Print separator.                                    
                                        Console.WriteLine("--- Row ---"); // Print separator.                                    
                                        int AddMap = System.Convert.ToInt32(row["AddMap"].ToString());
                                        if (AddMap == 1)
                                        {
                                            SendEmail = true;
                                            MapsToPrintLst.Add(new MapsToPrint() { MapName = row["MapName"].ToString(), MapSelectionID = 1 });
                                        }
                                        int ReturnStatus = System.Convert.ToInt32(row["ReturnStatus"].ToString());
                                        if (ReturnStatus != 3)
                                        {
                                            SendNewEmail = true;
                                        }
                                    }
                                }
                                
                                bool AlreadyMaps = false;
                                if (MapsToPrintLst.Count == AllMapDT.Rows.Count)
                                {
                                    AlreadyMaps = true;
                                }

                                if (SendEmail == true)
                                {
                                    String ClientPassword = NewPassword;
                                    // Send an email to the client with the email
                                    // ClientEmail = "aeplager@qkss.com";
                                    MailMessage message = new MailMessage(new MailAddress(EmailUserName, "Sender"),
                                                 new MailAddress(ClientEmail, "First receiver"));
                                    String EmailSubject = "";
                                    String EmailBody = "";
                                    if ((SendNewEmail == true) && (PreviousMapOwner == false))
                                    {
                                        EmailSubject = "Hook N Line Mapping Program Set Up";
                                        EmailBody = "Congratulations on your purchases for the below stated map(s)" + "\r\n";
                                        int iCnt = MapsToPrintLst.Count;
                                        for (int i = 0; i < iCnt; i++)
                                        {
                                            EmailBody = EmailBody + MapsToPrintLst[i].MapName + "\r\n";
                                        }
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "You can now access the above map(s) at the following web link:" + "\r\n";
                                        EmailBody = EmailBody + "https://hooknline.azurewebsites.net/MappingPage.html" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Your user name is " + ClientEmail + "\r\n";
                                        EmailBody = EmailBody + "Your password is Password01" + "\r\n";
                                        EmailBody = EmailBody + "Please change your password when you login" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Thank You," + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Hook N Line Customer Service" + "\r\n";
                                    }
                                    else
                                    {
                                        // Obtain all maps purchased

                                        List<String> AllMapsToPrintLst = new List<String>();

                                        EmailSubject = "Hook N Line Mapping Program Set Up";
                                        EmailBody = "Congratulations on your purchases for the below stated map(s)" + "\r\n";
                                        int iCnt = MapsToPrintLst.Count;
                                        for (int i = 0; i < iCnt; i++)
                                        {
                                            EmailBody = EmailBody + MapsToPrintLst[i].MapName + "\r\n";
                                        }
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Here is a summary of all the maps you have purchased" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        for (int i = 0; i < iCnt; i++)
                                        {
                                            EmailBody = EmailBody + MapsToPrintLst[i].MapName + "\r\n";
                                        }
                                        foreach (DataRow row in AllMapDT.Rows) // Loop over the rows.
                                        {
                                            EmailBody = EmailBody + row["MapName"].ToString() + "\r\n";
                                        }
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "You can now access the above map(s) at the following web link:" + "\r\n";
                                        EmailBody = EmailBody + "https://hooknline.azurewebsites.net/MappingPage.html" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Your user name is " + ClientEmail + "\r\n";
                                        EmailBody = EmailBody + "Your password is the last password you used." + "\r\n";
                                        EmailBody = EmailBody + "If you forgot your password, please reset the password" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Thank You," + "\r\n";
                                        EmailBody = EmailBody + "" + "\r\n";
                                        EmailBody = EmailBody + "Hook N Line Customer Service" + "\r\n";
                                    }
                                    message.Subject = EmailSubject;
                                    message.BodyText = EmailBody; //"Please log into the Hook N Line Web site at https://hooknline.azurewebsites.net/MappingPage.html \r\n" +
                                                                  //"Using User Name of " + ClientEmail + "\r\n" +
                                                                  //"and a password of " + ClientPassword + "\r\n";
                                    using (SmtpClient smtp = new SmtpClient("smtp.office365.com"))
                                    {
                                        smtp.Connect();
                                        Console.WriteLine("Connected.");

                                        smtp.Authenticate(EmailUserName, EmailUserPSW);
                                        Console.WriteLine("Authenticated.");

                                        smtp.SendMessage(message);

                                        //AzureHookNLineDbTableAdapters.QueriesTableAdapter UserNameUpsertQT = new AzureHookNLineDbTableAdapters.QueriesTableAdapter();
                                        //UserNameUpsertQT.InitialUserNameSetupUpsert(ClientEmail, ClientPassword, true);
                                        // Update the table 
                                        ConnectionString = ReturnConnectionString();
                                        DataSet ds = new DataSet();
                                        DataTable dt = new DataTable();
                                        StoredProc = "";
                                        using (SqlConnection con = new SqlConnection(ConnectionString))
                                        {
                                            using (SqlCommand cmd = new SqlCommand(StoredProc, con))
                                            {
                                                cmd.CommandType = CommandType.StoredProcedure;
                                                cmd.CommandText = StoredProc;
                                                cmd.Parameters.AddWithValue("@UserName", ClientEmail);
                                                cmd.Parameters.AddWithValue("@Password", ClientPassword);
                                                cmd.Parameters.AddWithValue("@EmailSent", true);
                                                cmd.Connection = con;
                                                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                                                {
                                                    da.Fill(ds, "SelectionItems");
                                                }

                                            }
                                        }
                                        }
                                    // Send out email
                                }
                            }
                        }
                    }
                }
                return 1;
            }
            catch (InvalidCastException e)
            {
                return 2;
            }
        }
        
        private DataTable ReturnDataTableStoredProcedure(string StoredProc)
        {
            string ConnectionString = ReturnConnectionString();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            //StoredProc = "EXEC " + StoredProc;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(StoredProc, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = StoredProc;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {                        
                        da.Fill(dt);
                    }
                }
            //    using (SqlCommand cmd = new SqlCommand())
            //    {
            //        string SqlCommandText = StoredProc;
            //        cmd.CommandType = CommandType.StoredProcedure;
            //        cmd.CommandText = SqlCommandText;
            //        cmd.Connection = con;
            //        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            //        {
            //            da.Fill(ds, "SelectionItems");
            //        }
            //    }
            }
            return dt;
        }

   
        public string SetNewestPassword(string ResetKey, string NewPassword)
        {
            string StatusPasswordSet;
            StatusPasswordSet = "FAIL";
            DataSet ds = new DataSet();
            //string NewPassword = "SHIT";
            string ConnectionString = ReturnConnectionString();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    string SqlCommandText = "[WebSite].[UserNameResetUpsert]";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = SqlCommandText;
                    cmd.Parameters.AddWithValue("@ResetKey", ResetKey);
                    cmd.Parameters.AddWithValue("@NewPassword", NewPassword);
                    cmd.Connection = con;
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds, "SelectionItems");
                    }
                }
            }
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables["SelectionItems"].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
                        {
                            StatusPasswordSet = dr["Status"].ToString();
                            break;
                        }
                    }
                }
            }
            return StatusPasswordSet;
        }
        
        private String ReturnConnectionString()
        {
            try
            {
                string Environment = ConfigurationManager.AppSettings["Environment"];
                string RetrievalVariable = "ConnectionString" + Environment;
                string ConnectionString = ConfigurationManager.AppSettings[RetrievalVariable];
                return ConnectionString;
            }
            catch (Exception ex)
            {
                string Error = ex.ToString();
                return @"Data Source=MACBOOKPRO-PC\SQLSVR2012;Trusted_Connection=True;DataBase=NOV2";
            }
        }


        public List<Players> GetPlayersXml()
        {
            return GetPlayers();
        }

        public List<Players> GetPlayersJson()
        {
            return GetPlayers();

        }

        public List<Players> GetPlayersJsonParam(string userid, string password)
        {
            List<Players> Players = new List<Players>
                {
                new Players
                {
                Country =userid, Name=password,Sports ="Cricket", ImageUrl="sachin.jpg"
                },
                new Players
                {
                Country =userid, Name=password,Sports ="Cricket", ImageUrl="dhoni.jpg"
                },
                new Players
                {
                Country =userid, Name="Rickey Ponting",Sports ="Cricket", ImageUrl="rickey.jpg"
                },
                new Players
                {
                Country =userid, Name="Sandeep Singh",Sports ="Hockey", ImageUrl="sandeep.jpg"
                },

                };
            return Players;

        }

        private List<Players> GetPlayers()
        {
            List<Players> Players = new List<Players>
                {
                new Players
                {
                Country ="India", Name="Sachin Tendulkar",Sports ="Cricket", ImageUrl="sachin.jpg"
                },
                new Players
                {
                Country ="India", Name="MS Dhoni",Sports ="Cricket", ImageUrl="dhoni.jpg"
                },
                new Players
                {
                Country ="Australia", Name="Rickey Ponting",Sports ="Cricket", ImageUrl="rickey.jpg"
                },
                new Players
                {
                Country ="India", Name="Sandeep Singh",Sports ="Hockey", ImageUrl="sandeep.jpg"
                },

                };
            return Players;
        }
        
        //public string GetData(int value)
        //{
        //    return string.Format("You entered: {0}", value);
        //}

        //public CompositeType GetDataUsingDataContract(CompositeType composite)
        //{
        //    if (composite == null)
        //    {
        //        throw new ArgumentNullException("composite");
        //    }
        //    if (composite.BoolValue)
        //    {
        //        composite.StringValue += "Suffix";
        //    }
        //    return composite;
        //}
    }
}
