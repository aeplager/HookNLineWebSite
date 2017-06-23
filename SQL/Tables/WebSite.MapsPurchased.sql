IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WayPoints]') AND type in (N'U'))
DROP TABLE [WebSite].[WayPoints]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WayPoints](
	[WayPointsID] [int] IDENTITY(1,1) NOT NULL,
	[MapDefinitionsID] [int] NOT NULL,
	[WayPointShortName] [varchar](500) NOT NULL,
	[WayPointName] [varchar](500) NOT NULL,
	[Latitude] FLOAT NOT NULL,
	[Longitude] FLOAT NOT NULL,
	[FishingText] VARCHAR(8000) NULL,
	[BestWindText] VARCHAR(8000) NULL,
	[TypeOfFishingText] VARCHAR(8000) NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[WayPointsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
