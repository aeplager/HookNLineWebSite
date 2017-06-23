IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTimeWaterTemp]') AND type in (N'U'))
DROP TABLE [WebSite].[WeatherRealTimeWaterTemp]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WeatherRealTimeWaterTemp](	
	[WeatherStationID] [int] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[RecordedTime] [DateTime] NOT NULL,
	[WaterTemp] FLOAT NULL,
PRIMARY KEY CLUSTERED 
(
	[WeatherStationID] DESC, [InsertDate] DESC, [RecordedTime] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
