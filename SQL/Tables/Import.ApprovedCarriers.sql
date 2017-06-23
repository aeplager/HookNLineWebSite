USE [IONLogisticsDevelopment]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Import].[ApprovedCarriersTemp]') AND type in (N'U'))
DROP TABLE [Import].[ApprovedCarriersTemp]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Import].[ApprovedCarriersTemp](
	[ApprovedCarriersID] [int] IDENTITY(1,1) NOT NULL,
	[ApprovedCarriersName] [varchar](500) NOT NULL,
	[ApprovedCarriersDesc] [varchar](4000) NOT NULL,
	[Approved] [bit] NOT NULL DEFAULT ((1)),
	[DisplayInRateSheet] [bit] NOT NULL DEFAULT ((1)),
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ApprovedCarriersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

SET IDENTITY_INSERT [Import].[ApprovedCarriersTemp] ON
INSERT INTO [Import].[ApprovedCarriersTemp] 
	([ApprovedCarriersID], [ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate])
	SELECT [ApprovedCarriersID]
		   ,[ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate]
	FROM [Import].[ApprovedCarriers]
	GROUP BY [ApprovedCarriersID]
		   ,[ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate]
   ORDER BY [ApprovedCarriersID]

SET IDENTITY_INSERT [Import].[ApprovedCarriersTemp] OFF

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Import].[ApprovedCarriers]') AND type in (N'U'))
DROP TABLE [Import].[ApprovedCarriers]

CREATE TABLE [Import].[ApprovedCarriers](
	[ApprovedCarriersID] [int] IDENTITY(1,1) NOT NULL,
	[ApprovedCarriersName] [varchar](500) NOT NULL,
	[ApprovedCarriersDesc] [varchar](4000) NOT NULL,
	[Approved] [bit] NOT NULL DEFAULT ((1)),
	[DisplayInRateSheet] [bit] NOT NULL DEFAULT ((1)),
	[FtpLocation] [varchar](4000) NULL,
	[FtpUserName] [varchar](4000) NULL,
	[FtpPassword] [varchar](4000) NULL,
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ApprovedCarriersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)


SET IDENTITY_INSERT [Import].[ApprovedCarriers] ON

INSERT INTO [Import].[ApprovedCarriers] 
	([ApprovedCarriersID], [ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate])
	SELECT [ApprovedCarriersID]
		   ,[ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate]
	FROM [Import].[ApprovedCarriersTemp]
	GROUP BY [ApprovedCarriersID]
		   ,[ApprovedCarriersName]
           ,[ApprovedCarriersDesc]
           ,[Approved]
           ,[DisplayInRateSheet]
           ,[InsertDate]
           ,[LastModifiedDate]
   ORDER BY [ApprovedCarriersID]

SET IDENTITY_INSERT [Import].[ApprovedCarriers] OFF


SELECT * FROM [Import].[ApprovedCarriersTemp] 
SELECT * FROM [Import].[ApprovedCarriers] 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Import].[ApprovedCarriersTemp]') AND type in (N'U'))
DROP TABLE [Import].[ApprovedCarriersTemp]
GO

GO

SET ANSI_PADDING OFF
GO


