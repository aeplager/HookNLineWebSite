/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[SpecificWayPointsGetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [WebSite].[SpecificWayPointsGetInfo]
GO


/****** Object:  StoredProcedure [Import].[GraphLFChartGetInfo]    Script Date: 05/11/2015 16:14:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Adam Plager
-- Create date: 05/11/2015
-- Description:	Update Email Log Information
-- =============================================
CREATE PROCEDURE [WebSite].[SpecificWayPointsGetInfo]
	-- Add the parameters for the stored procedure here		
--	@Latitude FLOAT = 0, @Longitude FLOAT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--DECLARE @Latitude FLOAT = 29.5278333686
	--DECLARE @Longitude FLOAT = -94.8963333294
--SET @Latitude = '29.5049999747'
--SET @Longitude = '-94.9328333326'
--DECLARE @Lng VARCHAR(25) = CAST(CAST(@Longitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Longitude)
--DECLARE @Lat VARCHAR(25) = CAST(CAST(@Latitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Latitude)

--DECLARE @shape geography

--SET @shape = (SELECT TOP 1 [GeoLocation] FROM [WebSite].[WayPoints] WHERE  [WayPointsID] = 12)
--SET @shape  = geography::Point(29.5049999747,-94.9328333326, 4326)
--SELECT	TOP 1 [WayPointName]
--FROM	[WebSite].[WayPoints]
--WHERE	[GeoLocation].STDistance(@Shape) <= 100
--		AND [GeoLocation].STDistance(@Shape) = (
--			SELECT MIN([GeoLocation].STDistance(@Shape)) AS Distance
--			FROM [WebSite].[WayPoints]
--			WHERE [GeoLocation].STDistance(@Shape) <= 100
--		)
	DECLARE @Latitude FLOAT = 29.5278333686
	DECLARE @Longitude FLOAT = -94.8963333294
	SET @Latitude = '29.5049999747'
	SET @Longitude = '-94.9328333326'
	DECLARE @Lng VARCHAR(25) = CAST(CAST(@Longitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Longitude)
	DECLARE @Lat VARCHAR(25) = CAST(CAST(@Latitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Latitude)

	SELECT @Longitude as LNG, @Latitude as Lat
	SELECT @Lng as Lng, @Lat as Lat
	SELECT   TOP 1
	[WayPointName],
			 geography::STGeomFromText('POINT(' + @Lng   + ' ' + @Lat + ')', 4326).STDistance([GeoLocation])  as Distance
	FROM     [WebSite].[WayPoints]
	ORDER BY geography::STGeomFromText('POINT(' + @Lng   + ' ' + @Lat + ')', 4326).STDistance([GeoLocation])

GO
	DECLARE @Latitude FLOAT = 29.5278333686
	DECLARE @Longitude FLOAT = -94.8963333294
	SET @Latitude = '29.5049999747'
	SET @Longitude = '-94.9328333326'
	DECLARE @Lng VARCHAR(25) = CAST(CAST(@Longitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Longitude)
	DECLARE @Lat VARCHAR(25) = CAST(CAST(@Latitude AS DECIMAL(38,12)) as VARCHAR(40))--CONVERT(VARCHAR(25),@Latitude)

	SELECT @Longitude as LNG, @Latitude as Lat
	SELECT @Lng as Lng, @Lat as Lat
	SELECT   TOP 1
	[WayPointName],
			 geography::STGeomFromText('POINT(' + @Lng   + ' ' + @Lat + ')', 4326).STDistance([GeoLocation])  as Distance
	FROM     [WebSite].[WayPoints]
	ORDER BY geography::STGeomFromText('POINT(' + @Lng   + ' ' + @Lat + ')', 4326).STDistance([GeoLocation]);

	--	RETURN
EXEC [WebSite].[SpecificWayPointsGetInfo]  --@Latitude, @Longitude