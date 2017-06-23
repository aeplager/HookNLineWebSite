USE [QKSSDevelopment]

TRUNCATE TABLE [WebSite].[UserNameReset]

INSERT INTO [WebSite].[UserNameReset]
           ([CurrentUserName]
           ,[CurrentPassword]
           ,[NewPassword]
           ,[Reset]
           ,[ResetStartDate]
           ,[ResetEndDate]
           ,[ResetKey]
           ,[InsertDate]
           ,[LastModifiedDate])
     VALUES
           ('aeplager@qkss.com'
           ,'Password01'
           ,''
           ,0
           ,GETDATE()
           ,1
           ,'RESETNOW'
           ,GETDATE()
           ,GETDATE())
GO

