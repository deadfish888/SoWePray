/****** Object:  Table [dbo].[OWChapterPayment]    Script Date: 10/4/2022 11:26:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OWChapterPayment](
	[chapterId] int not null,
	[isPaid] [bit] not null,
	[price] [decimal](10, 2) not null
	)
GO