/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherForecastGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[WeatherForecastGetInfo]
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
CREATE PROCEDURE [WebSite].[WeatherForecastGetInfo]
	-- Add the parameters for the stored procedure here	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;		
	DECLARE @MaxDate DATETIME = (SELECT MAX([RecordedTime]) as MaxDate FROM [WebSite].[WeatherForecast])
	CREATE TABLE #Tmp ([RecordedTime] DATETIME NULL, FromTime DATETIME NULL)
	INSERT INTO #Tmp (FromTime, [RecordedTime])
	SELECT FromTime, MAX([RecordedTime]) as MaxDate--, DATEADD(HOUR,-5,FromTime) as CalcCST--, GETDATE() CurrentDate
		FROM [WebSite].[WeatherForecast] 
		WHERE FromTime >= GETDATE()
		GROUP BY FromTime
	
	SELECT DATEADD(HOUR,-5, T.RecordedTime) as DateOfForecastCST, DATEADD(HOUR,-5,T.FromTime) as ForecastDateTimeCST, W.[WeatherCondition], W.[TempValue]
		FROM #Tmp T
		INNER JOIN [WebSite].[WeatherForecast] W ON T.RecordedTime = W.RecordedTime AND T.FromTime = W.FromTime
		GROUP BY T.RecordedTime, T.FromTime, W.[WeatherCondition], W.[TempValue]
		ORDER BY T.FromTime ASC

	DROP TABLE #Tmp


END



GO
EXEC [WebSite].[WeatherForecastGetInfo]