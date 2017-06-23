USE [QKSSDevelopment]
GO
TRUNCATE TABLE [WebSite].[MapDefinitions]
INSERT INTO [WebSite].[MapDefinitions]
           ([SYSNAME]
		   ,[MapDefinitionsName]
           ,[InsertDate]
           ,[LastModifiedDate])
     VALUES
           ('WESTBAY'
		   ,'West Bay'
           ,GETDATE()
           ,GETDATE())
		,('DICKENSON'
		   ,'Dickenson Bay'
           ,GETDATE()
           ,GETDATE())
GO
UPDATE [WebSite].[WayPoints] SET [MapDefinitionsID] = 1
	WHERE ISNULL([MapDefinitionsID],0) = 0

