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

namespace WCFWebRole
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "WCFWebService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select WCFWebService.svc or WCFWebService.svc.cs at the Solution Explorer and start debugging.
    public class WCFWebService : IWCFWebService
    {


        public List<WayPoints> SpecificWayPointGetInfo(double Latitude, double Longitude)
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
                    SqlCommandText = SqlCommandText + ",WT.[WayPointTypeID],[WayPointTypeName]";
                    SqlCommandText = SqlCommandText + ",geography::STGeomFromText('POINT(" + Latitude + " " + Longitude + ")', 4326).STDistance([GeoLocation])  as Distance";
                    SqlCommandText = SqlCommandText + " FROM	[WebSite].[WayPoints] W";
                    SqlCommandText = SqlCommandText + " INNER JOIN WebSite.WayPointType WT ON W.[WayPointTypeID] = WT.[WayPointTypeID]";
                    SqlCommandText = SqlCommandText + " ORDER BY geography::STGeomFromText('POINT(" + Latitude + " " + Longitude + ")', 4326).STDistance([GeoLocation])";
                    //SqlCommandText = SqlCommandText + " ORDER BY geography::STGeomFromText('POINT(-94.9328333326 29.5049999747)', 4326).STDistance([GeoLocation])";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "[WebSite].[SpecificWayPointGetInfo]";
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Lat", Latitude);
                    cmd.Parameters.AddWithValue("@Lng", Longitude);
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
                            SelectionItemsinfo.RecordedTime = SelectionItemsinfo.RecordedTime.AddHours(-5);
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
                                ForecastDate = String.Format("{0:MM/dd/yyyy hh:mm tt}", dr["ForecastDateTimeCST"]),
                                ForecastStatus = dr["WeatherCondition"].ToString(),
                                ForecastTemp = Convert.ToDouble(dr["TempValue"]),

                            });
                        }
                    }
                }
            }
            return SelectionItemsinfo;

        }
        public List<WayPoints> AllWayPointsGetInfo()
        {
            string MapDefinition;
            MapDefinition = "1";
            string mystring = "" + (char)34;
            MapDefinition = MapDefinition.Replace(mystring, "");
            mystring = "" + (char)47;
            MapDefinition = MapDefinition.Replace(mystring, "");
            mystring = "" + (char)92;
            MapDefinition = MapDefinition.Replace(mystring, "");
            MapDefinition = "1";
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
        //***************************************************************************
        // Setting Password Information
        //***************************************************************************
        //public string SendEmailForNewPassword(string UserName)
        //{
        //    string RestChar;
        //    RestChar = "FAIL";
        //    DataSet ds = new DataSet();
        //    string ConnectionString = ReturnConnectionString();
        //    using (SqlConnection con = new SqlConnection(ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand())
        //        {
        //            string SqlCommandText = "[WebSite].[UserNameSetupUpsert]";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.CommandText = SqlCommandText;
        //            cmd.Parameters.AddWithValue("@UserName", UserName);
        //            cmd.Connection = con;
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                da.Fill(ds, "SelectionItems");
        //            }
        //        }
        //    }
        //    if (ds != null)
        //    {
        //        if (ds.Tables.Count > 0)
        //        {
        //            if (ds.Tables["SelectionItems"].Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
        //                {
        //                    RestChar = dr["RandChar"].ToString();
        //                    break;
        //                }
        //            }
        //        }
        //    }
        //    try
        //    {

        //        ComponentInfo.SetLicense("FREE-LIMITED-KEY");
        //        //Console.WriteLine("Creating message...");
        //        MailMessage message = new MailMessage(new MailAddress("info@hooknline.net", "Joe Trombley"), new MailAddress(UserName, "Adam Plager"));
        //        message.Subject = "Hook N Line Reset Password";
        //        message.BodyText = "Please go to the following URL to reset your password:   http://localhost:17691/HookNLinePasswordReset.html?" + RestChar;
        //        using (SmtpClient smtp = new SmtpClient("smtp.office365.com"))
        //        {
        //            smtp.Connect();
        //            //Console.WriteLine("Connected.");
        //            smtp.Authenticate("info@hooknline.net", "G0gators#12");
        //            smtp.SendMessage(message);
        //        }
        //        return RestChar;
        //    }
        //    catch (Exception Ex)
        //    {
        //        return Ex.ToString();
        //    }
        //}
        //public string SetNewPassword(string UserName, string ResetKey, string NewPassword)
        //{
        //    string StatusPasswordSet;
        //    StatusPasswordSet = "FAIL";
        //    DataSet ds = new DataSet();
        //    string ConnectionString = ReturnConnectionString();
        //    using (SqlConnection con = new SqlConnection(ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand())
        //        {
        //            string SqlCommandText = "[WebSite].[UserNameResetUpsert]";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.CommandText = SqlCommandText;
        //            cmd.Parameters.AddWithValue("@ResetKey", ResetKey);
        //            cmd.Parameters.AddWithValue("@NewPassword", NewPassword);
        //            cmd.Connection = con;
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                da.Fill(ds, "SelectionItems");
        //            }
        //        }
        //    }
        //    if (ds != null)
        //    {
        //        if (ds.Tables.Count > 0)
        //        {
        //            if (ds.Tables["SelectionItems"].Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in ds.Tables["SelectionItems"].Rows)
        //                {
        //                    StatusPasswordSet = dr["Status"].ToString();
        //                    break;
        //                }
        //            }
        //        }
        //    }
        //    return StatusPasswordSet;

        //}




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
