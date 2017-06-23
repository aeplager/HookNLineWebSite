USE [QKSSDevelopment]

GO
DECLARE @CurrentDate DateTime = GETDATE()
INSERT INTO [WebSite].[WeatherStation]
           ([WeatherStationName]
           ,[InsertDate]
           ,[LastModifiedDate])
     VALUES
           ('Eagle Point'
           ,@CurrentDate
           ,@CurrentDate)


