USE [VideoShop]
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

/****** Object:  FullTextCatalog [BalloonShopFullText]    Script Date: 6/14/2016 10:56:39 PM ******/
CREATE FULLTEXT CATALOG [BalloonShopFullText]AS DEFAULT
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [money] NOT NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[PromoFront] [bit] NOT NULL,
	[PromoDept] [bit] NOT NULL,
	[newOne] [nchar](10) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[OrderDetails]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrderDetails]
AS
SELECT        dbo.OrderDetail.ProductID, dbo.OrderDetail.ProductName, dbo.Product.Thumbnail, dbo.OrderDetail.OrderID, dbo.OrderDetail.Quantity, dbo.OrderDetail.UnitCost, dbo.OrderDetail.Subtotal
FROM            dbo.Product INNER JOIN
                         dbo.OrderDetail ON dbo.Product.ProductID = dbo.OrderDetail.ProductID


GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ProdsInCats]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProdsInCats]
AS
SELECT dbo.Product.ProductID, dbo.Product.Name, dbo.Product.Description, dbo.Product.Price, dbo.Product.Thumbnail, dbo.ProductCategory.CategoryID
FROM   dbo.Product INNER JOIN
            dbo.ProductCategory ON dbo.Product.ProductID = dbo.ProductCategory.ProductID



GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attribute](
	[AttributeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeValue]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValue](
	[AttributeValueID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeID] [int] NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/14/2016 10:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateShipped] [smalldatetime] NULL,
	[Verified] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[Canceled] [bit] NOT NULL,
	[Comments] [nvarchar](1000) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[ShippingAddress] [nvarchar](500) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttributeValue]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributeValue](
	[ProductID] [int] NOT NULL,
	[AttributeValueID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[AttributeValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[CartID] [char](36) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Attributes] [nvarchar](1000) NULL,
	[DateAdded] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (2, 1, N'Adventure', N'"An adventure game is a video game in which the player assumes the role of protagonist in an interactive story driven by exploration and puzzle-solving. The genre''s
focus on story allows it to draw heavily from other narrative-based media such as literature and film, encompassing a wide variety of literary genres. Nearly all adventure games (text and graphic) are designed for a single player, since this emphasis on story and character makes multi-player design difficult."
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (3, 1, N'Platformer', N'"A platform game (or platformer) is a video game which involves guiding an avatar to jump between suspended platforms, over obstacles, or both to advance the game.
These challenges are known as jumping puzzles or freerunning. The player controls the jumps to avoid letting the avatar fall from platforms or miss necessary jumps."
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (4, 1, N'Fighting
', N'Fighting game is a video game genre in which the player controls an on-screen character and engages in close combat with an opponent. These characters tend to be of equal power and fight matches consisting of several rounds, which take place in an arena.  Players must master techniques such as blocking, counter-attacking, and chaining together sequences of attacks known as "combos".
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (5, 1, N'Shooter', N'Shooter games are a sub-genre of action game, which often test the player''s speed and reaction time. It includes many subgenres that have the commonality of focusing on the actions of the avatar using some sort of weapon.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (6, 1, N'RPG', N'A role-playing game (RPG) is a game in which each participant assumes the role of a character, generally in a fantasy or science fiction setting, that can interact within the game''s imaginary world.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (7, 1, N'Action', N'The action game is a video game genre that emphasizes physical challenges, including hand–eye coordination and reaction-time.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (12, 2, N'Shooter', N'Shooter games are a sub-genre of action game, which often test the player''s speed and reaction time. It includes many subgenres that have the commonality of focusing on the actions of the avatar using some sort of weapon.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (13, 2, N'RPG', N'A role-playing game (RPG) is a game in which each participant assumes the role of a character, generally in a fantasy or science fiction setting, that can interact within the game''s imaginary world.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (14, 2, N'Action', N'The action game is a video game genre that emphasizes physical challenges, including hand–eye coordination and reaction-time.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (15, 3, N'Sports', N'A sports game is a video game that simulates the practice of traditional sports.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (16, 3, N'Adventure', N'"An adventure game is a video game in which the player assumes the role of protagonist in an interactive story driven by exploration and puzzle-solving. The genre''s
focus on story allows it to draw heavily from other narrative-based media such as literature and film, encompassing a wide variety of literary genres. Nearly all adventure games (text and graphic) are designed for a single player, since this emphasis on story and character makes multi-player design difficult."
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (20, 3, N'RPG', N'A role-playing game (RPG) is a game in which each participant assumes the role of a character, generally in a fantasy or science fiction setting, that can interact within the game''s imaginary world.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (21, 3, N'Action', N'The action game is a video game genre that emphasizes physical challenges, including hand–eye coordination and reaction-time.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (26, 4, N'Shooter', N'Shooter games are a sub-genre of action game, which often test the player''s speed and reaction time. It includes many subgenres that have the commonality of focusing on the actions of the avatar using some sort of weapon.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (27, 4, N'RPG', N'A role-playing game (RPG) is a game in which each participant assumes the role of a character, generally in a fantasy or science fiction setting, that can interact within the game''s imaginary world.
')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (28, 4, N'Action', N'The action game is a video game genre that emphasizes physical challenges, including hand–eye coordination and reaction-time.
')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (1, N'Wii            ', N'Nintendo Wii is a video game console released by Nintendo. The Nintendo Wii console is connected to a TV monitor and plays Wii-specific video games in the shape of regular DVD''s. Wii brings people of all ages and video game experience together to play, and is usually known as the family-fun console.')
INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (2, N'PS             ', N'The PlayStation 4 (officially abbreviated as PS4) is a home video game console from Sony Computer Entertainment.                                                                                                                                                                                            ')
INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (3, N'PC             ', N'PC games, also know as computer games, are video games played on a general-purpose personal computer(Windows, Linux and Mac) rather than a dedicated video game console or arcade machine.                                                                                                                  ')
INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (4, N'Xbox           ', N'Discover the ultimate in entertainment with Xbox One, the all-in-one gaming system you won''t be able to stop playing. Browse our selection of Xbox One console bundles, which come with a variety of games and accessories to enhance your gaming experience.                                               ')
SET IDENTITY_INSERT [dbo].[Department] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (1, 1, N'The Legend of Zelda:Skyward Sword', 1, 59.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (2, 18, N'Tom Clancy''s The Division', 1, 59.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (3, 15, N'The Order: 1886', 1, 66.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (4, 2, N'Super Mario Galaxy 2', 1, 59.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (5, 23, N'Football Manager 2015', 1, 54.9900)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (5, 24, N'DOTA 2', 2, 26.3700)
INSERT [dbo].[OrderDetail] ([OrderID], [ProductID], [ProductName], [Quantity], [UnitCost]) VALUES (5, 33, N'Alien: Isolation
', 8, 64.9900)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [CustomerEmail], [ShippingAddress]) VALUES (1, CAST(N'2014-11-28T09:26:00' AS SmallDateTime), NULL, 0, 0, 0, N'in time', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [CustomerEmail], [ShippingAddress]) VALUES (2, CAST(N'2014-11-28T09:40:00' AS SmallDateTime), NULL, 1, 1, 0, N'Woo-hoo!', NULL, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [CustomerEmail], [ShippingAddress]) VALUES (3, CAST(N'2014-11-28T09:46:00' AS SmallDateTime), NULL, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [CustomerEmail], [ShippingAddress]) VALUES (4, CAST(N'2014-12-08T13:50:00' AS SmallDateTime), NULL, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [DateCreated], [DateShipped], [Verified], [Completed], [Canceled], [Comments], [CustomerName], [CustomerEmail], [ShippingAddress]) VALUES (5, CAST(N'2016-06-10T14:01:00' AS SmallDateTime), NULL, 0, 0, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (1, N'The Legend of Zelda:Skyward Sword', N'Skyward Sword follows an incarnation of the series protagonist Link who was raised in a society above the clouds known as Skyloft. After his closest childhood friend, Zelda, is swept into the land below the clouds
by demonic forces, Link does whatever it takes to save her, traveling 
between Skyloft and the surface below while battling the dark forces of 
the self-proclaimed "Demon Lord", Ghirahim.', 59.9900, N'SkwardSword__Image_TH.jpg', N'SkwardSword__Image.jpg', 1, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (2, N'Super Mario Galaxy 2', N'The story follows Mario as he pursues the Koopa King, Bowser into outer space,
where he has imprisoned Princess Peach and taken control of the universe using Power Stars. 
Mario must travel across various galaxies to recover the
Power Stars in order to travel to the center of the universe and rescue the princess.', 59.9900, N'SuperMarioGalaxy_Image_TH.jpg', N'SuperMarioGalaxy_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (3, N'Super Smash Bros. Brawl', N'Super Smash Bros. Brawlis a crossover fighting game published by Nintendo, featuring characters from established video games.
The gameplay differs from traditional fighters for focusing on knocking
opponents out of the stage instead of depleting life bars.', 59.9900, N'SuperSmashBrosBrawl_Image_TH.jpg', N'SuperSmashBrosBrawl_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (4, N'Metroid Prime Trilogy', N'Metroid Prime: Trilogy is an action-adventure video game compilation developed by Retro Studios and published by Nintendo for the Wii video game console. 
The compilation features three games from the Metroid series: Metroid Prime, Metroid Prime 2: Echoes, and Metroid Prime 3: Corruption. Prime and Echoes, which were originally released for the Nintendo GameCube', 59.9900, N'MetroidPrimeTrilogy_Image_TH.jpg', N'MetroidPrimeTrilogy_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (5, N'Donkey Kong Country Returns', N'Donkey Kong Country Returns is a 2010 side-scrolling platformer video game developed by Retro Studios and published by Nintendo for the Wii console. 
Players take control of the series''s protagonist Donkey Kong, as well as his friend Diddy Kong in certain situations,[5] with many traditional elements of the Donkey Kong Country
series returning, including mine cart levels, the ability to swing 
between vines and collect bananas, and the golden "KONG" puzzle pieces.', 59.9900, N'donkeykongcuontryreturns_TH.png', N'donkeykongcuontryreturns.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (6, N'New Super Mario Bros. Wii', N'New Super Mario Bros. Wii follows Mario as he fights his way through Bowser''s henchmen to rescue Princess Peach. Mario has access to several power-ups
that help him complete his quest, including the Ice Flower, the Fire 
Flower, and the Starman, each giving him unique abilities. While 
traveling through up to nine worlds with a total of 80 levels, Mario 
must defeat Bowser''s children (the Koopalings and Bowser Jr.), Kamek, and Bowser himself before finally saving Princess Peach.', 59.9900, N'NewSuperMarioBrosWii_Image_TH.jpg', N'NewSuperMarioBrosWii_Image.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (7, N'Tatsunoko vs Capcom:Ultimate All Stars', N'Tatsunoko vs. Capcom: Ultimate All-Stars is a crossover fighting game developed by Eighting and published by Capcom. 
Tatsunoko vs. Capcom is a tag team-based fighting game
in which players control characters with different attacks and fighting
styles, and engage in combat to deplete their opponent''s life gauge.[2][3] The gameplay is set in a 2.5D environment where the characters are rendered in three-dimensional graphics, but their movements are restricted to a two dimensional plane; they may only move left and right, and upward through the air.[3] Each player may select a team of two characters and can switch between them during combat.', 59.9900, N'TatsunokoVSCapcom_Image_TH.jpg', N'TatsunokoVSCapcom_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (8, N'The Last Story', N'The Last Story (ラストストーリー Rasuto Sutōrī?) is a third-person action role-playing game with stealth and strategy elements,[6] directed by Hironobu Sakaguchi and developed by Mistwalker and AQ Interactive for the Wii. It was published by Nintendo in Japan and Europe and by Xseed Games
in North America, and is copyrighted by Nintendo. Set on the fictional 
Lazulis Island, the game story focuses on a group of mercenaries from a 
desolate continent as they seek work, discovering the world''s slow 
destruction in the process.', 59.9900, N'TheLastStory_Image_TH.jpg', N'TheLastStory_Image.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (9, N'Xenoblade Chronicles', N'The game follows Shulk
and his band of friends as they search for answers about the mysterious
"Monado" sword and defend their homeland from the violent robotic 
"Mechon" race of creatures. The game contains a open world design and strongly emphasizes exploration of the world''s large size.', 59.9900, N'XenobladeChronicles_Image_TH.jpg', N'XenobladeChronicles_Image.jpg', 1, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (10, N'Dead Space: Extraction', N'Dead Space: Extraction is a 2009 rail shooter and prequel to the 2008 video game Dead Space.
Extraction is a first-person rail shooter introducing new enemies, characters, weapons and environments to the Dead Space series. Players also have some degree of control over the camera. The game uses the pointer function of the Wii Remote for aiming at enemies and can also be controlled through the Wii Zapper.', 59.9900, N'DeadSpaceExtraction_Image_TH.jpg', N'DeadSpaceExtraction_Image.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (11, N'No More Heroes 2', N'No More Heroes 2: Desperate Struggle is an action video game developed for the Wii video game system. 
Three years have passed since Travis Touchdown
became the top assassin in the United Assassins Association (UAA). Realizing that he has the opportunity to make it to the top, he sets out
to secure himself the coveted position of number one hitman in the UAA.', 59.9900, N'NoMoreHeroes2_Image_TH.jpg', N'NoMoreHeroes2_Image.jpg', 1, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (12, N'Super Paper Mario', N'Super Paper Mario (スーパーペーパーマリオ Sūpā Pēpā Mario?) is a 2007 platform action role-playing game developed by Intelligent Systems and published by Nintendo for the Wii video game console. It is the third game in the Paper Mario series of Mario role-playing games.
The game departs from the gameplay featured in earlier Paper Mario titles, primarily featuring side scrolling platforming gameplay with role-playing elements.', 59.9900, N'SuperPaperMario_Image_TH.jpg', N'SuperPaperMario_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (13, N'Monster Hunter Tri', N'Players of Monster Hunter Tri take on the role of a monster 
slayer from the Guild, assigned to help revitalize Moga Village, a small
fishing community that is under threat of monsters from a nearby 
deserted island. The player does this by completing free hunts on the 
island, where they collect materials and slay or capture monsters which 
are converted into resources that can be used to improve the village.', 59.9900, N'MonsterHunter3_Image_TH.jpg', N'MonsterHunter3_Image.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (14, N'Assassin''s Creed Unity', N'In addition to an epic single-player campaign, join with up to three friends online and experience the open world of 18th-century Paris', 77.9600, N'ps4sass01.jpg', N'ps4bass01.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (15, N'The Order: 1886', N'The Order: 1886 is set in an alternate history London, where an old order of knights keep all of the world safe from half breed monsters, who are a combination of animal and man. In the game''s history, around the seventh or eighth centuries a small number of humans took on bestial traits. The majority of humans feared these half breeds and war broke out. Despite the humans outnumbering the half breeds, their animal strength gave them the upper hand in centuries of conflict.', 66.9900, N'ps4stheotder.jpg', N'ps4btheotder.png', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (16, N'Witcher 3 Wild Hunt', N'The Witcher 3: Wild Hunt (Polish: Wiedźmin 3: Dziki Gon) is an upcoming action role-playing video game set in an open world environment, that is currently in development by Polish video game developer CD Projekt RED.', 59.9900, N'ps4switcher.jpg', N'ps4bwitcher.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (17, N'Uncharted 4', N'Uncharted 4: A Thief''s End is an upcoming 2015 action-adventure third-person shooter platform video game published by Sony Computer Entertainment and developed by Naughty Dog exclusively for the PlayStation 4.', 59.9900, N'ps4suncharted.jpg', N'ps4buncharted.jpg', 1, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (18, N'Tom Clancy''s The Division', N'Tom Clancy''s The Division is an upcoming third-person shooter video game developed by Ubisoft Massive, Ubisoft Reflections and Ubisoft Red Storm under the Tom Clancy brand for Microsoft Windows, PlayStation 4and Xbox One.', 59.9900, N'ps4stom.jpg', N'ps4btom.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (19, N'Bloodborne', N'Bloodborne is an upcoming video game being developed by From Software and published by Sony Computer Entertainment exclusively for the PlayStation 4.', 59.9900, N'ps4sblood.jpg', N'ps4bblood.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (20, N'Dead Island 2', N'Dead Island 2 is an upcoming action role-playing survival horror video game developed by German developer Yager Development and published by Deep Silver', 49.9900, N'ps4sdead.jpg', N'ps4bdead.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (21, N'Call of Duty Advanced Warfare', N'Plot In 2054, a terrorist organization known as the KVA initiates the first global terrorist attack in history by simultaneously destroying the nuclear reactors of developed countries around the globe, including the United States. Across five continents, many developed countries'' infrastructures were devastated and the military is incapable of fighting the threat posed by the KVA.', 69.9900, N'ps4scall.jpg', N'ps4bcall.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (22, N'Destiny', N'From the Creators of Halo and the company that brought you Call of Duty. In Destiny you are a Guardian of the last city on Earth, able to wield incredible power. Explore the ancient ruins of our solar system, from the red dunes of Mars to the lush jungles of Venus. Defeat Earth’s enemies. Reclaim all that we have lost. Become legend.', 69.9900, N'ps4sdestiny.jpg', N'ps4bdestiny.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (23, N'Football Manager 2015', N'Football Manager 2015, the latest in the award-winning and record-breaking series, is
coming to PC, Macintosh and Linux computers in November 2014.
Football manager is the most realistic, in-depth and immersive simulation of football
management available, putting you in the hot-seat of almost any club in more than
50 countries across the world, including all of European''s biggest leagues.', 54.9900, N'FootballManager2015_Thumbnail.png', N'FootballManager2015_Img.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (24, N'DOTA 2', N'Dota is a competitive game of action and strategy, played both professionally and casually
by millions of passionate worldwide. Players pick from a pool of over a hundred heroes, 
forming two teams of five players.', 26.3700, N'Dota2_Thumbnail.png', N'Dota2_Img.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (25, N'Counter-Strike: Global Offensive', N'Counter-Strike: Global Offensive (CS: GO) will expand upon the team-based action 
gameplay that it pioneered when it was launched 12 years ago. CS: GO features new 
maps, characters, and weapons and delivers updated versions of the classic CS content 
(de_dust, etc).', 16.9900, N'Counter_Thumbnail.png', N'Counter_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (26, N'The Binding of Isaac: Rebirth', N'The Binding of Isaac: Rebirth is a randomly generated action RPG shooter with heavy
Rogue-like elements. Following Isaac on his journey players will find bizarre treasures
that changes Isaac''s form giving him super human abilities and enabling him to fight off
droves of mysterious creatures.', 16.9900, N'TheBinding_Thumbnail.png', N'TheBinding_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (27, N'Endless Legend', N'Endless Legend is a 4X turn-based fantasy stategy game by the creators of Endless Space 
and Dungeon of the Endless. Control every aspect of your civilization as you struggle to
save your homeworld Auriga. ', 38.6900, N'Endless_Thumbnail.png', N'Endless_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (28, N'7 Days to Die', N'Building on survivalist and horror themes, players in 7 Days to Die can scavenge the 
abandoned cities of the buildable and destructible voxel world for supplies or explore
the wildemess to gather raw materials to build their own tools, weapons, traps, fortifications
and shelters.', 27.9900, N'7Days_Thumbnail.png', N'7Days_Img.jpg', 1, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (29, N'Wasteland 2', N'The Wasteland series impressive and innovative lineage has been preserved at its very 
core, but modernized for the fans of today with Wasteland 2. Immerse yourself in turn-
based tactical combat that will test the very limits of your strategy skills as you fight to 
survive a desolate world where brute strength.', 43.9900, N'Wasteland_Thumbnail.png', N'Wasteland_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (30, N'Left 4 Dead 2', N'Set in the zombie apocalypse, Left 4 Dead 2 (L4D2) is the highly anticipated sequel to the
award-winning Left 4 Dear, the #1 co-op game of 2008. This co-operative action horror FPS
takes you and your friends thourgh the cities, swamps and cemeteris of the Deep South,
from Savannah to New Orleans.', 32.9900, N'Left4_Thumbnail.png', N'Left4_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (31, N'Borderlands 2', N'The Ultimate Vault Hunter''s Upgrade lets you get the most out of the Borderlands 2 
experience.', 21.9900, N'Borderlands_Thumbnail.png', N'Borderlands_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (32, N'Merchants of Kaidan', N'Regain your riches, restore your honor and avenge your father''s murder. A challenging
trading game with lots of RPG elements.', 11.3800, N'Merchants_Thumbnail.png', N'Merchants_Img.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (33, N'Alien: Isolation
', N'Discover the true meaning of fear in alien: isolation, a survival horror set in an atmosphere of constant dread and mortal danger, how will you survive? Fifteen years after the events of alien, ellen ripley''s daughter, amanda enters a desperate battle for survival, on a mission to unravel the truth behind her mother''s disappearance. As amanda, you will navigate through an increasingly volatile world as you find yourself confronted on all sides by a panicked, desperate population and an unpredictable, ruthless alien. Underpowered and underprepared, you must scavenge resources, improvise solutions and use your wits, not just to succeed in your mission, but to simply stay alive…
', 64.9900, N'alien-isolation_TH.png', N'alien-isolation.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (34, N'Assassin''s Creed Iv: Black Flag
', N'Set sail in the lawless caribbean during the golden age of pirates in assassin''s creed iv: black flag for xbox one. The year is 1715, and ruthless pirates rule the land and sea. You are captain edward kenway, a charismatic but brutal pirate who strikes fear into the hearts of all with his fearsome reputation and mighty ship, the jackdaw. You will earn the respect of the legendary swashbucklers like blackbeard, calico jack, benjamin hornigold and more in the fullest, most diverse assassin''s creed world yet.
', 37.9600, N'Assassins_Creed_IV_Black_Flag_TH.png', N'Assassins_Creed_IV_Black_Flag.png', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (35, N'Batman: Arkham Knight
', N'Get ready the final chapter in the arkham series in batman: arkham knight for xbox one. Uniting to destroy the dark knight once and for all, the scarecrow, penguin, two-face and harley quinn have joined forces and must be stopped. Don the cowl and cape and, for the first time in the franchise, drive the batmobile as you traverse the rooftops, streets and skies of gotham to stand against the worst that the city has to offer
', 59.9900, N'batman__arkham_knight_TH.png', N'batman__arkham_knight.png', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (36, N'Battlefield 4
', N'The latest installment in the genre-defining, blockbuster series is here - gear up and get ready for combat in battlefield 4 for xbox one. Fueled by the powerful frostbite 3 engine, battlefield 4 offers a dramatic, visceral experience like no other, where you can use the environment as a weapon against the enemy and lead assaults from the back of a gun boat. Do more and be more while paving the road to victory in the intensely dramatic single-player campaign, and vanquish the competition in the hallmark multiplayer mode.
', 39.9900, N'Battlefield-4-Xbox-One-Box-Art_TH.png', N'Battlefield-4-Xbox-One-Box-Art.jpg', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (37, N'Dead Rising 3
', N'Get ready to fight back against an all-new onslaught of the undead in dead rising 3, exclusively for xbox one. Face overwhelming hordes of zombies in the immersive open-world city of los perdidos, where everything''s a weapon and supplies are scarce. Customize your character and create your own weapons with scavenged items as you travel through the sprawling metropolis and try to escape before the military wipes out the entire city and everyone in it.
', 49.9900, N'dead-rising-3_TH.png', N'dead-rising-3.jpg', 0, 1, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (38, N'Disney Infinity 2.0: Marvel Super Heroes Starter P', N'Use real-world figures of your favourite marvel heroes and villains to interact with the virtual worlds of marvel and disney with the disney infinity 2.0: marvel super heroes starter pack for xbox one! Join earth''s mightiest heroes as they fight to save the world in character-specific storylines written by award-winning marvel comic writer brian michael bendis. This set includes the disney infinity 2.0 game, 3 character figures, the avengers play set, a disney infinity base, a web code card, a poster and 2 game discs.
', 74.9900, N'dragon-age-inquisition_TH.png', N'dragon-age-inquisition.png', 0, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Thumbnail], [Image], [PromoFront], [PromoDept], [newOne]) VALUES (39, N'Dragon Age: Inquisition
', N'Ready yourself for the thrilling continuation of the dragon age saga with this deluxe edition of dragon age: inquisition for xbox one. The land of thedas has been plunged into turmoil, and the skies above the once-peaceful kingdom are darkened by dragons. War has erupted between the mages and the templars, nations rise against one another, and chaos threatens to reign supreme. You must rally your party of legendary heroes to lead the inquisition and eliminate the agents of chaos, breaking and forming bonds as you embark on your campaign for truth in this beautiful, sprawling epic.
', 69.9900, N'heros_TH.png', N'heros.png', 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (3, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (4, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (5, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (6, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (7, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (8, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (9, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (10, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (11, 7)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (12, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (13, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (14, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (15, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (16, 13)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (17, 12)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (18, 12)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (19, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (20, 14)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (21, 12)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (22, 12)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (23, 15)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (24, 21)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (25, 21)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (26, 20)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (27, 20)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (28, 21)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (29, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (30, 21)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (31, 20)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (32, 16)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (33, 28)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (34, 28)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (35, 28)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (36, 26)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (37, 28)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (38, 28)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (39, 27)
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'204e47df-eecc-424e-bfdc-c63b4b9be3a4', 23, 1, N'attributes', CAST(N'2016-06-11T16:22:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'204e47df-eecc-424e-bfdc-c63b4b9be3a4', 24, 1, N'attributes', CAST(N'2016-06-11T16:22:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'204e47df-eecc-424e-bfdc-c63b4b9be3a4', 29, 1, N'attributes', CAST(N'2016-06-11T16:22:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'204e47df-eecc-424e-bfdc-c63b4b9be3a4', 32, 1, N'attributes', CAST(N'2016-06-11T16:22:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'204e47df-eecc-424e-bfdc-c63b4b9be3a4', 33, 1, N'attributes', CAST(N'2016-06-11T16:22:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 1, 2, N'attributes', CAST(N'2016-06-10T15:43:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 18, 1, N'attributes', CAST(N'2016-06-10T16:11:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 23, 2, N'attributes', CAST(N'2016-06-10T15:43:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 29, 1, N'attributes', CAST(N'2016-06-10T15:43:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 32, 1, N'attributes', CAST(N'2016-06-10T15:43:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'2b18e0eb-e591-43a0-a223-d098eda39767', 33, 1, N'attributes', CAST(N'2016-06-10T16:11:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [Attributes], [DateAdded]) VALUES (N'60f57bec-6274-42f7-9313-64c52310885b', 11, 1, N'attributes', CAST(N'2014-12-11T21:39:00' AS SmallDateTime))
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Verified]  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Completed]  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Canceled]  DEFAULT ((0)) FOR [Canceled]
GO
ALTER TABLE [dbo].[AttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValue_Attribute] FOREIGN KEY([AttributeID])
REFERENCES [dbo].[Attribute] ([AttributeID])
GO
ALTER TABLE [dbo].[AttributeValue] CHECK CONSTRAINT [FK_AttributeValue_Attribute]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Department]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_AttributeValue] FOREIGN KEY([AttributeValueID])
REFERENCES [dbo].[AttributeValue] ([AttributeValueID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_AttributeValue]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_Product]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
/****** Object:  StoredProcedure [dbo].[CatalogAddDepartment]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAddDepartment]
(@DepartmentName nvarchar(50),
@DepartmentDescription nvarchar(1000))
AS
INSERT INTO Department (Name, Description)
VALUES (@DepartmentName, @DepartmentDescription)



GO
/****** Object:  StoredProcedure [dbo].[CatalogAssignProductToCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogAssignProductToCategory]
(@ProductID int, @CategoryID int)
AS
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateCategory]
(@DepartmentID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(50))
AS
INSERT INTO Category (DepartmentID, Name, Description)
VALUES (@DepartmentID, @CategoryName, @CategoryDescription)



GO
/****** Object:  StoredProcedure [dbo].[CatalogCreateProduct]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogCreateProduct]
(@CategoryID INT,
 @ProductName NVARCHAR(50),
 @ProductDescription NVARCHAR(MAX),
 @Price MONEY,
 @Thumbnail NVARCHAR(50),
 @Image NVARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
-- Declare a variable to hold the generated product ID
DECLARE @ProductID int
-- Create the new product entry

INSERT INTO Product 
    (Name, 
     Description, 
     Price, 
     Thumbnail, 
     Image,
     PromoFront, 
     PromoDept)
VALUES 
    (@ProductName, 
     @ProductDescription, 
     @Price, 
     @Thumbnail, 
     @Image,
     @PromoFront, 
     @PromoDept)
-- Save the generated product ID to a variable
SELECT @ProductID = @@Identity
-- Associate the product with a category
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteCategory]
(@CategoryID int)
AS
DELETE FROM Category
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteDepartment]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteDepartment]
(@DepartmentID int)
AS
DELETE FROM Department
WHERE DepartmentID = @DepartmentID



GO
/****** Object:  StoredProcedure [dbo].[CatalogDeleteProduct]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogDeleteProduct]
(@ProductID int)
AS
DELETE FROM ShoppingCart WHERE ProductID=@ProductID
DELETE FROM ProductCategory WHERE ProductID=@ProductID
DELETE FROM Product where ProductID=@ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetAllProductsInCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetAllProductsInCategory]
(@CategoryID INT)
AS
SELECT Product.ProductID, Name, Description, Price, Thumbnail, 
       Image, PromoDept, PromoFront
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesInDepartment]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--missing procedures from 05-07


CREATE PROCEDURE [dbo].[CatalogGetCategoriesInDepartment]
(@DepartmentID INT)
AS
SELECT CategoryID, Name, Description
FROM Category
WHERE DepartmentID = @DepartmentID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithoutProduct]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithoutProduct]
(@ProductID int)
AS
SELECT CategoryID, Name
FROM Category
WHERE CategoryID NOT IN
   (SELECT Category.CategoryID
    FROM Category INNER JOIN ProductCategory
    ON Category.CategoryID = ProductCategory.CategoryID
    WHERE ProductCategory.ProductID = @ProductID)



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoriesWithProduct]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoriesWithProduct]
(@ProductID int)
AS
SELECT Category.CategoryID, Name
FROM Category INNER JOIN ProductCategory
ON Category.CategoryID = ProductCategory.CategoryID
WHERE ProductCategory.ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetCategoryDetails]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetCategoryDetails]
(@CategoryID INT)
AS
SELECT DepartmentID, Name, Description
FROM Category
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetDepartmentDetails]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetDepartmentDetails]
(@DepartmentID INT)
AS
SELECT Name, Description
FROM Department
WHERE DepartmentID = @DepartmentID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetDepartments]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetDepartments] AS
SELECT DepartmentID, Name, Description
FROM Department



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductAttributeValues]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create CatalogGetProductAttributeValues stored procedure
CREATE PROCEDURE [dbo].[CatalogGetProductAttributeValues]
(@ProductId INT)
AS
SELECT a.Name AS AttributeName,
       av.AttributeValueID, 
       av.Value AS AttributeValue
FROM AttributeValue av
INNER JOIN attribute a ON av.AttributeID = a.AttributeID
WHERE av.AttributeValueID IN
  (SELECT AttributeValueID
   FROM ProductAttributeValue
   WHERE ProductID = @ProductID)
ORDER BY a.Name;



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductDetails]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductDetails]
(@ProductID INT)
AS
SELECT Name, Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductRecommendations]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CatalogGetProductRecommendations]
(@ProductID INT,
@DescriptionLength INT)
AS
SELECT ProductID,
Name,
CASE WHEN LEN(Description) <= @DescriptionLength THEN Description
ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END
AS Description
FROM Product
WHERE ProductID IN
(
SELECT TOP 5 od2.ProductID
FROM OrderDetail od1
JOIN OrderDetail od2 ON od1.OrderID = od2.OrderID
WHERE od1.ProductID = @ProductID AND od2.ProductID != @ProductID
GROUP BY od2.ProductID
ORDER BY COUNT(od2.ProductID) DESC
)



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsInCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsInCategory]
(@CategoryID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnDeptPromo]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnDeptPromo]
(@DepartmentID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)

-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS Row,
       ProductID, Name, SUBSTRING(Description, 1, @DescriptionLength)
+ '...' AS Description,
       Price, Thumbnail, Image, PromoFront, PromoDept
FROM
(SELECT DISTINCT Product.ProductID, Product.Name,
       CASE WHEN LEN(Product.Description) <= @DescriptionLength 
            THEN Product.Description 
            ELSE SUBSTRING(Product.Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
  FROM Product INNER JOIN ProductCategory
                      ON Product.ProductID = ProductCategory.ProductID
              INNER JOIN Category
                      ON ProductCategory.CategoryID = Category.CategoryID
  WHERE Product.PromoDept = 1
   AND Category.DepartmentID = @DepartmentID
) AS ProductOnDepPr

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogGetProductsOnFrontPromo]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogGetProductsOnFrontPromo]
(@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name NVARCHAR(50),
 Description NVARCHAR(MAX),
 Price MONEY,
 Thumbnail NVARCHAR(50),
 Image NVARCHAR(50),
 PromoFront bit,
 PromoDept bit)


-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept
FROM Product
WHERE PromoFront = 1

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Thumbnail,
       Image, PromoFront, PromoDept
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage



GO
/****** Object:  StoredProcedure [dbo].[CatalogMoveProductToCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogMoveProductToCategory]
(@ProductID int, @OldCategoryID int, @NewCategoryID int)
AS
UPDATE ProductCategory
SET CategoryID = @NewCategoryID
WHERE CategoryID = @OldCategoryID
  AND ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogRemoveProductFromCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogRemoveProductFromCategory]
(@ProductID int, @CategoryID int)
AS
DELETE FROM ProductCategory
WHERE CategoryID = @CategoryID AND ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateCategory]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateCategory]
(@CategoryID int,
@CategoryName nvarchar(50),
@CategoryDescription nvarchar(1000))
AS
UPDATE Category
SET Name = @CategoryName, Description = @CategoryDescription
WHERE CategoryID = @CategoryID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateDepartment]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateDepartment]
(@DepartmentID int,
@DepartmentName nvarchar(50),
@DepartmentDescription nvarchar(1000))
AS
UPDATE Department
SET Name = @DepartmentName, Description = @DepartmentDescription
WHERE DepartmentID = @DepartmentID



GO
/****** Object:  StoredProcedure [dbo].[CatalogUpdateProduct]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CatalogUpdateProduct]
(@ProductID INT,
 @ProductName VARCHAR(50),
 @ProductDescription VARCHAR(5000),
 @Price MONEY,
 @Thumbnail VARCHAR(50),
 @Image VARCHAR(50),
 @PromoFront BIT,
 @PromoDept BIT)
AS
UPDATE Product
SET Name = @ProductName,
    Description = @ProductDescription,
    Price = @Price,
    Thumbnail = @Thumbnail,
    Image = @Image,
    PromoFront = @PromoFront,
    PromoDept = @PromoDept
WHERE ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateOrder] 
(@CartID char(36))
AS
/* Insert a new record INTo Orders */
DECLARE @OrderID INT
INSERT INTO Orders DEFAULT VALUES
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)
SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID



GO
/****** Object:  StoredProcedure [dbo].[GetShoppingCartRecommendations]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetShoppingCartRecommendations]
(@CartID CHAR(36),
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that exist in a list of orders
   SELECT TOP 5 od1.ProductID AS Rank
   FROM OrderDetail od1 
     JOIN OrderDetail od2
       ON od1.OrderID=od2.OrderID
     JOIN ShoppingCart sp
       ON od2.ProductID = sp.ProductID
   WHERE sp.CartID = @CartID
        -- Must not include products that already exist in the visitor''s cart
      AND od1.ProductID NOT IN
      (
      -- Returns the products in the specified shopping cart
      SELECT ProductID 
      FROM ShoppingCart
      WHERE CartID = @CartID
      )
   -- Group the ProductID so we can calculate the rank
   GROUP BY od1.ProductID
   -- Order descending by rank
   ORDER BY COUNT(od1.ProductID) DESC
   )



GO
/****** Object:  StoredProcedure [dbo].[OrderGetDetails]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetDetails]
(@OrderID INT)
AS
SELECT Orders.OrderID, 
       ProductID, 
       ProductName, 
       Quantity, 
       UnitCost, 
       Subtotal
FROM OrderDetail JOIN Orders
ON Orders.OrderID = OrderDetail.OrderID
WHERE Orders.OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderGetInfo]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderGetInfo]
(@OrderID INT)
AS
SELECT OrderID, 
      (SELECT ISNULL(SUM(Subtotal), 0) FROM OrderDetail WHERE OrderID = @OrderID)        
       AS TotalAmount, 
       DateCreated, 
       DateShipped, 
       Verified, 
       Completed, 
       Canceled, 
       Comments, 
       CustomerName, 
       ShippingAddress, 
       CustomerEmail
FROM Orders
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCanceled]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCanceled]
(@OrderID INT)
AS
UPDATE Orders
SET Canceled = 1
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCompleted]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkCompleted]
(@OrderID INT)
AS
UPDATE Orders
SET Completed = 1,
    DateShipped = GETDATE()
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrderMarkVerified]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderMarkVerified]
(@OrderID INT)
AS
UPDATE Orders
SET Verified = 1
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByDate]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByDate] 
(@StartDate SMALLDATETIME,
 @EndDate SMALLDATETIME)
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE DateCreated BETWEEN @StartDate AND @EndDate
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByRecent]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetByRecent] 
(@Count smallINT)
AS
-- Set the number of rows to be returned
SET ROWCOUNT @Count
-- Get list of orders
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
ORDER BY DateCreated DESC
-- Reset rowcount value
SET ROWCOUNT 0



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetUnverifiedUncanceled]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetUnverifiedUncanceled]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=0 AND Canceled=0
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrdersGetVerifiedUncompleted]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrdersGetVerifiedUncompleted]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=1 AND Completed=0
ORDER BY DateCreated DESC



GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderUpdate]
(@OrderID INT,
 @DateCreated SMALLDATETIME,
 @DateShipped SMALLDATETIME = NULL,
 @Verified BIT,
 @Completed BIT,
 @Canceled BIT,
 @Comments VARCHAR(200),
 @CustomerName VARCHAR(50),
 @ShippingAddress VARCHAR(200),
 @CustomerEmail VARCHAR(50))
AS
UPDATE Orders
SET DateCreated=@DateCreated,
    DateShipped=@DateShipped,
    Verified=@Verified,
    Completed=@Completed,
    Canceled=@Canceled,
    Comments=@Comments,
    CustomerName=@CustomerName,
    ShippingAddress=@ShippingAddress,
    CustomerEmail=@CustomerEmail
WHERE OrderID = @OrderID



GO
/****** Object:  StoredProcedure [dbo].[SearchCatalog]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchCatalog] 
(@DescriptionLength INT,
 @PageNumber TINYINT,
 @ProductsPerPage TINYINT,
 @HowManyResults INT OUTPUT,
 @AllWords BIT,
 @Word1 NVARCHAR(15) = NULL,
 @Word2 NVARCHAR(15) = NULL,
 @Word3 NVARCHAR(15) = NULL,
 @Word4 NVARCHAR(15) = NULL,
 @Word5 NVARCHAR(15) = NULL)
AS

/* @NecessaryMatches needs to be 1 for any-word searches and
   the number of words for all-words searches */
DECLARE @NecessaryMatches INT
SET @NecessaryMatches = 1
IF @AllWords = 1 
  SET @NecessaryMatches =
    CASE WHEN @Word1 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word2 IS NULL THEN 0 ELSE 1 END + 
    CASE WHEN @Word3 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word4 IS NULL THEN 0 ELSE 1 END +
    CASE WHEN @Word5 IS NULL THEN 0 ELSE 1 END;

/* Create the table variable that will contain the search results */
DECLARE @Matches TABLE
([Key] INT NOT NULL,
 Rank INT NOT NULL)

-- Save matches for the first word
IF @Word1 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word1

-- Save the matches for the second word
IF @Word2 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word2

-- Save the matches for the third word
IF @Word3 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word3

-- Save the matches for the fourth word
IF @Word4 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word4

-- Save the matches for the fifth word
IF @Word5 IS NOT NULL
  INSERT INTO @Matches
  EXEC SearchWord @Word5

-- Calculate the IDs of the matching products
DECLARE @Results TABLE
(RowNumber INT,
 [KEY] INT NOT NULL,
 Rank INT NOT NULL)

-- Obtain the matching products 
INSERT INTO @Results
SELECT ROW_NUMBER() OVER (ORDER BY COUNT(M.Rank) DESC),
       M.[KEY], SUM(M.Rank) AS TotalRank
FROM @Matches M
GROUP BY M.[KEY]
HAVING COUNT(M.Rank) >= @NecessaryMatches

-- return the total number of results using an OUTPUT variable
SELECT @HowManyResults = COUNT(*) FROM @Results

-- populate the table variable with the complete list of products
SELECT Product.ProductID, Name,
       CASE WHEN LEN(Description) <= @DescriptionLength THEN Description 
            ELSE SUBSTRING(Description, 1, @DescriptionLength) + '...' END 
       AS Description, Price, Thumbnail, Image, PromoFront, PromoDept 
FROM Product 
INNER JOIN @Results R
ON Product.ProductID = R.[KEY]
WHERE R.RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND R.RowNumber <= @PageNumber * @ProductsPerPage
ORDER BY R.Rank DESC



GO
/****** Object:  StoredProcedure [dbo].[SearchWord]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchWord] (@Word NVARCHAR(50))
AS

SET @Word = 'FORMSOF(INFLECTIONAL, "' + @Word + '")'

SELECT COALESCE(NameResults.[KEY], DescriptionResults.[KEY]) AS [KEY],
       ISNULL(NameResults.Rank, 0) * 3 + 
       ISNULL(DescriptionResults.Rank, 0) AS Rank 
FROM 
  CONTAINSTABLE(Product, Name, @Word, 
                LANGUAGE 'English') AS NameResults
  FULL OUTER JOIN
  CONTAINSTABLE(Product, Description, @Word, 
                LANGUAGE 'English') AS DescriptionResults
  ON NameResults.[KEY] = DescriptionResults.[KEY]



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartAddItem]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartAddItem]
(@CartID char(36),
 @ProductID int,
 @Attributes nvarchar(1000))
AS
IF EXISTS
        (SELECT CartID
         FROM ShoppingCart
         WHERE ProductID = @ProductID AND CartID = @CartID)
    UPDATE ShoppingCart
    SET Quantity = Quantity + 1
    WHERE ProductID = @ProductID AND CartID = @CartID
ELSE
    IF EXISTS (SELECT Name FROM Product WHERE ProductID=@ProductID)
        INSERT INTO ShoppingCart (CartID, ProductID, Attributes, Quantity, DateAdded)
        VALUES (@CartID, @ProductID, @Attributes, 1, GETDATE())



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartCountOldCarts]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartCountOldCarts]
(@Days smallint)
AS
SELECT COUNT(CartID)
FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartDeleteOldCarts]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartDeleteOldCarts]
(@Days smallint)
AS
DELETE FROM ShoppingCart
WHERE CartID IN
(SELECT CartID
FROM ShoppingCart
GROUP BY CartID
HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetItems]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetItems]
(@CartID char(36))
AS
SELECT Product.ProductID, Product.Name, ShoppingCart.Attributes, Product.Price, ShoppingCart.Quantity,Product.Price * ShoppingCart.Quantity AS Subtotal
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetTotalAmount]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartGetTotalAmount]
(@CartID char(36))
AS
SELECT ISNULL(SUM(Product.Price * ShoppingCart.Quantity), 0)
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartRemoveItem]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShoppingCartRemoveItem]
(@CartID char(36),
 @ProductID int)
AS
DELETE FROM ShoppingCart
WHERE CartID = @CartID and ProductID = @ProductID



GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartUpdateItem]    Script Date: 6/14/2016 10:56:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ShoppingCartUpdateItem]
(@CartID char(36),
 @ProductID int,
 @Quantity int)
AS
IF @Quantity <= 0
  EXEC ShoppingCartRemoveItem @CartID, @ProductID
ELSE
  UPDATE ShoppingCart
  SET Quantity = @Quantity, DateAdded = GETDATE()
  WHERE ProductID = @ProductID AND CartID = @CartID



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[23] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 4
               Left = 24
               Bottom = 168
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderDetail"
            Begin Extent = 
               Top = 0
               Left = 435
               Bottom = 186
               Right = 643
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 156
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "ProductCategory"
            Begin Extent = 
               Top = 9
               Left = 307
               Bottom = 114
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProdsInCats'
GO
USE [master]
GO
ALTER DATABASE [VideoShop] SET  READ_WRITE 
GO
