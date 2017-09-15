/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherForecastAllUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherForecastAllUpsert]
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
CREATE PROCEDURE [WebSite].[WeatherForecastAllUpsert]
	-- Add the parameters for the stored procedure here	
	@FromTime DATETIME, @ToTime DATETIME
	,@WeatherConditionID INT = NULL, @WeatherCondition VARCHAR(MAX) = NULL
	,@PrecipitationVolume FLOAT = NULL, @PrecipitationUnit VARCHAR(500) = NULL, @PrecipitationType VARCHAR(500) = NULL
	,@WindDirection FLOAT = NULL, @WindCode VARCHAR(250) = NULL, @WindDescription VARCHAR(250) = NULL
	,@TempUnit FLOAT = NULL, @TempValue FLOAT = NULL, @TempMin FLOAT = NULL, @TempMax FLOAT = NULL
	,@PressUnit VARCHAR(250) = NULL, @PressValue FLOAT = NULL
	,@HumidityValue FLOAT = NULL, @HumidityUnit VARCHAR(250) = NULL
	,@CloudsValue VARCHAR(MAX) = NULL
	,@InsertDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		



INSERT INTO [WebSite].[WeatherForecast]
           ([WeatherStationID]
           ,[RecordedTime]
           ,[FromTime]
           ,[ToTime]
           ,[WeatherConditionID]
           ,[WeatherCondition]
           ,[WeatherIconID]
           ,[PrecipitationVolume]
           ,[PrecipitationUnit]
           ,[PrecipitationType]
           ,[WindDirection]
           ,[WindCode]
           ,[WindDescription]
           ,[TempUnit]
           ,[TempValue]
           ,[TempMin]
           ,[TempMax]
           ,[PressUnit]
           ,[PressValue]
           ,[HumidityValue]
           ,[HumidityUnit]
           ,[CloudsValue]
           ,[InsertDate])
     VALUES
           (1 -- Hard Coded to be the one weather station
           ,@InsertDate
           ,@FromTime
           ,@ToTime
           ,@WeatherConditionID
           ,@WeatherCondition
           ,1
           ,@PrecipitationVolume
           ,@PrecipitationUnit
           ,@PrecipitationType
           ,@WindDirection
           ,@WindCode
           ,@WindDescription
           ,@TempUnit
           ,@TempValue
           ,@TempMin
           ,@TempMax
           ,@PressUnit
           ,@PressValue
           ,@HumidityValue
           ,@HumidityUnit
           ,@CloudsValue
           ,@InsertDate)


END



GO
--EXEC [WebSite].[WeatherForecastAllUpsert] '4/1/2016 5PM', '4/1/2016 6PM', 76, 'Calm Seas'