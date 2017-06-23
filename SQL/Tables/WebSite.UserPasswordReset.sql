IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserNameReset]') AND type in (N'U'))
DROP TABLE [WebSite].[UserNameReset]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[UserNameReset](	
	[UserNameResetID] [int] IDENTITY(1,1) NOT NULL,
	[CurrentUserName] [varchar] (250) NOT NULL,
	[CurrentPassword] [varchar] (250) NOT NULL,
	[NewPassword] [varchar] (250) NOT NULL,
	[Reset] [bit] NOT NULL DEFAULT(0),
	[ResetStartDate] [datetime] NULL,
	[ResetEndDate] [datetime] NULL,
	[ResetKey] [varchar] (250) NOT NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[UserNameResetID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
