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
/****** Object:  Table [dbo].[Book_Own]    Script Date: 10/2/2022 1:53:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Own](
	[userId] [int] NOT NULL,
	[bookId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Account]    Script Date: 10/2/2022 1:53:23 AM ******/
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
/****** Object:  Table [dbo].[Payment_Method]    Script Date: 10/2/2022 1:53:23 AM ******/
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
	[is_super] int NOT NULL,
	[walletNumber] [bigint] NULL,
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
	[content] ntext not null
	CONSTRAINT [PK_chapter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([volumeId])
REFERENCES [dbo].[Volume] ([id]) ON DELETE CASCADE ON UPDATE CASCADE
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
/****** Object:  Table [dbo].[Comment]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Comment](
	[bookId] int not null,
	[userId] int not null,
	comment nvarchar(2000)
	)
Go
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
/****** Object:  Table [dbo].[ReportTitle]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Report](
	[id] int IDENTITY(1,1) not null,
	[title] nvarchar(100) not null
	CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
/****** Object:  Table [dbo].[ReportDetail]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ReportDetail](
	[id] int IDENTITY(1,1) not null,
	[reportId] int not null,
	[bookId] int not null,
	[userId] int not null,
	note nvarchar(2000)
	CONSTRAINT [PK_reportdetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([reportId])
REFERENCES [dbo].[Report] ([id])
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([bookId])
REFERENCES [dbo].[Book] ([id])
ALTER TABLE [dbo].[ReportDetail]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
/****** Object:  Table [dbo].[Transaction]    Script Date: 10/2/2022 1:53:23 AM ******/
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
/****** Object:  Table [dbo].[Transaction_Token]    Script Date: 10/2/2022 1:53:23 AM ******/
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
---------------------------------------------------

ALTER TABLE [dbo].[Book] ADD  DEFAULT (0) FOR [favourite]

ALTER TABLE [dbo].[Book] ADD  DEFAULT (1) FOR [status]
--ALTER TABLE [dbo].[Book] ADD  DEFAULT ('UNDECIDED') FOR [type]
--ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(did) REFERENCES [dbo].[Discount] (id)
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(categoryid) REFERENCES [dbo].[Category] (id)
GO
--ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [CK_user_id] CHECK  (([user_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [user_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))

ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Book__views__30F848ED]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__is_super__31EC6D26]  DEFAULT ((1)) FOR [is_super]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_balance]  DEFAULT ((0)) FOR [walletNumber]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK__Book__categoryid__32E0915F] FOREIGN KEY([categoryid])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK__Book__categoryid__32E0915F]
GO
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
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD  CONSTRAINT [FK__Favourite__bid__2B3F6F97] FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Favourite] CHECK CONSTRAINT [FK__Favourite__bid__2B3F6F97]
GO
ALTER TABLE [dbo].[Favourite]  WITH CHECK ADD  CONSTRAINT [FK__Favourite__uid__2A4B4B5E] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Favourite] CHECK CONSTRAINT [FK__Favourite__uid__2A4B4B5E]
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
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [FK__Star__bid__2E1BDC42] FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [FK__Star__bid__2E1BDC42]
GO
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [FK__Star__uid__2F10007B] FOREIGN KEY([uid])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [FK__Star__uid__2F10007B]
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
ALTER TABLE [dbo].[Star]  WITH CHECK ADD  CONSTRAINT [chk_star] CHECK  (([star]>=(1) AND [star]<=(5)))
GO
ALTER TABLE [dbo].[Star] CHECK CONSTRAINT [chk_star]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 mean Fail, 1 mean Pending, 2 mean Successful' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'status'
GO
USE [BOOKIE]
GO

