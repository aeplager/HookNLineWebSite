IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[ImagesLayers]') AND type in (N'U'))
DROP TABLE [WebSite].[ImagesLayers]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[ImagesLayers](
	[ImagesLayersID] [int] IDENTITY(1,1) NOT NULL,	
	[MapSelectionsID] [int] NOT NULL,
	[ImagesLayersURL] [varchar](500) NOT NULL,
	[Lat1] [FLOAT] NOT NULL, 
	[Lng1] [FLOAT] NOT NULL,
	[Lat2] [FLOAT] NOT NULL, 
	[Lng2] [FLOAT] NOT NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ImagesLayersID]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT INTO [WebSite].[ImagesLayers] ([MapSelectionsID], [ImagesLayersURL], [Lat1], [Lng1], [Lat2], [Lng2] )
	VALUES (1,'https://qkss.com/HooknLine/TILES/TrinityBay/',29.376639, -95.097300, 29.801420, -94.353477)
	,(1,'https://qkss.com/HooknLine/TILES/WestBay/', 28.993955, -95.309236, 29.385521, -94.814655)
	,(2,'https://qkss.com/HooknLine/TILES/DickensonBay/',  29.407933, -94.96053, 29.504333, -94.875166)

	SELECT * FROM [WebSite].[ImagesLayers] 