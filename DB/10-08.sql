USE [master]
GO
/****** Object:  Database [BOOKIE]    Script Date: 10/9/2022 9:14:31 PM ******/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BOOKIE')
BEGIN
	ALTER DATABASE [BOOKIE] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [BOOKIE] SET ONLINE;
	DROP DATABASE [BOOKIE];
END
GO
CREATE DATABASE [BOOKIE]
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
/****** Object:  Table [dbo].[Author]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_author] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Book_Own]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Own](
	[userId] [int] NOT NULL,
	[bookId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/9/2022 9:14:31 PM ******/
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
<<<<<<< Updated upstream
/****** Object:  Table [dbo].[CategoryBook]    Script Date: 10/4/2022 11:26:44 PM ******/
=======
/****** Object:  Table [dbo].[CategoryBook]    Script Date: 10/9/2022 9:14:31 PM ******/
>>>>>>> Stashed changes
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryBook](
	[bookId] [int] NOT NULL,
	[categoryId] [int] NOT NULL
<<<<<<< Updated upstream
 ) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter]    Script Date: 10/4/2022 11:26:44 PM ******/
=======
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter]    Script Date: 10/9/2022 9:14:31 PM ******/
>>>>>>> Stashed changes
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
/****** Object:  Table [dbo].[Chapter_Own]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter_Own](
	[userId] [int] NOT NULL,
	[chapterId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapter_Payment]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter_Payment](
	[chapterId] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 10/9/2022 9:14:31 PM ******/
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
	[createdAt] [date] NOT NULL,
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourite]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Payment_Account]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Payment_Method]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportDetail]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reportId] [int] NOT NULL,
	[bookId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[note] [nvarchar](2000) NULL,
 CONSTRAINT [PK_reportdetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Star]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Token]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Transaction]    Script Date: 10/9/2022 9:14:31 PM ******/
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
	[paymentId] [int] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction_Token]    Script Date: 10/9/2022 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction_Token](
	[transactionId] [bigint] NOT NULL,
	[token] [nvarchar](50) NOT NULL,
	[status] [bit] NOT NULL,
	[createdTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Transaction_Token] PRIMARY KEY CLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/9/2022 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[Volume]    Script Date: 10/9/2022 9:14:31 PM ******/
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
SET IDENTITY_INSERT [dbo].[Author] ON 
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (1, NULL, N'Gillian Flynn')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (2, NULL, N'Agatha Christie')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (3, NULL, N'Alex Michaelides')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (4, NULL, N'Paula Hawkins')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (5, NULL, N'Cuttlefish That Loves Diving')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (6, NULL, N'Stephen King')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (7, NULL, N'George RR Martin')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (8, NULL, N'Suzanne Collins')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (9, NULL, N'H.G. Wells, Greg Bear')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (10, NULL, N'Diana Gabaldon')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (11, NULL, N'Anthony Doerr')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (12, NULL, N'Hiromu Arakawa')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (13, NULL, N'Tsugumi Ohba')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (14, NULL, N'Eiichiro Oda')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (15, NULL, N'Syougo Kinugasa')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (16, 2, N'Vinh Nguyen')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (17, 3, N'Ivory Marcel')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (18, 4, N'Mary Barisol')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (19, 5, N'Eden Frost')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (20, 6, N'Benidict Robinett')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (21, 7, N'Zera Farmer')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (22, 8, N'Ceil Howell')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (23, 9, N'Taylor Marcel')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (24, 10, N'Wisley Ray')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (25, 11, N'Aiken Pope')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (26, 12, N'Rodolphe Blossom')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (27, 13, N'Alex Rogze')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (28, 14, N'Jean Padilla')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (29, 15, N'Dana Franklin')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (30, 16, N'Elluka Bush')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (31, 17, N'Kenelm Binder')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (32, 18, N'Narcissus Freezis')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (33, 19, N'Michelle Reynolds')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (34, 20, N'Callie Banica')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (35, 21, N'Malceria Freezis')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (36, 22, N'Jasmine Shepard')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (37, 23, N'Mia Franklin')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (38, 24, N'Schick Reyes')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (39, 25, N'Allen Reese')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (40, 26, N'Elman Baxter')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (41, 27, N'Willard Jordan')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (42, 28, N'Winona Walton')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (43, 29, N'Sophia Knight')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (44, 30, N'Hank Wade')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (45, 31, N'Mia Dinwiddie')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (46, 32, N'Ronald Chandler')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (47, 33, N'Elluka Ackerman')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (48, 34, N'Jude Gilbert')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (49, 35, N'Philbert Schultz')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (50, 36, N'Lamia Fowler')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (51, 37, N'Gererd Pope')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (52, 38, N'Thetal Shepard')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (53, 39, N'Yocaski Blossom')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (54, 40, N'Danielle Hodges')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (55, 41, N'Darlene Feron')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (56, 42, N'Hadden Chandler')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (57, 43, N'Sateriasis Hardy')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (58, 44, N'Mia Carpenter')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (59, 45, N'Kit Nerune')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (60, 46, N'Rodolphe Frost')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (61, 47, N'Jesse Watts')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (62, 48, N'Carl Crawford')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (63, 49, N'Ronald Robinett')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (64, 50, N'Zera Stanley')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (65, 51, N'Harley Avadonia')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (66, 52, N'Butglar Gray')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (67, 53, N'Joe Baxter')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (68, 54, N'Ward Wagner')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (69, 55, N'Charlie Reese')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (70, 56, N'Windsor Dinwiddie')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (71, 57, N'Charon Walton')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (72, 58, N'Hank Michaelis')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (73, 59, N'Seth Manning')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (74, 60, N'Seth Manning')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (75, 61, N'Light Jenning')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (76, 62, N'David Barisol')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (77, 63, N'Michaela Kelley')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (78, 64, N'Melody Elphen')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (79, 65, N'Elluka Norman')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (80, 66, N'Strange Feron')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (81, 67, N'Taylor Valdez')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (82, 68, N'Dana Macy')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (83, 69, N'Jean Valdez')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (84, 70, N'Minis Goodwin')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (85, 71, N'Clay Marlon')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (86, 72, N'Phil Powers')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (87, 73, N'Butglar Hardy')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (88, 74, N'Camelia Mullins')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (89, 75, N'Lionel Stanley')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (90, 76, N'Linda Payne')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (91, 77, N'Philbert Cross')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (92, 78, N'Phil Jordan')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (93, 79, N'Robert Kissos')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (94, 80, N'Ronald Rios')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (95, 81, N'Elluka Manning')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (96, 82, N'Ceil Payne')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (97, 83, N'Lizzy Meld')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (98, 84, N'Camelia Miller')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (99, 85, N'Diana Macy')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (100, 86, N'Windsor Badman')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (101, 87, N'Diana Obrien')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (102, 88, N'Adam Hodges')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (103, 89, N'Hansel May')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (104, 90, N'Oswald Pope')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (105, 91, N'Alex Hardy')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (106, 92, N'Butglar Michaelis')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (107, 93, N'Elman Blair')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (108, 94, N'Lucifer Blair')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (109, 95, N'Philbert Phantomhive')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (110, 96, N'Albion Alexdander')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (111, 97, N'Melody Chandler')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (112, 98, N'Katya Corbyn')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (113, 99, N'Rahab Octo')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (114, 100, N'Hansel May')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (115, 101, N'Luke Thayne')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (116, 102, N'Cyril Watson')
GO
INSERT [dbo].[Author] ([id], [userId], [name]) VALUES (117, 109, N'I Am Tester')
GO
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
<<<<<<< Updated upstream
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (1, N'Gone Girl ', 1, NULL, 0, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554086139l/19288043.jpg', N'Marriage can be a real killer.<br>
On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunne‚Äôs fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nick‚Äôs clever and beautiful wife disappears from their rented McMansion on the Mississippi River. Husband-of-the-Year Nick isn‚Äôt doing himself any favors with cringe-worthy daydreams about the slope and shape of his wife‚Äôs head, but passages from Amy''s diary reveal the alpha-girl perfectionist could have put anyone dangerously on edge. Under mounting pressure from the police and the media‚Äîas well as Amy‚Äôs fiercely doting parents‚Äîthe town golden boy parades an endless series of lies, deceits, and inappropriate behavior. Nick is oddly evasive, and he‚Äôs definitely bitter‚Äîbut is he really a killer?<br>
As the cops close in, every couple in town is soon wondering how well they know the one that they love. With his twin sister, Margo, at his side, Nick stands by his innocence. Trouble is, if Nick didn‚Äôt do it, where is that beautiful wife? And what was in that silvery gift box hidden in the back of her bedroom closet?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (2, N'And Then There Were None', 2, NULL, 0, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1638425885l/16299._SY475_.jpg', N'First, there were ten‚Äîa curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they''re unwilling to reveal‚Äîand a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:<br>
"Ten little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he''d stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none."<br>
When they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (3, N'The Silent Patient', 3, NULL, 0, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1582759969l/40097951._SX318_.jpg', N'Alicia Berenson‚Äôs life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of London‚Äôs most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.<br>
Alicia‚Äôs refusal to talk, or give any kind of explanation, turns a domestic tragedy into something far grander, a mystery that captures the public imagination and casts Alicia into notoriety. The price of her art skyrockets, and she, the silent patient, is hidden away from the tabloids and spotlight at the Grove, a secure forensic unit in North London.<br>
Theo Faber is a criminal psychotherapist who has waited a long time for the opportunity to work with Alicia. His determination to get her to talk and unravel the mystery of why she shot her husband takes him down a twisting path into his own motivations‚Äîa search for the truth that threatens to consume him....', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (4, N'The Girl on the Train', 4, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1574805682l/22557272.jpg', N'Rachel catches the same commuter train every morning. She knows it will wait at the same signal each time, overlooking a row of back gardens. She‚Äôs even started to feel like she knows the people who live in one of the houses. ‚ÄúJess and Jason,‚Äù she calls them. Their life‚Äîas she sees it‚Äîis perfect. If only Rachel could be that happy. And then she sees something shocking. It‚Äôs only a minute until the train moves on, but it‚Äôs enough. Now everything‚Äôs changed. Now Rachel has a chance to become a part of the lives she‚Äôs only watched from afar. Now they‚Äôll see; she‚Äôs much more than just the girl on the train...', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (5, N'Lord of the Mysteries', 5, NULL, 0, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1598845986l/55176693._SX318_.jpg', N'Waking up to be faced with a string of mysteries, Zhou Mingrui finds himself reincarnated as Klein Moretti in an alternate Victorian era world where he sees a world filled with machinery, cannons, dreadnoughts, airships, difference machines, as well as Potions, Divination, Hexes, Tarot Cards, Sealed Artifacts‚Ä¶ The Light continues to shine but the mystery has never gone far. Follow Klein as he finds himself entangled with the Churches of the world‚Äîboth orthodox and unorthodox‚Äîwhile he slowly develops newfound powers thanks to the Beyonder potions.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (6, N'The Shining', 6, NULL, 0, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1353277730l/11588.jpg', N'Jack Torrance''s new job at the Overlook Hotel is the perfect chance for a fresh start. As the off-season caretaker at the atmospheric old hotel, he''ll have plenty of time to spend reconnecting with his family and working on his writing. But as the harsh winter weather sets in, the idyllic location feels ever more remote...and more sinister. And the only one to notice the strange and terrible forces gathering around the Overlook is Danny Torrance, a uniquely gifted five-year-old.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (7, N'It', 6, NULL, 0, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1334416842l/830502.jpg', N'Welcome to Derry, Maine ...<br>
It‚Äôs a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...<br>
They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But none of them can withstand the force that has drawn them back to Derry to face the nightmare without an end, and the evil without a name.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (8, N'A Game Of Thrones: A Song of Ice and Fire', 7, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://m.media-amazon.com/images/P/0553386794.01._SCLZZZZZZZ_SX500_.jpg', N'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister and supernatural forces are massing beyond the kingdom‚Äôs protective Wall. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the land they were born to. Sweeping from a land of brutal cold to a distant summertime kingdom of epicurean plenty, here is a tale of lords and ladies, soldiers and sorcerers, assassins and bastards, who come together in a time of grim omens.
<br>
Here an enigmatic band of warriors bear swords of no human metal; a tribe of fierce wildlings carry men off into madness; a cruel young dragon prince barters his sister to win back his throne; and a determined woman undertakes the most treacherous of journeys. Amid plots and counterplots, tragedy and betrayal, victory and terror, the fate of the Starks, their allies, and their enemies hangs perilously in the balance, as each endeavors to win that deadliest of conflicts: the game of thrones.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (9, N'The Hunger Games', 8, NULL, 0, CAST(15.00 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1586722975l/2767052.jpg', N'Could you survive on your own in the wild, with every one out to make sure you don''t live to see the morning?
=======
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (1, N'Gone Girl ', 1, NULL, 0, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554086139l/19288043.jpg', N'Marriage can be a real killer.<br>
On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunneís fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nickís clever and beautiful wife disappears from their rented McMansion on the Mississippi River. Husband-of-the-Year Nick isnít doing himself any favors with cringe-worthy daydreams about the slope and shape of his wifeís head, but passages from Amy''s diary reveal the alpha-girl perfectionist could have put anyone dangerously on edge. Under mounting pressure from the police and the mediaóas well as Amyís fiercely doting parentsóthe town golden boy parades an endless series of lies, deceits, and inappropriate behavior. Nick is oddly evasive, and heís definitely bitteróbut is he really a killer?<br>
As the cops close in, every couple in town is soon wondering how well they know the one that they love. With his twin sister, Margo, at his side, Nick stands by his innocence. Trouble is, if Nick didnít do it, where is that beautiful wife? And what was in that silvery gift box hidden in the back of her bedroom closet?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (2, N'And Then There Were None', 2, NULL, 0, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1638425885l/16299._SY475_.jpg', N'First, there were tenóa curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they''re unwilling to revealóand a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:<br>
"Ten little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he''d stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none."<br>
When they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (3, N'The Silent Patient', 3, NULL, 0, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1582759969l/40097951._SX318_.jpg', N'Alicia Berensonís life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of Londonís most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.<br>
Aliciaís refusal to talk, or give any kind of explanation, turns a domestic tragedy into something far grander, a mystery that captures the public imagination and casts Alicia into notoriety. The price of her art skyrockets, and she, the silent patient, is hidden away from the tabloids and spotlight at the Grove, a secure forensic unit in North London.<br>
Theo Faber is a criminal psychotherapist who has waited a long time for the opportunity to work with Alicia. His determination to get her to talk and unravel the mystery of why she shot her husband takes him down a twisting path into his own motivationsóa search for the truth that threatens to consume him....', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (4, N'The Girl on the Train', 4, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1574805682l/22557272.jpg', N'Rachel catches the same commuter train every morning. She knows it will wait at the same signal each time, overlooking a row of back gardens. Sheís even started to feel like she knows the people who live in one of the houses. ìJess and Jason,î she calls them. Their lifeóas she sees itóis perfect. If only Rachel could be that happy. And then she sees something shocking. Itís only a minute until the train moves on, but itís enough. Now everythingís changed. Now Rachel has a chance to become a part of the lives sheís only watched from afar. Now theyíll see; sheís much more than just the girl on the train...', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (5, N'Lord of the Mysteries', 5, NULL, 0, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1598845986l/55176693._SX318_.jpg', N'Waking up to be faced with a string of mysteries, Zhou Mingrui finds himself reincarnated as Klein Moretti in an alternate Victorian era world where he sees a world filled with machinery, cannons, dreadnoughts, airships, difference machines, as well as Potions, Divination, Hexes, Tarot Cards, Sealed ArtifactsÖ The Light continues to shine but the mystery has never gone far. Follow Klein as he finds himself entangled with the Churches of the worldóboth orthodox and unorthodoxówhile he slowly develops newfound powers thanks to the Beyonder potions.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (6, N'The Shining', 6, NULL, 0, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1353277730l/11588.jpg', N'Jack Torrance''s new job at the Overlook Hotel is the perfect chance for a fresh start. As the off-season caretaker at the atmospheric old hotel, he''ll have plenty of time to spend reconnecting with his family and working on his writing. But as the harsh winter weather sets in, the idyllic location feels ever more remote...and more sinister. And the only one to notice the strange and terrible forces gathering around the Overlook is Danny Torrance, a uniquely gifted five-year-old.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (7, N'It', 6, NULL, 0, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1334416842l/830502.jpg', N'Welcome to Derry, Maine ...<br>
Itís a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...<br>
They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But none of them can withstand the force that has drawn them back to Derry to face the nightmare without an end, and the evil without a name.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (8, N'A Game Of Thrones: A Song of Ice and Fire', 7, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://m.media-amazon.com/images/P/0553386794.01._SCLZZZZZZZ_SX500_.jpg', N'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister and supernatural forces are massing beyond the kingdomís protective Wall. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the land they were born to. Sweeping from a land of brutal cold to a distant summertime kingdom of epicurean plenty, here is a tale of lords and ladies, soldiers and sorcerers, assassins and bastards, who come together in a time of grim omens.
<br>
Here an enigmatic band of warriors bear swords of no human metal; a tribe of fierce wildlings carry men off into madness; a cruel young dragon prince barters his sister to win back his throne; and a determined woman undertakes the most treacherous of journeys. Amid plots and counterplots, tragedy and betrayal, victory and terror, the fate of the Starks, their allies, and their enemies hangs perilously in the balance, as each endeavors to win that deadliest of conflicts: the game of thrones.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (9, N'The Hunger Games', 8, NULL, 0, CAST(15.00 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1586722975l/2767052.jpg', N'Could you survive on your own in the wild, with every one out to make sure you don''t live to see the morning?
>>>>>>> Stashed changes
<br>
In the ruins of a place once known as North America lies the nation of Panem, a shining Capitol surrounded by twelve outlying districts. The Capitol is harsh and cruel and keeps the districts in line by forcing them all to send one boy and one girl between the ages of twelve and eighteen to participate in the annual Hunger Games, a fight to the death on live TV.
<br>
Sixteen-year-old Katniss Everdeen, who lives alone with her mother and younger sister, regards it as a death sentence when she steps forward to take her sister''s place in the Games. But Katniss has been close to dead beforeóand survival, for her, is second nature. Without really meaning to, she becomes a contender. But if she is to win, she will have to start making choices that weight survival against humanity and life against love.', 0, 1)
GO
<<<<<<< Updated upstream
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (10, N'The Time Machine', 9, NULL, 0, CAST(12.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg', N'‚ÄúI‚Äôve had a most amazing time....‚Äù<br>
So begins the Time Traveller‚Äôs astonishing firsthand account of his journey 800,000 years beyond his own era‚Äîand the story that launched H.G. Wells‚Äôs successful career and earned him his reputation as the father of science fiction. With a speculative leap that still fires the imagination, Wells sends his brave explorer to face a future burdened with our greatest hopes...and our darkest fears. A pull of the Time Machine‚Äôs lever propels him to the age of a slowly dying Earth.  There he discovers two bizarre races‚Äîthe ethereal Eloi and the subterranean Morlocks‚Äîwho not only symbolize the duality of human nature, but offer a terrifying portrait of the men of tomorrow as well.  Published in 1895, this masterpiece of invention captivated readers on the threshold of a new century.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (11, N'Outlander', 10, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1529065012l/10964._SY475_.jpg', N'The year is 1945. Claire Randall, a former combat nurse, is just back from the war and reunited with her husband on a second honeymoon when she walks through a standing stone in one of the ancient circles that dot the British Isles. Suddenly she is a Sassenach‚Äîan ‚Äúoutlander‚Äù‚Äîin a Scotland torn by war and raiding border clans in the year of Our Lord...1743.
=======
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (10, N'The Time Machine', 9, NULL, 0, CAST(12.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg', N'ìIíve had a most amazing time....î<br>
So begins the Time Travellerís astonishing firsthand account of his journey 800,000 years beyond his own eraóand the story that launched H.G. Wellsís successful career and earned him his reputation as the father of science fiction. With a speculative leap that still fires the imagination, Wells sends his brave explorer to face a future burdened with our greatest hopes...and our darkest fears. A pull of the Time Machineís lever propels him to the age of a slowly dying Earth.  There he discovers two bizarre racesóthe ethereal Eloi and the subterranean Morlocksówho not only symbolize the duality of human nature, but offer a terrifying portrait of the men of tomorrow as well.  Published in 1895, this masterpiece of invention captivated readers on the threshold of a new century.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (11, N'Outlander', 10, NULL, 0, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1529065012l/10964._SY475_.jpg', N'The year is 1945. Claire Randall, a former combat nurse, is just back from the war and reunited with her husband on a second honeymoon when she walks through a standing stone in one of the ancient circles that dot the British Isles. Suddenly she is a Sassenachóan ìoutlanderîóin a Scotland torn by war and raiding border clans in the year of Our Lord...1743.
>>>>>>> Stashed changes
<br>
Hurled back in time by forces she cannot understand, Claire is catapulted into the intrigues of lairds and spies that may threaten her life, and shatter her heart. For here James Fraser, a gallant young Scots warrior, shows her a love so absolute that Claire becomes a woman torn between fidelity and desireóand between two vastly different men in two irreconcilable lives.', 0, 1)
GO
<<<<<<< Updated upstream
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (12, N'All the Light We Cannot See', 11, NULL, 0, CAST(10.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1451445646l/18143977.jpg', N'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure‚Äôs reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museum‚Äôs most valuable and dangerous jewel.
<br>In a mining town in Germany, Werner Pfennig, an orphan, grows up with his younger sister, enchanted by a crude radio they find that brings them news and stories from places they have never seen or imagined. Werner becomes an expert at building and fixing these crucial new instruments and is enlisted to use his talent to track down the resistance. Deftly interweaving the lives of Marie-Laure and Werner, Doerr illuminates the ways, against all odds, people try to be good to one another.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (13, N'Fullmetal Alchemist, Vol. 1', 12, NULL, 0, CAST(9.35 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1388179331l/870.jpg', N'Breaking the laws of nature is a serious crime!
<br>In an alchemical ritual gone wrong, Edward Elric lost his arm and his leg, and his brother Alphonse became nothing but a soul in a suit of armor. Equipped with mechanical ‚Äúauto-mail‚Äù limbs, Edward becomes a state alchemist, seeking the one thing that can restore his and his brother‚Äôs bodies...the legendary Philosopher‚Äôs Stone.
<br>Alchemy: the mystical power to alter the natural world; something between magic, art and science. When two brothers, Edward and Alphonse Elric, dabbled in this power to grant their dearest wish, one of them lost an arm and a leg‚Ä¶and the other became nothing but a soul locked into a body of living steel. Now Edward is an agent of the government, a slave of the military-alchemical complex, using his unique powers to obey orders‚Ä¶even to kill. Except his powers aren''t unique. The world has been ravaged by the abuse of alchemy. And in pursuit of the ultimate alchemical treasure, the Philosopher''s Stone, their enemies are even more ruthless than they are‚Ä¶', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (14, N'Death Note, Vol. 1: Boredom', 13, NULL, 0, CAST(10.40 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1419952134l/13615.jpg', N'Light Yagami is an ace student with great prospects - and he''s bored out of his mind. But all that changes when he finds the Death Note, a notebook dropped by a rogue Shinigami, a death god. Any human whose name is written in the notebook dies, and now Light has vowed to use the power of the Death Note to rid the world of evil. But when criminals begin dropping dead, the authorities send the legendary detective L to track down the killer. With L hot on his heels, will Light lose sight of his noble goal... or his life?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (15, N'One Piece, Volume 1: Romance Dawn', 14, NULL, 0, CAST(11.00 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1318523719l/1237398.jpg', N'A new shonen sensation in Japan, this series features Monkey D. Luffy, whose main ambition is to become a pirate. Eating the Gum-Gum Fruit gives him strange powers but also invokes the fruit''s curse: anybody who consumes it can never learn to swim. Nevertheless, Monkey and his crewmate Roronoa Zoro, master of the three-sword fighting style, sail the Seven Seas of swashbuckling adventure in search of the elusive treasure "One Piece."', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId],  [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (16, N'Classroom of the Elite Vol. 1', 15, NULL, 0, CAST(9.69 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1540974678l/41085104.jpg', N'Students of the prestigious Tokyo Metropolitan Advanced Nurturing High School are given remarkable freedom‚Äîif they can win, barter, or save enough points to work their way up the ranks! Ayanokoji Kiyotaka has landed at the bottom in the scorned Class D, where he meets Horikita Suzune, who‚Äôs determined to rise up the ladder to Class A. Can they beat the system in a school where cutthroat competition is the name of the game?', 0, 1)
=======
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (12, N'All the Light We Cannot See', 11, NULL, 0, CAST(10.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1451445646l/18143977.jpg', N'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laureís reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museumís most valuable and dangerous jewel.
<br>In a mining town in Germany, Werner Pfennig, an orphan, grows up with his younger sister, enchanted by a crude radio they find that brings them news and stories from places they have never seen or imagined. Werner becomes an expert at building and fixing these crucial new instruments and is enlisted to use his talent to track down the resistance. Deftly interweaving the lives of Marie-Laure and Werner, Doerr illuminates the ways, against all odds, people try to be good to one another.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (13, N'Fullmetal Alchemist, Vol. 1', 12, NULL, 0, CAST(9.35 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1388179331l/870.jpg', N'Breaking the laws of nature is a serious crime!
<br>In an alchemical ritual gone wrong, Edward Elric lost his arm and his leg, and his brother Alphonse became nothing but a soul in a suit of armor. Equipped with mechanical ìauto-mailî limbs, Edward becomes a state alchemist, seeking the one thing that can restore his and his brotherís bodies...the legendary Philosopherís Stone.
<br>Alchemy: the mystical power to alter the natural world; something between magic, art and science. When two brothers, Edward and Alphonse Elric, dabbled in this power to grant their dearest wish, one of them lost an arm and a legÖand the other became nothing but a soul locked into a body of living steel. Now Edward is an agent of the government, a slave of the military-alchemical complex, using his unique powers to obey ordersÖeven to kill. Except his powers aren''t unique. The world has been ravaged by the abuse of alchemy. And in pursuit of the ultimate alchemical treasure, the Philosopher''s Stone, their enemies are even more ruthless than they areÖ', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (14, N'Death Note, Vol. 1: Boredom', 13, NULL, 0, CAST(10.40 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1419952134l/13615.jpg', N'Light Yagami is an ace student with great prospects - and he''s bored out of his mind. But all that changes when he finds the Death Note, a notebook dropped by a rogue Shinigami, a death god. Any human whose name is written in the notebook dies, and now Light has vowed to use the power of the Death Note to rid the world of evil. But when criminals begin dropping dead, the authorities send the legendary detective L to track down the killer. With L hot on his heels, will Light lose sight of his noble goal... or his life?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (15, N'One Piece, Volume 1: Romance Dawn', 14, NULL, 0, CAST(11.00 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1318523719l/1237398.jpg', N'A new shonen sensation in Japan, this series features Monkey D. Luffy, whose main ambition is to become a pirate. Eating the Gum-Gum Fruit gives him strange powers but also invokes the fruit''s curse: anybody who consumes it can never learn to swim. Nevertheless, Monkey and his crewmate Roronoa Zoro, master of the three-sword fighting style, sail the Seven Seas of swashbuckling adventure in search of the elusive treasure "One Piece."', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [authorId], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (16, N'Classroom of the Elite Vol. 1', 15, NULL, 0, CAST(9.69 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1540974678l/41085104.jpg', N'Students of the prestigious Tokyo Metropolitan Advanced Nurturing High School are given remarkable freedomóif they can win, barter, or save enough points to work their way up the ranks! Ayanokoji Kiyotaka has landed at the bottom in the scorned Class D, where he meets Horikita Suzune, whoís determined to rise up the ladder to Class A. Can they beat the system in a school where cutthroat competition is the name of the game?', 0, 1)
>>>>>>> Stashed changes
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
INSERT [dbo].[Book_Own] ([userId], [bookId]) VALUES (109, 4)
GO
INSERT [dbo].[Book_Own] ([userId], [bookId]) VALUES (109, 7)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
<<<<<<< Updated upstream
--INSERT [dbo].[Category] ([id], [name]) VALUES (1, N'Crime, Thriller & Mystery')
--INSERT [dbo].[Category] ([id], [name]) VALUES (2, N'Fantasy, Horror')
--INSERT [dbo].[Category] ([id], [name]) VALUES (3, N'Science/Historical Fiction')
--INSERT [dbo].[Category] ([id], [name]) VALUES (4, N'Manga&LN')
=======
INSERT [dbo].[Category] ([id], [name]) VALUES (1, N'Art')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (2, N'Biography')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (3, N'Business')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (4, N'Chick Lit')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (5, N'Christian')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (6, N'Classics')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (7, N'Comics')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (8, N'Contemporary')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (9, N'Cookbooks')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (10, N'Crime')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (12, N'Fantasy')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (13, N'Fiction')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (14, N'Gay and Lesbian')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (15, N'Graphic Novels')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (16, N'Historical Fiction')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (17, N'History')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (18, N'Horror')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (19, N'Humor and Comedy')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (20, N'Manga')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (21, N'Memoir')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (22, N'Music')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (23, N'Mystery')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (24, N'Nonfiction')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (25, N'Paranormal')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (26, N'Philosophy')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (27, N'Poetry')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (28, N'Psychology')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (29, N'Religion')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (30, N'Romance')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (31, N'Science')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (32, N'Science Fiction')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (33, N'Self Help')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (34, N'Suspense')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (35, N'Spirituality')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (36, N'Sports')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (37, N'Thriller')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (38, N'Travel')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (39, N'Young Adult')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (40, N'Light Novel')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (41, N'Adventure')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (42, N'Action')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (43, N'Adult')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (44, N'Wars')
GO
INSERT [dbo].[Category] ([id], [name]) VALUES (45, N'Slice of Life')
>>>>>>> Stashed changes
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (1, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (1, 23)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (1, 37)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (2, 6)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (2, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (2, 23)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (3, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (3, 23)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (3, 37)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (4, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (4, 23)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (4, 37)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (5, 6)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (5, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (5, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (6, 18)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (6, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (6, 37)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (6, 6)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (7, 18)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (7, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (7, 37)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (7, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (8, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (8, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (8, 41)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (8, 43)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (9, 39)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (9, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (9, 32)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 16)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (9, 30)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (9, 41)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (10, 6)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (10, 32)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (10, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (10, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 30)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 32)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (11, 43)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (12, 16)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (12, 44)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (12, 43)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (13, 20)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (13, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (13, 39)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (13, 32)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (13, 41)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (14, 20)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (14, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (14, 18)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (14, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (14, 23)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (15, 20)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (15, 12)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (15, 41)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (15, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (16, 40)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (16, 45)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (16, 13)
GO
INSERT [dbo].[CategoryBook] ([bookId], [categoryId]) VALUES (16, 39)
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (0, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2, CAST(1541.47 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3, CAST(4120.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4, CAST(1442.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5, CAST(1079.29 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6, CAST(3782.48 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7, CAST(3407.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8, CAST(7827.57 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9, CAST(2443.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (10, CAST(9.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (11, CAST(5982.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (12, CAST(909.46 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (13, CAST(3551.77 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (14, CAST(6174.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (15, CAST(77.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (16, CAST(2703.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (17, CAST(455.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (18, CAST(5027.96 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (19, CAST(4319.66 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (20, CAST(4195.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (21, CAST(7731.47 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (22, CAST(5349.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (23, CAST(5313.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (24, CAST(2078.36 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (25, CAST(6675.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (26, CAST(1440.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (27, CAST(14.59 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (28, CAST(760.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (29, CAST(6765.91 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (30, CAST(7622.32 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (31, CAST(826.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (32, CAST(85.16 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (33, CAST(3136.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (34, CAST(76.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (35, CAST(4839.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (36, CAST(5480.93 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (37, CAST(3678.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (38, CAST(4267.66 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (39, CAST(5559.76 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (40, CAST(981.02 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (41, CAST(8808.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (42, CAST(4875.06 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (43, CAST(8112.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (44, CAST(2829.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (45, CAST(6999.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (46, CAST(6558.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (47, CAST(7931.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (48, CAST(7476.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (49, CAST(4480.66 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (50, CAST(1196.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (51, CAST(3107.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (52, CAST(1721.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (53, CAST(7169.71 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (54, CAST(2465.22 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (55, CAST(8525.55 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (56, CAST(1163.63 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (57, CAST(1910.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (58, CAST(1578.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (59, CAST(2177.29 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (60, CAST(5623.95 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (61, CAST(5093.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (62, CAST(8543.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (63, CAST(5424.55 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (64, CAST(1068.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (65, CAST(2659.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (66, CAST(6317.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (67, CAST(531.91 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (68, CAST(4332.51 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (69, CAST(5425.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (70, CAST(8037.13 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (71, CAST(6357.76 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (72, CAST(3767.05 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (73, CAST(7528.66 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (74, CAST(7135.03 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (75, CAST(979.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (76, CAST(1645.65 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (77, CAST(5195.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (78, CAST(6283.85 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (79, CAST(4977.79 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (80, CAST(5043.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (81, CAST(381.53 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (82, CAST(5080.89 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (83, CAST(16.69 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (84, CAST(3547.69 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (85, CAST(3475.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (86, CAST(1805.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (87, CAST(7012.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (88, CAST(6935.14 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (89, CAST(1641.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (90, CAST(1300.46 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (91, CAST(7175.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (92, CAST(3341.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (93, CAST(6665.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (94, CAST(8094.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (95, CAST(1064.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (96, CAST(4197.52 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (97, CAST(8879.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (98, CAST(5057.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (99, CAST(3718.89 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (100, CAST(1627.63 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (101, CAST(4261.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (102, CAST(4800.82 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (106, CAST(1085.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (109, CAST(205.67 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (110, CAST(0.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (37075223, CAST(1013.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (51173456, CAST(4708.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (74952141, CAST(967.37 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (139454019, CAST(2601.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (318071247, CAST(2773.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (386636643, CAST(4743.82 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (431618205, CAST(2455.83 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (446972780, CAST(868.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (473152984, CAST(4025.39 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (679671431, CAST(362.52 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (850401454, CAST(4467.16 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (917355251, CAST(4226.73 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (955966322, CAST(3608.38 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (972439339, CAST(575.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1145993637, CAST(2866.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1167357241, CAST(4561.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1283714042, CAST(4677.83 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1318334801, CAST(1650.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1331967611, CAST(961.05 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1332569623, CAST(2736.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1380002937, CAST(3917.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1422712096, CAST(3589.39 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1601270613, CAST(1553.94 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1836390590, CAST(3744.16 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1971979391, CAST(969.63 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (1976122113, CAST(4400.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2384611197, CAST(2457.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2437453828, CAST(1322.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2519495624, CAST(2990.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2619470944, CAST(4899.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2670916914, CAST(4310.07 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2680701419, CAST(1136.64 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2765599235, CAST(1192.15 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2793178405, CAST(3422.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2948873856, CAST(1918.69 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2955140061, CAST(2312.28 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (2997019069, CAST(291.88 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3016661812, CAST(2820.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3424019427, CAST(4911.65 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3473387652, CAST(1244.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3572954814, CAST(583.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3905247198, CAST(1754.22 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (3908116429, CAST(4443.57 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4146405242, CAST(3724.57 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4482504141, CAST(1070.37 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4519725304, CAST(4555.48 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4678472703, CAST(2749.56 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4681142538, CAST(1451.98 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (4964763819, CAST(3480.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5138125456, CAST(3009.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5159802194, CAST(4299.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5254587583, CAST(2721.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5355923867, CAST(982.88 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5419266462, CAST(534.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5429986684, CAST(2718.72 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5475360879, CAST(4401.64 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5547914765, CAST(1315.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5549015036, CAST(4094.62 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5557555461, CAST(1671.08 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5576484273, CAST(4683.13 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5887723221, CAST(5033.03 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5909459634, CAST(206.46 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5944525984, CAST(197.62 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (5988347845, CAST(1447.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6026989470, CAST(1279.26 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6068574838, CAST(4195.60 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6438403365, CAST(2582.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6442457323, CAST(2906.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6469848160, CAST(3998.92 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6479146192, CAST(4970.04 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6582769227, CAST(1292.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6597026015, CAST(4771.56 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6620691933, CAST(3481.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6952777387, CAST(1415.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (6997812930, CAST(4785.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7173493771, CAST(2964.03 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7183046243, CAST(1746.56 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7244526304, CAST(2703.83 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7263590060, CAST(2002.77 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7410852963, CAST(80.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7661491077, CAST(4502.04 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7748861664, CAST(2917.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (7997053302, CAST(2972.38 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8042711543, CAST(2522.15 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8074129941, CAST(3073.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8142936699, CAST(3675.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8185325202, CAST(2783.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8227851142, CAST(3124.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8455971628, CAST(1162.28 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8491633133, CAST(837.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8500602522, CAST(1975.43 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8531866336, CAST(2978.71 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8599753652, CAST(4145.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8731359880, CAST(3342.79 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8808419770, CAST(4254.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8881596476, CAST(3353.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (8910545709, CAST(2329.29 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9135370392, CAST(4930.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9215737984, CAST(3930.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9335327530, CAST(4865.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9430503622, CAST(4504.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9872231353, CAST(4068.72 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9876543210, CAST(244.05 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9880788429, CAST(2740.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9953524311, CAST(4946.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (9961111214, CAST(3763.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (10028714113, CAST(627.22 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (10108825850, CAST(1273.39 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (36950928992, CAST(2102.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (38285536832, CAST(1163.58 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (38724088357, CAST(591.05 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (41127767675, CAST(386.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (42534310518, CAST(2839.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (48071110244, CAST(1548.60 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (52301432232, CAST(1574.07 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (53097505521, CAST(518.58 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (56320572041, CAST(2727.35 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (60960915696, CAST(2478.77 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (66030440862, CAST(1444.67 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (79280419196, CAST(2384.96 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (81845189051, CAST(2746.01 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (89408126469, CAST(3820.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (97120071759, CAST(3615.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (101737393877, CAST(1059.70 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (103278207654, CAST(792.69 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (107031370718, CAST(2317.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (112411308346, CAST(1930.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (115287764998, CAST(1341.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (120853157158, CAST(101.32 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (122177522637, CAST(636.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (126440290567, CAST(3332.12 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (126503365507, CAST(2229.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (140475581701, CAST(692.93 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (142937696721, CAST(2497.83 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (149820848609, CAST(2315.04 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (151028402272, CAST(2969.12 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (152277997337, CAST(1206.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (158889565670, CAST(514.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (164375994213, CAST(2242.73 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (169294791218, CAST(810.10 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (174443321075, CAST(578.43 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (181523712733, CAST(1289.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (187897646152, CAST(2144.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (188177285964, CAST(921.62 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (199500188635, CAST(3101.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (203997350124, CAST(2578.13 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (207470283267, CAST(3806.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (209556166150, CAST(1946.06 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (209570001706, CAST(3772.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (213521244362, CAST(3947.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (227284879629, CAST(3762.78 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (231384165180, CAST(2799.71 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (232884349933, CAST(2278.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (236343429829, CAST(1981.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (236820266935, CAST(3598.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (237953430347, CAST(98.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (239309661578, CAST(3717.66 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (240889419410, CAST(2408.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (249992160549, CAST(905.87 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (250911429689, CAST(1319.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (254285772452, CAST(2241.19 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (262276321519, CAST(382.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (265245750110, CAST(3623.79 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (266121001335, CAST(695.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (273592303768, CAST(1560.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (285097785185, CAST(3933.28 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (287479779076, CAST(3579.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (290232933183, CAST(1469.63 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (315247907184, CAST(1718.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (322276924762, CAST(2272.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (324296175302, CAST(589.83 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (325783078690, CAST(3285.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (336158726699, CAST(840.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (336892621328, CAST(945.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (337513137816, CAST(1415.22 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (343420998738, CAST(3117.55 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (343845419707, CAST(401.38 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (351112611051, CAST(2672.39 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (352601308982, CAST(999.28 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (354824976571, CAST(3728.57 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (358782879216, CAST(2328.16 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (358822285150, CAST(378.48 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (359686743844, CAST(3256.72 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (376056683973, CAST(1941.16 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (377635932537, CAST(2121.85 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (379919804407, CAST(2453.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (385230566996, CAST(2785.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (385826325842, CAST(3103.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (386632492873, CAST(2574.62 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (391772588198, CAST(2692.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (392641792498, CAST(3979.04 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (393303298853, CAST(1124.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (400939899392, CAST(1050.96 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (418403880497, CAST(918.15 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (419653580434, CAST(825.47 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (430294349517, CAST(3507.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (430294857995, CAST(1681.88 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (430544819514, CAST(3492.71 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (435485221093, CAST(1351.56 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (435520516679, CAST(784.68 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (436793751216, CAST(1719.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (439147026401, CAST(484.06 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (441776164259, CAST(2106.53 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (442403217350, CAST(160.72 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (460132919932, CAST(1130.09 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (466638737912, CAST(28.57 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (471679850803, CAST(2795.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (491002702053, CAST(1494.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (493636572380, CAST(840.67 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (508925563656, CAST(1323.43 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (509069112420, CAST(2998.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (509663821365, CAST(2482.12 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (515764677007, CAST(2050.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (526857701876, CAST(3981.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (527442113653, CAST(1737.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (531389704974, CAST(3580.85 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (533581768089, CAST(1086.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (538441503541, CAST(1646.29 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (539222392333, CAST(311.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (539691899706, CAST(588.84 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (549774601361, CAST(2754.81 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (558666225544, CAST(3520.23 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (564106066444, CAST(750.93 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (565260147089, CAST(2477.67 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (567670273019, CAST(3867.52 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (572487169216, CAST(25.53 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (575633364565, CAST(3142.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (578098751297, CAST(3536.88 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (578829806493, CAST(2216.28 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (581523864399, CAST(781.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (582655711819, CAST(1374.82 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (592796329443, CAST(3292.56 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (594065092479, CAST(3466.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (598958801803, CAST(1825.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (601529762710, CAST(3308.58 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (604600101293, CAST(3915.81 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (605057996983, CAST(3813.15 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (607358308340, CAST(1911.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (610880290584, CAST(2877.82 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (611794509420, CAST(3814.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (615036392323, CAST(3235.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (619136362013, CAST(1422.61 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (624452533539, CAST(2789.71 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (628234675672, CAST(2448.07 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (628938127662, CAST(3897.55 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (635892814748, CAST(2255.36 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (648916271688, CAST(2632.26 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (650905394193, CAST(1465.48 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (653375173447, CAST(3935.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (655288902107, CAST(1304.58 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (657010967037, CAST(3701.03 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (672860905964, CAST(3276.39 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (674420418742, CAST(2964.09 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (675244595871, CAST(3613.85 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (675261076995, CAST(3533.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (675913287543, CAST(2680.86 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (686423328185, CAST(3369.96 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (707530192293, CAST(1193.29 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (713060829477, CAST(2213.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (720486988035, CAST(1399.69 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (741762191662, CAST(1536.13 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (743894265434, CAST(842.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (746257518271, CAST(7.32 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (759078918355, CAST(2427.13 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (776000584391, CAST(2316.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (792850415956, CAST(721.97 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (805608027221, CAST(672.55 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (805749058436, CAST(2866.52 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (809557958533, CAST(1919.76 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (810577190687, CAST(3075.60 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (813992959234, CAST(2758.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (819037236035, CAST(2967.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (821924822637, CAST(386.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (824153521557, CAST(559.70 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (825143075035, CAST(2892.25 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (828934338739, CAST(194.49 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (839372661076, CAST(2682.17 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (844584438318, CAST(2328.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (846620874005, CAST(716.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (853196387942, CAST(1170.18 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (866076402536, CAST(1990.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (872583500031, CAST(961.33 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (875377823249, CAST(3844.24 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (878967953571, CAST(1127.58 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (888888888888, CAST(123.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (901338596510, CAST(1318.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (902663344777, CAST(3846.06 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (903213176862, CAST(1838.54 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (904597945260, CAST(28.64 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (919592383256, CAST(1957.09 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (922451159291, CAST(1967.94 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (931536916174, CAST(3123.77 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (950478619471, CAST(3868.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (955067293038, CAST(1574.11 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (961407135267, CAST(2256.21 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (963262289282, CAST(3759.74 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (965397232308, CAST(0.89 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (967843195380, CAST(789.27 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (970108759513, CAST(2454.94 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (978683745760, CAST(830.31 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (982017699533, CAST(1447.45 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (985256672758, CAST(1165.42 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (989712775405, CAST(2723.93 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (998193093125, CAST(1430.44 AS Decimal(10, 2)))
GO
INSERT [dbo].[Payment_Account] ([accountNumber], [balance]) VALUES (998433188504, CAST(3219.33 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Payment_Method] ON 
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (45678, 1, 888888888888, N'Bank 1', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (45681, 1, 7410852963, N'Bank 2', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (45684, 2, 9876543210, N'Bank 1', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47112, 1, 1, N'Wallet of admin', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47115, 1, 2955140061, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47118, 2, 2, N'Wallet of vinh', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47121, 2, 9880788429, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47127, 3, 6469848160, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47130, 4, 4, N'Wallet of user_no2', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47133, 4, 5254587583, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47136, 5, 5, N'Wallet of user_no3', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47139, 5, 679671431, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47142, 6, 6, N'Wallet of user_no4', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47145, 6, 4482504141, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47148, 7, 7, N'Wallet of user_no5', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47151, 7, 9961111214, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47154, 8, 8, N'Wallet of user_no6', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47157, 8, 1976122113, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47160, 9, 9, N'Wallet of user_no7', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47163, 9, 1145993637, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47166, 10, 10, N'Wallet of user_no8', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47169, 10, 8185325202, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47172, 11, 11, N'Wallet of user_no9', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47175, 11, 6952777387, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47178, 12, 12, N'Wallet of user_no10', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47181, 12, 5557555461, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47184, 13, 13, N'Wallet of user_no11', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47187, 13, 7183046243, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47190, 14, 14, N'Wallet of user_no12', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47193, 14, 2670916914, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47196, 15, 15, N'Wallet of user_no13', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47199, 15, 1380002937, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47202, 16, 16, N'Wallet of user_no14', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47205, 16, 5355923867, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47208, 17, 17, N'Wallet of user_no15', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47211, 17, 5944525984, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47214, 18, 18, N'Wallet of user_no16', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47217, 18, 8808419770, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47220, 19, 19, N'Wallet of user_no17', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47223, 19, 51173456, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47226, 20, 20, N'Wallet of user_no18', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47229, 20, 5475360879, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47232, 21, 21, N'Wallet of user_no19', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47235, 21, 1601270613, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47238, 22, 22, N'Wallet of user_no20', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47241, 22, 5549015036, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47244, 23, 23, N'Wallet of user_no21', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47247, 23, 5419266462, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47250, 24, 24, N'Wallet of user_no22', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47253, 24, 9335327530, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47256, 25, 25, N'Wallet of user_no23', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47259, 25, 4146405242, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47262, 26, 26, N'Wallet of user_no24', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47265, 26, 9872231353, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47268, 27, 27, N'Wallet of user_no25', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47271, 27, 9215737984, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47274, 28, 28, N'Wallet of user_no26', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47277, 28, 6026989470, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47280, 29, 29, N'Wallet of user_no27', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47283, 29, 431618205, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47286, 30, 30, N'Wallet of user_no28', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47289, 30, 1318334801, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47292, 31, 31, N'Wallet of user_no29', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47295, 31, 5909459634, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47298, 32, 32, N'Wallet of user_no30', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47301, 32, 1283714042, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47304, 33, 33, N'Wallet of user_no31', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47307, 33, 7263590060, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47313, 34, 4519725304, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47316, 35, 35, N'Wallet of user_no33', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47319, 35, 8500602522, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47322, 36, 36, N'Wallet of user_no34', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47325, 36, 3908116429, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47328, 37, 37, N'Wallet of user_no35', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47331, 37, 37075223, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47334, 38, 38, N'Wallet of user_no36', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47337, 38, 3473387652, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47340, 39, 39, N'Wallet of user_no37', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47343, 39, 6597026015, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47346, 40, 40, N'Wallet of user_no38', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47349, 40, 473152984, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47352, 41, 41, N'Wallet of user_no39', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47355, 41, 1167357241, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47358, 42, 42, N'Wallet of user_no40', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47361, 42, 2519495624, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47364, 43, 43, N'Wallet of user_no41', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47367, 43, 5159802194, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47370, 44, 44, N'Wallet of user_no42', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47373, 44, 8142936699, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47376, 45, 45, N'Wallet of user_no43', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47379, 45, 2997019069, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47382, 46, 46, N'Wallet of user_no44', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47385, 46, 6442457323, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47388, 47, 47, N'Wallet of user_no45', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47391, 47, 6068574838, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47394, 48, 48, N'Wallet of user_no46', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47397, 48, 4964763819, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47400, 49, 49, N'Wallet of user_no47', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47403, 49, 139454019, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47406, 50, 50, N'Wallet of user_no48', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47409, 50, 1836390590, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47412, 51, 51, N'Wallet of user_no49', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47415, 51, 7997053302, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47418, 52, 52, N'Wallet of user_no50', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47421, 52, 8881596476, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47424, 53, 53, N'Wallet of user_no51', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47427, 53, 955966322, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47430, 54, 54, N'Wallet of user_no52', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47433, 54, 7748861664, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47436, 55, 55, N'Wallet of user_no53', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47439, 55, 6479146192, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47442, 56, 56, N'Wallet of user_no54', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47445, 56, 1332569623, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47448, 57, 57, N'Wallet of user_no55', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47451, 57, 2793178405, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47454, 58, 58, N'Wallet of user_no56', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47457, 58, 9135370392, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47463, 59, 4678472703, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47466, 60, 60, N'Wallet of user_no58', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47469, 60, 5988347845, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47472, 61, 61, N'Wallet of user_no59', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47475, 61, 3424019427, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47478, 62, 62, N'Wallet of user_no60', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47481, 62, 8731359880, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47484, 63, 63, N'Wallet of user_no61', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47487, 63, 8910545709, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47490, 64, 64, N'Wallet of user_no62', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47493, 64, 9430503622, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47499, 65, 5576484273, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47502, 66, 66, N'Wallet of user_no64', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47505, 66, 4681142538, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47508, 67, 67, N'Wallet of user_no65', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47511, 67, 8074129941, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47514, 68, 68, N'Wallet of user_no66', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47517, 68, 318071247, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47520, 69, 69, N'Wallet of user_no67', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47523, 69, 8042711543, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47526, 70, 70, N'Wallet of user_no68', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47529, 70, 8227851142, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47532, 71, 71, N'Wallet of user_no69', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47535, 71, 8491633133, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47538, 72, 72, N'Wallet of user_no70', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47541, 72, 8531866336, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47544, 73, 73, N'Wallet of user_no71', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47547, 73, 446972780, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47550, 74, 74, N'Wallet of user_no72', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47553, 74, 6438403365, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47556, 75, 75, N'Wallet of user_no73', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47559, 75, 2765599235, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47562, 76, 76, N'Wallet of user_no74', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47565, 76, 9953524311, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47568, 77, 77, N'Wallet of user_no75', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47571, 77, 917355251, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47574, 78, 78, N'Wallet of user_no76', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47577, 78, 7661491077, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47580, 79, 79, N'Wallet of user_no77', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47583, 79, 8599753652, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47586, 80, 80, N'Wallet of user_no78', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47589, 80, 1331967611, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47592, 81, 81, N'Wallet of user_no79', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47595, 81, 972439339, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47598, 82, 82, N'Wallet of user_no80', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47601, 82, 6620691933, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47604, 83, 83, N'Wallet of user_no81', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47607, 83, 3016661812, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47610, 84, 84, N'Wallet of user_no82', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47613, 84, 3905247198, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47616, 85, 85, N'Wallet of user_no83', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47619, 85, 7173493771, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47622, 86, 86, N'Wallet of user_no84', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47625, 86, 6997812930, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47628, 87, 87, N'Wallet of user_no85', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47631, 87, 74952141, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47634, 88, 88, N'Wallet of user_no86', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47637, 88, 1971979391, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47640, 89, 89, N'Wallet of user_no87', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47643, 89, 850401454, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47646, 90, 90, N'Wallet of user_no88', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47649, 90, 6582769227, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47652, 91, 91, N'Wallet of user_no89', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47655, 91, 5138125456, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47658, 92, 92, N'Wallet of user_no90', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47661, 92, 2619470944, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47667, 93, 1422712096, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47673, 94, 386636643, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47676, 95, 95, N'Wallet of user_no93', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47679, 95, 3572954814, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47682, 96, 96, N'Wallet of user_no94', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47685, 96, 2948873856, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47688, 97, 97, N'Wallet of user_no95', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47691, 97, 5887723221, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47694, 98, 98, N'Wallet of user_no96', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47697, 98, 7244526304, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47700, 99, 99, N'Wallet of user_no97', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47703, 99, 8455971628, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47706, 100, 100, N'Wallet of user_no98', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47709, 100, 2437453828, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47712, 101, 101, N'Wallet of user_no99', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47715, 101, 2384611197, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47718, 102, 102, N'Wallet of user_no100', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47721, 102, 2680701419, N'Linked Bank', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47724, 65, 65, N'Wallet of user_no63', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47727, 59, 59, N'Wallet of user_no57', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47730, 3, 3, N'Wallet of user_no_3', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47733, 93, 93, N'Wallet of user_no91', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47736, 94, 94, N'Wallet of user_no92', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47739, 2, 10028714113, N'Bank 3', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47763, 109, 109, N'Wallet of tester', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (47766, 109, 107031370718, N'Bank 2', 1)
GO
INSERT [dbo].[Payment_Method] ([paymentId], [userId], [accountNumber], [name], [active]) VALUES (48078, 110, 110, N'Wallet of autester', 1)
GO
SET IDENTITY_INSERT [dbo].[Payment_Method] OFF
GO
SET IDENTITY_INSERT [dbo].[Report] ON 
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (1, N'Sexual Content')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (2, N'Violent or repulsive content')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (3, N'Hateful or abusive content')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (4, N'Harassment or bullying')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (5, N'Harmful or dangerous acts')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (6, N'Child abuse')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (7, N'Promotes terrorism')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (8, N'Spam or misleading')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (9, N'Infringes my rights')
GO
INSERT [dbo].[Report] ([id], [title]) VALUES (10, N'Caption issue')
GO
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
INSERT [dbo].[Star] ([bid], [uid], [star]) VALUES (1, 2, 2)
GO
INSERT [dbo].[Star] ([bid], [uid], [star]) VALUES (1, 109, 5)
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000001, 2, CAST(297.69 AS Decimal(10, 2)), CAST(297.69 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.323' AS DateTime), 1, 2, N'Recharge money from Bank 1', 45684)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000002, 3, CAST(4120.33 AS Decimal(10, 2)), CAST(4120.33 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.380' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47127)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000003, 4, CAST(1442.86 AS Decimal(10, 2)), CAST(1442.86 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.430' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47133)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000004, 5, CAST(1079.29 AS Decimal(10, 2)), CAST(1079.29 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.493' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47139)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000005, 6, CAST(3782.48 AS Decimal(10, 2)), CAST(3782.48 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.557' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47145)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000006, 7, CAST(3407.86 AS Decimal(10, 2)), CAST(3407.86 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.617' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47151)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000007, 8, CAST(7827.57 AS Decimal(10, 2)), CAST(7827.57 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.670' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47157)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000008, 9, CAST(2443.45 AS Decimal(10, 2)), CAST(2443.45 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.753' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47163)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000009, 10, CAST(9.17 AS Decimal(10, 2)), CAST(9.17 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.820' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47169)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000010, 11, CAST(5982.25 AS Decimal(10, 2)), CAST(5982.25 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.890' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47175)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000011, 12, CAST(909.46 AS Decimal(10, 2)), CAST(909.46 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:10.953' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47181)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000012, 13, CAST(3551.77 AS Decimal(10, 2)), CAST(3551.77 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.010' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47187)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000013, 14, CAST(6174.18 AS Decimal(10, 2)), CAST(6174.18 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.073' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47193)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000014, 15, CAST(77.97 AS Decimal(10, 2)), CAST(77.97 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.130' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47199)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000015, 16, CAST(2703.23 AS Decimal(10, 2)), CAST(2703.23 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.190' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47205)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000016, 17, CAST(455.40 AS Decimal(10, 2)), CAST(455.40 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.263' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47211)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000017, 18, CAST(5027.96 AS Decimal(10, 2)), CAST(5027.96 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.320' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47217)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000018, 19, CAST(4319.66 AS Decimal(10, 2)), CAST(4319.66 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.373' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47223)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000019, 20, CAST(4195.68 AS Decimal(10, 2)), CAST(4195.68 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.433' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47229)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000020, 21, CAST(7731.47 AS Decimal(10, 2)), CAST(7731.47 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.490' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47235)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000021, 22, CAST(5349.61 AS Decimal(10, 2)), CAST(5349.61 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.547' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47241)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000022, 23, CAST(5313.50 AS Decimal(10, 2)), CAST(5313.50 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.603' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47247)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000023, 24, CAST(2078.36 AS Decimal(10, 2)), CAST(2078.36 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.650' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47253)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000024, 25, CAST(6675.17 AS Decimal(10, 2)), CAST(6675.17 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.700' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47259)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000025, 26, CAST(1440.90 AS Decimal(10, 2)), CAST(1440.90 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.747' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47265)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000026, 27, CAST(14.59 AS Decimal(10, 2)), CAST(14.59 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.797' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47271)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000027, 28, CAST(760.99 AS Decimal(10, 2)), CAST(760.99 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.850' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47277)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000028, 29, CAST(6765.91 AS Decimal(10, 2)), CAST(6765.91 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.897' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47283)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000029, 30, CAST(7622.32 AS Decimal(10, 2)), CAST(7622.32 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.940' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47289)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000030, 31, CAST(826.10 AS Decimal(10, 2)), CAST(826.10 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:11.983' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47295)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000031, 32, CAST(85.16 AS Decimal(10, 2)), CAST(85.16 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.040' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47301)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000032, 33, CAST(3136.10 AS Decimal(10, 2)), CAST(3136.10 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.093' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47307)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000033, 34, CAST(76.44 AS Decimal(10, 2)), CAST(76.44 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.143' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47313)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000034, 35, CAST(4839.84 AS Decimal(10, 2)), CAST(4839.84 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.203' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47319)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000035, 36, CAST(5480.93 AS Decimal(10, 2)), CAST(5480.93 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.307' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47325)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000036, 37, CAST(3678.42 AS Decimal(10, 2)), CAST(3678.42 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.357' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47331)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000037, 38, CAST(4267.66 AS Decimal(10, 2)), CAST(4267.66 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.403' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47337)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000038, 39, CAST(5559.76 AS Decimal(10, 2)), CAST(5559.76 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.453' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47343)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000039, 40, CAST(981.02 AS Decimal(10, 2)), CAST(981.02 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.507' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47349)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000040, 41, CAST(8808.18 AS Decimal(10, 2)), CAST(8808.18 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.553' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47355)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000041, 42, CAST(4875.06 AS Decimal(10, 2)), CAST(4875.06 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.597' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47361)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000042, 43, CAST(8112.23 AS Decimal(10, 2)), CAST(8112.23 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.643' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47367)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000043, 44, CAST(2829.23 AS Decimal(10, 2)), CAST(2829.23 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.693' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47373)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000044, 45, CAST(6999.18 AS Decimal(10, 2)), CAST(6999.18 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.740' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47379)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000045, 46, CAST(6558.10 AS Decimal(10, 2)), CAST(6558.10 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.787' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47385)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000046, 47, CAST(7931.99 AS Decimal(10, 2)), CAST(7931.99 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.837' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47391)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000047, 48, CAST(7476.40 AS Decimal(10, 2)), CAST(7476.40 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.897' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47397)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000048, 49, CAST(4480.66 AS Decimal(10, 2)), CAST(4480.66 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.943' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47403)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000049, 50, CAST(1196.33 AS Decimal(10, 2)), CAST(1196.33 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:12.990' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47409)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000050, 51, CAST(3107.50 AS Decimal(10, 2)), CAST(3107.50 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.037' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47415)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000051, 52, CAST(1721.74 AS Decimal(10, 2)), CAST(1721.74 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.083' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47421)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000052, 53, CAST(7169.71 AS Decimal(10, 2)), CAST(7169.71 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.133' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47427)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000053, 54, CAST(2465.22 AS Decimal(10, 2)), CAST(2465.22 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.180' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47433)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000054, 55, CAST(8525.55 AS Decimal(10, 2)), CAST(8525.55 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.227' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47439)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000055, 56, CAST(1163.63 AS Decimal(10, 2)), CAST(1163.63 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.270' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47445)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000056, 57, CAST(1910.84 AS Decimal(10, 2)), CAST(1910.84 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.320' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47451)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000057, 58, CAST(1578.50 AS Decimal(10, 2)), CAST(1578.50 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.370' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47457)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000058, 59, CAST(2177.29 AS Decimal(10, 2)), CAST(2177.29 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.423' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47463)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000059, 60, CAST(5623.95 AS Decimal(10, 2)), CAST(5623.95 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.473' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47469)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000060, 61, CAST(5093.20 AS Decimal(10, 2)), CAST(5093.20 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.530' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47475)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000061, 62, CAST(8543.68 AS Decimal(10, 2)), CAST(8543.68 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.593' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47481)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000062, 63, CAST(5424.55 AS Decimal(10, 2)), CAST(5424.55 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.643' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47487)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000063, 64, CAST(1068.78 AS Decimal(10, 2)), CAST(1068.78 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.700' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47493)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000064, 65, CAST(2659.99 AS Decimal(10, 2)), CAST(2659.99 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.757' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47499)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000065, 66, CAST(6317.44 AS Decimal(10, 2)), CAST(6317.44 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.817' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47505)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000066, 67, CAST(531.91 AS Decimal(10, 2)), CAST(531.91 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.883' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47511)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000067, 68, CAST(4332.51 AS Decimal(10, 2)), CAST(4332.51 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:13.953' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47517)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000068, 69, CAST(5425.50 AS Decimal(10, 2)), CAST(5425.50 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.017' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47523)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000069, 70, CAST(8037.13 AS Decimal(10, 2)), CAST(8037.13 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.080' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47529)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000070, 71, CAST(6357.76 AS Decimal(10, 2)), CAST(6357.76 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.163' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47535)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000071, 72, CAST(3767.05 AS Decimal(10, 2)), CAST(3767.05 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.223' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47541)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000072, 73, CAST(7528.66 AS Decimal(10, 2)), CAST(7528.66 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.277' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47547)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000073, 74, CAST(7135.03 AS Decimal(10, 2)), CAST(7135.03 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.333' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47553)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000074, 75, CAST(979.24 AS Decimal(10, 2)), CAST(979.24 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.390' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47559)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000075, 76, CAST(1645.65 AS Decimal(10, 2)), CAST(1645.65 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.450' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47565)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000076, 77, CAST(5195.25 AS Decimal(10, 2)), CAST(5195.25 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.500' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47571)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000077, 78, CAST(6283.85 AS Decimal(10, 2)), CAST(6283.85 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.543' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47577)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000078, 79, CAST(4977.79 AS Decimal(10, 2)), CAST(4977.79 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.597' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47583)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000079, 80, CAST(5043.27 AS Decimal(10, 2)), CAST(5043.27 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.647' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47589)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000080, 81, CAST(381.53 AS Decimal(10, 2)), CAST(381.53 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.690' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47595)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000081, 82, CAST(5080.89 AS Decimal(10, 2)), CAST(5080.89 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.737' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47601)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000082, 83, CAST(16.69 AS Decimal(10, 2)), CAST(16.69 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.787' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47607)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000083, 84, CAST(3547.69 AS Decimal(10, 2)), CAST(3547.69 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.837' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47613)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000084, 85, CAST(3475.33 AS Decimal(10, 2)), CAST(3475.33 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.883' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47619)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000085, 86, CAST(1805.99 AS Decimal(10, 2)), CAST(1805.99 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.927' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47625)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000086, 87, CAST(7012.19 AS Decimal(10, 2)), CAST(7012.19 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:14.973' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47631)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000087, 88, CAST(6935.14 AS Decimal(10, 2)), CAST(6935.14 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.017' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47637)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000088, 89, CAST(1641.78 AS Decimal(10, 2)), CAST(1641.78 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.067' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47643)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000089, 90, CAST(1300.46 AS Decimal(10, 2)), CAST(1300.46 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.110' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47649)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000090, 91, CAST(7175.78 AS Decimal(10, 2)), CAST(7175.78 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.157' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47655)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000091, 92, CAST(3341.84 AS Decimal(10, 2)), CAST(3341.84 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.203' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47661)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000092, 93, CAST(6665.80 AS Decimal(10, 2)), CAST(6665.80 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.247' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47667)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000093, 94, CAST(8094.17 AS Decimal(10, 2)), CAST(8094.17 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.293' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47673)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000094, 95, CAST(1064.11 AS Decimal(10, 2)), CAST(1064.11 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.337' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47679)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000095, 96, CAST(4197.52 AS Decimal(10, 2)), CAST(4197.52 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.387' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47685)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000096, 97, CAST(8879.19 AS Decimal(10, 2)), CAST(8879.19 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.433' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47691)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000097, 98, CAST(5057.10 AS Decimal(10, 2)), CAST(5057.10 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.483' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47697)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000098, 99, CAST(3718.89 AS Decimal(10, 2)), CAST(3718.89 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.530' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47703)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000099, 100, CAST(1627.63 AS Decimal(10, 2)), CAST(1627.63 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.580' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47709)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000100, 101, CAST(4261.23 AS Decimal(10, 2)), CAST(4261.23 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.627' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47715)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000101, 102, CAST(4800.82 AS Decimal(10, 2)), CAST(4800.82 AS Decimal(10, 2)), CAST(N'2022-10-01T05:52:15.683' AS DateTime), 1, 2, N'Recharge money from Linked Bank', 47721)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000102, 2, CAST(150.13 AS Decimal(10, 2)), CAST(147.56 AS Decimal(10, 2)), CAST(N'2022-10-01T22:25:58.213' AS DateTime), 2, 2, N'Withdraw from wallet to Bank 1.', 45684)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000103, 2, CAST(1235.42 AS Decimal(10, 2)), CAST(1783.24 AS Decimal(10, 2)), CAST(N'2022-10-01T22:31:43.330' AS DateTime), 1, 2, N'Recharge from Linked Bank into wallet.', 47121)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000104, 2, CAST(241.77 AS Decimal(10, 2)), CAST(1541.47 AS Decimal(10, 2)), CAST(N'2022-10-01T22:32:21.120' AS DateTime), 2, 2, N'Withdraw from wallet to Bank 1.', 45684)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000108, 109, CAST(230.16 AS Decimal(10, 2)), CAST(230.16 AS Decimal(10, 2)), CAST(N'2022-10-03T13:50:31.843' AS DateTime), 1, 2, N'Recharge from Bank 2 into wallet.', 47766)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000109, 109, CAST(13.99 AS Decimal(10, 2)), CAST(216.17 AS Decimal(10, 2)), CAST(N'2022-10-03T13:50:45.683' AS DateTime), 3, 2, N'Buy The Girl on the Train.', 47763)
GO
INSERT [dbo].[Transaction] ([transactionId], [userId], [amount], [balanceAfter], [transactionTime], [type], [status], [description], [paymentId]) VALUES (3000110, 109, CAST(10.50 AS Decimal(10, 2)), CAST(205.67 AS Decimal(10, 2)), CAST(N'2022-10-03T13:53:14.897' AS DateTime), 3, 2, N'Buy It.', 47763)
GO
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (1, N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhnthe163219@fpt.edu.vn', N'0382132025', N'FBT University ', N'admin', N'admin', 5, 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (2, N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhvn102@gmail.com', N'0382132025', N'FBT University ', N'vinh', N'2002', 2, 2)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (3, N'Ivory Marcel', 0, CAST(N'1969-09-20' AS Date), N'Bookie_User1@qa.team', N'6128170843', N'E312R', N'user_no1', N'9v9SJ2gqt1', 1, 3)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (4, N'duy pham', 1, CAST(N'1970-02-16' AS Date), N'duy2@qa.team', N'7134690959', N'F012R', N'duy', N'1001', 1, 4)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (5, N'Eden Frost', 1, CAST(N'1984-03-13' AS Date), N'Bookie_User3@qa.team', N'8252042139', N'B438R', N'user_no3', N'IMG2x1T1iv', 1, 5)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (6, N'Benidict Robinett', 1, CAST(N'1966-02-10' AS Date), N'Bookie_User4@qa.team', N'3999059789', N'A400R', N'user_no4', N'mq8q4KfNjV', 1, 6)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (7, N'Zera Farmer', 0, CAST(N'1961-02-10' AS Date), N'Bookie_Admin5@qa.team', N'5706825096', N'E271R', N'user_no5', N'2bh7UnCPxT', 1, 7)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (8, N'Ceil Howell', 1, CAST(N'1992-09-16' AS Date), N'Bookie_User6@qa.team', N'5374439245', N'C146R', N'user_no6', N'kURf75I4QQ', 0, 8)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (9, N'Taylor Marcel', 0, CAST(N'2000-09-04' AS Date), N'Bookie_User7@qa.team', N'9180387665', N'E402L', N'user_no7', N'1FF4G03cId', 1, 9)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (10, N'Wisley Ray', 1, CAST(N'1971-10-28' AS Date), N'Bookie_User8@qa.team', N'8155814231', N'B398R', N'user_no8', N'T4dI4P82Ab', 1, 10)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (11, N'Aiken Pope', 1, CAST(N'1979-05-01' AS Date), N'Bookie_User9@qa.team', N'7770308417', N'F421L', N'user_no9', N'op6An5T76g', 1, 11)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (12, N'Rodolphe Blossom', 1, CAST(N'2001-02-19' AS Date), N'Bookie_User10@qa.team', N'6610856429', N'A168L', N'user_no10', N'2203lupus8', 1, 12)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (13, N'Alex Rogze', 0, CAST(N'1987-08-07' AS Date), N'Bookie_Admin11@qa.team', N'9326626549', N'B508R', N'user_no11', N'Lngixrl107', 1, 13)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (14, N'Jean Padilla', 1, CAST(N'1967-11-16' AS Date), N'Bookie_User12@qa.team', N'3348144073', N'E545L', N'user_no12', N'63Q38IrHQ6', 1, 14)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (15, N'Dana Franklin', 1, CAST(N'1965-08-28' AS Date), N'Bookie_User13@qa.team', N'0621966375', N'E501R', N'user_no13', N'2n70PtX3x3', 1, 15)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (16, N'Elluka Bush', 0, CAST(N'1996-11-19' AS Date), N'Bookie_User14@qa.team', N'5303149491', N'E329R', N'user_no14', N'656H6NLX8R', 1, 16)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (17, N'Kenelm Binder', 1, CAST(N'1962-04-16' AS Date), N'Bookie_User15@qa.team', N'8319378641', N'E300R', N'user_no15', N'EaMR6k40vW', 2, 17)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (18, N'Narcissus Freezis', 0, CAST(N'2000-02-19' AS Date), N'Bookie_User16@qa.team', N'5209703781', N'C223R', N'user_no16', N'pC0EkBn3S7', 2, 18)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (19, N'Michelle Reynolds', 0, CAST(N'1996-05-24' AS Date), N'Bookie_User17@qa.team', N'9960504670', N'A076L', N'user_no17', N'j75wC2vU9T', 2, 19)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (20, N'Callie Banica', 0, CAST(N'2003-03-28' AS Date), N'Bookie_User18@qa.team', N'6314402583', N'B591L', N'user_no18', N'AdqKEjAvT2', 1, 20)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (21, N'Malceria Freezis', 0, CAST(N'1992-02-20' AS Date), N'Bookie_User19@qa.team', N'2483694818', N'E536R', N'user_no19', N'40PC98quFo', 1, 21)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (22, N'Jasmine Shepard', 1, CAST(N'1973-08-09' AS Date), N'Bookie_User20@qa.team', N'9780125454', N'C555L', N'user_no20', N'6G6nwxj3XG', 0, 22)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (23, N'Mia Franklin', 0, CAST(N'1970-04-02' AS Date), N'Bookie_User21@qa.team', N'5381738475', N'B033R', N'user_no21', N'FCKNmmEX80', 1, 23)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (24, N'Schick Reyes', 1, CAST(N'2001-09-15' AS Date), N'Bookie_User22@qa.team', N'2832297215', N'F554R', N'user_no22', N'xNWW1u0t5t', 1, 24)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (25, N'Allen Reese', 1, CAST(N'1985-02-09' AS Date), N'Bookie_User23@qa.team', N'5189606718', N'E434R', N'user_no23', N'6pRG2f75Xu', 1, 25)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (26, N'Elman Baxter', 0, CAST(N'1990-08-29' AS Date), N'Bookie_User24@qa.team', N'4250803384', N'F399L', N'user_no24', N'V0N5FSoh48', 1, 26)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (27, N'Willard Jordan', 0, CAST(N'1962-08-23' AS Date), N'Bookie_User25@qa.team', N'8546595378', N'C249R', N'user_no25', N'KNTpXU0UKv', 1, 27)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (28, N'Winona Walton', 1, CAST(N'1972-06-28' AS Date), N'Bookie_User26@qa.team', N'2154390483', N'A271R', N'user_no26', N'0jxj5IEv81', 1, 28)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (29, N'Sophia Knight', 1, CAST(N'1984-03-09' AS Date), N'Bookie_User27@qa.team', N'8607919741', N'A014L', N'user_no27', N'A4fN001VmH', 1, 29)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (30, N'Hank Wade', 0, CAST(N'1965-03-12' AS Date), N'Bookie_User28@qa.team', N'7523062315', N'D388R', N'user_no28', N'2Bfmh791kK', 0, 30)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (31, N'Mia Dinwiddie', 0, CAST(N'1999-02-28' AS Date), N'Bookie_User29@qa.team', N'0246122286', N'F208L', N'user_no29', N'NOxv1OoN1e', 1, 31)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (32, N'Ronald Chandler', 1, CAST(N'1997-10-31' AS Date), N'Bookie_User30@qa.team', N'2828181439', N'E367R', N'user_no30', N'w46Ju1i8L9', 1, 32)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (33, N'Elluka Ackerman', 1, CAST(N'1981-04-17' AS Date), N'Bookie_User31@qa.team', N'9156318073', N'D567R', N'user_no31', N'5uF4wFljD4', 1, 33)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (34, N'Jude Gilbert', 1, CAST(N'1981-11-09' AS Date), N'Bookie_User32@qa.team', N'0169512308', N'F273R', N'user_no32', N'FFdch7h6LS', 0, 34)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (35, N'Philbert Schultz', 0, CAST(N'1989-01-22' AS Date), N'Bookie_User33@qa.team', N'6849016541', N'C488R', N'user_no33', N'4779u17pT0', 1, 35)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (36, N'Lamia Fowler', 0, CAST(N'1967-11-26' AS Date), N'Bookie_User34@qa.team', N'2741015314', N'A021R', N'user_no34', N'hMtBqGhT7W', 1, 36)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (37, N'Gererd Pope', 1, CAST(N'1997-01-03' AS Date), N'Bookie_User35@qa.team', N'3065738164', N'C082R', N'user_no35', N'FUKg17DIa2', 1, 37)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (38, N'Thetal Shepard', 1, CAST(N'1999-05-29' AS Date), N'Bookie_User36@qa.team', N'9823201684', N'B218R', N'user_no36', N'CQ29Nd4kw3', 2, 38)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (39, N'Yocaski Blossom', 0, CAST(N'1968-06-03' AS Date), N'Bookie_User37@qa.team', N'8540069619', N'B203L', N'user_no37', N'IMlu2mqOpO', 2, 39)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (40, N'Danielle Hodges', 1, CAST(N'1987-07-08' AS Date), N'Bookie_User38@qa.team', N'6019926882', N'C533L', N'user_no38', N'0EHMq4RtiX', 1, 40)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (41, N'Darlene Feron', 0, CAST(N'1979-01-25' AS Date), N'Bookie_User39@qa.team', N'1335700997', N'D352L', N'user_no39', N'q6D9MT721A', 1, 41)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (42, N'Hadden Chandler', 0, CAST(N'2001-10-30' AS Date), N'Bookie_User40@qa.team', N'6968727500', N'C048R', N'user_no40', N'ihctjAx8Ca', 1, 42)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (43, N'Sateriasis Hardy', 1, CAST(N'1996-06-13' AS Date), N'Bookie_User41@qa.team', N'2222683128', N'B011L', N'user_no41', N'Q5nX178217', 1, 43)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (44, N'Mia Carpenter', 1, CAST(N'1969-10-24' AS Date), N'Bookie_User42@qa.team', N'7098290406', N'C121L', N'user_no42', N'7TN6q8oT22', 1, 44)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (45, N'Kit Nerune', 1, CAST(N'1986-06-20' AS Date), N'Bookie_User43@qa.team', N'8061375590', N'E086R', N'user_no43', N'D5OmM2G0Hf', 0, 45)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (46, N'Rodolphe Frost', 0, CAST(N'1991-10-11' AS Date), N'Bookie_Admin44@qa.team', N'8079576071', N'B166L', N'user_no44', N'633fiUne77', 0, 46)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (47, N'Jesse Watts', 1, CAST(N'1962-01-09' AS Date), N'Bookie_User45@qa.team', N'6734813546', N'A079R', N'user_no45', N'8xKCPgxkG6', 1, 47)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (48, N'Carl Crawford', 0, CAST(N'1966-09-23' AS Date), N'Bookie_User46@qa.team', N'9164323101', N'A587R', N'user_no46', N'8Ogl6495GC', 1, 48)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (49, N'Ronald Robinett', 1, CAST(N'1975-09-13' AS Date), N'Bookie_User47@qa.team', N'1939248911', N'F056L', N'user_no47', N'9nvm39FdG4', 0, 49)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (50, N'Zera Stanley', 1, CAST(N'1962-06-22' AS Date), N'Bookie_Admin48@qa.team', N'3023618105', N'A242L', N'user_no48', N'WV2x0jNQL8', 1, 50)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (51, N'Harley Avadonia', 1, CAST(N'1998-05-30' AS Date), N'Bookie_User49@qa.team', N'2549882790', N'A524L', N'user_no49', N'63XQKOsfP5', 1, 51)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (52, N'Butglar Gray', 0, CAST(N'2001-11-07' AS Date), N'Bookie_User50@qa.team', N'7015229259', N'E391L', N'user_no50', N't6NaNclluX', 2, 52)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (53, N'Joe Baxter', 1, CAST(N'1978-05-19' AS Date), N'Bookie_User51@qa.team', N'8763978419', N'C297R', N'user_no51', N'10VLDxiejW', 1, 53)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (54, N'Ward Wagner', 0, CAST(N'1995-02-15' AS Date), N'Bookie_User52@qa.team', N'2458631214', N'F312L', N'user_no52', N'JaWagx8363', 0, 54)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (55, N'Charlie Reese', 1, CAST(N'1978-11-07' AS Date), N'Bookie_User53@qa.team', N'8751908426', N'B598R', N'user_no53', N'0gT2B1b3uX', 1, 55)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (56, N'Windsor Dinwiddie', 0, CAST(N'1988-01-22' AS Date), N'Bookie_User54@qa.team', N'0217649643', N'D467R', N'user_no54', N'BvR10X7Be7', 0, 56)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (57, N'Charon Walton', 0, CAST(N'1965-05-05' AS Date), N'Bookie_User55@qa.team', N'3488293409', N'A094L', N'user_no55', N'gQ5mp7Ln9B', 2, 57)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (58, N'Hank Michaelis', 1, CAST(N'1994-07-09' AS Date), N'Bookie_User56@qa.team', N'2886762525', N'F063R', N'user_no56', N'VKeuCjdDo7', 0, 58)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (59, N'Seth Manning', 1, CAST(N'1973-05-06' AS Date), N'Bookie_User57@qa.team', N'7193619411', N'B266R', N'user_no57', N'9B8txaGLUn', 0, 59)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (60, N'Seth Manning', 0, CAST(N'1978-12-07' AS Date), N'Bookie_User58@qa.team', N'3562422001', N'B018R', N'user_no58', N'P3VOu0cHE9', 0, 60)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (61, N'Light Jenning', 0, CAST(N'1992-12-11' AS Date), N'Bookie_User59@qa.team', N'5399302391', N'F278R', N'user_no59', N'5MOL5X7w2m', 0, 61)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (62, N'David Barisol', 1, CAST(N'1962-04-12' AS Date), N'Bookie_Admin60@qa.team', N'1262618674', N'C060L', N'user_no60', N'cAEscuX0bp', 1, 62)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (63, N'Michaela Kelley', 1, CAST(N'1988-11-13' AS Date), N'Bookie_Admin61@qa.team', N'9181933819', N'C120L', N'user_no61', N'c3Kp2w1ePD', 1, 63)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (64, N'Melody Elphen', 1, CAST(N'1981-12-04' AS Date), N'Bookie_User62@qa.team', N'8636081048', N'F542R', N'user_no62', N'L0nU3qkIqD', 0, 64)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (65, N'Elluka Norman', 0, CAST(N'1991-03-07' AS Date), N'Bookie_User63@qa.team', N'6646101635', N'F258L', N'user_no63', N'8b6k4lf3bX', 0, 65)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (66, N'Strange Feron', 0, CAST(N'1998-01-10' AS Date), N'Bookie_User64@qa.team', N'1135823939', N'F393R', N'user_no64', N'V36337U7LQ', 2, 66)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (67, N'Taylor Valdez', 1, CAST(N'1991-12-03' AS Date), N'Bookie_User65@qa.team', N'3733355471', N'E585L', N'user_no65', N'TRQjooaqPE', 0, 67)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (68, N'Dana Macy', 0, CAST(N'1990-10-11' AS Date), N'Bookie_User66@qa.team', N'8754299135', N'F407L', N'user_no66', N'1LjH434D2f', 0, 68)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (69, N'Jean Valdez', 0, CAST(N'1982-10-15' AS Date), N'Bookie_User67@qa.team', N'9735839086', N'D407L', N'user_no67', N'30uboLi0pq', 0, 69)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (70, N'Minis Goodwin', 1, CAST(N'2003-06-05' AS Date), N'Bookie_User68@qa.team', N'9113433152', N'C176L', N'user_no68', N'6HgQhX4vAS', 0, 70)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (71, N'Clay Marlon', 0, CAST(N'1976-01-03' AS Date), N'Bookie_User69@qa.team', N'8151717641', N'F276L', N'user_no69', N'h8b6Ks3aHG', 0, 71)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (72, N'Phil Powers', 1, CAST(N'2002-07-26' AS Date), N'Bookie_User70@qa.team', N'0859547485', N'E327L', N'user_no70', N'RGGX9xaFd9', 0, 72)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (73, N'Butglar Hardy', 0, CAST(N'1985-06-29' AS Date), N'Bookie_User71@qa.team', N'9494816505', N'F150L', N'user_no71', N'SuC0uP5MWc', 0, 73)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (74, N'Camelia Mullins', 1, CAST(N'1977-10-10' AS Date), N'Bookie_User72@qa.team', N'2264980236', N'D302R', N'user_no72', N'37ov3LQvr5', 0, 74)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (75, N'Lionel Stanley', 1, CAST(N'1976-07-15' AS Date), N'Bookie_User73@qa.team', N'2592270859', N'F134R', N'user_no73', N'fagIRa8sd2', 0, 75)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (76, N'Linda Payne', 1, CAST(N'1967-07-05' AS Date), N'Bookie_User74@qa.team', N'2138430999', N'E582L', N'user_no74', N'R6DhW5Us1U', 0, 76)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (77, N'Philbert Cross', 1, CAST(N'1978-02-10' AS Date), N'Bookie_User75@qa.team', N'7912138173', N'A244R', N'user_no75', N'4FbN3eR914', 0, 77)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (78, N'Phil Jordan', 1, CAST(N'1998-09-09' AS Date), N'Bookie_User76@qa.team', N'3171032506', N'D582L', N'user_no76', N'4HoS1o8LiQ', 0, 78)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (79, N'Robert Kissos', 1, CAST(N'1989-04-12' AS Date), N'Bookie_Admin77@qa.team', N'8210911505', N'B322R', N'user_no77', N'44h7516veR', 1, 79)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (80, N'Ronald Rios', 1, CAST(N'1974-04-27' AS Date), N'Bookie_Admin78@qa.team', N'1230714908', N'E391L', N'user_no78', N'XcT993M91U', 1, 80)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (81, N'Elluka Manning', 1, CAST(N'1978-01-13' AS Date), N'Bookie_User79@qa.team', N'4453821425', N'D520L', N'user_no79', N'13NMusTvTs', 0, 81)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (82, N'Ceil Payne', 1, CAST(N'1981-01-25' AS Date), N'Bookie_User80@qa.team', N'5169407308', N'B558R', N'user_no80', N'm1lSpbnxKR', 0, 82)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (83, N'Lizzy Meld', 0, CAST(N'1974-03-29' AS Date), N'Bookie_User81@qa.team', N'7971588225', N'E401L', N'user_no81', N'CQ625H6cpM', 0, 83)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (84, N'Camelia Miller', 0, CAST(N'1995-10-05' AS Date), N'Bookie_User82@qa.team', N'6418028724', N'D425R', N'user_no82', N'kx9qI8Lrpn', 0, 84)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (85, N'Diana Macy', 0, CAST(N'1987-06-15' AS Date), N'Bookie_User83@qa.team', N'0392517157', N'C064L', N'user_no83', N'NOLEd7ip6u', 0, 85)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (86, N'Windsor Badman', 1, CAST(N'1963-04-23' AS Date), N'Bookie_User84@qa.team', N'2211777973', N'B225L', N'user_no84', N'Oq52kK54Wt', 0, 86)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (87, N'Diana Obrien', 0, CAST(N'1965-09-05' AS Date), N'Bookie_User85@qa.team', N'5234651834', N'B266R', N'user_no85', N'Xg48U9vViT', 1, 87)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (88, N'Adam Hodges', 1, CAST(N'1991-09-17' AS Date), N'Bookie_User86@qa.team', N'8244422163', N'F547L', N'user_no86', N'69OblisKtI', 1, 88)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (89, N'Hansel May', 1, CAST(N'1963-04-10' AS Date), N'Bookie_User87@qa.team', N'0832781475', N'B408L', N'user_no87', N'6k69wo0082', 1, 89)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (90, N'Oswald Pope', 0, CAST(N'2003-06-25' AS Date), N'Bookie_User88@qa.team', N'5045023619', N'B063R', N'user_no88', N'8V0cXHnT2m', 1, 90)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (91, N'Alex Hardy', 1, CAST(N'1975-08-25' AS Date), N'Bookie_User89@qa.team', N'2345729992', N'D066R', N'user_no89', N'42RAMiQXtP', 2, 91)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (92, N'Butglar Michaelis', 0, CAST(N'1973-11-06' AS Date), N'Bookie_User90@qa.team', N'0368248093', N'C055L', N'user_no90', N'tIh5JIP0wO', 1, 92)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (93, N'Elman Blair', 1, CAST(N'1976-07-19' AS Date), N'Bookie_User91@qa.team', N'2461908732', N'A427R', N'user_no91', N'UnoMh1cNLM', 1, 93)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (94, N'Lucifer Blair', 0, CAST(N'1983-01-08' AS Date), N'Bookie_User92@qa.team', N'1323033244', N'A500L', N'user_no92', N'BAobhPn8q3', 0, 94)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (95, N'Philbert Phantomhive', 0, CAST(N'1991-03-23' AS Date), N'Bookie_User93@qa.team', N'3364836425', N'B478R', N'user_no93', N'N7946Sgcp7', 1, 95)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (96, N'Albion Alexdander', 1, CAST(N'1990-10-28' AS Date), N'Bookie_User94@qa.team', N'9179724841', N'A044R', N'user_no94', N'Aom68vB96X', 1, 96)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (97, N'Melody Chandler', 1, CAST(N'1963-12-30' AS Date), N'Bookie_User95@qa.team', N'5587772688', N'A579L', N'user_no95', N'n7q1WnuD8L', 1, 97)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (98, N'Katya Corbyn', 0, CAST(N'1969-12-31' AS Date), N'Bookie_User96@qa.team', N'7693285889', N'D506R', N'user_no96', N'5M5g7rO37L', 1, 98)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (99, N'Rahab Octo', 0, CAST(N'1989-05-01' AS Date), N'Bookie_User97@qa.team', N'5723628843', N'A079L', N'user_no97', N'38622s3j03', 1, 99)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (100, N'Hansel May', 1, CAST(N'2003-06-22' AS Date), N'Bookie_User98@qa.team', N'0343057780', N'E443R', N'user_no98', N'1oST7ll09m', 1, 100)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (101, N'Luke Thayne', 0, CAST(N'1989-10-15' AS Date), N'Bookie_User99@qa.team', N'0889839198', N'D114L', N'user_no99', N'IK7S0hEEW1', 1, 101)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (102, N'Cyril Watson', 0, CAST(N'1999-02-15' AS Date), N'Bookie_User100@qa.team', N'5859588913', N'F550R', N'user_no100', N'aBaQq4bHD0', 1, 102)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (109, N'I Am Tester', 1, CAST(N'2002-01-01' AS Date), N'Bookie_User200@qa.team', N'0987654321', NULL, N'tester', N'test', 1, 109)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super], [walletNumber]) VALUES (110, N'Test Author', 0, CAST(N'2011-12-13' AS Date), N'Bookie_Author1@qa.team', N'0963852741', NULL, N'autester', N'test_author1', 2, 110)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Volume] ON 
GO
INSERT [dbo].[Volume] ([id], [bookId], [no], [title], [summary]) VALUES (1, 1, 1, N'Part One: BOY LOSES GIRL', NULL)
GO
INSERT [dbo].[Volume] ([id], [bookId], [no], [title], [summary]) VALUES (2, 1, 2, N'Part Two: Boy Meets Girl', NULL)
GO
INSERT [dbo].[Volume] ([id], [bookId], [no], [title], [summary]) VALUES (3, 1, 3, N'Part Three Boy Gets Girl Back (Or Vice Versa)', NULL)
GO
SET IDENTITY_INSERT [dbo].[Volume] OFF
GO
ALTER TABLE [dbo].[Book] ADD  DEFAULT ((0)) FOR [favourite]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Book__views__30F848ED]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[Book] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__is_super__31EC6D26]  DEFAULT ((1)) FOR [is_super]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_balance]  DEFAULT ((0)) FOR [walletNumber]
GO
ALTER TABLE [dbo].[Author]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Author]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
<<<<<<< Updated upstream
ALTER TABLE [dbo].[CategoryBook]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [CategoryBook] with check add foreign key  ([bookId]) 
references [Book] ([id])
GO
=======
>>>>>>> Stashed changes
ALTER TABLE [dbo].[Book_Own]  WITH CHECK ADD  CONSTRAINT [FK_Book_Own_Book] FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Book_Own] CHECK CONSTRAINT [FK_Book_Own_Book]
GO
ALTER TABLE [dbo].[Book_Own]  WITH CHECK ADD  CONSTRAINT [FK_Book_Own_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Book_Own] CHECK CONSTRAINT [FK_Book_Own_User]
GO
ALTER TABLE [dbo].[CategoryBook]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[CategoryBook]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([volumeId])
REFERENCES [dbo].[Volume] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Chapter_Own]  WITH CHECK ADD FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapter] ([id])
GO
ALTER TABLE [dbo].[Chapter_Own]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
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
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([reportId])
REFERENCES [dbo].[Report] ([id])
GO
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
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
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Payment_Method] FOREIGN KEY([paymentId])
REFERENCES [dbo].[Payment_Method] ([paymentId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Payment_Method]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_User]
GO
ALTER TABLE [dbo].[Transaction_Token]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Token_Transaction] FOREIGN KEY([transactionId])
REFERENCES [dbo].[Transaction] ([transactionId])
GO
ALTER TABLE [dbo].[Transaction_Token] CHECK CONSTRAINT [FK_Transaction_Token_Transaction]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Payment_Account] FOREIGN KEY([walletNumber])
REFERENCES [dbo].[Payment_Account] ([accountNumber])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Payment_Account]
GO
ALTER TABLE [dbo].[Volume]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
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