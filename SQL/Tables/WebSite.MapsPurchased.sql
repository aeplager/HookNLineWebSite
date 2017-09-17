IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[UserPurchases]') AND type in (N'U'))
DROP TABLE [WebSite].[UserPurchases]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

/****** Object:  Table [WebSite].[UserPurchases]    Script Date: 9/17/2017 4:33:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [WebSite].[UserPurchases](
	[UserName] [varchar](250) NOT NULL,
	[MapSelectionsID] [int] NOT NULL,
	[LastPurchaseDate] [datetime] NULL,
	[InsertDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC,
	[MapSelectionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

ALTER TABLE [WebSite].[UserPurchases] ADD  DEFAULT (getdate()) FOR [InsertDate]
GO

ALTER TABLE [WebSite].[UserPurchases] ADD  DEFAULT (getdate()) FOR [LastModifiedDate]
GO
--INSERT INTO [WebSite].[UserPurchases] (UserName, MapSelectionsID, InsertDate, LastModifiedDate)
--SELECT UserName, MapSelectionsID, InsertDate, LastModifiedDate
--FROM [WebSite].[UserPurchasesOLD] 
--GROUP BY UserName, MapSelectionsID, InsertDate, LastModifiedDate

