/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTimeGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherRealTimeGetInfo]
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
CREATE PROCEDURE [WebSite].[WeatherRealTimeGetInfo]
	-- Add the parameters for the stored procedure here	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	DECLARE @RecordedTime DATETIME = (SELECT MAX([RecordedTime]) as MaxDate FROM [WebSite].[WeatherRealTime])
	DECLARE @InsertDate DATETIME = (SELECT MAX([InsertDate]) as MaxDate FROM [WebSite].[WeatherRealTime])
	
	DECLARE @WaterRecordedTime DATETIME, @WaterTemp FLOAT = 0.00, @WaterTempInsertTime DATETIME
	SET @WaterTempInsertTime = (SELECT MAX(InsertDate) FROM WebSite.[WeatherRealTimeWaterTemp])
	SELECT @WaterRecordedTime = RecordedTime, @WaterTemp = WaterTemp FROM WebSite.[WeatherRealTimeWaterTemp] WHERE InsertDate = @WaterTempInsertTime 


SELECT [WeatherStationID]
      ,[InsertDate]
      ,[RecordedTime]
      ,'Fahrenheit' as TempUnit
      ,1.8*([TempValue] - 273) + 32 as TempValueF
      ,1.8*([TempMin] - 273) + 32 as TempMinF
      ,1.8*([TempMax] - 273) + 32 as TempMaxF
      ,[HumidityValue]
      ,[HumidityUnit]
      ,[PressUnit]
      ,[PressValue]
      ,[WindSpeed]
      ,[WindSpeedDesc]
      ,[WindCode]
      ,[WindDescription]	  
	  ,[WindDir]
      ,[CloudsValue]
      ,[WeatherValue]	  
	  ,@WaterRecordedTime  as WaterTempRecordedTime
	  ,@WaterTemp as WaterTemp
  FROM [WebSite].[WeatherRealTime]
  WHERE InsertDate = @InsertDate

END



GO
EXEC [WebSite].[WeatherRealTimeGetInfo]