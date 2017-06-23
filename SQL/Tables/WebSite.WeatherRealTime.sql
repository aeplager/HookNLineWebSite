IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTime]') AND type in (N'U'))
DROP TABLE [WebSite].[WeatherRealTime]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WeatherRealTime](	
	[WeatherStationID] [int] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[RecordedTime] [DateTime] NOT NULL,
	[TempUnit] VARCHAR(250) NULL,
	[TempValue] FLOAT NULL,
	[TempMin] FLOAT NULL,
	[TempMax] FLOAT NULL,
	[HumidityValue] FLOAT NULL,
	[HumidityUnit] VARCHAR(250) NULL,
	[PressUnit] VARCHAR(250) NULL,
	[PressValue] FLOAT NULL,
	[WindSpeed] [float] NULL,
	[WindSpeedDesc] [varchar] (500) NULL,
	[WindCode] VARCHAR(250) NULL,
	[WindDescription] VARCHAR(250) NULL,
	[WindDir] FLOAT NULL,
	[CloudsValue] VARCHAR(Max) NULL,
	[WeatherValue] VARCHAR(Max) NULL,	
PRIMARY KEY CLUSTERED 
(
	[WeatherStationID] DESC, [InsertDate] DESC, [RecordedTime] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
