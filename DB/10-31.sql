USE [master]
GO
/****** Object:  Database [BOOKIE]    Script Date: 10/31/2022 12:29:21 AM ******/
CREATE DATABASE [BOOKIE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BOOKIE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SILVER_000\MSSQL\DATA\BOOKIE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BOOKIE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SILVER_000\MSSQL\DATA\BOOKIE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BOOKIE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BOOKIE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BOOKIE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BOOKIE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BOOKIE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BOOKIE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BOOKIE] SET ARITHABORT OFF 
GO
ALTER DATABASE [BOOKIE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BOOKIE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BOOKIE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BOOKIE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BOOKIE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BOOKIE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BOOKIE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BOOKIE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BOOKIE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BOOKIE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BOOKIE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BOOKIE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BOOKIE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BOOKIE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BOOKIE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BOOKIE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BOOKIE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BOOKIE] SET RECOVERY FULL 
GO
ALTER DATABASE [BOOKIE] SET  MULTI_USER 
GO
ALTER DATABASE [BOOKIE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BOOKIE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BOOKIE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BOOKIE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BOOKIE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BOOKIE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BOOKIE', N'ON'
GO
ALTER DATABASE [BOOKIE] SET QUERY_STORE = OFF
GO
USE [BOOKIE]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[name] [nvarchar](50) NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_author] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[authorId] [int] NULL,
	[rating] [decimal](10, 2) NULL,
	[favourite] [int] NULL,
	[price] [decimal](10, 2) NULL,
	[is_sale] [bit] NULL,
	[image] [varchar](4000) NULL,
	[description] [nvarchar](4000) NULL,
	[views] [int] NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_book] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book_Own]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Own](
	[userId] [int] NOT NULL,
	[bookId] [int] NOT NULL,
	[recentTime] [datetime] NULL,
	[recentChapterId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryBook]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryBook](
	[bookId] [int] NOT NULL,
	[categoryId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[volumeId] [int] NOT NULL,
	[no] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[status] [bit] NOT NULL,
	[content] [ntext] NOT NULL,
 CONSTRAINT [PK_chapter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter_Payment]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter_Payment](
	[chapterId] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bookId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[comment] [nvarchar](2000) NOT NULL,
	[sonOf] [int] NULL,
	[replyTo] [int] NULL,
	[createdAt] [datetime] NOT NULL,
	[editedAt] [datetime] NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourite]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourite](
	[uid] [int] NOT NULL,
	[bid] [int] NOT NULL,
 CONSTRAINT [PK_favourite] PRIMARY KEY CLUSTERED 
(
	[uid] ASC,
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Account]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Account](
	[accountNumber] [bigint] NOT NULL,
	[balance] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Payment_Account] PRIMARY KEY CLUSTERED 
(
	[accountNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Method]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Method](
	[paymentId] [int] IDENTITY(45678,3) NOT NULL,
	[userId] [int] NOT NULL,
	[accountNumber] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Payment_Method] PRIMARY KEY CLUSTERED 
(
	[paymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productId] [varchar](30) NOT NULL,
	[bookId] [int] NOT NULL,
	[chapterId] [int] NULL,
	[price] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Own]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Own](
	[userId] [int] NOT NULL,
	[productId] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reportType] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[objectId] [int] NULL,
	[note] [nvarchar](2000) NULL,
	[sent] [datetime] NOT NULL,
	[received] [datetime] NULL,
	[status] [bit] NULL,
	[action] [nvarchar](2000) NULL,
 CONSTRAINT [PK_reportdetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_Violation]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_Violation](
	[reportId] [int] NOT NULL,
	[violationId] [int] NOT NULL,
 CONSTRAINT [PK_Report_Violation] PRIMARY KEY CLUSTERED 
(
	[reportId] ASC,
	[violationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Star]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Star](
	[bid] [int] NOT NULL,
	[uid] [int] NOT NULL,
	[star] [int] NOT NULL,
 CONSTRAINT [PK_star] PRIMARY KEY CLUSTERED 
(
	[uid] ASC,
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Token]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[userId] [int] NOT NULL,
	[token] [varchar](20) NOT NULL,
	[expiredDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[transactionId] [bigint] IDENTITY(3000000,1) NOT NULL,
	[userId] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[balanceAfter] [decimal](10, 2) NOT NULL,
	[transactionTime] [datetime] NULL,
	[type] [int] NOT NULL,
	[status] [int] NOT NULL,
	[description] [nvarchar](500) NULL,
	[productID] [varchar](30) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[gender] [bit] NULL,
	[dob] [date] NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](11) NULL,
	[address] [nvarchar](200) NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[is_super] [int] NOT NULL,
	[walletNumber] [bigint] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Violation]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Violation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reportType] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volume]    Script Date: 10/31/2022 12:29:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volume](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bookId] [int] NOT NULL,
	[no] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[summary] [nvarchar](2000) NULL,
 CONSTRAINT [PK_vol] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book] ADD  DEFAULT ((0)) FOR [favourite]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Book__views__30F848ED]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[Book] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_status]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__is_super__31EC6D26]  DEFAULT ((1)) FOR [is_super]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_balance]  DEFAULT ((0)) FOR [walletNumber]
