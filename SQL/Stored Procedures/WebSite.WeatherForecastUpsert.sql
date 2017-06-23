/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherForecastUpsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherForecastUpsert]
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
CREATE PROCEDURE [WebSite].[WeatherForecastUpsert]
	-- Add the parameters for the stored procedure here	
	@FromTime DATETIME, @ToTime DATETIME, @Temp FLOAT, @WeatherDesc VARCHAR(MAX), @InsertDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	INSERT INTO [WebSite].[WeatherForecast] ([WeatherStationID], [RecordedTime], [FromTime], [ToTime], [TempValue], [WeatherCondition])
		VALUES (1, @InsertDate, @FromTime, @ToTime, @Temp, @WeatherDesc)
END



GO
--EXEC [WebSite].[WeatherForecastUpsert] '4/1/2016 5PM', '4/1/2016 6PM', 76, 'Calm Seas'