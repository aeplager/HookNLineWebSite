IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSite].[MapSelections]') AND type in (N'U'))
DROP TABLE [WebSite].[MapSelections]
GO

/****** Object:  Table [Import].[ApprovedCarriersTemp]    Script Date: 7/29/2015 3:19:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WebSite].[MapSelections](
	[MapSelectionsID] [int] IDENTITY(1,1) NOT NULL,	
	[MapSelectionsShortName] [varchar](500) NOT NULL,
	[MapSelectionsFullName] [varchar](500) NOT NULL,	
	[MapSelectionsKML] [varchar](500) NOT NULL,	
	[InsertDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifiedDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[MapSelectionsID]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT INTO [WebSite].[MapSelections] ([MapSelectionsShortName],[MapSelectionsFullName],[MapSelectionsKML] )
	VALUES ('F102-A','Galveston Bay','https://qkss.com/HooknLine/KML/JoeTrombleyChangesCircles20160215.kml')
	,('F102-D','Dickenson Bay','https://qkss.com/HooknLine/KML/DickensonBayForKMLV2.kml')


	SELECT * FROM [WebSite].[MapSelections] 