USE [QKSSDevelopment]
GO
DECLARE @CurrentDate DateTime = GETDATE()
TRUNCATE TABLE [WebSite].[WayPoints] 
INSERT INTO [WebSite].[WayPoints] (WayPointName, Latitude, Longitude, InsertDate, LastModifiedDate)
SELECT Name, Lat, Long, @CurrentDate as InsertDate, @CurrentDate as LastModifiedDate
	FROM UniqueNumbers$
	WHERE Name <> 'BASTROP 5'
	AND ISNUMERIC(Lat) <> 0 
	GROUP BY Name, Lat, Long
	ORDER BY Name

	UPDATE WayPoints SET WayPoints.[FishingText] = [Fish]
	,WayPoints.[BestWindText] = [Best Wind]
	,WayPoints.[TypeOfFishingText] = [Type of Fishing]
	,LastModifiedDate = @CurrentDate
	FROM [WebSite].[WayPoints] WayPoints
	INNER JOIN ImportSheet$ ImpSheet ON WayPoints.WayPointName = ImpSheet.Name
	 
	 SELECT * FROM WebSite.WayPoints