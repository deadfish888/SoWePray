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
	[views] int
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
CREATE TABLE [dbo].[ResetToken](
	[uid] int not null,
	[token] [varchar](20) not null,
	[expired_date] datetime not null
	)
GO
ALTER TABLE [dbo].[ResetToken]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[User] (id)
/****** Object:  Table [dbo].[Index]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Volume](
	[bid] int not null,
	[vol] int not null,
	[vol_name] nvarchar(100),
	CONSTRAINT [PK_vol] PRIMARY KEY CLUSTERED 
(
	[bid],[vol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Volume]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Book] (id)
/****** Object:  Table [dbo].[Chapter]    BOOKIE ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Chapter](
	[bid] int not null,
	[vol] int not null,
	[chapter] int not null,
	[chapter_name] nvarchar(100),
	content ntext not null,
	CONSTRAINT [PK_chapter] PRIMARY KEY CLUSTERED 
(
	[bid],[vol],[chapter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD FOREIGN KEY([bid],[vol])
REFERENCES [dbo].[Volume] ([bid],[vol])
---------------------------------------------------
ALTER TABLE [dbo].[Book] ADD  DEFAULT (0) FOR [views]

ALTER TABLE [dbo].[User] ADD  DEFAULT (0) FOR [is_super]

--ALTER TABLE [dbo].[Book] ADD  DEFAULT ('UNDECIDED') FOR [type]


--ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(did)
--REFERENCES [dbo].[Discount] (id)
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY(categoryid)
REFERENCES [dbo].[Category] (id)
GO

--ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [CK_user_id] CHECK  (([user_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [user_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))
GO
INSERT [dbo].[User] ([fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES ( N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhnthe163219@fpt.edu.vn', N'0382132025', N'FBT University ', N'admin', N'admin',1)
go
INSERT [dbo].[User] ([fullname], [gender], [dob], [email], [phone], [address], [username], [password], [is_super]) VALUES ( N'Vinh Nguyen', 1, CAST(N'2002-12-25' AS Date), N'vinhvn102@gmail.com', N'0382132025', N'FBT University ', N'vinh', N'2002',0)
GO
Insert [dbo].[Category] ([name]) values (N'Crime, Thriller & Mystery'),(N'Fantasy, Horror'),(N'Science/Historical Fiction'),(N'Manga&LN')
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (1, N'Gone Girl ', N'Gillian Flynn', 1, NULL, 12, CAST(11.99 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1554086139l/19288043.jpg', N'Marriage can be a real killer.<br>
On a warm summer morning in North Carthage, Missouri, it is Nick and Amy Dunne’s fifth wedding anniversary. Presents are being wrapped and reservations are being made when Nick’s clever and beautiful wife disappears from their rented McMansion on the Mississippi River. Husband-of-the-Year Nick isn’t doing himself any favors with cringe-worthy daydreams about the slope and shape of his wife’s head, but passages from Amy''s diary reveal the alpha-girl perfectionist could have put anyone dangerously on edge. Under mounting pressure from the police and the media—as well as Amy’s fiercely doting parents—the town golden boy parades an endless series of lies, deceits, and inappropriate behavior. Nick is oddly evasive, and he’s definitely bitter—but is he really a killer?<br>
As the cops close in, every couple in town is soon wondering how well they know the one that they love. With his twin sister, Margo, at his side, Nick stands by his innocence. Trouble is, if Nick didn’t do it, where is that beautiful wife? And what was in that silvery gift box hidden in the back of her bedroom closet?', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (2, N'And Then There Were None', N'Agatha Christie', 1, NULL, 20, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1638425885l/16299._SY475_.jpg', N'First, there were ten—a curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they''re unwilling to reveal—and a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:<br>
"Ten little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he''d stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none."<br>
When they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (3, N'The Silent Patient', N'Alex Michaelides', 1, NULL, 19, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1582759969l/40097951._SX318_.jpg', N'Alicia Berenson’s life is seemingly perfect. A famous painter married to an in-demand fashion photographer, she lives in a grand house with big windows overlooking a park in one of London’s most desirable areas. One evening her husband Gabriel returns home late from a fashion shoot, and Alicia shoots him five times in the face, and then never speaks another word.<br>
Alicia’s refusal to talk, or give any kind of explanation, turns a domestic tragedy into something far grander, a mystery that captures the public imagination and casts Alicia into notoriety. The price of her art skyrockets, and she, the silent patient, is hidden away from the tabloids and spotlight at the Grove, a secure forensic unit in North London.<br>
Theo Faber is a criminal psychotherapist who has waited a long time for the opportunity to work with Alicia. His determination to get her to talk and unravel the mystery of why she shot her husband takes him down a twisting path into his own motivations—a search for the truth that threatens to consume him....', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (4, N'The Girl on the Train', N'Paula Hawkins', 1, NULL, 22, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1574805682l/22557272.jpg', N'Rachel catches the same commuter train every morning. She knows it will wait at the same signal each time, overlooking a row of back gardens. She’s even started to feel like she knows the people who live in one of the houses. “Jess and Jason,” she calls them. Their life—as she sees it—is perfect. If only Rachel could be that happy. And then she sees something shocking. It’s only a minute until the train moves on, but it’s enough. Now everything’s changed. Now Rachel has a chance to become a part of the lives she’s only watched from afar. Now they’ll see; she’s much more than just the girl on the train...', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (5, N'Lord of the Mysteries', N'Cuttlefish That Loves Diving', 2, NULL, 20, CAST(11.99 AS Decimal(10, 2)), 1, N'https://cdn.novelupdates.com/images/2018/11/Lord-of-the-Mysteries.jpeg', N'Waking up to be faced with a string of mysteries, Zhou Mingrui finds himself reincarnated as Klein Moretti in an alternate Victorian era world where he sees a world filled with machinery, cannons, dreadnoughts, airships, difference machines, as well as Potions, Divination, Hexes, Tarot Cards, Sealed Artifacts… The Light continues to shine but the mystery has never gone far. Follow Klein as he finds himself entangled with the Churches of the world—both orthodox and unorthodox—while he slowly develops newfound powers thanks to the Beyonder potions.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (6, N'The Shining', N' Stephen King', 2, NULL, 15, CAST(12.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1353277730l/11588.jpg', N'Jack Torrance''s new job at the Overlook Hotel is the perfect chance for a fresh start. As the off-season caretaker at the atmospheric old hotel, he''ll have plenty of time to spend reconnecting with his family and working on his writing. But as the harsh winter weather sets in, the idyllic location feels ever more remote...and more sinister. And the only one to notice the strange and terrible forces gathering around the Overlook is Danny Torrance, a uniquely gifted five-year-old.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (7, N'It', N'Stephen King', 2, NULL, 13, CAST(10.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1334416842l/830502.jpg', N'Welcome to Derry, Maine ...<br>
It’s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...<br>
They were seven teenagers when they first stumbled upon the horror. Now they are grown-up men and women who have gone out into the big world to gain success and happiness. But none of them can withstand the force that has drawn them back to Derry to face the nightmare without an end, and the evil without a name.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (8, N'A Game Of Thrones: A Song of Ice and Fire', N'George RR Martin', 2, NULL, 21, CAST(13.99 AS Decimal(10, 2)), 0, N'https://m.media-amazon.com/images/P/0553386794.01._SCLZZZZZZZ_SX500_.jpg', N'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister and supernatural forces are massing beyond the kingdom’s protective Wall. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the land they were born to. Sweeping from a land of brutal cold to a distant summertime kingdom of epicurean plenty, here is a tale of lords and ladies, soldiers and sorcerers, assassins and bastards, who come together in a time of grim omens.
<br>
Here an enigmatic band of warriors bear swords of no human metal; a tribe of fierce wildlings carry men off into madness; a cruel young dragon prince barters his sister to win back his throne; and a determined woman undertakes the most treacherous of journeys. Amid plots and counterplots, tragedy and betrayal, victory and terror, the fate of the Starks, their allies, and their enemies hangs perilously in the balance, as each endeavors to win that deadliest of conflicts: the game of thrones.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (9, N'The Hunger Games', N'Suzanne Collins', 3, NULL, 10, CAST(15.00 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1586722975l/2767052.jpg', N'Could you survive on your own in the wild, with every one out to make sure you don''t live to see the morning?
<br>
In the ruins of a place once known as North America lies the nation of Panem, a shining Capitol surrounded by twelve outlying districts. The Capitol is harsh and cruel and keeps the districts in line by forcing them all to send one boy and one girl between the ages of twelve and eighteen to participate in the annual Hunger Games, a fight to the death on live TV.
<br>
Sixteen-year-old Katniss Everdeen, who lives alone with her mother and younger sister, regards it as a death sentence when she steps forward to take her sister''s place in the Games. But Katniss has been close to dead before—and survival, for her, is second nature. Without really meaning to, she becomes a contender. But if she is to win, she will have to start making choices that weight survival against humanity and life against love.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (10, N'The Time Machine', N'H.G. Wells, Greg Bear', 3, NULL, 12, CAST(12.50 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg', N'“I’ve had a most amazing time....”<br>
So begins the Time Traveller’s astonishing firsthand account of his journey 800,000 years beyond his own era—and the story that launched H.G. Wells’s successful career and earned him his reputation as the father of science fiction. With a speculative leap that still fires the imagination, Wells sends his brave explorer to face a future burdened with our greatest hopes...and our darkest fears. A pull of the Time Machine’s lever propels him to the age of a slowly dying Earth.  There he discovers two bizarre races—the ethereal Eloi and the subterranean Morlocks—who not only symbolize the duality of human nature, but offer a terrifying portrait of the men of tomorrow as well.  Published in 1895, this masterpiece of invention captivated readers on the threshold of a new century.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (11, N'Outlander', N'Diana Gabaldon', 3, NULL, 14, CAST(13.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1529065012l/10964._SY475_.jpg', N'The year is 1945. Claire Randall, a former combat nurse, is just back from the war and reunited with her husband on a second honeymoon when she walks through a standing stone in one of the ancient circles that dot the British Isles. Suddenly she is a Sassenach—an “outlander”—in a Scotland torn by war and raiding border clans in the year of Our Lord...1743.
<br>
Hurled back in time by forces she cannot understand, Claire is catapulted into the intrigues of lairds and spies that may threaten her life, and shatter her heart. For here James Fraser, a gallant young Scots warrior, shows her a love so absolute that Claire becomes a woman torn between fidelity and desire—and between two vastly different men in two irreconcilable lives.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (12, N'All the Light We Cannot See', N'Anthony Doerr', 3, NULL, 13, CAST(10.99 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1451445646l/18143977.jpg', N'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure’s reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museum’s most valuable and dangerous jewel.
<br>In a mining town in Germany, Werner Pfennig, an orphan, grows up with his younger sister, enchanted by a crude radio they find that brings them news and stories from places they have never seen or imagined. Werner becomes an expert at building and fixing these crucial new instruments and is enlisted to use his talent to track down the resistance. Deftly interweaving the lives of Marie-Laure and Werner, Doerr illuminates the ways, against all odds, people try to be good to one another.', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (13, N'Fullmetal Alchemist, Vol. 1', N'Hiromu Arakawa', 4, NULL, 15, CAST(9.35 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1388179331l/870.jpg', N'Breaking the laws of nature is a serious crime!
<br>In an alchemical ritual gone wrong, Edward Elric lost his arm and his leg, and his brother Alphonse became nothing but a soul in a suit of armor. Equipped with mechanical “auto-mail” limbs, Edward becomes a state alchemist, seeking the one thing that can restore his and his brother’s bodies...the legendary Philosopher’s Stone.
<br>Alchemy: the mystical power to alter the natural world; something between magic, art and science. When two brothers, Edward and Alphonse Elric, dabbled in this power to grant their dearest wish, one of them lost an arm and a leg…and the other became nothing but a soul locked into a body of living steel. Now Edward is an agent of the government, a slave of the military-alchemical complex, using his unique powers to obey orders…even to kill. Except his powers aren''t unique. The world has been ravaged by the abuse of alchemy. And in pursuit of the ultimate alchemical treasure, the Philosopher''s Stone, their enemies are even more ruthless than they are…', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (14, N'Death Note, Vol. 1: Boredom', N'Tsugumi Ohba', 4, NULL, 15, CAST(10.40 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1419952134l/13615.jpg', N'Light Yagami is an ace student with great prospects - and he''s bored out of his mind. But all that changes when he finds the Death Note, a notebook dropped by a rogue Shinigami, a death god. Any human whose name is written in the notebook dies, and now Light has vowed to use the power of the Death Note to rid the world of evil. But when criminals begin dropping dead, the authorities send the legendary detective L to track down the killer. With L hot on his heels, will Light lose sight of his noble goal... or his life?', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (15, N'One Piece, Volume 1: Romance Dawn', N'Eiichiro Oda', 4, NULL, 15, CAST(11.00 AS Decimal(10, 2)), 1, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1318523719l/1237398.jpg', N'A new shonen sensation in Japan, this series features Monkey D. Luffy, whose main ambition is to become a pirate. Eating the Gum-Gum Fruit gives him strange powers but also invokes the fruit''s curse: anybody who consumes it can never learn to swim. Nevertheless, Monkey and his crewmate Roronoa Zoro, master of the three-sword fighting style, sail the Seven Seas of swashbuckling adventure in search of the elusive treasure "One Piece."', 0)
GO
INSERT [dbo].[Book] ([id], [title], [author], [categoryid], [rating], [favourite], [price], [is_sale], [image], [description], [views]) VALUES (16, N'Classroom of the Elite Vol. 1', N'Syougo Kinugasa', 4, NULL, 15, CAST(9.69 AS Decimal(10, 2)), 0, N'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1540974678l/41085104.jpg', N'Students of the prestigious Tokyo Metropolitan Advanced Nurturing High School are given remarkable freedom—if they can win, barter, or save enough points to work their way up the ranks! Ayanokoji Kiyotaka has landed at the bottom in the scorned Class D, where he meets Horikita Suzune, who’s determined to rise up the ladder to Class A. Can they beat the system in a school where cutthroat competition is the name of the game?', 0)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
