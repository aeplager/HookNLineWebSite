/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTimeUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherRealTimeUpsert]
GO


/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Adam Plager
-- Create date: 04/01/2016
-- Description:	Insert the Weather Forecast Information
-- =============================================
CREATE PROCEDURE [WebSite].[WeatherRealTimeUpsert]
	-- Add the parameters for the stored procedure here	
	@RecordTime DATETIME, 
	@TempUnit  VARCHAR(250) NULL,
	@TempValue  FLOAT NULL,
	@TempMin  FLOAT NULL,
	@TempMax  FLOAT NULL,
	@HumidityValue  FLOAT NULL,
	@HumidityUnit  VARCHAR(250) NULL,
	@PressUnit  VARCHAR(250) NULL,
	@PressValue  FLOAT NULL,
	@WindSpeed  [float] NULL,
	@WindSpeedDesc  [varchar] (500) NULL,
	@WindCode  VARCHAR(250) NULL,
	@WindDescription  VARCHAR(250) NULL,
	@CloudsValue  VARCHAR(Max) NULL,
	@WeatherValue  VARCHAR(Max) NULL,
	@WindDir FLOAT NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
INSERT INTO [WebSite].[WeatherRealTime]
           ([WeatherStationID]
           ,[InsertDate]
           ,[RecordedTime]
           ,[TempUnit]
           ,[TempValue]
           ,[TempMin]
           ,[TempMax]
           ,[HumidityValue]
           ,[HumidityUnit]
           ,[PressUnit]
           ,[PressValue]
           ,[WindSpeed]
           ,[WindSpeedDesc]
           ,[WindCode]
           ,[WindDescription]
           ,[CloudsValue]
           ,[WeatherValue]
		   ,[WindDir])
     VALUES
           (1
           ,@RecordTime
           ,@RecordTime
           ,@TempUnit
           ,@TempValue
           ,@TempMin
           ,@TempMax
           ,@HumidityValue
           ,@HumidityUnit
           ,@PressUnit
           ,@PressValue
           ,@WindSpeed
           ,@WindSpeedDesc
           ,@WindCode
           ,@WindDescription
           ,@CloudsValue
           ,@WeatherValue
		   ,@WindDir)



END



GO