Insert [dbo].[Category] ([name]) values (N'Crime, Thriller & Mystery'),(N'Fantasy, Horror'),(N'Science/Historical Fiction'),(N'Manga&LN')
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
GO
SET IDENTITY_INSERT [dbo].[Volume] ON 
GO
INSERT [dbo].[Volume] ([id], [bookId], [volume], [volumeName], [summary]) VALUES (1, 1, 1, N'Part One: BOY LOSES GIRL', NULL)
GO
INSERT [dbo].[Volume] ([id], [bookId], [volume], [volumeName], [summary]) VALUES (2, 1, 2, N'Part Two: Boy Meets Girl', NULL)
GO
SET IDENTITY_INSERT [dbo].[Volume] OFF
GO
SET IDENTITY_INSERT [dbo].[Chapter] ON 
GO
INSERT [dbo].[Chapter] ([id], [bookId], [volumeId], [chapter], [chapterName], [status], [content]) VALUES (1, 1, 1, 1, N'NICK DUNNE', 1, N'When I think of my wife, I always think of her head. The shape of it, to begin with. The very first time I saw her, it was the back of the head I saw, and there was something lovely about it, the angles of it. Like a shiny, hard corn kernel or a riverbed fossil. She had what the Victorians would call a finely shaped head. You could imagine the skull quite easily.
I’d know her head anywhere.
And what’s inside it. I think of that, too: her mind. Her brain, all those coils, and her thoughts shuttling through those coils like fast, frantic centipedes. Like a child, I picture opening her skull, unspooling her brain and sifting through it, trying to catch and pin down her thoughts. What are you thinking, Amy? The question I’ve asked most often during our marriage, if not out loud, if not to the person who could answer. I suppose these questions stormcloud over every marriage: What are you thinking? How are you feeling? Who are you? What have we done to each other? What will we do?
My eyes flipped open at exactly six a.m. This was no avian fluttering of the lashes, no gentle blink toward consciousness. The awakening was mechanical. A spooky ventriloquist-dummy click of the lids: The world is black and then, showtime! 6-0-0 the clock said – in my face, first thing I saw. 6-0-0. It felt different. I rarely woke at such a rounded time. I was a man of jagged risings: 8:43, 11:51, 9:26. My life was alarmless.
At that exact moment, 6-0-0, the sun climbed over the skyline of oaks, revealing its full summer angry-God self. Its reflection flared across the river toward our house, a long, blaring finger aimed at me through our frail bedroom curtains. Accusing: You have been seen. You will be seen.
I wallowed in bed, which was our New York bed in our new house, which we still called the new house, even though we’d been back here for two years. It’s a rented house right along the Mississippi River, a house that screams Suburban Nouveau Riche, the kind of place I aspired to as a kid from my split-level, shag-carpet side of town. The kind of house that is immediately familiar: a generically grand, unchallenging, new, new, new house that my wife would – and did – detest.
‘Should I remove my soul before I come inside?’ Her first line upon arrival. It had been a compromise: Amy demanded we rent, not buy, in my little Missouri hometown, in her firm hope that we wouldn’t be stuck here long. But the only houses for rent were clustered in this failed development: a miniature ghost town of bank-owned, recession-busted, price-reduced mansions, a neighborhood that closed before it ever opened. It was a compromise, but Amy didn’t see it that way, not in the least. To Amy, it was a punishing whim on my part, a nasty, selfish twist of the knife. I would drag her, caveman-style, to a town she had aggressively avoided, and make her live in the kind of house she used to mock. I suppose it’s not a compromise if only one of you considers it such, but that was what our compromises tended to look like. One of us was always angry. Amy, usually.
Do not blame me for this particular grievance, Amy. The Missouri Grievance. Blame the economy, blame bad luck, blame my parents, blame your parents, blame the Internet, blame people who use the Internet. I used to be a writer. I was a writer who wrote about TV and movies and books. Back when people read things on paper, back when anyone cared about what I thought. I’d arrived in New York in the late ’90s, the last gasp of the glory days, although no one knew it then. New York was packed with writers, real writers, because there were magazines, real magazines, loads of them. This was back when the Internet was still some exotic pet kept in the corner of the publishing world – throw some kibble at it, watch it dance on its little leash, oh quite cute, it definitely won’t kill us in the night. Think about it: a time when newly graduated college kids could come to New York and get paid to write. We had no clue that we were embarking on careers that would vanish within a decade.
I had a job for eleven years and then I didn’t, it was that fast. All around the country, magazines began shuttering, succumbing to a sudden infection brought on by the busted economy. Writers (my kind of writers: aspiring novelists, ruminative thinkers, people whose brains don’t work quick enough to blog or link or tweet, basically old, stubborn blowhards) were through. We were like women’s hat makers or buggy-whip manufacturers: Our time was done. Three weeks after I got cut loose, Amy lost her job, such as it was. (Now I can feel Amy looking over my shoulder, smirking at the time I’ve spent discussing my career, my misfortune, and dismissing her experience in one sentence. That, she would tell you, is typical. Just like Nick, she would say. It was a refrain of hers: Just like Nick to … and whatever followed, whatever was just like me, was bad.) Two jobless grown-ups, we spent weeks wandering around our Brooklyn brownstone in socks and pajamas, ignoring the future, strewing unopened mail across tables and sofas, eating ice cream at ten a.m. and taking thick afternoon naps.
Then one day the phone rang. My twin sister was on the other end. Margo had moved back home after her own New York layoff a year before – the girl is one step ahead of me in everything, even shitty luck. Margo, calling from good ole North Carthage, Missouri, from the house where we grew up, and as I listened to her voice, I saw her at age ten, with a dark cap of hair and overall shorts, sitting on our grandparents’ back dock, her body slouched over like an old pillow, her skinny legs dangling in the water, watching the river flow over fish-white feet, so intently, utterly self-possessed even as a child.
Go’s voice was warm and crinkly even as she gave this cold news: Our indomitable mother was dying. Our dad was nearly gone – his (nasty) mind, his (miserable) heart, both murky as he meandered toward the great gray beyond. But it looked like our mother would beat him there. About six months, maybe a year, she had. I could tell that Go had gone to meet with the doctor by herself, taken her studious notes in her slovenly handwriting, and she was teary as she tried to decipher what she’d written. Dates and doses.
‘Well, fuck, I have no idea what this says, is it a nine? Does that even make sense?’ she said, and I interrupted. Here was a task, a purpose, held out on my sister’s palm like a plum. I almost cried with relief.
‘I’ll come back, Go. We’ll move back home. You shouldn’t have to do this all by yourself.’
She didn’t believe me. I could hear her breathing on the other end.
‘I’m serious, Go. Why not? There’s nothing here.’
A long exhale. ‘What about Amy?’
That is what I didn’t take long enough to consider. I simply assumed I would bundle up my New York wife with her New York interests, her New York pride, and remove her from her New York parents – leave the frantic, thrilling futureland of Manhattan behind – and transplant her to a little town on the river in Missouri, and all would be fine.
I did not yet understand how foolish, how optimistic, how, yes, just like Nick I was for thinking this. The misery it would lead to.
‘Amy will be fine. Amy …’ Here was where I should have said, ‘Amy loves Mom.’ But I couldn’t tell Go that Amy loved our mother, because after all that time, Amy still barely knew our mother. Their few meetings had left them both baffled. Amy would dissect the conversations for days after – ‘And what did she mean by …,’ – as if my mother were some ancient peasant tribeswoman arriving from the tundra with an armful of raw yak meat and some buttons for bartering, trying to get something from Amy that wasn’t on offer.
Amy didn’t care to know my family, didn’t want to know my birthplace, and yet for some reason, I thought moving home would be a good idea.
My morning breath warmed the pillow, and I changed the subject in my mind. Today was not a day for second-guessing or regret, it was a day for doing. Downstairs, I could hear the return of a long-lost sound: Amy making breakfast. Banging wooden cupboards (rump-thump!), rattling containers of tin and glass (ding-ring!), shuffling and sorting a collection of metal pots and iron pans (ruzz-shuzz!). A culinary orchestra tuning up, clattering vigorously toward the finale, a cake pan drumrolling along the floor, hitting the wall with a cymballic crash. Something impressive was being created, probably a crepe, because crepes are special, and today Amy would want to cook something special.
It was our five-year anniversary.
I walked barefoot to the edge of the steps and stood listening, working my toes into the plush wall-to-wall carpet Amy detested on principle, as I tried to decide whether I was ready to join my wife. Amy was in the kitchen, oblivious to my hesitation. She was humming something melancholy and familiar. I strained to make it out – a folk song? a lullabye? – and then realized it was the theme to M.A.S.H. Suicide is painless. I went downstairs.
I hovered in the doorway, watching my wife. Her yellow-butter hair was pulled up, the hank of ponytail swinging cheerful as a jumprope, and she was sucking distractedly on a burnt fingertip, humming around it. She hummed to herself because she was an unrivaled botcher of lyrics. When we were first dating, a Genesis song came on the radio: ‘She seems to have an invisible touch, yeah.’ And Amy crooned instead, ‘She takes my hat and puts it on the top shelf.’ When I asked her why she’d ever think her lyrics were remotely, possibly, vaguely right, she told me she always thought the woman in the song truly loved the man because she put his hat on the top shelf. I knew I liked her then, really liked her, this girl with an explanation for everything.
There’s something disturbing about recalling a warm memory and feeling utterly cold.
Amy peered at the crepe sizzling in the pan and licked something off her wrist. She looked triumphant, wifely. If I took her in my arms, she would smell like berries and powdered sugar.
When she spied me lurking there in grubby boxers, my hair in full Heat Miser spike, she leaned against the kitchen counter and said, ‘Well, hello, handsome.’
Bile and dread inched up my throat. I thought to myself: Okay, go.
I was very late getting to work. My sister and I had done a foolish thing when we both moved back home. We had done what we always talked about doing. We opened a bar. We borrowed money from Amy to do this, eighty thousand dollars, which was once nothing to Amy but by then was almost everything. I swore I would pay her back, with interest. I would not be a man who borrowed from his wife – I could feel my dad twisting his lips at the very idea. Well, there are all kinds of men, his most damning phrase, the second half left unsaid, and you are the wrong kind.
But truly, it was a practical decision, a smart business move. Amy and I both needed new careers; this would be mine. She would pick one someday, or not, but in the meantime, here was an income, made possible by the last of Amy’s trust fund. Like the McMansion I rented, the bar featured symbolically in my childhood memories – a place where only grown-ups go, and do whatever grown-ups do. Maybe that’s why I was so insistent on buying it after being stripped of my livelihood. It’s a reminder that I am, after all, an adult, a grown man, a useful human being, even though I lost the career that made me all these things. I won’t make that mistake again: The once plentiful herds of magazine writers would continue to be culled – by the Internet, by the recession, by the American public, who would rather watch TV or play video games or electronically inform friends that, like, rain sucks! But there’s no app for a bourbon buzz on a warm day in a cool, dark bar. The world will always want a drink.
Our bar is a corner bar with a haphazard, patchwork aesthetic. Its best feature is a massive Victorian backbar, dragon heads and angel faces emerging from the oak – an extravagant work of wood in these shitty plastic days. The remainder of the bar is, in fact, shitty, a showcase of the shabbiest design offerings of every decade: an Eisenhower-era linoleum floor, the edges turned up like burnt toast; dubious wood-paneled walls straight from a ’70s home-porn video; halogen floor lamps, an accidental tribute to my 1990s dorm room. The ultimate effect is strangely homey – it looks less like a bar than someone’s benignly neglected fixer-upper. And jovial: We share a parking lot with the local bowling alley, and when our door swings wide, the clatter of strikes applauds the customer’s entrance.
We named the bar The Bar. ‘People will think we’re ironic instead of creatively bankrupt,’ my sister reasoned.
Yes, we thought we were being clever New Yorkers – that the name was a joke no one else would really get, not get like we did. Not meta-get. We pictured the locals scrunching their noses: Why’d you name it The Bar? But our first customer, a gray-haired woman in bifocals and a pink jogging suit, said, ‘I like the name. Like in Breakfast at Tiffany’s and Audrey Hepburn’s cat was named Cat.’
We felt much less superior after that, which was a good thing.
I pulled into the parking lot. I waited until a strike erupted from the bowling alley – thank you, thank you, friends – then stepped out of the car. I admired the surroundings, still not bored with the broken-in view: the squatty blond-brick post office across the street (now closed on Saturdays), the unassuming beige office building just down the way (now closed, period). The town wasn’t prosperous, not anymore, not by a long shot. Hell, it wasn’t even original, being one of two Carthage, Missouris – ours is technically North Carthage, which makes it sound like a twin city, although it’s hundreds of miles from the other and the lesser of the two: a quaint little 1950s town that bloated itself into a basic midsize suburb and dubbed it progress. Still, it was where my mom grew up and where she raised me and Go, so it had some history. Mine, at least.
As I walked toward the bar across the concrete-and-weed parking lot, I looked straight down the road and saw the river. That’s what I’ve always loved about our town: We aren’t built on some safe bluff overlooking the Mississippi – we are on the Mississippi. I could walk down the road and step right into the sucker, an easy three-foot drop, and be on my way to Tennessee. Every building downtown bears hand-drawn lines from where the river hit during the Flood of ’61, ’75, ’84, ’93, ’07, ’08, ’11. And so on.
The river wasn’t swollen now, but it was running urgently, in strong ropy currents. Moving apace with the river was a long single-file line of men, eyes aimed at their feet, shoulders tense, walking steadfastly nowhere. As I watched them, one suddenly looked up at me, his face in shadow, an oval blackness. I turned away.
I felt an immediate, intense need to get inside. By the time I’d gone twenty feet, my neck bubbled with sweat. The sun was still an angry eye in the sky. You have been seen.
My gut twisted, and I moved quicker. I needed a drink.')
GO
INSERT [dbo].[Chapter] ([id], [bookId], [volumeId], [chapter], [chapterName], [status], [content]) VALUES (2, 1, 1, 2, N'AMY ELLIOTT JANUARY 8, 2005', 1, N'– Diary entry –
Tra and la! I am smiling a big adopted-orphan smile as I write this. I am embarrassed at how happy I am, like some Technicolor comic of a teenage girl talking on the phone with my hair in a ponytail, the bubble above my head saying: I met a boy!
But I did. This is a technical, empirical truth. I met a boy, a great, gorgeous dude, a funny, cool-ass guy. Let me set the scene, because it deserves setting for posterity (no, please, I’m not that far gone, posterity! feh). But still. It’s not New Year’s, but still very much the new year. It’s winter: early dark, freezing cold.
Carmen, a newish friend – semi-friend, barely friend, the kind of friend you can’t cancel on – has talked me into going out to Brooklyn, to one of her writers’ parties. Now, I like a writer party, I like writers, I am the child of writers, I am a writer. I still love scribbling that word – WRITER – any time a form, questionnaire, document asks for my occupation. Fine, I write personality quizzes, I don’t write about the Great Issues of the Day, but I think it’s fair to say I am a writer. I’m using this journal to get better: to hone my skills, to collect details and observations. To show don’t tell and all that other writery crap. (Adopted-orphan smile, I mean, that’s not bad, come on.) But really, I do think my quizzes alone qualify me on at least an honorary basis. Right?
At a party you find yourself surrounded by genuine talented writers, employed at high-profile, respected newspapers and magazines.
You merely write quizzes for women’s rags. When someone asks what you do for a living, you:
a) Get embarrassed and say, ‘I’m just a quiz writer, it’s silly stuff!’
b) Go on the offense: ‘I’m a writer now, but I’m considering something more challenging and worthwhile – why, what do you do?’
c) Take pride in your accomplishments: ‘I write personality quizzes using the knowledge gleaned from my master’s degree in psychology – oh, and fun fact: I am the inspiration for a beloved children’s-book series, I’m sure you know it, Amazing Amy? Yeah, so suck it, snobdouche!
Answer: C, totally C
Anyway, the party is being thrown by one of Carmen’s good friends who writes about movies for a movie magazine, and is very funny, according to Carmen. I worry for a second that she wants to set us up: I am not interested in being set up. I need to be ambushed, caught unawares, like some sort of feral love-jackal. I’m too self-conscious otherwise. I feel myself trying to be charming, and then I realize I’m obviously trying to be charming, and then I try to be even more charming to make up for the fake charm, and then I’ve basically turned into Liza Minnelli: I’m dancing in tights and sequins, begging you to love me. There’s a bowler and jazz hands and lots of teeth.
But no, I realize, as Carmen gushes on about her friend: She likes him. Good.
We climb three flights of warped stairs and walk into a whoosh of body heat and writerness: many black-framed glasses and mops of hair; faux western shirts and heathery turtlenecks; black wool pea-coats flopped all across the couch, puddling to the floor; a German poster for The Getaway (Ihre Chance war gleich Null!) covering one paint-cracked wall. Franz Ferdinand on the stereo: ‘Take Me Out.’
A clump of guys hovers near a card table where all the alcohol is set up, tipping more booze into their cups after every few sips, all too aware of how little is left to go around. I nudge in, aiming my plastic cup in the center like a busker, get a clatter of ice cubes and a splash of vodka from a sweet-faced guy wearing a Space Invaders T-shirt.
A lethal-looking bottle of green-apple liqueur, the host’s ironic purchase, will soon be our fate unless someone makes a booze run, and that seems unlikely, as everyone clearly believes they made the run last time. It is a January party, definitely, everyone still glutted and sugar-pissed from the holidays, lazy and irritated simultaneously. A party where people drink too much and pick cleverly worded fights, blowing cigarette smoke out an open window even after the host asks them to go outside. We’ve already talked to one another at a thousand holiday parties, we have nothing left to say, we are collectively bored, but we don’t want to go back into the January cold; our bones still ache from the subway steps.
I have lost Carmen to her host-beau – they are having an intense discussion in a corner of the kitchen, the two of them hunching their shoulders, their faces toward each other, the shape of a heart. Good. I think about eating to give myself something to do besides standing in the center of the room, smiling like the new kid in the lunchroom. But almost everything is gone. Some potato-chip shards sit in the bottom of a giant Tupperware bowl. A supermarket deli tray full of hoary carrots and gnarled celery and a semeny dip sits untouched on a coffee table, cigarettes littered throughout like bonus vegetable sticks. I am doing my thing, my impulse thing: What if I leap from the theater balcony right now? What if I tongue the homeless man across from me on the subway? What if I sit down on the floor of this party by myself and eat everything on that deli tray, including the cigarettes?
‘Please don’t eat anything in that area,’ he says. It is him (bum bum BUMMM!), but I don’t yet know it’s him (bum-bum-bummm). I know it’s a guy who will talk to me, he wears his cockiness like an ironic T-shirt, but it fits him better. He is the kind of guy who carries himself like he gets laid a lot, a guy who likes women, a guy who would actually fuck me properly. I would like to be fucked properly! My dating life seems to rotate around three types of men: preppy Ivy Leaguers who believe they’re characters in a Fitzgerald novel; slick Wall Streeters with money signs in their eyes, their ears, their mouths; and sensitive smart-boys who are so self-aware that everything feels like a joke. The Fitzgerald fellows tend to be ineffectively porny in bed, a lot of noise and acrobatics to very little end. The finance guys turn rageful and flaccid. The smart-boys fuck like they’re composing a piece of math rock: This hand strums around here, and then this finger offers a nice bass rhythm … I sound quite slutty, don’t I? Pause while I count how many … eleven. Not bad. I’ve always thought twelve was a solid, reasonable number to end at.
‘Seriously,’ Number 12 continues. (Ha!) ‘Back away from the tray. James has up to three other food items in his refrigerator. I could make you an olive with mustard. Just one olive, though.’
Just one olive, though. It is a line that is only a little funny, but it already has the feel of an inside joke, one that will get funnier with nostalgic repetition. I think: A year from now, we will be walking along the Brooklyn Bridge at sunset and one of us will whisper, ‘Just one olive, though,’ and we’ll start to laugh. (Then I catch myself. Awful. If he knew I was doing a year from now already, he’d run and I’d be obliged to cheer him on.)
Mainly, I will admit, I smile because he’s gorgeous. Distractingly gorgeous, the kind of looks that make your eyes pinwheel, that make you want to just address the elephant – ‘You know you’re gorgeous, right?’ – and move on with the conversation. I bet dudes hate him: He looks like the rich-boy villain in an ’80s teen movie – the one who bullies the sensitive misfit, the one who will end up with a pie in the puss, the whipped cream wilting his upturned collar as everyone in the cafeteria cheers.
He doesn’t act that way, though. His name is Nick. I love it. It makes him seem nice, and regular, which he is. When he tells me his name, I say, ‘Now, that’s a real name.’ He brightens and reels off some line: ‘Nick’s the kind of guy you can drink a beer with, the kind of guy who doesn’t mind if you puke in his car. Nick!’
He makes a series of awful puns. I catch three fourths of his movie references. Two thirds, maybe. (Note to self: Rent The Sure Thing.) He refills my drink without me having to ask, somehow ferreting out one last cup of the good stuff. He has claimed me, placed a flag in me: I was here first, she’s mine, mine. It feels nice, after my recent series of nervous, respectful post-feminist men, to be a territory. He has a great smile, a cat’s smile. He should cough out yellow Tweety Bird feathers, the way he smiles at me. He doesn’t ask what I do for a living, which is fine, which is a change. (I’m a writer, did I mention?) He talks to me in his river-wavy Missouri accent; he was born and raised outside of Hannibal, the boyhood home of Mark Twain, the inspiration for Tom Sawyer. He tells me he worked on a steamboat when he was a teenager, dinner and jazz for the tourists. And when I laugh (bratty, bratty New York girl who has never ventured to those big unwieldy middle states, those States Where Many Other People Live), he informs me that Missoura is a magical place, the most beautiful in the world, no state more glorious. His eyes are mischievous, his lashes are long. I can see what he looked like as a boy.
We share a taxi home, the streetlights making dizzy shadows and the car speeding as if we’re being chased. It is one a.m. when we hit one of New York’s unexplained deadlocks twelve blocks from my apartment, so we slide out of the taxi into the cold, into the great What Next? and Nick starts walking me home, his hand on the small of my back, our faces stunned by the chill. As we turn the corner, the local bakery is getting its powdered sugar delivered, funneled into the cellar by the barrelful as if it were cement, and we can see nothing but the shadows of the deliverymen in the white, sweet cloud. The street is billowing, and Nick pulls me close and smiles that smile again, and he takes a single lock of my hair between two fingers and runs them all the way to the end, tugging twice, like he’s ringing a bell. His eyelashes are trimmed with powder, and before he leans in, he brushes the sugar from my lips so he can taste me.')
GO
INSERT [dbo].[Chapter] ([id], [bookId], [volumeId], [chapter], [chapterName], [status], [content]) VALUES (3, 1, 1, 3, N'NICK DUNNE', 0, N'I swung wide the door of my bar, slipped into the darkness, and took my first real deep breath of the day, took in the smell of cigarettes and beer, the spice of a dribbled bourbon, the tang of old popcorn. There was only one customer in the bar, sitting by herself at the far, far end: an older woman named Sue who had come in every Thursday with her husband until he died three months back. Now she came alone every Thursday, never much for conversation, just sitting with a beer and a crossword, preserving a ritual.
My sister was at work behind the bar, her hair pulled back in nerdy-girl barrettes, her arms pink as she dipped the beer glasses in and out of hot suds. Go is slender and strange-faced, which is not to say unattractive. Her features just take a moment to make sense: the broad jaw; the pinched, pretty nose; the dark globe eyes. If this were a period movie, a man would tilt back his fedora, whistle at the sight of her, and say, ‘Now, there’s a helluva broad!’ The face of a ’30s screwball-movie queen doesn’t always translate in our pixie-princess times, but I know from our years together that men like my sister, a lot, which puts me in that strange brotherly realm of being both proud and wary.
‘Do they still make pimento loaf?’ she said by way of greeting, not looking up, just knowing it was me, and I felt the relief I usually felt when I saw her: Things might not be great, but things would be okay.
My twin, Go. I’ve said this phrase so many times, it has become a reassuring mantra instead of actual words: Mytwingo. We were born in the ’70s, back when twins were rare, a bit magical: cousins of the unicorn, siblings of the elves. We even have a dash of twin telepathy. Go is truly the one person in the entire world I am totally myself with. I don’t feel the need to explain my actions to her. I don’t clarify, I don’t doubt, I don’t worry. I don’t tell her everything, not anymore, but I tell her more than anyone else, by far. I tell her as much as I can. We spent nine months back to back, covering each other. It became a lifelong habit. It never mattered to me that she was a girl, strange for a deeply self-conscious kid. What can I say? She was always just cool.
‘Pimento loaf, that’s like lunch meat, right? I think they do.’
‘We should get some,’ she said. She arched an eyebrow at me. ‘I’m intrigued.’
Without asking, she poured me a draft of PBR into a mug of questionable cleanliness. When she caught me staring at the smudged rim, she brought the glass up to her mouth and licked the smudge away, leaving a smear of saliva. She set the mug squarely in front of me. ‘Better, my prince?’
Go firmly believes that I got the best of everything from our parents, that I was the boy they planned on, the single child they could afford, and that she sneaked into this world by clamping onto my ankle, an unwanted stranger. (For my dad, a particularly unwanted stranger.) She believes she was left to fend for herself throughout childhood, a pitiful creature of random hand-me-downs and forgotten permission slips, tightened budgets and general regret. This vision could be somewhat true; I can barely stand to admit it.
‘Yes, my squalid little serf,’ I said, and fluttered my hands in royal dispensation.
I huddled over my beer. I needed to sit and drink a beer or three. My nerves were still singing from the morning.
‘What’s up with you?’ she asked. ‘You look all twitchy.’ She flicked some suds at me, more water than soap. The air-conditioning kicked on, ruffling the tops of our heads. We spent more time in The Bar than we needed to. It had become the childhood clubhouse we never had. We’d busted open the storage boxes in our mother’s basement one drunken night last year, back when she was alive but right near the end, when we were in need of comfort, and we revisited the toys and games with much oohing and ahhing between sips of canned beer. Christmas in August. After Mom died, Go moved into our old house, and we slowly relocated our toys, piecemeal, to The Bar: a Strawberry Shortcake doll, now scentless, pops up on a stool one day (my gift to Go). A tiny Hot Wheels El Camino, one wheel missing, appears on a shelf in the corner (Go’s to me).
We were thinking of introducing a board game night, even though most of our customers were too old to be nostalgic for our Hungry Hungry Hippos, our Game of Life with its tiny plastic cars to be filled with tiny plastic pinhead spouses and tiny plastic pinhead babies. I couldn’t remember how you won. (Deep Hasbro thought for the day.)
Go refilled my beer, refilled her beer. Her left eyelid drooped slightly. It was exactly noon, 12–00, and I wondered how long she’d been drinking. She’s had a bumpy decade. My speculative sister, she of the rocket-science brain and the rodeo spirit, dropped out of college and moved to Manhattan in the late ’90s. She was one of the original dot-com phenoms – made crazy money for two years, then took the Internet bubble bath in 2000. Go remained unflappable. She was closer to twenty than thirty; she was fine. For act two, she got her degree and joined the gray-suited world of investment banking. She was midlevel, nothing flashy, nothing blameful, but she lost her job – fast – with the 2008 financial meltdown. I didn’t even know she’d left New York until she phoned me from Mom’s house: I give up. I begged her, cajoled her to return, hearing nothing but peeved silence on the other end. After I hung up, I made an anxious pilgrimage to her apartment in the Bowery and saw Gary, her beloved ficus tree, yellow-dead on the fire escape, and knew she’d never come back.
The Bar seemed to cheer her up. She handled the books, she poured the beers. She stole from the tip jar semi-regularly, but then she did more work than me. We never talked about our old lives. We were Dunnes, and we were done, and strangely content about it.
‘So, what?’ Go said, her usual way of beginning a conversation.
‘Eh.’
‘Eh, what? Eh, bad? You look bad.’
I shrugged a yes; she scanned my face.
‘Amy?’ she asked. It was an easy question. I shrugged again – a confirmation this time, a whatcha gonna do? shrug.
Go gave me her amused face, both elbows on the bar, hands cradling chin, hunkering down for an incisive dissection of my marriage. Go, an expert panel of one. ‘What about her?’
‘Bad day. It’s just a bad day.’
‘Don’t let her worry you.’ Go lit a cigarette. She smoked exactly one a day. ‘Women are crazy.’ Go didn’t consider herself part of the general category of women, a word she used derisively.
I blew Go’s smoke back to its owner. ‘It’s our anniversary today. Five years.’
‘Wow.’ My sister cocked her head back. She’d been a bridesmaid, all in violet – ‘the gorgeous, raven-haired, amethyst-draped dame,’ Amy’s mother had dubbed her – but anniversaries weren’t something she’d remember. ‘Jeez. Fuck. Dude. That came fast.’ She blew more smoke toward me, a lazy game of cancer catch. ‘She going to do one of her, uh, what do you call it, not scavenger hunt—’
‘Treasure hunt,’ I said.
My wife loved games, mostly mind games, but also actual games of amusement, and for our anniversary she always set up an elaborate treasure hunt, with each clue leading to the hiding place of the next clue until I reached the end, and my present. It was what her dad always did for her mom on their anniversary, and don’t think I don’t see the gender roles here, that I don’t get the hint. But I did not grow up in Amy’s household, I grew up in mine, and the last present I remember my dad giving my mom was an iron, set on the kitchen counter, no wrapping paper.
‘Should we make a wager on how pissed she’s going to get at you this year?’ Go asked, smiling over the rim of her beer.
The problem with Amy’s treasure hunts: I never figured out the clues. Our first anniversary, back in New York, I went two for seven. That was my best year. The opening parley:
This place is a bit of a hole in the wall,
But we had a great kiss there one Tuesday last fall.
Ever been in a spelling bee as a kid? That snowy second after the announcement of the word as you sift your brain to see if you can spell it? It was like that, the blank panic.
‘An Irish bar in a not-so-Irish place,’ Amy nudged.
I bit the side of my lip, started a shrug, scanning our living room as if the answer might appear. She gave me another very long minute.
‘We were lost in the rain,’ she said in a voice that was pleading on the way to peeved.
I finished the shrug.
‘McMann’s, Nick. Remember, when we got lost in the rain in Chinatown trying to find that dim sum place, and it was supposed to be near the statue of Confucius but it turns out there are two statues of Confucius, and we ended up at that random Irish bar all soaking wet, and we slammed a few whiskeys, and you grabbed me and kissed me, and it was—’
‘Right! You should have done a clue with Confucius, I would have gotten that.’
‘The statue wasn’t the point. The place was the point. The moment. I just thought it was special.’ She said these last words in a childish lilt that I once found fetching.
‘It was special.’ I pulled her to me and kissed her. ‘That smooch right there was my special anniversary reenactment. Let’s go do it again at McMann’s.’
At McMann’s, the bartender, a big, bearded bear-kid, saw us come in and grinned, poured us both whiskeys, and pushed over the next clue.
When I’m down and feeling blue
There’s only one place that will do.
That one turned out to be the Alice in Wonderland statue at Central Park, which Amy had told me – she’d told me, she knew she’d told me many times – lightened her moods as a child. I do not remember any of those conversations. I’m being honest here, I just don’t. I have a dash of ADD, and I’ve always found my wife a bit dazzling, in the purest sense of the word: to lose clear vision, especially from looking at bright light. It was enough to be near her and hear her talk, it didn’t always matter what she was saying. It should have, but it didn’t.
By the time we got to the end of the day, to exchanging our actual presents – the traditional paper presents for the first year of marriage – Amy was not speaking to me.
‘I love you, Amy. You know I love you,’ I said, tailing her in and out of the family packs of dazed tourists parked in the middle of the sidewalk, oblivious and openmouthed. Amy was slipping through the Central Park crowds, maneuvering between laser-eyed joggers and scissor-legged skaters, kneeling parents and toddlers careering like drunks, always just ahead of me, tight-lipped, hurrying nowhere. Me trying to catch up, grab her arm. She stopped finally, gave me a face unmoved as I explained myself, one mental finger tamping down my exasperation: ‘Amy, I don’t get why I need to prove my love to you by remembering the exact same things you do, the exact same way you do. It doesn’t mean I don’t love our life together.’
A nearby clown blew up a balloon animal, a man bought a rose, a child licked an ice cream cone, and a genuine tradition was born, one I’d never forget: Amy always going overboard, me never, ever worthy of the effort. Happy anniversary, asshole.
‘I’m guessing –five years – she’s going to get really pissed,’ Go continued. ‘So I hope you got her a really good present.’
‘On the to-do list.’
‘What’s the, like, symbol, for five years? Paper?’
‘Paper is first year,’ I said. At the end of Year One’s unexpectedly wrenching treasure hunt, Amy presented me with a set of posh stationery, my initials embossed at the top, the paper so creamy I expected my fingers to come away moist. In return, I’d presented my wife with a bright red dime-store paper kite, picturing the park, picnics, warm summer gusts. Neither of us liked our presents; we’d each have preferred the other’s. It was a reverse O. Henry.
‘Silver?’ guessed Go. ‘Bronze? Scrimshaw? Help me out.’
‘Wood,’ I said. ‘There’s no romantic present for wood.’
At the other end of the bar, Sue neatly folded her newspaper and left it on the bartop with her empty mug and a five-dollar bill. We all exchanged silent smiles as she walked out.
‘I got it,’ Go said. ‘Go home, fuck her brains out, then smack her with your penis and scream, “There’s some wood for you, bitch!”
We laughed. Then we both flushed pink in our cheeks in the same spot. It was the kind of raunchy, unsisterly joke that Go enjoyed tossing at me like a grenade. It was also the reason why, in high school, there were always rumors that we secretly screwed. Twincest. We were too tight: our inside jokes, our edge-of-the-party whispers. I’m pretty sure I don’t need to say this, but you are not Go, you might misconstrue, so I will: My sister and I have never screwed or even thought of screwing. We just really like each other.
Go was now pantomiming dick-slapping my wife.
No, Amy and Go were never going to be friends. They were each too territorial. Go was used to being the alpha girl in my life, Amy was used to being the alpha girl in everyone’s life. For two people who lived in the same city – the same city twice: first New York, now here – they barely knew each other. They flitted in and out of my life like well-timed stage actors, one going out the door as the other came in, and on the rare occasions when they both inhabited the same room, they seemed somewhat bemused at the situation.
Before Amy and I got serious, got engaged, got married, I would get glimpses of Go’s thoughts in a sentence here or there. It’s funny, I can’t quite get a bead on her, like who she really is. And: You just seem kind of not yourself with her. And: There’s a difference between really loving someone and loving the idea of her. And finally: The important thing is she makes you really happy.
Back when Amy made me really happy.
Amy offered her own notions of Go: She’s very … Missouri, isn’t she? And: You just have to be in the right mood for her. And: She’s a little needy about you, but then I guess she doesn’t have anyone else.
I’d hoped when we all wound up back in Missouri, the two would let it drop – agree to disagree, free to be you and me. Neither did. Go was funnier than Amy, though, so it was a mismatched battle. Amy was clever, withering, sarcastic. Amy could get me riled up, could make an excellent, barbed point, but Go always made me laugh. It is dangerous to laugh at your spouse.
‘Go, I thought we agreed you’d never mention my genitalia again,’ I said. ‘That within the bounds of our sibling relationship, I have no genitalia.’
The phone rang. Go took one more sip of her beer and answered, gave an eyeroll and a smile. ‘He sure is here, one moment, please!’ To me, she mouthed: ‘Carl.’
Carl Pelley lived across the street from me and Amy. Retired three years. Divorced two years. Moved into our development right after. He’d been a traveling salesman – children’s party supplies – and I sensed that after four decades of motel living, he wasn’t quite at home being home. He showed up at the bar nearly every day with a pungent Hardee’s bag, complaining about his budget until he was offered a first drink on the house. (This was another thing I learned about Carl from his days in The Bar – that he was a functioning but serious alcoholic.) He had the good grace to accept whatever we were ‘trying to get rid of,’ and he meant it: For one full month Carl drank nothing but dusty Zimas, circa 1992, that we’d discovered in the basement. When a hangover kept Carl home, he’d find a reason to call: Your mailbox looks awfully full today, Nicky, maybe a package came. Or: It’s supposed to rain, you might want to close your windows. The reasons were bogus. Carl just needed to hear the clink of glasses, the glug of a drink being poured.
I picked up the phone, shaking a tumbler of ice near the receiver so Carl could imagine his gin.
‘Hey, Nicky,’ Carl’s watery voice came over. ‘Sorry to bother you. I just thought you should know … your door is wide open, and that cat of yours is outside. It isn’t supposed to be, right?’
I gave a non-commital grunt.
‘I’d go over and check, but I’m a little under the weather,’ Carl said heavily.
‘Don’t worry,’ I said. ‘It’s time for me to go home anyway.’
It was a fifteen-minute drive, straight north along River Road. Driving into our development occasionally makes me shiver, the sheer number of gaping dark houses – homes that have never known inhabitants, or homes that have known owners and seen them ejected, the house standing triumphantly voided, humanless.
When Amy and I moved in, our only neighbors descended on us: one middle-aged single mom of three, bearing a casserole; a young father of triplets with a six-pack of beer (his wife left at home with the triplets); an older Christian couple who lived a few houses down; and of course, Carl from across the street. We sat out on our back deck and watched the river, and they all talked ruefully about ARMs, and zero percent interest, and zero money down, and then they all remarked how Amy and I were the only ones with river access, the only ones without children. ‘Just the two of you? In this whole big house?’ the single mom asked, doling out a scrambled-egg something.
‘Just the two of us,’ I confirmed with a smile, and nodded in appreciation as I took a mouthful of wobbly egg.
‘Seems lonely.’
On that she was right.
Four months later, the whole big house lady lost her mortgage battle and disappeared in the night with her three kids. Her house has remained empty. The living room window still has a child’s picture of a butterfly taped to it, the bright Magic Marker sun-faded to brown. One evening not long ago, I drove past and saw a man, bearded, bedraggled, staring out from behind the picture, floating in the dark like some sad aquarium fish. He saw me see him and flickered back into the depths of the house. The next day I left a brown paper bag full of sandwiches on the front step; it sat in the sun untouched for a week, decaying wetly, until I picked it back up and threw it out.
Quiet. The complex was always disturbingly quiet. As I neared our home, conscious of the noise of the car engine, I could see the cat was definitely on the steps. Still on the steps, twenty minutes after Carl’s call. This was strange. Amy loved the cat, the cat was declawed, the cat was never let outside, never ever, because the cat, Bleecker, was sweet but extremely stupid, and despite the LoJack tracking device pelleted somewhere in his fat furry rolls, Amy knew she’d never see the cat again if he ever got out. The cat would waddle straight into the Mississippi River – deedle-de-dum – and float all the way to the Gulf of Mexico into the maw of a hungry bull shark.
But it turned out the cat wasn’t even smart enough to get past the steps. Bleecker was perched on the edge of the porch, a pudgy but proud sentinel – Private Tryhard. As I pulled in to the drive, Carl came out and stood on his own front steps, and I could feel the cat and the old man both watching me as I got out of the car and walked toward the house, the red peonies along the border looking fat and juicy, asking to be devoured.
I was about to go into blocking position to get the cat when I saw that the front door was open. Carl had said as much, but seeing it was different. This wasn’t taking-out-the-trash-back-in-a-minute open. This was wide-gaping-ominous open.
Carl hovered across the way, waiting for my response, and like some awful piece of performance art, I felt myself enacting Concerned Husband. I stood on the middle step and frowned, then took the stairs quickly, two at a time, calling out my wife’s name.
Silence.
‘Amy, you home?’
I ran straight upstairs. No Amy. The ironing board was set up, the iron still on, a dress waiting to be pressed.
‘Amy!’
As I ran back downstairs, I could see Carl still framed in the open doorway, hands on hips, watching. I swerved into the living room, and pulled up short. The carpet glinted with shards of glass, the coffee table shattered. End tables were on their sides, books slid across the floor like a card trick. Even the heavy antique ottoman was belly-up, its four tiny feet in the air like something dead. In the middle of the mess was a pair of good sharp scissors.
‘Amy!’
I began running, bellowing her name. Through the kitchen, where a kettle was burning, down to the basement, where the guest room stood empty, and then out the back door. I pounded across our yard onto the slender boat deck leading out over the river. I peeked over the side to see if she was in our rowboat, where I had found her one day, tethered to the dock, rocking in the water, her face to the sun, eyes closed, and as I’d peered down into the dazzling reflections of the river, at her beautiful, still face, she’d suddenly opened her blue eyes and said nothing to me, and I’d said nothing back and gone into the house alone.
‘Amy!’
She wasn’t on the water, she wasn’t in the house. Amy was not there.
Amy was gone.')
GO
INSERT [dbo].[Chapter] ([id], [bookId], [volumeId], [chapter], [chapterName], [status], [content]) VALUES (4, 1, 1, 4, N'Amy Elliott September 18, 2005', 1, N'– Diary entry –
Well, well, well. Guess who’s back? Nick Dunne, Brooklyn party boy, sugar-cloud kisser, disappearing act. Eight months, two weeks, couple of days, no word, and then he resurfaces, like it was all part of the plan. Turns out, he’d lost my phone number. His cell was out of juice, so he’d written it on a stickie. Then he’d tucked the stickie into his jeans pocket and put the jeans in the washer, and it turned the stickie into a piece of cyclone-shaped pulp. He tried to unravel it but could only see a 3 and an 8. (He said.)
And then work clobbered him and suddenly it was March and too embarrassingly late to try to find me. (He said.)
Of course I was angry. I had been angry. But now I’m not. Let me set the scene. (She said.) Today. Gusty September winds. I’m walking along Seventh Avenue, making a lunchtime contemplation of the sidewalk bodega bins – endless plastic containers of cantaloupe and honeydew and melon perched on ice like the day’s catch – and I could feel a man barnacling himself to my side as I sailed along, and I corner-eyed the intruder and realized who it was. It was him. The boy in ‘I met a boy!’
I didn’t break my stride, just turned to him and said:
a) ‘Do I know you?’ (manipulative, challenging)
b) ‘Oh, wow, I’m so happy to see you!’ (eager, doormatlike)
c) ‘Go fuck yourself.’ (aggressive, bitter)
d) ‘Well, you certainly take your time about it, don’t you, Nick?’ (light, playful, laid-back)
Answer: D
And now we’re together. Together, together. It was that easy.
It’s interesting, the timing. Propitious, if you will. (And I will.) Just last night was my parents’ book party. Amazing Amy and the Big Day. Yup, Rand and Marybeth couldn’t resist. They’ve given their daughter’s namesake what they can’t give their daughter: a husband! Yes, for book twenty, Amazing Amy is getting married! Wheeeeeee. No one cares. No one wanted Amazing Amy to grow up, least of all me. Leave her in kneesocks and hair ribbons and let me grow up, unencumbered by my literary alter ego, my paperbound better half, the me I was supposed to be.
But Amy is the Elliott bread and butter, and she’s served us well, so I suppose I can’t begrudge her a perfect match. She’s marrying good old Able Andy, of course. They’ll be just like my parents: happy-happy.
Still, it was unsettling, the incredibly small order the publisher put in. A new Amazing Amy used to get a first print of a hundred thousand copies back in the ’80s. Now ten thousand. The book-launch party was, accordingly, unfabulous. Off-tone. How do you throw a party for a fictional character who started life as a precocious moppet of six and is now a thirty-year-old bride-to-be who still speaks like a child? (‘Sheesh,’ thought Amy, ‘my dear fiance´ sure is a grouch-monster when he doesn’t get his way …’ That is an actual quote. The whole book made me want to punch Amy right in her stupid, spotless vagina.) The book is a nostalgia item, intended to be purchased by women who grew up with Amazing Amy, but I’m not sure who will actually want to read it. I read it, of course. I gave the book my blessing – multiple times. Rand and Marybeth feared that I might take Amy’s marriage as some jab at my perpetually single state. (‘I, for one, don’t think women should marry before thirty-five,’ said my mom, who married my dad at twenty-three.)
My parents have always worried that I’d take Amy too personally – they always tell me not to read too much into her. And yet I can’t fail to notice that whenever I screw something up, Amy does it right: When I finally quit violin at age twelve, Amy was revealed as a prodigy in the next book. (‘Sheesh, violin can be hard work, but hard work is the only way to get better!’) When I blew off the junior tennis championship at age sixteen to do a beach weekend with friends, Amy recommitted to the game. (‘Sheesh, I know it’s fun to spend time with friends, but I’d be letting myself and everyone else down if I didn’t show up for the tournament.’) This used to drive me mad, but after I went off to Harvard (and Amy correctly chose my parents’ alma mater), I decided it was all too ridiculous to think about. That my parents, two child psychologists, chose this particular public form of passive-aggressiveness toward their child was not just fucked up but also stupid and weird and kind of hilarious. So be it.
The book party was as schizophrenic as the book – at Bluenight, off Union Square, one of those shadowy salons with wingback chairs and art deco mirrors that are supposed to make you feel like a Bright Young Thing. Gin martinis wobbling on trays lofted by waiters with rictus smiles. Greedy journalists with knowing smirks and hollow legs, getting the free buzz before they go somewhere better.
My parents circulate the room hand in hand – their love story is always part of the Amazing Amy story: husband and wife in mutual creative labor for a quarter century. Soul mates. They really call themselves that, which makes sense, because I guess they are. I can vouch for it, having studied them, little lonely only child, for many years. They have no harsh edges with each other, no spiny conflicts, they ride through life like conjoined jellyfish – expanding and contracting instinctively, filling each other’s spaces liquidly. Making it look easy, the soul-mate thing. People say children from broken homes have it hard, but the children of charmed marriages have their own particular challenges.
Naturally, I have to sit on some velvety banquette in the corner of the room, out of the noise, so I can give a few interviews to a sad handful of kid interns who’ve gotten stuck with the ‘grab a quote’ assignment from their editors.
How does it feel to see Amy finally married to Andy? Because you’re not married, right?
Question asked by:
a) a sheepish, bug-eyed kid balancing a notebook on top of his messenger bag
b) an overdressed, sleek-haired young thing with fuck-me stilettos
c) an eager, tattooed rockabilly girl who seemed way more interested in Amy than one would guess a tattooed rockabilly girl would be
d) all of the above
Answer: D
Me: ‘Oh, I’m thrilled for Amy and Andy, I wish them the best. Ha, ha.’
My answers to all the other questions, in no particular order:
‘Some parts of Amy are inspired by me, and some are just fiction.’
‘I’m happily single right now, no Able Andy in my life!’
‘No, I don’t think Amy oversimplifies the male-female dynamic.’
‘No, I wouldn’t say Amy is dated; I think the series is a classic.’
‘Yes, I am single. No Able Andy in my life right now.’
‘Why is Amy amazing and Andy’s just able? Well, don’t you know a lot of powerful, fabulous women who settle for regular guys, Average Joes and Able Andys? No, just kidding, don’t write that.’
‘Yes, I am single.’
‘Yes, my parents are definitely soul mates.’
‘Yes, I would like that for myself one day.’
‘Yep, single, motherfucker.’
Same questions over and over, and me trying to pretend they’re thought-provoking. And them trying to pretend they’re thought-provoking. Thank God for the open bar.
Then no one else wants to talk to me – that fast – and the PR girl pretends it’s a good thing: Now you can get back to your party! I wriggle back into the (small) crowd, where my parents are in full hosting mode, their faces flushed – Rand with his toothy prehistoric-monster-fish smile, Marybeth with her chickeny, cheerful head bobs, their hands intertwined, making each other laugh, enjoying each other, thrilled with each other – and I think, I am so fucking lonely.
I go home and cry for a while. I am almost thirty-two. That’s not old, especially not in New York, but fact is, it’s been years since I even really liked someone. So how likely is it I’ll meet someone I love, much less someone I love enough to marry? I’m tired of not knowing who I’ll be with, or if I’ll be with anyone.
I have many friends who are married – not many who are happily married, but many married friends. The few happy ones are like my parents: They’re baffled by my singleness. A smart, pretty, nice girl like me, a girl with so many interests and enthusiasms, a cool job, a loving family. And let’s say it: money. They knit their eyebrows and pretend to think of men they can set me up with, but we all know there’s no one left, no one good left, and I know that they secretly think there’s something wrong with me, something hidden away that makes me unsatisfiable, unsatisfying.
The ones who are not soul-mated – the ones who have settled – are even more dismissive of my singleness: It’s not that hard to find someone to marry, they say. No relationship is perfect, they say – they, who make do with dutiful sex and gassy bedtime rituals, who settle for TV as conversation, who believe that husbandly capitulation – yes, honey, okay, honey – is the same as concord. He’s doing what you tell him to do because he doesn’t care enough to argue, I think. Your petty demands simply make him feel superior, or resentful, and someday he will fuck his pretty, young coworker who asks nothing of him, and you will actually be shocked. Give me a man with a little fight in him, a man who calls me on my bullshit. (But who also kind of likes my bullshit.) And yet: Don’t land me in one of those relationships where we’re always pecking at each other, disguising insults as jokes, rolling our eyes and ‘playfully’ scrapping in front of our friends, hoping to lure them to our side of an argument they could not care less about. Those awful if only relationships: This marriage would be great if only … and you sense the if only list is a lot longer than either of them realizes.
So I know I am right not to settle, but it doesn’t make me feel better as my friends pair off and I stay home on Friday night with a bottle of wine and make myself an extravagant meal and tell myself, This is perfect, as if I’m the one dating me. As I go to endless rounds of parties and bar nights, perfumed and sprayed and hopeful, rotating myself around the room like some dubious dessert. I go on dates with men who are nice and good-looking and smart – perfect-on-paper men who make me feel like I’m in a foreign land, trying to explain myself, trying to make myself known. Because isn’t that the point of every relationship: to be known by someone else, to be understood? He gets me. She gets me. Isn’t that the simple magic phrase?
So you suffer through the night with the perfect-on-paper man – the stutter of jokes misunderstood, the witty remarks lobbed and missed. Or maybe he understands that you’ve made a witty remark but, unsure of what to do with it, he holds it in his hand like some bit of conversational phlegm he will wipe away later. You spend another hour trying to find each other, to recognise each other, and you drink a little too much and try a little too hard. And you go home to a cold bed and think, That was fine. And your life is a long line of fine.
And then you run into Nick Dunne on Seventh Avenue as you’re buying diced cantaloupe, and pow, you are known, you are recognised, the both of you. You both find the exact same things worth remembering. (Just one olive, though). You have the same rhythm. Click. You just know each other. All of a sudden you see reading in bed and waffles on Sunday and laughing at nothing and his mouth on yours. And it’s so far beyond fine that you know you can never go back to fine. That fast. You think: Oh, here is the rest of my life. It’s finally arrived.')
GO
INSERT [dbo].[Chapter] ([id], [bookId], [volumeId], [chapter], [chapterName], [status], [content]) VALUES (5, 1, 1, 5, N'Nick Dunne', 1, N'I waited for the police first in the kitchen, but the acrid smell of the burnt teakettle was curling up in the back of my throat, underscoring my need to retch, so I drifted out on the front porch, sat on the top stair, and willed myself to be calm. I kept trying Amy’s cell, and it kept going to voice mail, that quick-clip cadence swearing she’d phone right back. Amy always phoned right back. It had been three hours, and I’d left five messages, and Amy had not phoned back.
I didn’t expect her to. I’d tell the police: Amy would never have left the house with the teakettle on. Or the door open. Or anything waiting to be ironed. The woman got shit done, and she was not one to abandon a project (say, her fixer-upper husband, for instance), even if she decided she didn’t like it. She’d made a grim figure on the Fiji beach during our two-week honeymoon, battling her way through a million mystical pages of The Wind-Up Bird Chronicle, casting pissy glances at me as I devoured thriller after thriller. Since our move back to Missouri, the loss of her job, her life had revolved (devolved?) around the completion of endless tiny, inconsequential projects. The dress would have been ironed.
And there was the living room, signs pointing to a struggle. I already knew Amy wasn’t phoning back. I wanted the next part to start.
It was the best time of day, the July sky cloudless, the slowly setting sun a spotlight on the east, turning everything golden and lush, a Flemish painting. The police rolled up. It felt casual, me sitting on the steps, an evening bird singing in the tree, these two cops getting out of their car at a leisurely pace, as if they were dropping by a neighborhood picnic. Kid cops, mid-twenties, confident and uninspired, accustomed to soothing worried parents of curfew-busting teens. A Hispanic girl, her hair in a long dark braid, and a black guy with a marine’s stance. Carthage had become a bit (a very tiny bit) less Caucasian while I was away, but it was still so severely segregated that the only people of color I saw in my daily routine tended to be occupational roamers: delivery men, medics, postal workers. Cops. (‘This place is so white, it’s disturbing,’ said Amy, who, back in the melting pot of Manhattan, counted a single African-American among her friends. I accused her of craving ethnic window dressing, minorities as backdrops. It did not go well.)
‘Mr Dunne? I’m Officer Velásquez,’ said the woman, ‘and this is Officer Riordan. We understand you’re concerned about your wife?’
Riordan looked down the road, sucking on a piece of candy. I could see his eyes follow a darting bird out over the river. Then he snapped his gaze back toward me, his curled lips telling me he saw what everyone else did. I have a face you want to punch: I’m a working-class Irish kid trapped in the body of a total trust-fund douchebag. I smile a lot to make up for my face, but this only sometimes works. In college, I even wore glasses for a bit, fake spectacles with clear lenses that I thought would lend me an affable, unthreatening vibe. ‘You do realize that makes you even more of a dick?’ Go reasoned. I threw them out and smiled harder.
I waved in the cops: ‘Come inside the house and see.’
The two climbed the steps, accompanied by the squeaking and shuffling noises of their belts and guns. I stood in the entry to the living room and pointed at the destruction.
‘Oh,’ said Officer Riordan, and gave a brisk crack of his knuckles. He suddenly looked less bored.
Riordan and Velásquez leaned forward in their seats at the dining room table as they asked me all the initial questions: who, where, how long. Their ears were literally pricked. A call had been made out of my hearing, and Riordan informed me that detectives were being dispatched. I had the grave pride of being taken seriously.
Riordan was asking me for the second time if I’d seen any strangers in the neighborhood lately, was reminding me for the third time about Carthage’s roving bands of homeless men, when the phone rang. I launched myself across the room and grabbed it.
A surly woman’s voice: ‘Mr Dunne, this is Comfort Hill Assisted Living.’ It was where Go and I boarded our Alzheimer’s-riddled father.
‘I can’t talk right now, I’ll call you back,’ I snapped, and hung up. I despised the women who staffed Comfort Hill: unsmiling, uncomforting. Underpaid, gruelingly underpaid, which was probably why they never smiled or comforted. I knew my anger toward them was misdirected – it absolutely infuriated me that my father lingered on while my mom was in the ground.
It was Go’s turn to send the check. I was pretty sure it was Go’s turn for July. And I’m sure she was positive it was mine. We’d done this before. Go said we must be mutually subliminally forgetting to mail those checks, that what we really wanted to forget was our dad.
I was telling Riordan about the strange man I’d seen in our neighbor’s vacated house when the doorbell rang. The doorbell rang. It sounded so normal, like I was expecting a pizza.
The two detectives entered with end-of-shift weariness. The man was rangy and thin, with a face that tapered severely into a dribble of a chin. The woman was surprisingly ugly – brazenly, beyond the scope of everyday ugly: tiny round eyes set tight as buttons, a long twist of a nose, skin spackled with tiny bumps, long lank hair the color of a dust bunny. I have an affinity for ugly women. I was raised by a trio of women who were hard on the eyes – my grandmother, my mom, her sister – and they were all smart and kind and funny and sturdy, good, good women. Amy was the first pretty girl I ever dated, really dated.
The ugly woman spoke first, an echo of Miss Officer Velásquez. ‘Mr Dunne? I’m Detective Rhonda Boney. This is my partner, Detective Jim Gilpin. We understand there are some concerns about your wife.’
My stomach growled loud enough for us all to hear it, but we pretended we didn’t.
‘We take a look around, sir?’ Gilpin said. He had fleshy bags under his eyes and scraggly white whiskers in his mustache. His shirt wasn’t wrinkled, but he wore it like it was; he looked like he should stink of cigarettes and sour coffee, even though he didn’t. He smelled like Dial soap.
I led them a few short steps to the living room, pointed once again at the wreckage, where the two younger cops were kneeling carefully, as if waiting to be discovered doing something useful. Boney steered me toward a chair in the dining room, away from but in view of the signs of struggle.
Rhonda Boney walked me through the same basics I’d told Velásquez and Riordan, her attentive sparrow eyes on me. Gilpin squatted down on a knee, assessing the living room.
‘Have you phoned friends or family, people your wife might be with?’ Rhonda Boney asked.
‘I … No. Not yet. I guess I was waiting for you all.’
‘Ah.’ She smiled. ‘Let me guess: baby of the family.’
‘What?’
‘You’re the baby.’
‘I have a twin sister.’ I sensed some internal judgment being made. ‘Why?’ Amy’s favorite vase was lying on the floor, intact, bumped up against the wall. It was a wedding present, a Japanese masterwork that Amy put away each week when our housecleaner came because she was sure it would get smashed.
‘Just a guess of mine, why you’d wait for us: You’re used to someone else always taking the lead,’ Boney said. ‘That’s what my little brother is like. It’s a birth-order thing.’ She scribbled something on a notepad.
‘Okay.’ I gave an angry shrug. ‘Do you need my sun sign too, or can we get started?’
Boney smiled at me kindly, waiting.
‘I waited to do something because, I mean, she’s obviously not with a friend,’ I said, pointing at the disarray in the living room.
‘You’ve lived here, what, Mr Dunne, two years?’ she asked.
‘Two years September.’
‘Moved from where?’
‘New York.’
‘City?’
‘Yes.’
She pointed upstairs, asking permission without asking, and I nodded and followed her, Gilpin following me.
‘I was a writer there,’ I blurted out before I could stop myself. Even now, two years back here, and I couldn’t bear for someone to think this was my only life.
Boney: ‘Sounds impressive.’
Gilpin: ‘Of what?’
I timed my answer to my stair climbing: I wrote for a magazine (step), I wrote about pop culture (step) for a men’s magazine (step). At the top of the stairs, I turned to see Gilpin looking back at the living room. He snapped to.
‘Pop culture?’ he called up as he began climbing. ‘What exactly does that entail?’
‘Popular culture,’ I said. We reached the top of the stairs, Boney waiting for us. ‘Movies, TV, music, but, uh, you know, not high arts, nothing hifalutin.’ I winced: hifalutin? How patronizing. You two bumpkins probably need me to translate my English, Comma, Educated East Coast into English, Comma, Midwest Folksy. Me do sum scribbling of stuffs I get in my noggin after watchin’ them movin’ pitchers!
‘She loves movies,’ Gilpin said, gesturing toward Boney. Boney nodded: I do.
‘Now I own The Bar, downtown,’ I added. I taught a class at the junior college too, but to add that suddenly felt too needy. I wasn’t on a date.
Boney was peering into the bathroom, halting me and Gilpin in the hallway. ‘The Bar?’ she said. ‘I know the place. Been meaning to drop by. Love the name. Very meta.’
‘Sounds like a smart move,’ Gilpin said. Boney made for the bedroom, and we followed. ‘A life surrounded by beer ain’t too bad.’
‘Sometimes the answer is at the bottom of a bottle,’ I said, then winced again at the inappropriateness.
We entered the bedroom.
Gilpin laughed. ‘Don’t I know that feeling.’
‘See how the iron is still on?’ I began.
Boney nodded, opened the door of our roomy closet, and walked inside, flipping on the light, fluttering her latexed hands over shirts and dresses as she moved toward the back. She made a sudden noise, bent down, turned around – holding a perfectly square box covered in elaborate silver wrapping.
My stomach seized.
‘Someone’s birthday?’ she asked.
‘It’s our anniversary.’
Boney and Gilpin both twitched like spiders and pretended they didn’t.
By the time we returned to the living room, the kid officers were gone. Gilpin got down on his knees, eyeing the overturned ottoman.
‘Uh, I’m a little freaked out, obviously,’ I started.
‘I don’t blame you at all, Nick,’ Gilpin said earnestly. He had pale blue eyes that jittered in place, an unnerving tic.
‘Can we do something? To find my wife. I mean, because she’s clearly not here.’
Boney pointed at the wedding portrait on the wall: me in my tux, a block of teeth frozen on my face, my arms curved formally around Amy’s waist; Amy, her blond hair tightly coiled and sprayed, her veil blowing in the beach breeze of Cape Cod, her eyes open too wide because she always blinked at the last minute and she was trying so hard not to blink. The day after Independence Day, the sulfur from the fireworks mingling with the ocean salt – summer.
The Cape had been good to us. I remember discovering several months in that Amy, my girlfriend, was also quite wealthy, a treasured only child of creative-genius parents. An icon of sorts, thanks to a namesake book series that I thought I could remember as a kid. Amazing Amy. Amy explained this to me in calm, measured tones, as if I were a patient waking from a coma. As if she’d had to do it too many times before and it had gone badly – the admission of wealth that’s greeted with too much enthusiasm, the disclosure of a secret identity that she herself didn’t create.
Amy told me who and what she was, and then we went out to the Elliotts’ historically registered home on Nantucket Sound, went sailing together, and I thought: I am a boy from Missouri, flying across the ocean with people who’ve seen much more than I have. If I began seeing things now, living big, I could still not catch up with them. It didn’t make me feel jealous. It made me feel content. I never aspired to wealth or fame. I was not raised by big-dreamer parents who pictured their child as a future president. I was raised by pragmatic parents who pictured their child as a future office worker of some sort, making a living of some sort. To me, it was heady enough to be in the Elliotts’ proximity, to skim across the Atlantic and return to a plushly restored home built in 1822 by a whaling captain, and there to prepare and eat meals of organic, healthful foods whose names I didn’t know how to pronounce. Quinoa. I remember thinking quinoa was a kind of fish.
So we married on the beach on a deep blue summer day, ate and drank under a white tent that billowed like a sail, and a few hours in, I sneaked Amy off into the dark, toward the waves, because I was feeling so unreal, I believed I had become merely a shimmer. The chilly mist on my skin pulled me back, Amy pulled me back, toward the golden glow of the tent, where the Gods were feasting, everything ambrosia. Our whole courtship was just like that.
Boney leaned in to examine Amy. ‘Your wife is very pretty.’
‘She is, she’s beautiful,’ I said, and felt my stomach lilt.
‘What anniversary today?’ she asked.
‘Five.’
I was jittering from one foot to another, wanting to do something. I didn’t want them to discuss how lovely my wife was, I wanted them to go out and search for my fucking wife. I didn’t say this out loud, though; I often don’t say things out loud, even when I should. I contain and I compartmentalize to a disturbing degree: In my belly-basement are hundreds of bottles of rage, despair, fear, but you’d never guess from looking at me.
‘Five, big one. Let me guess, reservations at Houston’s?’ Gilpin asked. It was the only upscale restaurant in town. You all really need to try Houston’s, my mom had said when we moved back, thinking it was Carthage’s unique little secret, hoping it might please my wife.
‘Of course, Houston’s.’
It was my fifth lie to the police. I was just starting.')
GO
SET IDENTITY_INSERT [dbo].[Chapter] OFF
GO