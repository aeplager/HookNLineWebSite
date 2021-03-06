﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WCFWebRole
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IWCFWebService" in both code and config file together.
    [ServiceContract]
    public interface IWCFWebService
    {

        [WebGet(UriTemplate = "/GetPlayersXml",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Bare)]
        List<Players> GetPlayersXml();

        [WebGet(UriTemplate = "/GetPlayersJson",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        List<Players> GetPlayersJson();

        [WebGet(UriTemplate = "/GetPlayersJsonParam/?userid={userid}&password={password}",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        List<Players> GetPlayersJsonParam(string userid, string password);

        [WebGet(UriTemplate = "/SpecificWayPointGetInfo/?Latitude={Latitude}&Longitude={Longitude}&MapDefinition={MapDefinition}",
           RequestFormat = WebMessageFormat.Json,
           ResponseFormat = WebMessageFormat.Json,
           BodyStyle = WebMessageBodyStyle.Bare)]
        List<WayPoints> SpecificWayPointGetInfo(double Latitude, double Longitude, int MapDefinition);

        [WebGet(UriTemplate = "/RealTimeWeatherGetInfo",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        RealTimeWeather RealTimeWeatherGetInfo();

        [WebGet(UriTemplate = "/WeatherForecastGetInfo",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        List<WeatherForecast> WeatherForecastGetInfo();

        [WebGet(UriTemplate = "/AllWayPointsGetInfo/?MapSelection={MapSelection}",
          RequestFormat = WebMessageFormat.Json,
          ResponseFormat = WebMessageFormat.Json,
          BodyStyle = WebMessageBodyStyle.Bare)]
        List<WayPoints> AllWayPointsGetInfo(int MapSelection);

        [WebGet(UriTemplate = "/LoginValidation/?UserName={UserName}&Password={Password}",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Bare)]
        string LoginValidation(string UserName, string Password);

        [WebGet(UriTemplate = "/SetNewestPassword/?ResetKey={ResetKey}&NewPassword={NewPassword}",
          RequestFormat = WebMessageFormat.Json,
          ResponseFormat = WebMessageFormat.Json,
          BodyStyle = WebMessageBodyStyle.Bare)]
        string SetNewestPassword(string ResetKey, string NewPassword);

        [WebGet(UriTemplate = "/SendEmailForNewPassword/?UserName={UserName}",
          RequestFormat = WebMessageFormat.Json,
          ResponseFormat = WebMessageFormat.Json,
          BodyStyle = WebMessageBodyStyle.Bare)]
        string SendEmailForNewPassword(string UserName);
        
        [WebGet(UriTemplate = "/UserPurchasesGetInfo/?UserName={UserName}",
          RequestFormat = WebMessageFormat.Json,
          ResponseFormat = WebMessageFormat.Json,
          BodyStyle = WebMessageBodyStyle.Bare)]
        List<UserPurchases> UserPurchasesGetInfo(String UserName);


        [WebGet(UriTemplate = "/UserNameValidation/?UserName={UserName}",
           RequestFormat = WebMessageFormat.Json,
           ResponseFormat = WebMessageFormat.Json,
           BodyStyle = WebMessageBodyStyle.Bare)]
        int UserNameValidation(String UserName);


        [WebGet(UriTemplate = "/TestOfEntryRunningScheduler",
           RequestFormat = WebMessageFormat.Json,
           ResponseFormat = WebMessageFormat.Json,
           BodyStyle = WebMessageBodyStyle.Bare)]
        int TestOfEntryRunningScheduler();

        [WebGet(UriTemplate = "/RunHookNLineStuff",
           RequestFormat = WebMessageFormat.Json,
           ResponseFormat = WebMessageFormat.Json,
           BodyStyle = WebMessageBodyStyle.Bare)]
        int RunHookNLineStuff(); 
        // TODO: Add your service operations here
    }
    [DataContract]
    public class Players
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Sports { get; set; }
        [DataMember]
        public string Country { get; set; }
        [DataMember]
        public string ImageUrl { get; set; }

    }
    [DataContract]
    public class TEST
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Sports { get; set; }
        [DataMember]
        public string Country { get; set; }
        [DataMember]
        public string ImageUrl { get; set; }

    }
    [DataContract]
    public class WayPoints
    {
        public int WayPointID { get; set; }
        [DataMember]
        public string WayPointName { get; set; }
        [DataMember]
        public double Latitude { get; set; }
        [DataMember]
        public double Longitude { get; set; }
        [DataMember]
        public string FishingText { get; set; }
        [DataMember]
        public string BestWindText { get; set; }
        [DataMember]
        public string TypeOfFishingText { get; set; }
        [DataMember]
        public int WayPointTypeID { get; set; }
        [DataMember]
        public string WayPointTypeName { get; set; }
    }
    public class RealTimeWeather
    {
        [DataMember]
        public int WeatherStationID { get; set; }
        [DataMember]
        public DateTime InsertDate { get; set; }
        [DataMember]
        public DateTime RecordedTime { get; set; }
        [DataMember]
        public String RecordedTimeFormatted { get; set; }
        [DataMember]
        public String TempUnit { get; set; }
        [DataMember]
        public Double TempValue { get; set; }
        [DataMember]
        public String TempValueFormatted { get; set; }
        [DataMember]
        public Double WaterTempValue { get; set; }
        [DataMember]
        public String WaterTempValueFormatted { get; set; }
        [DataMember]
        public Double TempMin { get; set; }
        [DataMember]
        public Double TempMax { get; set; }
        [DataMember]
        public Double HumidityValue { get; set; }
        [DataMember]
        public String HumidityUnit { get; set; }
        [DataMember]
        public String PressUnit { get; set; }
        [DataMember]
        public Double PressValue { get; set; }
        [DataMember]
        public Double WindSpeed { get; set; }
        [DataMember]
        public String WindSpeedDesc { get; set; }
        [DataMember]
        public String WindCode { get; set; }
        [DataMember]
        public String WindDescription { get; set; }
        [DataMember]
        public int WindDir { get; set; }
        [DataMember]
        public String CloudsValue { get; set; }
        [DataMember]
        public String WeatherValue { get; set; }
    }
    public class WeatherForecast
    {
        [DataMember]
        public String DateOfForecast { get; set; }
        [DataMember]
        public String ForecastDate { get; set; }
        [DataMember]
        public String ForecastStatus { get; set; }
        [DataMember]
        public String ForecastTemp { get; set; }
    }
    public class UserPurchases
    {
        [DataMember]
        public String UserName { get; set; }
        [DataMember]
        public Int32 MapSelectionsID { get; set; }
        [DataMember]
        public String MapSelectionsName { get; set; }

    }
    public class MapsToPrint
    {
        public String MapName;
        public int MapSelectionID;
    }

}
