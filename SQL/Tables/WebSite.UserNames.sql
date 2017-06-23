IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNames]') AND type in (N'U'))
DROP TABLE [WebSite].[UserNames]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[UserNames](
	[UserName] [varchar] (250) NOT NULL,
	[Password] [varchar] (250) NULL,
	[FirstName] [varchar](500) NULL,
	[LastName] [varchar](500) NULL,
	[Registered] [bit] NULL DEFAULT(0),
	[SignedIn] [bit] NULL DEFAULT(0),	
	[LastSignInDate] [datetime] NULL DEFAULT(GETDATE()), 
	[EmailSent] [bit] NULL DEFAULT(0),
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT INTO WebSite.UserNames (UserName, Password)
VALUES ('joetrom@sbcglobal.net', 'joe123')
,('aeplager@qkss.com','apl')
SELECT * FROM WebSite.UserNames 
