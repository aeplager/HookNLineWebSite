USE [QKSSDevelopment]

TRUNCATE TABLE [WebSite].[UserNames]

INSERT INTO [WebSite].[UserNames]
           ([UserName]
           ,[Password]
           ,[FirstName]
           ,[LastName]
           ,[Registered]
           ,[SignedIn]
           ,[LastSignInDate]
           )
     VALUES
           ('Adam.Plager'
           ,'Gogators'
           ,'Adam'
           ,'Plager'
           ,<Registered, bit,>
           ,<SignedIn, bit,>
           ,<LastSignInDate, datetime,>
           )


