IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[WeatherForecast]') AND type in (N'U'))
DROP TABLE [WebSite].[WeatherForecast]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[WeatherForecast](
	[WeatherStationID] [int] NOT NULL,
	[RecordedTime] [datetime] NOT NULL,
	[FromTime] [datetime] NOT NULL,
	[ToTime] [datetime] NOT NULL,
	[WeatherConditionID] [int] NULL,
	[WeatherCondition] [varchar](max) NULL,
	[WeatherIconID] [int] NULL DEFAULT ((0)),
	[PrecipitationVolume] [float] NULL,
	[PrecipitationUnit] [varchar](500) NULL,
	[PrecipitationType] [varchar](500) NULL,
	[WindDirection] [float] NULL,
	[WindCode] [varchar](250) NULL,
	[WindDescription] VARCHAR(250) NULL,
	[TempUnit] [varchar](250) NULL,
	[TempValue] [float] NULL,
	[TempMin] [float] NULL,
	[TempMax] [float] NULL,
	[PressUnit] [varchar](250) NULL,
	[PressValue] [float] NULL,
	[HumidityValue] [float] NULL,
	[HumidityUnit] [varchar](250) NULL,
	[CloudsValue] [varchar](max) NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[WeatherStationID] DESC,
	[RecordedTime] DESC,
	[FromTime] ASC,
	[ToTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO

GO
