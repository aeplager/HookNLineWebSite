IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[MapDefinitions]') AND type in (N'U'))
DROP TABLE [WebSite].[MapDefinitions]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[MapDefinitions](
	[MapDefinitionsID] [int] IDENTITY(1,1) NOT NULL,
	[MapDefinitionsName] [varchar](500) NOT NULL,
	[SYSNAME] VARCHAR(12) NOT NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[MapDefinitionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
