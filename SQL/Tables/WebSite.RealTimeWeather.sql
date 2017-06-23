IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherRealTime]') AND type in (N'U'))
DROP TABLE [WebSite].[WeatherRealTime]
GO


/****** Object:  Table [WebSite].[WeatherForecast]    Script Date: 4/3/2016 5:42:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WeatherRealTime](
	[WeatherStationID] [int] NOT NULL,
	[RecordedTime] [datetime] NOT NULL DEFAULT(GETDATE()),
	[TempCurrent] [float] NULL,
	[TempMin] [float] NULL,
	[TempMax] [float] NULL,
	[TempUnit] [varchar] (500) NULL, 
	[HumdityValue] [float] NULL,
	[HumdityUnit] [varchar] (500) NULL, 
	[PressureValue] [float] NULL,
	[PressureUnit] [varchar] (500) NULL,
	[WindSpeed] [float] NULL,
	[WindDesc] [varchar] (500) NULL, 
	[WindDirCode] [varchar] (500) NULL, 
	[WindDirName] [varchar] (500) NULL, 
	[CloudsDesc] [varchar] (500) NULL,
	[Presip] [varchar] (500) NULL, 
	[WeatherDesc] [varchar] (500) NULL, 
	[UpdateDate] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	[WeatherStationID] DESC, [RecordedTime] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)


SET ANSI_PADDING OFF
GO

