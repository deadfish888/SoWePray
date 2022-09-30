USE [master]
GO
/****** Object:  Database [BOOKIE] ******/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BOOKIE')
BEGIN
	ALTER DATABASE [BOOKIE] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [BOOKIE] SET ONLINE;
	DROP DATABASE [BOOKIE];
END
GO
CREATE DATABASE [BOOKIE]

ALTER DATABASE [BOOKIE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BOOKIE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BOOKIE] SET ANSI_NULL_DEFAULT OFF 
ALTER DATABASE [BOOKIE] SET ANSI_NULLS OFF 
ALTER DATABASE [BOOKIE] SET ANSI_PADDING OFF 
ALTER DATABASE [BOOKIE] SET ANSI_WARNINGS OFF 
ALTER DATABASE [BOOKIE] SET ARITHABORT OFF 
ALTER DATABASE [BOOKIE] SET AUTO_CLOSE OFF 
ALTER DATABASE [BOOKIE] SET AUTO_SHRINK OFF 
ALTER DATABASE [BOOKIE] SET AUTO_UPDATE_STATISTICS ON 
ALTER DATABASE [BOOKIE] SET CURSOR_CLOSE_ON_COMMIT OFF 
ALTER DATABASE [BOOKIE] SET CURSOR_DEFAULT  GLOBAL 
ALTER DATABASE [BOOKIE] SET CONCAT_NULL_YIELDS_NULL OFF 
ALTER DATABASE [BOOKIE] SET NUMERIC_ROUNDABORT OFF 
ALTER DATABASE [BOOKIE] SET QUOTED_IDENTIFIER OFF 
ALTER DATABASE [BOOKIE] SET RECURSIVE_TRIGGERS OFF 
ALTER DATABASE [BOOKIE] SET  ENABLE_BROKER 
ALTER DATABASE [BOOKIE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
ALTER DATABASE [BOOKIE] SET DATE_CORRELATION_OPTIMIZATION OFF 
ALTER DATABASE [BOOKIE] SET TRUSTWORTHY OFF 
ALTER DATABASE [BOOKIE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
ALTER DATABASE [BOOKIE] SET PARAMETERIZATION SIMPLE 
ALTER DATABASE [BOOKIE] SET READ_COMMITTED_SNAPSHOT OFF 
ALTER DATABASE [BOOKIE] SET HONOR_BROKER_PRIORITY OFF 
ALTER DATABASE [BOOKIE] SET RECOVERY FULL 
ALTER DATABASE [BOOKIE] SET  MULTI_USER 
ALTER DATABASE [BOOKIE] SET PAGE_VERIFY CHECKSUM  
ALTER DATABASE [BOOKIE] SET DB_CHAINING OFF 
ALTER DATABASE [BOOKIE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
ALTER DATABASE [BOOKIE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
ALTER DATABASE [BOOKIE] SET DELAYED_DURABILITY = DISABLED 
ALTER DATABASE [BOOKIE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
ALTER DATABASE [BOOKIE] SET QUERY_STORE = OFF
EXEC sys.sp_db_vardecimal_storage_format N'BOOKIE', N'ON'
GO
USE [BOOKIE]
GO
/****** Object:  Table [dbo].[book]    BOOKIE ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[id] int IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100),
	[author] [nvarchar](80),
	[categoryid] int,
	[rating] decimal(10,2),
	[favourite] int,
	[price] decimal(10,2),
	[is_sale] bit,
	[image] [varchar](4000),
	[description] nvarchar(4000),
	[views] int,
	[status] bit,
 CONSTRAINT [PK_book] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    BOOKIE ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] int identity(1,1) not null,
	[name] [nvarchar](100),
	 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] int IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](50),
	[gender] [bit],
	[dob] [date],
	[email] [varchar](50) not NULL,
	[phone] [varchar](11) NULL,
	[address] [nvarchar](200) NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[is_super] [bit] NOT NULL
CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourite]    BOOKIE ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourite](
	[uid] int not null,
	[bid] int not null,
	 CONSTRAINT [PK_favourite] PRIMARY KEY CLUSTERED 
(
	[uid],bid ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[User] (id)
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Book] (id)
/****** Object:  Table [dbo].[Star]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Star](
	[bid] int not null,
	[uid] int not null,
	[star] int not null,
	CONSTRAINT [PK_star] PRIMARY KEY CLUSTERED 
(
	[uid],bid ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Book] (id)
ALTER TABLE [dbo].[Star]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[User] (id)
ALTER TABLE [dbo].[Star]  WITH CHECK ADD constraint chk_star check (star between 1 and 5)
/****** Object:  Table [dbo].[Star]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Token](
	[userId] int not null,
	[token] [varchar](20) not null,
	[expiredDate] datetime not null
	)
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] (id)

/****** Object:  Table [dbo].[Volume]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Volume](
	[id] int IDENTITY(1,1) not null,
	[bookId] int not null,
	[volume] int not null,
	[volumeName] nvarchar(100),
	[summary] nvarchar(2000),
	CONSTRAINT [PK_vol] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Volume]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] (id)
/****** Object:  Table [dbo].[Chapter]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Chapter](
	[id] int IDENTITY(1,1) not null,
	[bookId] int not null,
	[volumeId] int not null,
	[chapter] int not null,
	[chapterName] nvarchar(100),
	[status] bit not null,
	CONSTRAINT [PK_chapter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([volumeId])
REFERENCES [dbo].[Volume] ([id])
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
/****** Object:  Table [dbo].[Content]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Content](
	[chapterId] int not null,
	[paragraph] int not null,
	content ntext
	)
Go
ALTER TABLE [dbo].[Content]  WITH CHECK ADD FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapter] ([id])

/****** Object:  Table [dbo].[Transaction]    BOOKIE ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[userId] [int] NOT NULL,
	[balanceBefore] [bigint] NOT NULL,
	[amount] [bigint] NOT NULL,
	[balanceAfter] [bigint] NOT NULL,
	[transactionTime] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[status] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
---------------------------------------------------
ALTER TABLE [dbo].[Book] ADD  DEFAULT (0) FOR [views]

ALTER TABLE [dbo].[Book] ADD  DEFAULT (0) FOR [favourite]

ALTER TABLE [dbo].[Book] ADD  DEFAULT (1) FOR [status]

ALTER TABLE [dbo].[User] ADD  DEFAULT (0) FOR [is_super]

--ALTER TABLE [dbo].[Book] ADD  DEFAULT ('UNDECIDED') FOR [type]


--ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(did)
--REFERENCES [dbo].[Discount] (id)
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(categoryid)
REFERENCES [dbo].[Category] (id)
GO

--ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [CK_user_id] CHECK  (([user_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [user_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))
Insert [dbo].[Category] ([name]) values (N'Crime, Thriller & Mystery'),(N'Fantasy, Horror'),(N'Science/Historical Fiction'),(N'Manga&LN')
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (1, N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhnthe163219@fpt.edu.vn', N'0382132025', N'FBT University ', N'admin', N'admin', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (2, N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhvn102@gmail.com', N'0382132025', N'FBT University ', N'vinh', N'2002', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (3, N'Ivory Marcel', 0, CAST(N'1969-09-20' AS Date), N'Bookie_User1@qa.team', N'6128170843', N'E312R', N'user_no1', N'9v9SJ2gqt1', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (4, N'Mary Barisol', 1, CAST(N'1970-02-16' AS Date), N'Bookie_User2@qa.team', N'7134690959', N'F012R', N'user_no2', N'i64LIeOm56', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (5, N'Eden Frost', 1, CAST(N'1984-03-13' AS Date), N'Bookie_User3@qa.team', N'8252042139', N'B438R', N'user_no3', N'IMG2x1T1iv', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (6, N'Benidict Robinett', 1, CAST(N'1966-02-10' AS Date), N'Bookie_User4@qa.team', N'3999059789', N'A400R', N'user_no4', N'mq8q4KfNjV', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (7, N'Zera Farmer', 0, CAST(N'1961-02-10' AS Date), N'Bookie_Admin5@qa.team', N'5706825096', N'E271R', N'user_no5', N'2bh7UnCPxT', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (8, N'Ceil Howell', 1, CAST(N'1992-09-16' AS Date), N'Bookie_User6@qa.team', N'5374439245', N'C146R', N'user_no6', N'kURf75I4QQ', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (9, N'Taylor Marcel', 0, CAST(N'2000-09-04' AS Date), N'Bookie_User7@qa.team', N'9180387665', N'E402L', N'user_no7', N'1FF4G03cId', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (10, N'Wisley Ray', 1, CAST(N'1971-10-28' AS Date), N'Bookie_User8@qa.team', N'8155814231', N'B398R', N'user_no8', N'T4dI4P82Ab', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (11, N'Aiken Pope', 1, CAST(N'1979-05-01' AS Date), N'Bookie_User9@qa.team', N'7770308417', N'F421L', N'user_no9', N'op6An5T76g', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (12, N'Rodolphe Blossom', 1, CAST(N'2001-02-19' AS Date), N'Bookie_User10@qa.team', N'6610856429', N'A168L', N'user_no10', N'2203lupus8', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (13, N'Alex Rogze', 0, CAST(N'1987-08-07' AS Date), N'Bookie_Admin11@qa.team', N'9326626549', N'B508R', N'user_no11', N'Lngixrl107', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (14, N'Jean Padilla', 1, CAST(N'1967-11-16' AS Date), N'Bookie_User12@qa.team', N'3348144073', N'E545L', N'user_no12', N'63Q38IrHQ6', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (15, N'Dana Franklin', 1, CAST(N'1965-08-28' AS Date), N'Bookie_User13@qa.team', N'0621966375', N'E501R', N'user_no13', N'2n70PtX3x3', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (16, N'Elluka Bush', 0, CAST(N'1996-11-19' AS Date), N'Bookie_User14@qa.team', N'5303149491', N'E329R', N'user_no14', N'656H6NLX8R', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (17, N'Kenelm Binder', 1, CAST(N'1962-04-16' AS Date), N'Bookie_User15@qa.team', N'8319378641', N'E300R', N'user_no15', N'EaMR6k40vW', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (18, N'Narcissus Freezis', 0, CAST(N'2000-02-19' AS Date), N'Bookie_User16@qa.team', N'5209703781', N'C223R', N'user_no16', N'pC0EkBn3S7', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (19, N'Michelle Reynolds', 0, CAST(N'1996-05-24' AS Date), N'Bookie_User17@qa.team', N'9960504670', N'A076L', N'user_no17', N'j75wC2vU9T', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (20, N'Callie Banica', 0, CAST(N'2003-03-28' AS Date), N'Bookie_User18@qa.team', N'6314402583', N'B591L', N'user_no18', N'AdqKEjAvT2', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (21, N'Malceria Freezis', 0, CAST(N'1992-02-20' AS Date), N'Bookie_User19@qa.team', N'2483694818', N'E536R', N'user_no19', N'40PC98quFo', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (22, N'Jasmine Shepard', 1, CAST(N'1973-08-09' AS Date), N'Bookie_User20@qa.team', N'9780125454', N'C555L', N'user_no20', N'6G6nwxj3XG', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (23, N'Mia Franklin', 0, CAST(N'1970-04-02' AS Date), N'Bookie_User21@qa.team', N'5381738475', N'B033R', N'user_no21', N'FCKNmmEX80', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (24, N'Schick Reyes', 1, CAST(N'2001-09-15' AS Date), N'Bookie_User22@qa.team', N'2832297215', N'F554R', N'user_no22', N'xNWW1u0t5t', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (25, N'Allen Reese', 1, CAST(N'1985-02-09' AS Date), N'Bookie_User23@qa.team', N'5189606718', N'E434R', N'user_no23', N'6pRG2f75Xu', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (26, N'Elman Baxter', 0, CAST(N'1990-08-29' AS Date), N'Bookie_User24@qa.team', N'4250803384', N'F399L', N'user_no24', N'V0N5FSoh48', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (27, N'Willard Jordan', 0, CAST(N'1962-08-23' AS Date), N'Bookie_User25@qa.team', N'8546595378', N'C249R', N'user_no25', N'KNTpXU0UKv', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (28, N'Winona Walton', 1, CAST(N'1972-06-28' AS Date), N'Bookie_User26@qa.team', N'2154390483', N'A271R', N'user_no26', N'0jxj5IEv81', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (29, N'Sophia Knight', 1, CAST(N'1984-03-09' AS Date), N'Bookie_User27@qa.team', N'8607919741', N'A014L', N'user_no27', N'A4fN001VmH', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (30, N'Hank Wade', 0, CAST(N'1965-03-12' AS Date), N'Bookie_User28@qa.team', N'7523062315', N'D388R', N'user_no28', N'2Bfmh791kK', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (31, N'Mia Dinwiddie', 0, CAST(N'1999-02-28' AS Date), N'Bookie_User29@qa.team', N'0246122286', N'F208L', N'user_no29', N'NOxv1OoN1e', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (32, N'Ronald Chandler', 1, CAST(N'1997-10-31' AS Date), N'Bookie_User30@qa.team', N'2828181439', N'E367R', N'user_no30', N'w46Ju1i8L9', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (33, N'Elluka Ackerman', 1, CAST(N'1981-04-17' AS Date), N'Bookie_User31@qa.team', N'9156318073', N'D567R', N'user_no31', N'5uF4wFljD4', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (34, N'Jude Gilbert', 1, CAST(N'1981-11-09' AS Date), N'Bookie_User32@qa.team', N'0169512308', N'F273R', N'user_no32', N'FFdch7h6LS', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (35, N'Philbert Schultz', 0, CAST(N'1989-01-22' AS Date), N'Bookie_User33@qa.team', N'6849016541', N'C488R', N'user_no33', N'4779u17pT0', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (36, N'Lamia Fowler', 0, CAST(N'1967-11-26' AS Date), N'Bookie_User34@qa.team', N'2741015314', N'A021R', N'user_no34', N'hMtBqGhT7W', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (37, N'Gererd Pope', 1, CAST(N'1997-01-03' AS Date), N'Bookie_User35@qa.team', N'3065738164', N'C082R', N'user_no35', N'FUKg17DIa2', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (38, N'Thetal Shepard', 1, CAST(N'1999-05-29' AS Date), N'Bookie_User36@qa.team', N'9823201684', N'B218R', N'user_no36', N'CQ29Nd4kw3', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (39, N'Yocaski Blossom', 0, CAST(N'1968-06-03' AS Date), N'Bookie_User37@qa.team', N'8540069619', N'B203L', N'user_no37', N'IMlu2mqOpO', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (40, N'Danielle Hodges', 1, CAST(N'1987-07-08' AS Date), N'Bookie_User38@qa.team', N'6019926882', N'C533L', N'user_no38', N'0EHMq4RtiX', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (41, N'Darlene Feron', 0, CAST(N'1979-01-25' AS Date), N'Bookie_User39@qa.team', N'1335700997', N'D352L', N'user_no39', N'q6D9MT721A', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (42, N'Hadden Chandler', 0, CAST(N'2001-10-30' AS Date), N'Bookie_User40@qa.team', N'6968727500', N'C048R', N'user_no40', N'ihctjAx8Ca', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (43, N'Sateriasis Hardy', 1, CAST(N'1996-06-13' AS Date), N'Bookie_User41@qa.team', N'2222683128', N'B011L', N'user_no41', N'Q5nX178217', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (44, N'Mia Carpenter', 1, CAST(N'1969-10-24' AS Date), N'Bookie_User42@qa.team', N'7098290406', N'C121L', N'user_no42', N'7TN6q8oT22', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (45, N'Kit Nerune', 1, CAST(N'1986-06-20' AS Date), N'Bookie_User43@qa.team', N'8061375590', N'E086R', N'user_no43', N'D5OmM2G0Hf', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (46, N'Rodolphe Frost', 0, CAST(N'1991-10-11' AS Date), N'Bookie_Admin44@qa.team', N'8079576071', N'B166L', N'user_no44', N'633fiUne77', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (47, N'Jesse Watts', 1, CAST(N'1962-01-09' AS Date), N'Bookie_User45@qa.team', N'6734813546', N'A079R', N'user_no45', N'8xKCPgxkG6', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (48, N'Carl Crawford', 0, CAST(N'1966-09-23' AS Date), N'Bookie_User46@qa.team', N'9164323101', N'A587R', N'user_no46', N'8Ogl6495GC', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (49, N'Ronald Robinett', 1, CAST(N'1975-09-13' AS Date), N'Bookie_User47@qa.team', N'1939248911', N'F056L', N'user_no47', N'9nvm39FdG4', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (50, N'Zera Stanley', 1, CAST(N'1962-06-22' AS Date), N'Bookie_Admin48@qa.team', N'3023618105', N'A242L', N'user_no48', N'WV2x0jNQL8', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (51, N'Harley Avadonia', 1, CAST(N'1998-05-30' AS Date), N'Bookie_User49@qa.team', N'2549882790', N'A524L', N'user_no49', N'63XQKOsfP5', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (52, N'Butglar Gray', 0, CAST(N'2001-11-07' AS Date), N'Bookie_User50@qa.team', N'7015229259', N'E391L', N'user_no50', N't6NaNclluX', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (53, N'Joe Baxter', 1, CAST(N'1978-05-19' AS Date), N'Bookie_User51@qa.team', N'8763978419', N'C297R', N'user_no51', N'10VLDxiejW', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (54, N'Ward Wagner', 0, CAST(N'1995-02-15' AS Date), N'Bookie_User52@qa.team', N'2458631214', N'F312L', N'user_no52', N'JaWagx8363', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (55, N'Charlie Reese', 1, CAST(N'1978-11-07' AS Date), N'Bookie_User53@qa.team', N'8751908426', N'B598R', N'user_no53', N'0gT2B1b3uX', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (56, N'Windsor Dinwiddie', 0, CAST(N'1988-01-22' AS Date), N'Bookie_User54@qa.team', N'0217649643', N'D467R', N'user_no54', N'BvR10X7Be7', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (57, N'Charon Walton', 0, CAST(N'1965-05-05' AS Date), N'Bookie_User55@qa.team', N'3488293409', N'A094L', N'user_no55', N'gQ5mp7Ln9B', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (58, N'Hank Michaelis', 1, CAST(N'1994-07-09' AS Date), N'Bookie_User56@qa.team', N'2886762525', N'F063R', N'user_no56', N'VKeuCjdDo7', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (59, N'Seth Manning', 1, CAST(N'1973-05-06' AS Date), N'Bookie_User57@qa.team', N'7193619411', N'B266R', N'user_no57', N'9B8txaGLUn', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (60, N'Seth Manning', 0, CAST(N'1978-12-07' AS Date), N'Bookie_User58@qa.team', N'3562422001', N'B018R', N'user_no58', N'P3VOu0cHE9', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (61, N'Light Jenning', 0, CAST(N'1992-12-11' AS Date), N'Bookie_User59@qa.team', N'5399302391', N'F278R', N'user_no59', N'5MOL5X7w2m', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (62, N'David Barisol', 1, CAST(N'1962-04-12' AS Date), N'Bookie_Admin60@qa.team', N'1262618674', N'C060L', N'user_no60', N'cAEscuX0bp', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (63, N'Michaela Kelley', 1, CAST(N'1988-11-13' AS Date), N'Bookie_Admin61@qa.team', N'9181933819', N'C120L', N'user_no61', N'c3Kp2w1ePD', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (64, N'Melody Elphen', 1, CAST(N'1981-12-04' AS Date), N'Bookie_User62@qa.team', N'8636081048', N'F542R', N'user_no62', N'L0nU3qkIqD', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (65, N'Elluka Norman', 0, CAST(N'1991-03-07' AS Date), N'Bookie_User63@qa.team', N'6646101635', N'F258L', N'user_no63', N'8b6k4lf3bX', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (66, N'Strange Feron', 0, CAST(N'1998-01-10' AS Date), N'Bookie_User64@qa.team', N'1135823939', N'F393R', N'user_no64', N'V36337U7LQ', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (67, N'Taylor Valdez', 1, CAST(N'1991-12-03' AS Date), N'Bookie_User65@qa.team', N'3733355471', N'E585L', N'user_no65', N'TRQjooaqPE', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (68, N'Dana Macy', 0, CAST(N'1990-10-11' AS Date), N'Bookie_User66@qa.team', N'8754299135', N'F407L', N'user_no66', N'1LjH434D2f', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (69, N'Jean Valdez', 0, CAST(N'1982-10-15' AS Date), N'Bookie_User67@qa.team', N'9735839086', N'D407L', N'user_no67', N'30uboLi0pq', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (70, N'Minis Goodwin', 1, CAST(N'2003-06-05' AS Date), N'Bookie_User68@qa.team', N'9113433152', N'C176L', N'user_no68', N'6HgQhX4vAS', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (71, N'Clay Marlon', 0, CAST(N'1976-01-03' AS Date), N'Bookie_User69@qa.team', N'8151717641', N'F276L', N'user_no69', N'h8b6Ks3aHG', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (72, N'Phil Powers', 1, CAST(N'2002-07-26' AS Date), N'Bookie_User70@qa.team', N'0859547485', N'E327L', N'user_no70', N'RGGX9xaFd9', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (73, N'Butglar Hardy', 0, CAST(N'1985-06-29' AS Date), N'Bookie_User71@qa.team', N'9494816505', N'F150L', N'user_no71', N'SuC0uP5MWc', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (74, N'Camelia Mullins', 1, CAST(N'1977-10-10' AS Date), N'Bookie_User72@qa.team', N'2264980236', N'D302R', N'user_no72', N'37ov3LQvr5', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (75, N'Lionel Stanley', 1, CAST(N'1976-07-15' AS Date), N'Bookie_User73@qa.team', N'2592270859', N'F134R', N'user_no73', N'fagIRa8sd2', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (76, N'Linda Payne', 1, CAST(N'1967-07-05' AS Date), N'Bookie_User74@qa.team', N'2138430999', N'E582L', N'user_no74', N'R6DhW5Us1U', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (77, N'Philbert Cross', 1, CAST(N'1978-02-10' AS Date), N'Bookie_User75@qa.team', N'7912138173', N'A244R', N'user_no75', N'4FbN3eR914', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (78, N'Phil Jordan', 1, CAST(N'1998-09-09' AS Date), N'Bookie_User76@qa.team', N'3171032506', N'D582L', N'user_no76', N'4HoS1o8LiQ', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (79, N'Robert Kissos', 1, CAST(N'1989-04-12' AS Date), N'Bookie_Admin77@qa.team', N'8210911505', N'B322R', N'user_no77', N'44h7516veR', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (80, N'Ronald Rios', 1, CAST(N'1974-04-27' AS Date), N'Bookie_Admin78@qa.team', N'1230714908', N'E391L', N'user_no78', N'XcT993M91U', 1)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (81, N'Elluka Manning', 1, CAST(N'1978-01-13' AS Date), N'Bookie_User79@qa.team', N'4453821425', N'D520L', N'user_no79', N'13NMusTvTs', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (82, N'Ceil Payne', 1, CAST(N'1981-01-25' AS Date), N'Bookie_User80@qa.team', N'5169407308', N'B558R', N'user_no80', N'm1lSpbnxKR', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (83, N'Lizzy Meld', 0, CAST(N'1974-03-29' AS Date), N'Bookie_User81@qa.team', N'7971588225', N'E401L', N'user_no81', N'CQ625H6cpM', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (84, N'Camelia Miller', 0, CAST(N'1995-10-05' AS Date), N'Bookie_User82@qa.team', N'6418028724', N'D425R', N'user_no82', N'kx9qI8Lrpn', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (85, N'Diana Macy', 0, CAST(N'1987-06-15' AS Date), N'Bookie_User83@qa.team', N'0392517157', N'C064L', N'user_no83', N'NOLEd7ip6u', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (86, N'Windsor Badman', 1, CAST(N'1963-04-23' AS Date), N'Bookie_User84@qa.team', N'2211777973', N'B225L', N'user_no84', N'Oq52kK54Wt', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (87, N'Diana Obrien', 0, CAST(N'1965-09-05' AS Date), N'Bookie_User85@qa.team', N'5234651834', N'B266R', N'user_no85', N'Xg48U9vViT', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (88, N'Adam Hodges', 1, CAST(N'1991-09-17' AS Date), N'Bookie_User86@qa.team', N'8244422163', N'F547L', N'user_no86', N'69OblisKtI', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (89, N'Hansel May', 1, CAST(N'1963-04-10' AS Date), N'Bookie_User87@qa.team', N'0832781475', N'B408L', N'user_no87', N'6k69wo0082', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (90, N'Oswald Pope', 0, CAST(N'2003-06-25' AS Date), N'Bookie_User88@qa.team', N'5045023619', N'B063R', N'user_no88', N'8V0cXHnT2m', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (91, N'Alex Hardy', 1, CAST(N'1975-08-25' AS Date), N'Bookie_User89@qa.team', N'2345729992', N'D066R', N'user_no89', N'42RAMiQXtP', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (92, N'Butglar Michaelis', 0, CAST(N'1973-11-06' AS Date), N'Bookie_User90@qa.team', N'0368248093', N'C055L', N'user_no90', N'tIh5JIP0wO', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (93, N'Elman Blair', 1, CAST(N'1976-07-19' AS Date), N'Bookie_User91@qa.team', N'2461908732', N'A427R', N'user_no91', N'UnoMh1cNLM', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (94, N'Lucifer Blair', 0, CAST(N'1983-01-08' AS Date), N'Bookie_User92@qa.team', N'1323033244', N'A500L', N'user_no92', N'BAobhPn8q3', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (95, N'Philbert Phantomhive', 0, CAST(N'1991-03-23' AS Date), N'Bookie_User93@qa.team', N'3364836425', N'B478R', N'user_no93', N'N7946Sgcp7', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (96, N'Albion Alexdander', 1, CAST(N'1990-10-28' AS Date), N'Bookie_User94@qa.team', N'9179724841', N'A044R', N'user_no94', N'Aom68vB96X', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (97, N'Melody Chandler', 1, CAST(N'1963-12-30' AS Date), N'Bookie_User95@qa.team', N'5587772688', N'A579L', N'user_no95', N'n7q1WnuD8L', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (98, N'Katya Corbyn', 0, CAST(N'1969-12-31' AS Date), N'Bookie_User96@qa.team', N'7693285889', N'D506R', N'user_no96', N'5M5g7rO37L', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (99, N'Rahab Octo', 0, CAST(N'1989-05-01' AS Date), N'Bookie_User97@qa.team', N'5723628843', N'A079L', N'user_no97', N'38622s3j03', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (100, N'Hansel May', 1, CAST(N'2003-06-22' AS Date), N'Bookie_User98@qa.team', N'0343057780', N'E443R', N'user_no98', N'1oST7ll09m', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (101, N'Luke Thayne', 0, CAST(N'1989-10-15' AS Date), N'Bookie_User99@qa.team', N'0889839198', N'D114L', N'user_no99', N'IK7S0hEEW1', 0)
GO
INSERT [dbo].[User] ([id], [fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES (102, N'Cyril Watson', 0, CAST(N'1999-02-15' AS Date), N'Bookie_User100@qa.team', N'5859588913', N'F550R', N'user_no100', N'aBaQq4bHD0', 0)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (1, N'Gone Girl ', N'Gillian Flynn', 1, NULL, 12, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554086139l/19288043.jpg', N'Marriage can be a real killer.<br>
On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunne’s fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nick’s clever and beautiful wife disappears from their rented McMansion on the Mississippi River. Husband-of-the-Year Nick isn’t doing himself any favors with cringe-worthy daydreams about the slope and shape of his wife’s head, but passages from Amy''s diary reveal the alpha-girl perfectionist could have put anyone dangerously on edge. Under mounting pressure from the police and the media—as well as Amy’s fiercely doting parents—the town golden boy parades an endless series of lies, deceits, and inappropriate behavior. Nick is oddly evasive, and he’s definitely bitter—but is he really a killer?<br>
As the cops close in, every couple in town is soon wondering how well they know the one that they love. With his twin sister, Margo, at his side, Nick stands by his innocence. Trouble is, if Nick didn’t do it, where is that beautiful wife? And what was in that silvery gift box hidden in the back of her bedroom closet?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (2, N'And Then There Were None', N'Agatha Christie', 1, NULL, 20, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1638425885l/16299._SY475_.jpg', N'First, there were ten—a curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they''re unwilling to reveal—and a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:<br>
"Ten little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he''d stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none."<br>
When they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (3, N'The Silent Patient', N'Alex Michaelides', 1, NULL, 19, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1582759969l/40097951._SX318_.jpg', N'Alicia Berenson’s life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of London’s most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.<br>
Alicia’s refusal to talk, or give any kind of explanation, turns a domestic tragedy into something far grander, a mystery that captures the public imagination and casts Alicia into notoriety. The price of her art skyrockets, and she, the silent patient, is hidden away from the tabloids and spotlight at the Grove, a secure forensic unit in North London.<br>
Theo Faber is a criminal psychotherapist who has waited a long time for the opportunity to work with Alicia. His determination to get her to talk and unravel the mystery of why she shot her husband takes him down a twisting path into his own motivations—a search for the truth that threatens to consume him....', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (4, N'The Girl on the Train', N'Paula Hawkins', 1, NULL, 22, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1574805682l/22557272.jpg', N'Rachel catches the same commuter train every morning. She knows it will wait at the same signal each time, overlooking a row of back gardens. She’s even started to feel like she knows the people who live in one of the houses. “Jess and Jason,” she calls them. Their life—as she sees it—is perfect. If only Rachel could be that happy. And then she sees something shocking. It’s only a minute until the train moves on, but it’s enough. Now everything’s changed. Now Rachel has a chance to become a part of the lives she’s only watched from afar. Now they’ll see; she’s much more than just the girl on the train...', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (5, N'Lord of the Mysteries', N'Cuttlefish That Loves Diving', 2, NULL, 20, CAST(11.99 AS Decimal(10, 2)), 1, N'https://cdn.novelupdates.com/images/2018/11/Lord-of-the-Mysteries.jpeg', N'Waking up to be faced with a string of mysteries, Zhou Mingrui finds himself reincarnated as Klein Moretti in an alternate Victorian era world where he sees a world filled with machinery, cannons, dreadnoughts, airships, difference machines, as well as Potions, Divination, Hexes, Tarot Cards, Sealed Artifacts… The Light continues to shine but the mystery has never gone far. Follow Klein as he finds himself entangled with the Churches of the world—both orthodox and unorthodox—while he slowly develops newfound powers thanks to the Beyonder potions.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (6, N'The Shining', N' Stephen King', 2, NULL, 15, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1353277730l/11588.jpg', N'Jack Torrance''s new job at the Overlook Hotel is the perfect chance for a fresh start. As the off-season caretaker at the atmospheric old hotel, he''ll have plenty of time to spend reconnecting with his family and working on his writing. But as the harsh winter weather sets in, the idyllic location feels ever more remote...and more sinister. And the only one to notice the strange and terrible forces gathering around the Overlook is Danny Torrance, a uniquely gifted five-year-old.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (7, N'It', N'Stephen King', 2, NULL, 13, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1334416842l/830502.jpg', N'Welcome to Derry, Maine ...<br>
It’s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...<br>
They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But none of them can withstand the force that has drawn them back to Derry to face the nightmare without an end, and the evil without a name.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (8, N'A Game Of Thrones: A Song of Ice and Fire', N'George RR Martin', 2, NULL, 21, CAST(13.99 AS Decimal(10, 2)), 0, N'https://m.media-amazon.com/images/P/0553386794.01._SCLZZZZZZZ_SX500_.jpg', N'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister and supernatural forces are massing beyond the kingdom’s protective Wall. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the land they were born to. Sweeping from a land of brutal cold to a distant summertime kingdom of epicurean plenty, here is a tale of lords and ladies, soldiers and sorcerers, assassins and bastards, who come together in a time of grim omens.
<br>
Here an enigmatic band of warriors bear swords of no human metal; a tribe of fierce wildlings carry men off into madness; a cruel young dragon prince barters his sister to win back his throne; and a determined woman undertakes the most treacherous of journeys. Amid plots and counterplots, tragedy and betrayal, victory and terror, the fate of the Starks, their allies, and their enemies hangs perilously in the balance, as each endeavors to win that deadliest of conflicts: the game of thrones.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (9, N'The Hunger Games', N'Suzanne Collins', 3, NULL, 10, CAST(15.00 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1586722975l/2767052.jpg', N'Could you survive on your own in the wild, with every one out to make sure you don''t live to see the morning?
<br>
In the ruins of a place once known as North America lies the nation of Panem, a shining Capitol surrounded by twelve outlying districts. The Capitol is harsh and cruel and keeps the districts in line by forcing them all to send one boy and one girl between the ages of twelve and eighteen to participate in the annual Hunger Games, a fight to the death on live TV.
<br>
Sixteen-year-old Katniss Everdeen, who lives alone with her mother and younger sister, regards it as a death sentence when she steps forward to take her sister''s place in the Games. But Katniss has been close to dead before—and survival, for her, is second nature. Without really meaning to, she becomes a contender. But if she is to win, she will have to start making choices that weight survival against humanity and life against love.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (10, N'The Time Machine', N'H.G. Wells, Greg Bear', 3, NULL, 12, CAST(12.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg', N'“I’ve had a most amazing time....”<br>
So begins the Time Traveller’s astonishing firsthand account of his journey 800,000 years beyond his own era—and the story that launched H.G. Wells’s successful career and earned him his reputation as the father of science fiction. With a speculative leap that still fires the imagination, Wells sends his brave explorer to face a future burdened with our greatest hopes...and our darkest fears. A pull of the Time Machine’s lever propels him to the age of a slowly dying Earth.  There he discovers two bizarre races—the ethereal Eloi and the subterranean Morlocks—who not only symbolize the duality of human nature, but offer a terrifying portrait of the men of tomorrow as well.  Published in 1895, this masterpiece of invention captivated readers on the threshold of a new century.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (11, N'Outlander', N'Diana Gabaldon', 3, NULL, 14, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1529065012l/10964._SY475_.jpg', N'The year is 1945. Claire Randall, a former combat nurse, is just back from the war and reunited with her husband on a second honeymoon when she walks through a standing stone in one of the ancient circles that dot the British Isles. Suddenly she is a Sassenach—an “outlander”—in a Scotland torn by war and raiding border clans in the year of Our Lord...1743.
<br>
Hurled back in time by forces she cannot understand, Claire is catapulted into the intrigues of lairds and spies that may threaten her life, and shatter her heart. For here James Fraser, a gallant young Scots warrior, shows her a love so absolute that Claire becomes a woman torn between fidelity and desire—and between two vastly different men in two irreconcilable lives.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (12, N'All the Light We Cannot See', N'Anthony Doerr', 3, NULL, 13, CAST(10.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1451445646l/18143977.jpg', N'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure’s reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museum’s most valuable and dangerous jewel.
<br>In a mining town in Germany, Werner Pfennig, an orphan, grows up with his younger sister, enchanted by a crude radio they find that brings them news and stories from places they have never seen or imagined. Werner becomes an expert at building and fixing these crucial new instruments and is enlisted to use his talent to track down the resistance. Deftly interweaving the lives of Marie-Laure and Werner, Doerr illuminates the ways, against all odds, people try to be good to one another.', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (13, N'Fullmetal Alchemist, Vol. 1', N'Hiromu Arakawa', 4, NULL, 15, CAST(9.35 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1388179331l/870.jpg', N'Breaking the laws of nature is a serious crime!
<br>In an alchemical ritual gone wrong, Edward Elric lost his arm and his leg, and his brother Alphonse became nothing but a soul in a suit of armor. Equipped with mechanical “auto-mail” limbs, Edward becomes a state alchemist, seeking the one thing that can restore his and his brother’s bodies...the legendary Philosopher’s Stone.
<br>Alchemy: the mystical power to alter the natural world; something between magic, art and science. When two brothers, Edward and Alphonse Elric, dabbled in this power to grant their dearest wish, one of them lost an arm and a leg…and the other became nothing but a soul locked into a body of living steel. Now Edward is an agent of the government, a slave of the military-alchemical complex, using his unique powers to obey orders…even to kill. Except his powers aren''t unique. The world has been ravaged by the abuse of alchemy. And in pursuit of the ultimate alchemical treasure, the Philosopher''s Stone, their enemies are even more ruthless than they are…', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (14, N'Death Note, Vol. 1: Boredom', N'Tsugumi Ohba', 4, NULL, 15, CAST(10.40 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1419952134l/13615.jpg', N'Light Yagami is an ace student with great prospects - and he''s bored out of his mind. But all that changes when he finds the Death Note, a notebook dropped by a rogue Shinigami, a death god. Any human whose name is written in the notebook dies, and now Light has vowed to use the power of the Death Note to rid the world of evil. But when criminals begin dropping dead, the authorities send the legendary detective L to track down the killer. With L hot on his heels, will Light lose sight of his noble goal... or his life?', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (15, N'One Piece, Volume 1: Romance Dawn', N'Eiichiro Oda', 4, NULL, 15, CAST(11.00 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1318523719l/1237398.jpg', N'A new shonen sensation in Japan, this series features Monkey D. Luffy, whose main ambition is to become a pirate. Eating the Gum-Gum Fruit gives him strange powers but also invokes the fruit''s curse: anybody who consumes it can never learn to swim. Nevertheless, Monkey and his crewmate Roronoa Zoro, master of the three-sword fighting style, sail the Seven Seas of swashbuckling adventure in search of the elusive treasure "One Piece."', 0, 1)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views], [status]) VALUES (16, N'Classroom of the Elite Vol. 1', N'Syougo Kinugasa', 4, NULL, 15, CAST(9.69 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1540974678l/41085104.jpg', N'Students of the prestigious Tokyo Metropolitan Advanced Nurturing High School are given remarkable freedom—if they can win, barter, or save enough points to work their way up the ranks! Ayanokoji Kiyotaka has landed at the bottom in the scorned Class D, where he meets Horikita Suzune, who’s determined to rise up the ladder to Class A. Can they beat the system in a school where cutthroat competition is the name of the game?', 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO