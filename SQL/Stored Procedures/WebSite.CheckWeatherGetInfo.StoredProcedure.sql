USE [HookNLine]
GO

/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 11/24/2016 6:25:14 PM ******/
IF ISNULL((SELECT COUNT(*) as CountOfRecords FROM SYS.OBJECTS WHERE [type] = 'P' AND name = 'CheckWeatherGetInfo'),0) <> 0
BEGIN	
	DROP PROCEDURE [WebSite].[CheckWeatherGetInfo]
END 

GO

/****** Object:  StoredProcedure [WebSite].[LoginValidationGetInfo]    Script Date: 11/24/2016 6:25:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[CheckWeatherGetInfo]
	-- Add the parameters for the stored procedure here		
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @RealTimeWeatherInformation DATETIME
	DECLARE @ForecastWeatherInformation DATETIME
	DECLARE @BaseTime DATETIME = '1/1/2000'
	SELECT @RealTimeWeatherInformation = ISNULL(MAX(InsertDate), @BaseTime)
	FROM [WebSite].[WeatherRealTime]

	SELECT @ForecastWeatherInformation = ISNULL(MAX(InsertDate), @BaseTime)
	FROM [WebSite].[WeatherForecast]
	
	

	SELECT (CASE WHEN @ForecastWeatherInformation > @RealTimeWeatherInformation  THEN @RealTimeWeatherInformation  
	ELSE @ForecastWeatherInformation 
	END) as WeatherMaxTimeGMT
END
GO


EXEC [WebSite].[CheckWeatherGetInfo]
