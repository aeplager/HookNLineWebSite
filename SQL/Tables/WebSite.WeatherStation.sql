IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherStation]') AND type in (N'U'))
DROP TABLE [WebSite].[WeatherStation]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WeatherStation](	
	[WeatherStationID] [int] IDENTITY(1,1) NOT NULL,
	[WeatherStationName] [varchar] (500) NOT NULL,
	[Latitude] [numeric](19, 10) NULL,
	[Longitude] [numeric](19, 10) NULL,
	[GeoLocation] [geography] NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[WeatherStationID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
