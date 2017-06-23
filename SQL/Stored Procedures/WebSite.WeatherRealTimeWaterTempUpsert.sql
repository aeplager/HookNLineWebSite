/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTimeWaterTempUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherRealTimeWaterTempUpsert]
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
CREATE PROCEDURE [WebSite].[WeatherRealTimeWaterTempUpsert]
	-- Add the parameters for the stored procedure here	
	@RecordTime DATETIME, 	
	@WaterTempValue  FLOAT NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
INSERT INTO [WebSite].[WeatherRealTimeWaterTemp]
           ([WeatherStationID]
           ,[InsertDate]
           ,[RecordedTime]
           ,[WaterTemp])
     VALUES
           (1
           ,GETDATE()
           ,@RecordTime
           ,@WaterTempValue
		   )



END

GO