GO
ALTER TABLE [dbo].[Author]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Book_Own]  WITH CHECK ADD  CONSTRAINT [FK_Book_Own_Book] FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Book_Own] CHECK CONSTRAINT [FK_Book_Own_Book]
GO
ALTER TABLE [dbo].[Book_Own]  WITH CHECK ADD  CONSTRAINT [FK_Book_Own_Chapter] FOREIGN KEY([recentChapterId])
REFERENCES [dbo].[Chapter] ([id])
GO
ALTER TABLE [dbo].[Book_Own] CHECK CONSTRAINT [FK_Book_Own_Chapter]
GO
ALTER TABLE [dbo].[Book_Own]  WITH CHECK ADD  CONSTRAINT [FK_Book_Own_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Book_Own] CHECK CONSTRAINT [FK_Book_Own_User]
GO
ALTER TABLE [dbo].[CategoryBook]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryBook]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([volumeId])
REFERENCES [dbo].[Volume] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapter_Payment]  WITH CHECK ADD FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapter] ([id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD  CONSTRAINT [FK__Favourite__bid__2B3F6F97] FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Favourite] CHECK CONSTRAINT [FK__Favourite__bid__2B3F6F97]
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD  CONSTRAINT [FK__Favourite__uid__2A4B4B5E] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Favourite] CHECK CONSTRAINT [FK__Favourite__uid__2A4B4B5E]
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Payment_Method]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Method_Payment_Account] FOREIGN KEY([accountNumber])
REFERENCES [dbo].[Payment_Account] ([accountNumber])
GO
ALTER TABLE [dbo].[Payment_Method] CHECK CONSTRAINT [FK_Payment_Method_Payment_Account]
GO
ALTER TABLE [dbo].[Payment_Method]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Method_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Payment_Method] CHECK CONSTRAINT [FK_Payment_Method_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Book] FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Book]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Chapter] FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapter] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Chapter]
GO
ALTER TABLE [dbo].[Product_Own]  WITH CHECK ADD  CONSTRAINT [FK_Product_Own_Product] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([productId])
GO
ALTER TABLE [dbo].[Product_Own] CHECK CONSTRAINT [FK_Product_Own_Product]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Report_Violation]  WITH CHECK ADD  CONSTRAINT [FK_Report_Violation_Report] FOREIGN KEY([reportId])
REFERENCES [dbo].[Report] ([id])
GO
ALTER TABLE [dbo].[Report_Violation] CHECK CONSTRAINT [FK_Report_Violation_Report]
GO
ALTER TABLE [dbo].[Report_Violation]  WITH CHECK ADD  CONSTRAINT [FK_Report_Violation_Violation] FOREIGN KEY([violationId])
REFERENCES [dbo].[Violation] ([id])
GO
ALTER TABLE [dbo].[Report_Violation] CHECK CONSTRAINT [FK_Report_Violation_Violation]
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [FK__Star__bid__2E1BDC42] FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [FK__Star__bid__2E1BDC42]
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [FK__Star__uid__2F10007B] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [FK__Star__uid__2F10007B]
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Product]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Payment_Account] FOREIGN KEY([walletNumber])
REFERENCES [dbo].[Payment_Account] ([accountNumber])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Payment_Account]
GO
ALTER TABLE [dbo].[Volume]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [chk_star] CHECK  (([star]>=(1) AND [star]<=(5)))
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [chk_star]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 mean Fail, 1 mean Pending, 2 mean Successful' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'status'
GO
USE [master]
GO
ALTER DATABASE [BOOKIE] SET  READ_WRITE 
GO
