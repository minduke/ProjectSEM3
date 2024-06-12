CREATE DATABASE [GiveAID]
go
USE [GiveAID]
GO
/****** Object:  Table [dbo].[banner]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[banner_image] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[cate_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[cate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuration]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[configuration](
	[keyword] [varchar](255) NOT NULL,
	[value] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[keyword] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[image_post]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image_post](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[image] [varchar](max) NULL,
	[post_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[partner]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[partner_name] [nvarchar](100) NULL,
	[partner_image] [varchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[address] [nvarchar](200) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[partner_status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[post_id] [int] NULL,
	[user_id] [int] NULL,
	[transaction_amout] [decimal](18, 2) NULL,
	[transaction_no] [varchar](max) NULL,
	[transaction_date] [datetime] NULL,
	[banktran_no] [varchar](50) NULL,
	[pay_status] [nvarchar](50) NULL,
	[anonymous] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[post]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[content] [ntext] NULL,
	[image] [varchar](max) NULL,
	[time_start] [date] NULL,
	[time_end] [date] NULL,
	[target] [decimal](18, 2) NULL,
	[cate_id] [int] NULL,
	[partner_id] [int] NULL,
	[status] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 6/12/2024 1:32:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[fullname] [nvarchar](100) NULL,
	[image] [varchar](max) NULL,
	[phone] [varchar](11) NULL,
	[email] [varchar](100) NULL,
	[permission] [nvarchar](50) NULL,
	[gender] [nvarchar](10) NULL,
	[address] [nvarchar](max) NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[banner] ON 
GO
INSERT [dbo].[banner] ([id], [banner_image]) VALUES (21, N'638536625452331322_wallpaperflare.com_wallpaper (1).jpg')
GO
INSERT [dbo].[banner] ([id], [banner_image]) VALUES (35, N'638537592964614168_dongLuc.jpg')
GO
INSERT [dbo].[banner] ([id], [banner_image]) VALUES (36, N'638537592964634110_wallpaperflare.com_wallpaper.jpg')
GO
SET IDENTITY_INSERT [dbo].[banner] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (1, N'Y tế')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (2, N'Giáo dục')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (3, N'Trẻ em')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (4, N'Hoàn cảnh khó khăn')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (5, N'Thiên tai')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (1016, N'Trẻ con')
GO
INSERT [dbo].[category] ([cate_id], [name]) VALUES (1017, N'Mới')
GO
SET IDENTITY_INSERT [dbo].[category] OFF
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_ADDRESS', N'102 Nguyễn Đình Chính, phường Đính Đá, Quận Đình Chỉ, TPHCM')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_DISPLAY_NAME', N'Give.AID')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_EMAIL', N'Give.AID@gmail.com')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_IMAGE_FOOTER', N'638536625452231596_wallpaperflare.com_wallpaper (1).jpg')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_INTRODUCE', N'Give-AID is a product intended to serve charitable funds that need to call for donations.')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_INTRODUCE_FOOTER', N'Give-AID is a product intended to serve charitable funds that need to call for donations.')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_LOGO', N'638536625452211636_LogoGive.png')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_MAIL_ADDRESS', N'give.aid.vip@gmail.com')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_MAIL_PASS', N'fpBjWK53hc1UwoS1p4fUdqaPUY76rHNd')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_MAIL_PORT', N'587')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_MAIL_USERNAME', N'give.aid.vip@gmail.com')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_PHONE', N'8456490734012')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_SMTP_SERVER', N'smtp.gmail.com')
GO
INSERT [dbo].[configuration] ([keyword], [value]) VALUES (N'SYS_SSL', N'true')
GO
SET IDENTITY_INSERT [dbo].[image_post] ON 
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4064, N'638536517031723596_help_Baby.png', 4027)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4065, N'638536517031893131_help_Woman.png', 4027)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4066, N'638537410601641134_help_Baby.png', 4028)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4067, N'638537410601760810_help_Elderly.png', 4028)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4068, N'638537500861945510_help_Animal.png', 4029)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4069, N'638537500867021944_help_Baby.png', 4029)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4070, N'638537500867021944_help_Elderly.png', 4029)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4071, N'638537500867031916_help_Woman.png', 4029)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4072, N'638537590686284887_help_Baby.png', 4030)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4073, N'638537590686284887_help_Elderly.png', 4030)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4074, N'638537592255011159_IMG_9877-768x768.jpg', 4031)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4075, N'638537592255011159_THHP-_432x324_Banner-news_Givenow-1024x768.png', 4031)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4076, N'638537592255021130_z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-1024x768.jpg', 4031)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4077, N'638537594166580898_help_Baby.png', 4032)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4081, N'638537793433317877_MINIAPP_1200x840-800x600.png', 4034)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4082, N'638537814535440465_img.jpg', 4035)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4083, N'638537814535450449_IMG_9877-768x768.jpg', 4035)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4084, N'638537814535460415_MINIAPP_1200x840-800x600.png', 4035)
GO
INSERT [dbo].[image_post] ([id], [image], [post_id]) VALUES (4085, N'638537814535470392_THHP-_432x324_Banner-news_Givenow-1024x768.png', 4035)
GO
SET IDENTITY_INSERT [dbo].[image_post] OFF
GO
SET IDENTITY_INSERT [dbo].[partner] ON 
GO
INSERT [dbo].[partner] ([id], [partner_name], [partner_image], [description], [address], [phone], [email], [partner_status]) VALUES (1012, N'Từ Thiện Của Những Giấc Mơ', N'638536514514971713_LogoGive2.png', N'Ở đây chúng tôi sẽ luôn cố gắng thực hiện giấc mơ cho các hoàn cảnh khó khăn cần sự giúp đỡ để họ có thể vượt qua giai đoạn này một cách thật tốt đẹp và mong muốn họ có mọi thứ tốt hơn chúng tôi là Từ Thiện Của Những Giấc Mơ', N'300 CMT8 quận 3 Hồ Chí Minh', N'0908070605', N'TuThienGiacMo@gmail.com', N'Open')
GO
INSERT [dbo].[partner] ([id], [partner_name], [partner_image], [description], [address], [phone], [email], [partner_status]) VALUES (1013, N'Support Baby', N'638537486420771544_help_Elderly.png', N'The center is a charity fund established in 2009 and developed by ABC Bank with the aim of supporting children in highland areas to have a better life.', N'Số 1 nguyễn trải phường nguyễn cư trinh quận 1 TP. Hồ Chí Minh', N'0908070605', N'bankABC@gmail.com', N'Open')
GO
INSERT [dbo].[partner] ([id], [partner_name], [partner_image], [description], [address], [phone], [email], [partner_status]) VALUES (1014, N'Quỹ Từ thiện Nâng bước tuổi thơ', N'638537792646481373_iiii.png', N'Nâng Bước Tuổi Thơ là tổ chức từ thiện duy nhất tại Việt Nam cung cấp chuyên môn điều trị bệnh lý & phẫu thuật đa khoa theo tiêu chuẩn quốc tế cho trẻ em dị tật bẩm sinh có hoàn cảnh khó khăn. Thắp sáng bởi ngọn lửa của tình thương vô điều kiện, Quỹ Nâng Bước Tuổi Thơ ấp ủ khát vọng cùng sứ mệnh mang tới cơ thể lành lặn và tương lai tốt đẹp nhất cho những trẻ em kém may mắn trên khắp mọi miền đất Việt.', N'Tầng 6, SGR.O1-606, Saigon Royal, 34-35 Bến Vân Đồn, Phường 13, Quận 4, TP. Hồ Chí Minh', N'0903035030', N'contact@children-of-vietnam.org', N'Open')
GO
INSERT [dbo].[partner] ([id], [partner_name], [partner_image], [description], [address], [phone], [email], [partner_status]) VALUES (1015, N'Quỹ kêu gọi từ thiện', N'638537813295824383_help_Elderly.png', N'mô tả về test 1', N'111 Anh em bốn bể là nhà dù xa dù lạ vẫn là anh em', N'0908070605', N'vuvunguyen8420@gmail.com', N'Closed')
GO
SET IDENTITY_INSERT [dbo].[partner] OFF
GO
SET IDENTITY_INSERT [dbo].[payment] ON 
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5049, 4027, 11, CAST(1000000.00 AS Decimal(18, 2)), N'14452701', CAST(N'2024-06-10T21:31:34.000' AS DateTime), N'VNP14452701', N'Success', N'')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5050, 4027, 2017, CAST(1000000.00 AS Decimal(18, 2)), N'14452743', CAST(N'2024-06-10T22:07:20.000' AS DateTime), N'VNP14452743', N'Success', N'')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5051, 4027, 11, CAST(10000.00 AS Decimal(18, 2)), N'14452797', CAST(N'2024-06-10T22:46:48.000' AS DateTime), N'VNP14452797', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5052, 4028, 11, CAST(1000000.00 AS Decimal(18, 2)), N'14454594', CAST(N'2024-06-11T22:19:04.000' AS DateTime), N'VNP14454594', N'Success', N'')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5053, 4028, 2018, CAST(1000000.00 AS Decimal(18, 2)), N'', CAST(N'2024-06-12T01:57:27.170' AS DateTime), N'', N'Failure', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5054, 4028, 2018, CAST(1000000.00 AS Decimal(18, 2)), N'14454865', CAST(N'2024-06-12T01:59:53.000' AS DateTime), N'VNP14454865', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5055, 4027, 11, CAST(10000000.00 AS Decimal(18, 2)), N'14454889', CAST(N'2024-06-12T03:15:42.000' AS DateTime), N'VNP14454889', N'Success', N'')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5056, 4031, 11, CAST(100000.00 AS Decimal(18, 2)), N'14454950', CAST(N'2024-06-12T08:23:28.000' AS DateTime), N'VNP14454950', N'Success', N'')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5057, 4028, 2019, CAST(50000000.00 AS Decimal(18, 2)), N'14454951', CAST(N'2024-06-12T08:28:43.000' AS DateTime), N'VNP14454951', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5058, 4031, 11, CAST(25000000.00 AS Decimal(18, 2)), N'14454972', CAST(N'2024-06-12T08:46:09.000' AS DateTime), N'VNP14454972', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5059, 4032, 1, CAST(5000000.00 AS Decimal(18, 2)), N'14454983', CAST(N'2024-06-12T08:52:59.000' AS DateTime), N'VNP14454983', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5060, 4030, 1, CAST(1000000.00 AS Decimal(18, 2)), N'14454984', CAST(N'2024-06-12T08:53:50.000' AS DateTime), N'VNP14454984', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5061, 4028, 1, CAST(3000000.00 AS Decimal(18, 2)), N'14454986', CAST(N'2024-06-12T08:54:45.000' AS DateTime), N'VNP14454986', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5062, 4032, 2020, CAST(1000000.00 AS Decimal(18, 2)), N'14455052', CAST(N'2024-06-12T09:26:27.000' AS DateTime), N'VNP14455052', N'Success', N'Anonymous User')
GO
INSERT [dbo].[payment] ([id], [post_id], [user_id], [transaction_amout], [transaction_no], [transaction_date], [banktran_no], [pay_status], [anonymous]) VALUES (5063, 4034, 2020, CAST(380000000.00 AS Decimal(18, 2)), N'', CAST(N'2024-06-12T09:38:30.823' AS DateTime), N'', N'Failure', N'')
GO
SET IDENTITY_INSERT [dbo].[payment] OFF
GO
SET IDENTITY_INSERT [dbo].[post] ON 
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4027, N'Kiến tạo trường học hạnh phúc: Xây dựng 5 hạng mục nước sạch ', N'', N'<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">N&oacute;i đến trường học hạnh ph&uacute;c, bạn nghĩ đến điều g&igrave;? Đ&oacute; c&oacute; thể l&agrave; cơ sở vật chất khang trang, m&aacute;y m&oacute;c hiện đại, ph&ograve;ng học hạnh ph&uacute;c, c&aacute;c bữa ăn đủ đầy, c&aacute;c học sinh vừa tiếp thu c&aacute;c tri thức hiện đại, vừa gi&ograve;n tan trong nụ cười của tuổi thơ???&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Trường học hạnh ph&uacute;c c&oacute; thể l&agrave; những thứ cao xa, nhưng cũng c&oacute; thể rất giản dị với những trẻ em v&ugrave;ng cao, d&acirc;n tộc thiểu số c&oacute; ho&agrave;n cảnh kh&oacute; khăn m&agrave; ch&uacute;ng t&ocirc;i gặp gỡ trong h&agrave;nh tr&igrave;nh thực địa, khảo s&aacute;t x&acirc;y dựng c&aacute;c trường học hạnh ph&uacute;c, gi&aacute;o dục c&ocirc;ng bằng tr&ecirc;n khắp Việt Nam.&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;"><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&ldquo;Con th&iacute;ch trường đầy nước&rdquo;</span></span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">Em A học lớp 4, d&acirc;n tộc T&agrave;y, trường tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh Ho&agrave; B&igrave;nh rất th&iacute;ch đi học d&ugrave; nh&agrave; em c&aacute;ch trường 8&nbsp;c&acirc;y số. Mỗi ng&agrave;y đến trường với em &nbsp;đều l&agrave; một ng&agrave;y vui. Em A, 9&nbsp;tuổi nhưng nhỏ thấp hơn c&aacute;c bạn đồng lứa, để đi học, mỗi ng&agrave;y ngo&agrave;i vượt 8 c&acirc;y số tới trường, em c&ograve;n mang theo nước để uống. Ở trường thiếu nước sạch, n&ecirc;n bố mẹ phải dậy sớm h&agrave;ng ng&agrave;y lấy nước, đun nước cho em mang tới trường, nhưng kể cả thế, nước em mang cũng kh&ocirc;ng phải nước hợp vệ sinh v&igrave; chỉ được lấy từ m&oacute; nước b&ecirc;n khe suối, bờ ruộng được xử l&yacute; qua loa. Ch&iacute;nh v&igrave; thế, ch&uacute;t nước qu&yacute; gi&aacute; nhiều c&ocirc;ng sức em mang tới trường kia vẫn thỉnh thoảng l&agrave;m em đau bụng v&agrave; kh&ocirc;ng đ&atilde; kh&aacute;t. Khi gặp ch&uacute;ng t&ocirc;i, em bảo &ldquo;Con th&iacute;ch trường đầy nước&rdquo;&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">Những thứ giản dị l&agrave; nước sạch, nh&agrave; vệ sinh&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">ch&iacute;nh l&agrave; những thứ căn bản, nhưng mang lại hạnh ph&uacute;c cho việc học tập của kh&ocirc;ng chỉ em A, em T m&agrave; c&ograve;n của hơn 555 học sinh d&acirc;n tộc thiểu số của Tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh Ho&agrave; B&igrave;nh.&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Được biết đến l&agrave; một ng&ocirc;i trường tại v&ugrave;ng s&acirc;u xa kh&oacute; khăn bậc nhất của Ho&agrave; B&igrave;nh, trường tiểu học v&agrave; THCS Cao Sơn c&ograve;n gặp rất nhiều kh&oacute; khăn, đặc biệt l&agrave; h</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">ệ thống nước sạch của trường chưa</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;đủ chất lượng để&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">c&oacute; thể cung cấp đầy đủ nhu cầu sử</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;dụng&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">của to&agrave;n trường, nh&agrave; vệ</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sinh xuống cấp, kh&ocirc;ng đảm bảo an to&agrave;n</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">. Đặc</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;biệt, c</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&ocirc;ng tr&igrave;nh vệ sinh c&ograve;n thiếu c&oacute; khu rửa tay với nước sạch v&agrave; x&agrave; ph&ograve;ng</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">/</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">dung dịch s&aacute;t khuẩn</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;cho học sinh. Ch&iacute;nh v&igrave; thế, v</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">iệc đầu tư cải</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tạo nh&agrave; vệ sinh v&agrave; hệ thống nước sạch</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sẽ gi&uacute;p đảm bảo điều kiện vệ sinh học đường đồng thời lan tỏa, thu h&uacute;t sự tham gia của đ&ocirc;ng đảo c&aacute;c nguồn lực x&atilde; hội kh&aacute;c đầu tư đ&uacute;ng hướng cho học sinh để c&oacute; một m&ocirc;i trường học tập &ldquo;trường học th&acirc;n thiện, học sinh khỏe mạnh&rdquo;.</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<img alt="" class="aligncenter wp-image-28003 size-full" height="1324" loading="lazy" sizes="(max-width: 1340px) 100vw, 1340px" src="https://givenow.vn/wp-content/uploads/2024/05/A%CC%89nh-ma%CC%80n-hi%CC%80nh-2024-05-29-lu%CC%81c-22.02.52.png" srcset="https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52.png 1340w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-300x296.png 300w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-1024x1012.png 1024w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-768x759.png 768w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-100x100.png 100w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-600x593.png 600w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; clear: both; text-align: center; border-radius: 0px; box-shadow: none; display: block; margin-left: auto; margin-right: auto;" width="1340" /></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;"><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">Kỷ niệm 5 năm th&agrave;nh lập Tổng C&ocirc;ng ty dịch vụ số Viettel &ndash; đơn vị chủ quản của Viettel Money, Viettel Money kết hợp c&ugrave;ng quỹ Hỗ</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;trợ đổi mới gi&aacute;o dục phổ th&ocirc;ng Việt Nam (</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">VIGEF</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">)</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;v&agrave; nền tảng G&acirc;y quỹ GiveNow triển khai chuỗi chương tr&igrave;nh &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo;, mang niềm</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;vui tới trường v&agrave;&nbsp;</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">cơ hội tiếp cận gi&aacute;o dục b&igrave;nh</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;đẳng,&nbsp;</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">hiện đại v&agrave; ph&aacute;t triển năng lực to&agrave;n diện cho</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN">&nbsp;<span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">1500 em học sinh v&ugrave;ng cao, trong đ&oacute; c&oacute;&nbsp;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">hơn 555&nbsp;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;học sinh trường Tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh&nbsp;</span><span class="NormalTextRun SpellingErrorV2Themed SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">Ho&agrave;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;B&igrave;nh.</span></span><span class="EOP SCXW238105938 BCX0" data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span>&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Giai đoạn 1 dự &aacute;n &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo; đặt mục ti&ecirc;u mang nước sạch v&agrave; nh&agrave; vệ sinh sạch sẽ &ldquo;Đại sứ nước đủ đầy&rdquo; tới hơn 555 học sinh v&ugrave;ng cao tại trường Tiểu học v&agrave; THCS Cao Sơn th&ocirc;ng qua việc hỗ trợ 05 hạng mục nước sạch v&agrave; vệ sinh bao gồm:</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<ol style="overflow-wrap: break-word; margin: 1em 0px 28px 8px; padding-right: 0px; padding-left: 16px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Lắp mới hệ thống lọc nước sạch.</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Cải tạo lại 02 nh&agrave; vệ sinh nam, nữ của trường</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">X&acirc;y mới bể phốt v&agrave; hoặc hệ thống xử l&yacute; chất thải của nh&agrave; vệ sinh</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Trang bị căn bản hệ thống nh&agrave; vệ sinh</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">X&acirc;y dựng v&agrave; cải tạo 05 bồn rửa tay</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
</ol>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Để&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">l&agrave;m được điều đ&oacute;, ch&uacute;ng t&ocirc;i k&ecirc;u gọi sự chung tay đ&oacute;ng g&oacute;p của cộng đồng với tổng số tiền số tiền g&acirc;y quỹ l&agrave; 100.000.000đ trong thời gian dự kiến từ 30.5.2024 &ndash; 30.06.2024 để cải</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tạo 05 hạng mục n&oacute;i tr&ecirc;n, trao tặng c&aacute;c phần qu&agrave; cho học sinh&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">v&agrave; c&aacute;c chi ph&iacute; kh&aacute;c như chi ph&iacute; truyền th&ocirc;ng, g&acirc;y quỹ, theo d&otilde;i, gi&aacute;m s&aacute;t v&agrave; quản l&yacute; dự &aacute;n&hellip; Ch&uacute;ng t&ocirc;i tin rằng, sau khi được hỗ trợ, c&aacute;c em học sinh trường TH</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;v&agrave; THCS Cao Sơn</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sẽ được sinh hoạt trong m&ocirc;i trường đ&aacute;p ứng ti&ecirc;u chuẩn về vệ sinh học đường.</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">H&atilde;y c&ugrave;ng ch&uacute;ng t&ocirc;i chung tay mang trường học hạnh ph&uacute;c đủ đầy nước sạch v&agrave; vệ sinh cho c&aacute;c em học sinh hạnh ph&uacute;c tới trường.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	&nbsp;</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<img alt="" class="aligncenter wp-image-28019 size-full" height="413" loading="lazy" src="https://givenow.vn/wp-content/uploads/2024/05/THHP_Banner-ngang-CTKM-e1716997598342.png" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; clear: both; text-align: center; border-radius: 0px; box-shadow: none; display: block; margin-left: auto; margin-right: auto;" width="1000" /></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">Về Chương tr&igrave;nh &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Kỷ niệm 5 năm th&agrave;nh lập Tổng C&ocirc;ng ty dịch vụ số Viettel &ndash; đơn vị chủ quản của Viettel Money, Viettel Money kết hợp c&ugrave;ng quỹ Hỗ</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;trợ đổi mới gi&aacute;o dục phổ th&ocirc;ng Việt Nam (</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">VIGEF</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">)</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;v&agrave; nền tảng G&acirc;y quỹ GiveNow triển khai chuỗi chương tr&igrave;nh &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo;, mang niềm</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;vui tới trường v&agrave;&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">cơ hội tiếp cận gi&aacute;o dục b&igrave;nh</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;đẳng,&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">hiện đại v&agrave; ph&aacute;t triển năng lực to&agrave;n diện cho</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;hơn 1,500</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;trẻ em v&ugrave;ng cao</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tại một số địa b&agrave;n kh&oacute; khăn nhất của Ho&agrave; B&igrave;nh, Y&ecirc;n B&aacute;i v&agrave; H&agrave; Giang.</span><span data-ccp-props="{}" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Mục ti&ecirc;u g&acirc;y quỹ: 555.000.000 VNĐ được chia th&agrave;nh 4 giai đoạn, dự kiến:</span><span data-ccp-props="{}" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;"><span style="font-weight: 700; box-sizing: border-box;">+ Giai đoạn 1</span>: từ ng&agrave;y 30.05-30.06.2024, g&acirc;y quỹ 100 triệu&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Đ</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">ồng nhằm x&acirc;y dựng/ cải tạo 5 hạng mục nước sạch</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;cho hơn 561 học sinh&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">điểm trường</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tiểu học</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;Cao Sơn, huyện Đ&agrave; Bắc, tỉnh Ho&agrave; B&igrave;nh</span><span data-ccp-props="{}" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;"><span style="font-weight: 700; box-sizing: border-box;">+ Giai đoạn 2</span>: từ ng&agrave;y 28.06-28.08.2024, g&acirc;y quỹ&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">100 triệu Đồng</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;nhằm cải tạo nh&agrave; ăn tập thể v&agrave; bếp ăn cho&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">605</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;học sinh d&acirc;n tộc thiểu số tại trường&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">phổ th&ocirc;ng d&acirc;n tộc b&aacute;n tr&uacute;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;THCS Khao Mang, x&atilde; Khao Mang, huyện M&ugrave; Cang Chải, Y&ecirc;n B&aacute;i</span><span data-ccp-props="{}" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;"><span style="font-weight: 700; box-sizing: border-box;">+ Giai đoạn 3</span>: từ ng&agrave;y 29.08 &ndash; 31.10.2024,</span>&nbsp;<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">g&acirc;y quỹ</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;200 triệu Đồng</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;nhằm cải tạo nh&agrave; vệ sinh cho trường</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;phổ th&ocirc;ng d&acirc;n tộc b&aacute;n tr&uacute;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;THCS Khao Mang</span><span data-ccp-props="{}" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;"><span style="font-weight: 700; box-sizing: border-box;">+ Giai đoạn 4</span>: từ ng&agrave;y 01.11-31.12.2024, g&acirc;y quỹ 155 triệu đồng nhằm trang bị ph&ograve;ng học theo m&ocirc; h&igrave;nh STEM cho</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;461 học sinh&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">trường phổ th&ocirc;ng d&acirc;n tộc</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;b&aacute;n tr&uacute; tiểu học</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;Sơn Vĩ, H&agrave; Giang.</span></p>
', N'638536517031893131_help_Baby.png', CAST(N'2024-06-10' AS Date), CAST(N'2024-06-16' AS Date), CAST(100000000.00 AS Decimal(18, 2)), 1, 1012, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4028, N'Tay Cộng Tay – Cho hạt nảy mầm: Gây quỹ trao 20 suất học bổng TÀI CHÍNH – KIẾN THỨC – KỸ NĂNG cho các em học sinh khó khăn, hiếu học tại Bến Tre', N'', N'<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">Thực tế khắc nghiệt đ&atilde; v&ugrave;i dập ước mơ của những em học sinh ngh&egrave;o!</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Về miền T&acirc;y, dừng ch&acirc;n gh&eacute; lại Bến Tre v&agrave; chứng kiến một thực trạng đ&aacute;ng lo ngại: t&igrave;nh trạng bỏ học ng&agrave;y c&agrave;ng nhiều của c&aacute;c em học sinh c&oacute; ho&agrave;n cảnh kh&oacute; khăn. T&iacute;nh đến đầu năm 2022, to&agrave;n tỉnh Bến Tre hiện c&oacute; 231.300 trẻ em, chiếm tỷ lệ khoảng 19% trong tổng d&acirc;n số. Trong đ&oacute;, trẻ em c&oacute; ho&agrave;n cảnh kh&oacute; khăn l&agrave; 1.478 trẻ, trẻ em con hộ ngh&egrave;o l&agrave; 11.891 trẻ. Lu&ocirc;n kh&aacute;t khao đến trường nhưng ho&agrave;n cảnh thực tế qu&aacute; khắc nghiệt đ&atilde; phần n&agrave;o v&ugrave;i dập ước mơ của c&aacute;c em!</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px; text-align: center;">
	<img class="aligncenter" src="https://homepage.momocdn.net/blogscontents/momo-upload-api-230810110531-638272623313605730.jpg" style="border: none; vertical-align: middle; max-width: 100%; height: auto; clear: both; box-sizing: border-box; display: block; margin-left: auto; margin-right: auto; border-radius: 0px; box-shadow: none;" /><em style="box-sizing: border-box;">Đến trường theo đuổi tri thức l&agrave; niềm mơ ước của nhiều em học sinh ngh&egrave;o kh&oacute; khăn</em></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Theo b&aacute;o c&aacute;o của Sở Gi&aacute;o dục v&agrave; Đ&agrave;o tạo tỉnh Bến Tre, trong năm học 2021-2022, tỉ lệ bỏ học của c&aacute;c em học sinh tại địa phương vẫn c&ograve;n cao, trong đ&oacute; c&oacute; hơn 60% l&agrave; c&aacute;c em nữ. V&igrave; kinh tế kh&oacute; khăn n&ecirc;n c&oacute; nhiều em học sinh phải đi l&agrave;m sớm để phụ gi&uacute;p gia đ&igrave;nh c&oacute; th&ecirc;m thu nhập. C&oacute; em ba mẹ mất sớm do bệnh hiểm ngh&egrave;o, c&oacute; em sống với &ocirc;ng b&agrave;. Thế n&ecirc;n ở c&aacute;i tuổi ăn chưa no, lo chưa tới nhưng c&aacute;c em vừa phải bươn chải kiếm sống, lại vừa cố gắng học h&agrave;nh để kh&ocirc;ng bị bỏ lại ph&iacute;a sau so với bạn học đồng trang lứa.</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Những kh&oacute; khăn về kinh tế khiến cho việc theo đuổi con chữ trở n&ecirc;n kh&oacute; khăn hơn bao giờ hết. C&aacute;i ngh&egrave;o như một v&ograve;ng luẩn quẩn n&iacute;u ch&acirc;n những đứa trẻ trong chặng đường tiến bước đến tương lai. Cha mẹ c&aacute;c em c&oacute; lẽ cũng hiểu được &yacute; nghĩa của việc học, hiểu được học l&agrave; con đường ngắn nhất để đi tới th&agrave;nh c&ocirc;ng, thế nhưng họ đến c&aacute;i ăn c&aacute;i mặc mỗi bữa c&ograve;n phải đắn đo lo lắng, n&oacute;i g&igrave; đến việc đi học t&igrave;m kiếm con chữ.</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px; text-align: center;">
	<img alt="" src="https://homepage.momocdn.net/blogscontents/momo-upload-api-230810110604-638272623648559933.jpg" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none;" /><em style="box-sizing: border-box;">Ho&agrave;n cảnh gia đ&igrave;nh ảnh hưởng đến việc theo đuổi ước mơ của nhiều học sinh</em></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">G&acirc;y quỹ trao học bổng gi&uacute;p học sinh ngh&egrave;o tiếp bước đến trường!</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Những kh&oacute; khăn về kinh tế vẫn hiện hữu ở đ&oacute;, nhưng nhiều em học sinh hiếu học vẫn vươn l&ecirc;n để đạt danh hiệu học sinh Kh&aacute;, Giỏi. Để tiếp sức cho qu&atilde;ng đường chinh phục tri thức của c&aacute;c em, Quỹ gi&aacute;o dục Hands-On k&ecirc;u gọi cộng đồng, c&aacute;c mạnh thường qu&acirc;n c&ugrave;ng chung tay quy&ecirc;n g&oacute;p số tiền l&agrave; 150.000.000 đồng. Tổng số tiền của dự &aacute;n sẽ được trao cho 20 em học sinh.</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px; text-align: center;">
	<img alt="" src="https://homepage.momocdn.net/blogscontents/momo-upload-api-230810110659-638272624197180045.jpg" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none;" /><em style="box-sizing: border-box;">Học bổng sẽ gi&uacute;p c&aacute;c em đ&oacute;ng học ph&iacute;, mua sắm dụng cụ&hellip;</em></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Mỗi suất học bổng trị gi&aacute; 7.500.000 đồng c&aacute;c em sẽ được hỗ trợ to&agrave;n diện trong suốt 1 năm tới, bao gồm: học ph&iacute; ch&iacute;nh quy, mua sắm dụng cụ học tập, thiết bị học tập online, c&aacute;c chương tr&igrave;nh học tiếng anh, tin học, hướng nghiệp v&agrave; kỹ năng mềm, bảo hiểm y tế cho người gi&aacute;m hộ&hellip;</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Một hạt giống trong vườn ươm của Hands-On sẽ cần đ&aacute;p ứng 3 ti&ecirc;u ch&iacute;:<br style="box-sizing: border-box;" />
	<em style="box-sizing: border-box;">1. Năng lực học tập kh&aacute;, giỏi<br style="box-sizing: border-box;" />
	2. C&oacute; nguy cơ phải tạm dừng việc học do ho&agrave;n cảnh kh&oacute; khăn<br style="box-sizing: border-box;" />
	3. &Yacute; ch&iacute;, kh&aacute;t khao được đi học, cam kết tham gia &iacute;t nhất mỗi năm một dự &aacute;n cộng đồng.</em><br style="box-sizing: border-box;" />
	Với ti&ecirc;u ch&iacute; 1 &amp; 2, Hands-On l&agrave;m việc s&acirc;u s&aacute;t với Ban Gi&aacute;m Hiệu nh&agrave; trường v&agrave; địa phương để c&oacute; được những th&ocirc;ng tin chuẩn x&aacute;c. Với ti&ecirc;u ch&iacute; 3, Hands-On v&agrave; nh&agrave; trường chung tay thực hiện &ldquo;Ng&agrave;y Gặp Gỡ&rdquo; để lắng nghe c&aacute;c em chia sẻ, định hướng đ&aacute;nh gi&aacute; v&agrave; chọn lọc những hạt mầm ph&ugrave; hợp.</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Cộng tay c&ugrave;ng Hands-On để x&oacute;a mờ đi sự bất b&igrave;nh đẳng trong tiếp cận gi&aacute;o dục v&agrave; để ng&agrave;y c&agrave;ng c&oacute; nhiều hơn nữa trẻ em tại Đồng bằng s&ocirc;ng Cửu Long được vững bước tới trường, c&ugrave;ng hướng tới một tương lai tự chủ v&agrave; hạnh ph&uacute;c!</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Tay đang cần Tay! Bạn ơi, c&ugrave;ng cộng tay nh&eacute;!</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<u style="box-sizing: border-box;"><span style="font-weight: 700; box-sizing: border-box;">Quỹ gi&aacute;o dục Hands-On:</span></u><br style="box-sizing: border-box;" />
	Quỹ gi&aacute;o dục Hands-On ra đời với niềm tin s&acirc;u sắc về việc khơi dậy v&agrave; th&uacute;c đẩy nội lực hạt giống trong mỗi đứa trẻ nảy mầm một c&aacute;ch tự chủ v&agrave; hạnh ph&uacute;c bằng con đường gi&aacute;o dục, Hands-On hướng đến việc kh&ocirc;ng chỉ hỗ trợ t&agrave;i ch&iacute;nh để tiếp sức cho c&aacute;c em học sinh trung học cơ sở v&agrave; trung học phổ th&ocirc;ng c&oacute; ho&agrave;n cảnh kh&oacute; khăn tại Đồng bằng s&ocirc;ng Cửu Long được đến trường, m&agrave; c&ograve;n tập trung x&acirc;y dựng c&aacute;c kh&oacute;a học bồi dưỡng kiến thức, hướng nghiệp, kỹ năng v&agrave; nhận thức để c&aacute;c em d&aacute;m ước mơ v&agrave; biến ước mơ của m&igrave;nh th&agrave;nh hiện thực. Quỹ tập trung hỗ trợ t&agrave;i ch&iacute;nh, kiến thức v&agrave; kỹ năng nhằm gi&uacute;p c&aacute;c em tăng cường năng lực tự chủ v&agrave; kết nối với nguồn tri thức cấp tiến, r&uacute;t ngắn ch&ecirc;nh lệch về mức độ tiếp cận tri thức giữa c&aacute;c v&ugrave;ng, ph&aacute;t triển l&ograve;ng tự h&agrave;o v&agrave; sự tr&acirc;n qu&yacute; của c&aacute;c em đối với qu&ecirc; hương, đất nước. Hands-On tin rằng, rồi mai đ&acirc;y ch&iacute;nh c&aacute;c em sẽ l&agrave; người tiếp tục h&agrave;nh tr&igrave;nh tay cộng tay, để tiếp tục kiến tạo n&ecirc;n những đổi thay t&iacute;ch cực cho gia đ&igrave;nh v&agrave; qu&ecirc; hương của c&aacute;c em v&agrave; để chắp c&aacute;nh cho nhiều ước mơ kh&aacute;c bay xa.</p>
', N'638537410601760810_wallpaperflare.com_wallpaper.jpg', CAST(N'2024-06-11' AS Date), CAST(N'2024-06-12' AS Date), CAST(100000000.00 AS Decimal(18, 2)), 4, 1012, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4029, N'Kêu gọi quyên góp cho trẻ em vùng cao cao thật là cao', N'', N'<h1 style="text-align: center;">
	<strong>Ti&ecirc;u đề : abc</strong></h1>
<h1 style="text-align: center;">
	<strong>nội dung : abc</strong></h1>
<h1 style="text-align: center;">
	<strong>mục ti&ecirc;u: abc</strong></h1>
', N'638537500867031916_help_Woman.png', CAST(N'2024-06-12' AS Date), CAST(N'2024-06-11' AS Date), CAST(10000000.00 AS Decimal(18, 2)), 1, 1012, N'Closed')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4030, N'Chung tay tiếp bước đến trường cho em Khang', N'', N'<section class="elementor-section elementor-top-section elementor-element elementor-element-4f880ac2 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="4f880ac2" style="box-sizing: border-box; position: relative; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 1440px;">
		<div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-2b83bc1b" data-element_type="column" data-id="2b83bc1b" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 681.763px;">
			<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 681.763px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
				<div class="elementor-element elementor-element-1da69a9f elementor-widget elementor-widget-text-editor" data-element_type="widget" data-id="1da69a9f" data-widget_type="text-editor.default" style="box-sizing: border-box; position: relative; width: 681.763px;">
					<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							Danh Dĩ Khang sinh ra v&agrave; lớn l&ecirc;n tại Ki&ecirc;n Giang, l&agrave; người con của d&acirc;n tộc thiểu số. Hiện tại đang học tập v&agrave; sinh sống tại Thủ Đức &ndash; B&igrave;nh Dương. Với ước mơ theo học ng&agrave;nh Kiến tr&uacute;c nhưng v&igrave; ho&agrave;n cảnh kh&oacute; khăn kh&ocirc;ng đủ điều kiện n&ecirc;n em đang học ng&agrave;nh Đ&ocirc; thị Trường Đại học Khoa học X&atilde; hội v&agrave; Nh&acirc;n văn. Bản th&acirc;n em hiểu được những kh&oacute; khăn v&agrave; nhọc nhằn của gia đ&igrave;nh, mẹ phải chạy đi mượn nợ v&agrave; ba&nbsp;phải lao động kh&ocirc;ng ngừng nghỉ v&igrave; để c&oacute; tiền cho em ăn học th&agrave;nh t&agrave;i.&nbsp;Mỗi ng&agrave;y mỗi giờ em lu&ocirc;n học tập kh&ocirc;ng ngừng v&igrave; em nghĩ rằng&nbsp;nếu như bu&ocirc;ng xu&ocirc;i tất cả th&igrave; m&igrave;nh rất phụ l&ograve;ng đến gia đ&igrave;nh của m&igrave;nh.</p>
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							<span style="font-weight: 700; box-sizing: border-box;">Vừa học vừa l&agrave;m</span></p>
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							Khang l&agrave; con trai cả trong gia đ&igrave;nh, sau Khang c&ograve;n 2 em nhỏ. Với tr&aacute;ch nhiệm của một người anh cả trong gia đ&igrave;nh Khang phải tự th&acirc;n bươn chải, sau những giờ học tr&ecirc;n lớp th&igrave; em đ&atilde; l&agrave;m th&ecirc;m kiếm tiền đ&oacute;ng học ph&iacute; một phần n&agrave;o đ&oacute; phụ gi&uacute;p gia đ&igrave;nh. Trong cuộc sống hằng ng&agrave;y em cũng gặp kh&ocirc;ng &iacute;t kh&oacute; khăn, v&igrave; gia đ&igrave;nh kh&oacute; khăn n&ecirc;n em phải ở gh&eacute;p với một bạn sinh vi&ecirc;n. C&ugrave;ng với đ&oacute; Khang đang bị suy dinh dưỡng n&ecirc;n rất nhiều lần&nbsp;em đ&atilde; ngất xỉu v&igrave; kiệt sức.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="elementor-section elementor-top-section elementor-element elementor-element-fd4000a elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="fd4000a" style="box-sizing: border-box; position: relative; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 1440px;">
		<div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-1629311" data-element_type="column" data-id="1629311" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 681.763px;">
			<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 681.763px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
				<section class="elementor-section elementor-inner-section elementor-element elementor-element-93608d0 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="93608d0" style="box-sizing: border-box; position: relative; width: 681.763px;">
					<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 100%;">
						<div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-152924a" data-element_type="column" data-id="152924a" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 340.875px;">
							<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 340.875px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
								<div class="elementor-element elementor-element-de54bc7 elementor-widget elementor-widget-image" data-element_type="widget" data-id="de54bc7" data-widget_type="image.default" style="box-sizing: border-box; position: relative; text-align: center; width: 340.875px;">
									<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
										<img alt="" class="attachment-large size-large" height="768" loading="lazy" sizes="(max-width: 1024px) 100vw, 1024px" src="https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-1024x768.jpg" srcset="https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-1024x768.jpg 1024w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-300x225.jpg 300w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-768x576.jpg 768w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-800x600.jpg 800w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-450x338.jpg 450w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1-600x450.jpg 600w, https://givenow.vn/wp-content/uploads/2023/05/z4326797645816_ca324d0154bac0ee95a50cfadc3558f1.jpg 1280w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none; display: inline-block;" width="1024" /></div>
								</div>
							</div>
						</div>
						<div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-7c8127f" data-element_type="column" data-id="7c8127f" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 340.875px;">
							<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 340.875px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
								<div class="elementor-element elementor-element-b0755fc elementor-widget elementor-widget-image" data-element_type="widget" data-id="b0755fc" data-widget_type="image.default" style="box-sizing: border-box; position: relative; text-align: center; width: 340.875px; margin-bottom: 20px;">
									<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
										<img alt="" class="attachment-large size-large" height="768" loading="lazy" sizes="(max-width: 1024px) 100vw, 1024px" src="https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-1024x768.jpg" srcset="https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-1024x768.jpg 1024w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-300x225.jpg 300w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-768x576.jpg 768w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-800x600.jpg 800w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-450x338.jpg 450w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-600x450.jpg 600w, https://givenow.vn/wp-content/uploads/2023/05/z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6.jpg 1280w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none; display: inline-block;" width="1024" /></div>
								</div>
								<div class="elementor-element elementor-element-1c4596e elementor-widget elementor-widget-spacer" data-element_type="widget" data-id="1c4596e" data-widget_type="spacer.default" style="box-sizing: border-box; position: relative; width: 340.875px;">
									<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
										<div class="elementor-spacer" style="box-sizing: border-box;">
											<div class="elementor-spacer-inner" style="box-sizing: border-box; height: 10px;">
												&nbsp;</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
</section>
<section class="elementor-section elementor-top-section elementor-element elementor-element-d9cf706 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="d9cf706" style="box-sizing: border-box; position: relative; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 1440px;">
		<div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-c591061" data-element_type="column" data-id="c591061" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 681.763px;">
			<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 681.763px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
				<section class="elementor-section elementor-inner-section elementor-element elementor-element-872460b elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="872460b" style="box-sizing: border-box; position: relative; width: 681.763px;">
					<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 100%;">
						<div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-68e0c38" data-element_type="column" data-id="68e0c38" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 340.875px;">
							<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 340.875px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
								<div class="elementor-element elementor-element-95ce71a elementor-widget elementor-widget-image" data-element_type="widget" data-id="95ce71a" data-widget_type="image.default" style="box-sizing: border-box; position: relative; text-align: center; width: 340.875px;">
									<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
										<img alt="" class="attachment-large size-large" height="1024" loading="lazy" sizes="(max-width: 768px) 100vw, 768px" src="https://givenow.vn/wp-content/uploads/2023/05/z4326797652225_e48978255661fd522d89e6d7ed1d6b5c-768x1024.jpg" srcset="https://givenow.vn/wp-content/uploads/2023/05/z4326797652225_e48978255661fd522d89e6d7ed1d6b5c-768x1024.jpg 768w, https://givenow.vn/wp-content/uploads/2023/05/z4326797652225_e48978255661fd522d89e6d7ed1d6b5c-225x300.jpg 225w, https://givenow.vn/wp-content/uploads/2023/05/z4326797652225_e48978255661fd522d89e6d7ed1d6b5c-600x800.jpg 600w, https://givenow.vn/wp-content/uploads/2023/05/z4326797652225_e48978255661fd522d89e6d7ed1d6b5c.jpg 960w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none; display: inline-block;" width="768" /></div>
								</div>
							</div>
						</div>
						<div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-00b163d" data-element_type="column" data-id="00b163d" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 340.875px;">
							<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 340.875px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
								<div class="elementor-element elementor-element-1a5d1a8 elementor-widget elementor-widget-image" data-element_type="widget" data-id="1a5d1a8" data-widget_type="image.default" style="box-sizing: border-box; position: relative; text-align: center; width: 340.875px;">
									<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
										<img alt="" class="attachment-large size-large" height="1024" loading="lazy" sizes="(max-width: 768px) 100vw, 768px" src="https://givenow.vn/wp-content/uploads/2023/05/z4326797644176_f3e8a2673931ff3c8e3878d060eb4390-768x1024.jpg" srcset="https://givenow.vn/wp-content/uploads/2023/05/z4326797644176_f3e8a2673931ff3c8e3878d060eb4390-768x1024.jpg 768w, https://givenow.vn/wp-content/uploads/2023/05/z4326797644176_f3e8a2673931ff3c8e3878d060eb4390-225x300.jpg 225w, https://givenow.vn/wp-content/uploads/2023/05/z4326797644176_f3e8a2673931ff3c8e3878d060eb4390-600x800.jpg 600w, https://givenow.vn/wp-content/uploads/2023/05/z4326797644176_f3e8a2673931ff3c8e3878d060eb4390.jpg 960w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none; display: inline-block;" width="768" /></div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
</section>
<section class="elementor-section elementor-top-section elementor-element elementor-element-331714b elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-element_type="section" data-id="331714b" style="box-sizing: border-box; position: relative; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<div class="elementor-container elementor-column-gap-default" style="box-sizing: border-box; display: flex; margin-right: auto; margin-left: auto; position: relative; max-width: 1440px;">
		<div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-3aced61" data-element_type="column" data-id="3aced61" style="box-sizing: border-box; min-height: 1px; position: relative; display: flex; width: 681.763px;">
			<div class="elementor-widget-wrap elementor-element-populated" style="box-sizing: border-box; position: relative; width: 681.763px; flex-wrap: wrap; align-content: flex-start; display: flex; padding: 0px;">
				<div class="elementor-element elementor-element-4d10fd9 elementor-widget elementor-widget-text-editor" data-element_type="widget" data-id="4d10fd9" data-widget_type="text-editor.default" style="box-sizing: border-box; position: relative; width: 681.763px;">
					<div class="elementor-widget-container" style="box-sizing: border-box; transition: background 0.3s ease 0s, border 0.3s ease 0s, border-radius 0.3s ease 0s, box-shadow 0.3s ease 0s, -webkit-border-radius 0.3s ease 0s, -webkit-box-shadow 0.3s ease 0s;">
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							<br style="box-sizing: border-box;" />
							<span style="font-weight: 700; box-sizing: border-box;">Tham gia hoạt động x&atilde; hội</span></p>
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							Khang l&agrave; một người năng nổ, hoạt b&aacute;t lu&ocirc;n tham gia c&aacute;c hoạt động như: &ldquo;Tham gia chiến dịch xu&acirc;n t&igrave;nh nguyện 2021&rdquo;, &ldquo;Tham gia chương tr&igrave;nh&nbsp;Đ&ecirc;m t&igrave;nh nguyện&rdquo;, &ldquo;Tham gia chương tr&igrave;nh đ&aacute; đơm hoa&rdquo;, &ldquo;Tham gia m&ugrave;a h&egrave; xanh 2022&rdquo;&hellip;</p>
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							<span style="font-weight: 700; box-sizing: border-box;">Quyết t&acirc;m theo đuổi ước mơ</span></p>
						<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box;">
							Kh&oacute; khăn l&agrave; vậy nhưng Khang chưa một lần bỏ cuộc với một niềm tin rằng mọi chuyện đều sẽ ổn nếu như em c&oacute; một tinh thần lạc quan v&agrave; kh&ocirc;ng ngừng nỗ lực theo đuổi ước mơ. Ước mơ lớn nhất của em l&agrave; sau n&agrave;y sẽ kh&ocirc;ng bao giờ nh&igrave;n thấy sự lam lũ v&agrave; cực nhọc của cha v&agrave; mẹ nữa, em muốn th&agrave;nh một người c&oacute; &iacute;t cho x&atilde; hội v&agrave; cho cộng đồng. Em muốn m&igrave;nh c&oacute; những kỹ năng của một nh&agrave; kỹ sư, một cử nh&acirc;n đ&ocirc; thị để sau n&agrave;y c&oacute; thể x&acirc;y cho cha v&agrave; mẹ một căn nh&agrave; mơ ước.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<p>
	&nbsp;</p>
', N'638537590686294863_z4326797635083_faf4239384b8e4458cf67bd3a6ef5ae6-1024x768.jpg', CAST(N'2024-06-12' AS Date), CAST(N'2024-06-13' AS Date), CAST(100000000.00 AS Decimal(18, 2)), 2, 1012, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4031, N'Kiến tạo trường học hạnh phúc: Xây dựng 5 hạng mục nước sạch cho hơn 550 học sinh TH&THCS Cao Sơn, Hoà Bình', N'', N'<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">N&oacute;i đến trường học hạnh ph&uacute;c, bạn nghĩ đến điều g&igrave;? Đ&oacute; c&oacute; thể l&agrave; cơ sở vật chất khang trang, m&aacute;y m&oacute;c hiện đại, ph&ograve;ng học hạnh ph&uacute;c, c&aacute;c bữa ăn đủ đầy, c&aacute;c học sinh vừa tiếp thu c&aacute;c tri thức hiện đại, vừa gi&ograve;n tan trong nụ cười của tuổi thơ???&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Trường học hạnh ph&uacute;c c&oacute; thể l&agrave; những thứ cao xa, nhưng cũng c&oacute; thể rất giản dị với những trẻ em v&ugrave;ng cao, d&acirc;n tộc thiểu số c&oacute; ho&agrave;n cảnh kh&oacute; khăn m&agrave; ch&uacute;ng t&ocirc;i gặp gỡ trong h&agrave;nh tr&igrave;nh thực địa, khảo s&aacute;t x&acirc;y dựng c&aacute;c trường học hạnh ph&uacute;c, gi&aacute;o dục c&ocirc;ng bằng tr&ecirc;n khắp Việt Nam.&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;"><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&ldquo;Con th&iacute;ch trường đầy nước&rdquo;</span></span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">Em A học lớp 4, d&acirc;n tộc T&agrave;y, trường tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh Ho&agrave; B&igrave;nh rất th&iacute;ch đi học d&ugrave; nh&agrave; em c&aacute;ch trường 8&nbsp;c&acirc;y số. Mỗi ng&agrave;y đến trường với em &nbsp;đều l&agrave; một ng&agrave;y vui. Em A, 9&nbsp;tuổi nhưng nhỏ thấp hơn c&aacute;c bạn đồng lứa, để đi học, mỗi ng&agrave;y ngo&agrave;i vượt 8 c&acirc;y số tới trường, em c&ograve;n mang theo nước để uống. Ở trường thiếu nước sạch, n&ecirc;n bố mẹ phải dậy sớm h&agrave;ng ng&agrave;y lấy nước, đun nước cho em mang tới trường, nhưng kể cả thế, nước em mang cũng kh&ocirc;ng phải nước hợp vệ sinh v&igrave; chỉ được lấy từ m&oacute; nước b&ecirc;n khe suối, bờ ruộng được xử l&yacute; qua loa. Ch&iacute;nh v&igrave; thế, ch&uacute;t nước qu&yacute; gi&aacute; nhiều c&ocirc;ng sức em mang tới trường kia vẫn thỉnh thoảng l&agrave;m em đau bụng v&agrave; kh&ocirc;ng đ&atilde; kh&aacute;t. Khi gặp ch&uacute;ng t&ocirc;i, em bảo &ldquo;Con th&iacute;ch trường đầy nước&rdquo;&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">Những thứ giản dị l&agrave; nước sạch, nh&agrave; vệ sinh&nbsp;</span><span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">ch&iacute;nh l&agrave; những thứ căn bản, nhưng mang lại hạnh ph&uacute;c cho việc học tập của kh&ocirc;ng chỉ em A, em T m&agrave; c&ograve;n của hơn 555 học sinh d&acirc;n tộc thiểu số của Tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh Ho&agrave; B&igrave;nh.&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Được biết đến l&agrave; một ng&ocirc;i trường tại v&ugrave;ng s&acirc;u xa kh&oacute; khăn bậc nhất của Ho&agrave; B&igrave;nh, trường tiểu học v&agrave; THCS Cao Sơn c&ograve;n gặp rất nhiều kh&oacute; khăn, đặc biệt l&agrave; h</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">ệ thống nước sạch của trường chưa</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;đủ chất lượng để&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">c&oacute; thể cung cấp đầy đủ nhu cầu sử</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;dụng&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">của to&agrave;n trường, nh&agrave; vệ</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sinh xuống cấp, kh&ocirc;ng đảm bảo an to&agrave;n</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">. Đặc</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;biệt, c</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&ocirc;ng tr&igrave;nh vệ sinh c&ograve;n thiếu c&oacute; khu rửa tay với nước sạch v&agrave; x&agrave; ph&ograve;ng</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">/</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">dung dịch s&aacute;t khuẩn</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;cho học sinh. Ch&iacute;nh v&igrave; thế, v</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">iệc đầu tư cải</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tạo nh&agrave; vệ sinh v&agrave; hệ thống nước sạch</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sẽ gi&uacute;p đảm bảo điều kiện vệ sinh học đường đồng thời lan tỏa, thu h&uacute;t sự tham gia của đ&ocirc;ng đảo c&aacute;c nguồn lực x&atilde; hội kh&aacute;c đầu tư đ&uacute;ng hướng cho học sinh để c&oacute; một m&ocirc;i trường học tập &ldquo;trường học th&acirc;n thiện, học sinh khỏe mạnh&rdquo;.</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<img alt="" class="aligncenter wp-image-28003 size-full" height="1324" loading="lazy" sizes="(max-width: 1340px) 100vw, 1340px" src="https://givenow.vn/wp-content/uploads/2024/05/A%CC%89nh-ma%CC%80n-hi%CC%80nh-2024-05-29-lu%CC%81c-22.02.52.png" srcset="https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52.png 1340w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-300x296.png 300w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-1024x1012.png 1024w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-768x759.png 768w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-100x100.png 100w, https://givenow.vn/wp-content/uploads/2024/05/Ảnh-màn-hình-2024-05-29-lúc-22.02.52-600x593.png 600w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; clear: both; text-align: center; border-radius: 0px; box-shadow: none; display: block; margin-left: auto; margin-right: auto;" width="1340" /></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;"><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">Kỷ niệm 5 năm th&agrave;nh lập Tổng C&ocirc;ng ty dịch vụ số Viettel &ndash; đơn vị chủ quản của Viettel Money, Viettel Money kết hợp c&ugrave;ng quỹ Hỗ</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;trợ đổi mới gi&aacute;o dục phổ th&ocirc;ng Việt Nam (</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">VIGEF</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">)</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;v&agrave; nền tảng G&acirc;y quỹ GiveNow triển khai chuỗi chương tr&igrave;nh &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo;, mang niềm</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;vui tới trường v&agrave;&nbsp;</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">cơ hội tiếp cận gi&aacute;o dục b&igrave;nh</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;đẳng,&nbsp;</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI"><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">hiện đại v&agrave; ph&aacute;t triển năng lực to&agrave;n diện cho</span></span><span class="TextRun SCXW238105938 BCX0" data-contrast="auto" lang="VI-VN" style="box-sizing: border-box; padding-bottom: 25px;" xml:lang="VI-VN">&nbsp;<span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">1500 em học sinh v&ugrave;ng cao, trong đ&oacute; c&oacute;&nbsp;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">hơn 555&nbsp;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;học sinh trường Tiểu học v&agrave; THCS Cao Sơn, huyện Đ&agrave; Bắc, tỉnh&nbsp;</span><span class="NormalTextRun SpellingErrorV2Themed SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">Ho&agrave;</span><span class="NormalTextRun SCXW238105938 BCX0" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;B&igrave;nh.</span></span><span class="EOP SCXW238105938 BCX0" data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span>&nbsp;</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Giai đoạn 1 dự &aacute;n &ldquo;Kiến tạo trường học hạnh ph&uacute;c&rdquo; đặt mục ti&ecirc;u mang nước sạch v&agrave; nh&agrave; vệ sinh sạch sẽ &ldquo;Đại sứ nước đủ đầy&rdquo; tới hơn 555 học sinh v&ugrave;ng cao tại trường Tiểu học v&agrave; THCS Cao Sơn th&ocirc;ng qua việc hỗ trợ 05 hạng mục nước sạch v&agrave; vệ sinh bao gồm:</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<ol style="overflow-wrap: break-word; margin: 1em 0px 28px 8px; padding-right: 0px; padding-left: 16px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Lắp mới hệ thống lọc nước sạch.</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Cải tạo lại 02 nh&agrave; vệ sinh nam, nữ của trường</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">X&acirc;y mới bể phốt v&agrave; hoặc hệ thống xử l&yacute; chất thải của nh&agrave; vệ sinh</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">Trang bị căn bản hệ thống nh&agrave; vệ sinh</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
	<li style="box-sizing: border-box;">
		<span data-contrast="auto" style="box-sizing: border-box;">X&acirc;y dựng v&agrave; cải tạo 05 bồn rửa tay</span><span data-ccp-props="{" style="box-sizing: border-box;">&nbsp;</span></li>
</ol>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="auto" style="box-sizing: border-box; padding-bottom: 25px;">Để&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">l&agrave;m được điều đ&oacute;, ch&uacute;ng t&ocirc;i k&ecirc;u gọi sự chung tay đ&oacute;ng g&oacute;p của cộng đồng với tổng số tiền số tiền g&acirc;y quỹ l&agrave; 100.000.000đ trong thời gian dự kiến từ 30.5.2024 &ndash; 30.06.2024 để cải</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;tạo 05 hạng mục n&oacute;i tr&ecirc;n, trao tặng c&aacute;c phần qu&agrave; cho học sinh&nbsp;</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">v&agrave; c&aacute;c chi ph&iacute; kh&aacute;c như chi ph&iacute; truyền th&ocirc;ng, g&acirc;y quỹ, theo d&otilde;i, gi&aacute;m s&aacute;t v&agrave; quản l&yacute; dự &aacute;n&hellip; Ch&uacute;ng t&ocirc;i tin rằng, sau khi được hỗ trợ, c&aacute;c em học sinh trường TH</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;v&agrave; THCS Cao Sơn</span><span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;sẽ được sinh hoạt trong m&ocirc;i trường đ&aacute;p ứng ti&ecirc;u chuẩn về vệ sinh học đường.</span><span data-ccp-props="{" style="box-sizing: border-box; padding-bottom: 25px;">&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span data-contrast="none" style="box-sizing: border-box; padding-bottom: 25px;">H&atilde;y c&ugrave;ng ch&uacute;ng t&ocirc;i chung tay mang trường học hạnh ph&uacute;c đủ đầy nước sạch v&agrave; vệ sinh cho c&aacute;c em học sinh hạnh ph&uacute;c tới trường.</span></p>
', N'638537592255031116_THHP-_432x324_Banner-news_Givenow-1024x768.png', CAST(N'2024-06-12' AS Date), CAST(N'2024-06-16' AS Date), CAST(110000000.00 AS Decimal(18, 2)), 2, 1013, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4032, N'Người già neo đơn đang nuôi dưỡng tại Trung tâm Bảo trợ xã hội ủng hộ Quỹ phòng, chống già cả', N'', N'<div class="chitiet_tomtat" style="box-sizing: border-box; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Sans Serif&quot;;">
	<p dir="ltr" style="box-sizing: border-box; margin: 0px 0px 10px; text-align: justify;">
		<strong style="box-sizing: border-box;"><span style="font-size: 16px; box-sizing: border-box;"><span style="font-size: 12px; box-sizing: border-box; font-family: &quot;times new roman&quot;, times, serif;">Hưởng ứng lời k&ecirc;u gọi của Ủy ban Mặt trận Tổ quốc Việt Nam tỉnh C&agrave; Mau, với nghĩa cử cao đẹp của 11 cụ gi&agrave; neo đơn đang được nu&ocirc;i dưỡng tại Trung t&acirc;m Bảo trợ X&atilde; hội, ng&agrave;y 08/6/2021 đ&atilde; tự nguyện quy&ecirc;n g&oacute;p, ủng hộ cho quỹ ph&ograve;ng, chống dịch bệnh Covid-19.</span></span></strong></p>
</div>
<div class="chitiet_noidung" id="contentPrintId" style="box-sizing: border-box; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Sans Serif&quot;; text-align: justify;">
	<p dir="ltr" style="box-sizing: border-box; margin: 0px 0px 10px;">
		<span style="font-size: 16px; box-sizing: border-box;"><span style="font-size: 12px; box-sizing: border-box; font-family: &quot;times new roman&quot;, times, serif;">Trung t&acirc;m Bảo trợ X&atilde; hội hiện đang quản l&yacute;, chăm s&oacute;c, nu&ocirc;i dưỡng 103 đối tượng, trong đ&oacute; c&oacute; 50 cụ gi&agrave; gồm: mẹ VNAH, người c&oacute; c&ocirc;ng với nước, th&acirc;n nh&acirc;n gia đ&igrave;nh ch&iacute;nh s&aacute;ch v&agrave; người gi&agrave; c&ocirc; đơn kh&ocirc;ng nơi nương tựa; c&ugrave;ng 53 trẻ bị bỏ rơi, mồ c&ocirc;i, lang thang, khuyết tật, trẻ c&oacute; ho&agrave;n cảnh đặc biệt kh&oacute; khăn...</span></span></p>
	<p dir="ltr" style="box-sizing: border-box; margin: 0px 0px 10px; text-align: center;">
		<img alt="" height="500" src="https://soldtbxh.camau.gov.vn/wps/wcm/connect/soldtbvaxh/b2384231-3b08-43f2-916e-4aabcee334da/1/H%C3%8CNH+%E1%BB%A6NG+H%E1%BB%98+COVID-19.jpg?MOD=AJPERES&amp;CVID=" style="box-sizing: border-box; border: 0px; vertical-align: middle; max-width: 100%;" title="" width="500" /></p>
	<p dir="ltr" style="box-sizing: border-box; margin: 0px 0px 10px;">
		<span style="font-size: 16px; box-sizing: border-box;"><span style="font-size: 12px; box-sizing: border-box; font-family: &quot;times new roman&quot;, times, serif;">Kể từ khi đại dịch Covid-19 b&ugrave;ng ph&aacute;t đến nay, với quyết t&acirc;m &ldquo;Chống dịch như chống giặc&rdquo;, dưới sự l&atilde;nh đạo của Đảng, Nh&agrave; nước v&agrave; sự điều h&agrave;nh của ch&iacute;nh quyền c&aacute;c cấp đ&atilde; triển khai quyết liệt với nhiều biện ph&aacute;p đồng bộ, vừa ngăn chặn, kiểm so&aacute;t dịch bệnh, vừa kh&ocirc;i phục ph&aacute;t triển kinh tế, bảo đảm an sinh x&atilde; hội. Tuy nhi&ecirc;n, hiện nay dịch bệnh đang diễn biến hết sức phức tạp, l&acirc;y lan nhanh v&agrave; rất nguy hiểm, kh&oacute; lường, g&acirc;y ảnh hưởng lớn đến ph&aacute;t triển kinh tế - x&atilde; hội, đời sống, sản xuất của nh&acirc;n d&acirc;n trong cả nước n&oacute;i chung, tỉnh C&agrave; Mau n&oacute;i ri&ecirc;ng. Trước t&igrave;nh h&igrave;nh đ&oacute;, hưởng ứng lời k&ecirc;u gọi của Ủy ban Mặt trận Tổ quốc Việt Nam tỉnh C&agrave; Mau,c&aacute;c cụ gi&agrave; neo đơn đang được nu&ocirc;i dưỡng tại Trung t&acirc;m Bảo trợ X&atilde; hội mặc d&ugrave; ho&agrave;n cảnh hết sức đặc biệt (mỗi người một ho&agrave;n cảnh) nhưng cũng đ&atilde; &yacute; thức, tr&aacute;ch nhiệm của bản th&acirc;n m&igrave;nh đối với đất nước trong l&uacute;c kh&oacute; khăn do đại dịch Covid-19 n&ecirc;n mong muốn đ&oacute;ng g&oacute;p một phần kinh ph&iacute; để ủng hộ cho Quỹ ph&ograve;ng, chống dịch bệnh Covid-19.</span></span></p>
</div>
<p>
	&nbsp;</p>
', N'638537594843261910_img.jpg', CAST(N'2024-06-12' AS Date), CAST(N'2024-07-01' AS Date), CAST(25000000.00 AS Decimal(18, 2)), 1, 1012, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4034, N'Một ngàn cánh diều cho hy vọng', N'', N'<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">Gi&uacute;p đỡ nhiều bệnh nhi với Chiến dịch g&acirc;y quỹ &ldquo;C&aacute;nh Diều Hy Vọng, H&egrave; 2024&rdquo;&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<i style="box-sizing: border-box;"><span style="box-sizing: border-box; padding-bottom: 25px;">Chiến dịch g&acirc;y quỹ &ldquo;C&aacute;nh Diều Hy Vọng, H&egrave; 2024&rdquo; do Quỹ N&acirc;ng Bước Tuổi Thơ tổ chức l&agrave; cơ hội để mỗi c&aacute; nh&acirc;n, tổ chức v&agrave; doanh nghiệp chung tay hỗ trợ c&aacute;c bệnh nhi c&oacute; được sự chăm s&oacute;c y tế chất lượng cao kịp thời.&nbsp;</span></i></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	Ch&uacute;ng t&ocirc;i xin k&ecirc;u gọi sự chung tay gi&uacute;p đỡ của cộng đồng c&aacute;c nh&agrave; hảo t&acirc;m GiveNow&nbsp;<span style="font-weight: 700; box-sizing: border-box;">c&ugrave;ng g&acirc;y quỹ&nbsp;với 1.000 c&aacute;nh diều</span>, tương đương với số tiền 380.000.000vnd cho Chiến dịch C&aacute;nh Diều Vy Vọng</p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">Nhu cầu y tế cấp thiết cho trẻ em</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">Theo thống k&ecirc; gần nhất của cơ quan y tế, mỗi năm Việt Nam c&oacute; khoảng 41.000 trẻ em bị dị tật bẩm sinh. Tỉ lệ n&agrave;y tương đương cứ 13 ph&uacute;t lại c&oacute; một trẻ mắc dị tật bẩm sinh được sinh ra. Trong đ&oacute; c&oacute; khoảng 1.400-1.800 trẻ bị mắc bệnh Down, 1.000-1.500 trẻ bị dị tật ống thần kinh, 300-400 trẻ bị suy gi&aacute;p bẩm sinh, khoảng 2.200 trẻ bị bệnh tan m&aacute;u bẩm sinh&hellip; Con số n&agrave;y chưa bao gồm c&aacute;c trẻ em bị mắc tai nạn v&agrave; bệnh tật do c&aacute;c yếu tố b&ecirc;n ngo&agrave;i.&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">Chi ph&iacute; y tế cho con em kh&ocirc;ng may gặp c&aacute;c t&igrave;nh huống tr&ecirc;n của c&aacute;c gia đ&igrave;nh l&agrave; rất lớn. Do đ&oacute;, ngay từ năm 2006, Quỹ N&acirc;ng Bước Tuổi Thơ đ&atilde; được s&aacute;ng lập nhằm cung cấp chuy&ecirc;n m&ocirc;n điều trị bệnh l&yacute; v&agrave; phẫu thuật đa khoa theo ti&ecirc;u chuẩn quốc tế cho trẻ em dị tật bẩm sinh c&oacute; ho&agrave;n cảnh kh&oacute; khăn. Tổ chức n&agrave;y ra đời với sứ mệnh tạo n&ecirc;n sức mạnh của t&igrave;nh y&ecirc;u thương, gi&uacute;p trẻ em c&oacute; ho&agrave;n cảnh kh&oacute; khăn tr&ecirc;n khắp Việt Nam vượt qua những khiếm khuyết của cơ thể th&ocirc;ng qua điều trị y tế b&agrave;i bản, c&oacute; cơ hội ph&aacute;t triển hết tiềm năng của m&igrave;nh cho một cuộc sống mới tốt đẹp hơn.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">Trong 18 năm hoạt động tại Việt Nam, Quỹ N&acirc;ng Bước Tuổi Thơ đ&atilde; gi&uacute;p hơn 800 trẻ em dị tật bẩm sinh v&agrave; thương tật do tai nạn c&oacute; thể tiếp cận điều trị tại những cơ sở y tế tốt nhất Việt Nam nhờ sự đ&oacute;ng g&oacute;p của c&aacute;c doanh nghiệp, c&aacute;c nh&agrave; hảo t&acirc;m trong v&agrave; ngo&agrave;i nước. Nguồn g&acirc;y quỹ được sử dụng để chu cấp trọn vẹn trong suốt qu&aacute; tr&igrave;nh điều trị, từ khi phẫu thuật cho đến khi c&aacute;c em hồi phục c&aacute;c khiếm khuyết (bao gồm cả chi ph&iacute; đi lại v&agrave; ăn ở cho người th&acirc;n nu&ocirc;i bệnh).</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">C&aacute;c bệnh l&yacute; v&agrave; phẫu thuật đa khoa từng được Quỹ N&acirc;ng Bước Tuổi Thơ hỗ trợ bao gồm: mắt, h&agrave;m mặt, c&aacute;c bệnh l&yacute; tim mạch bẩm sinh, bệnh mạch m&aacute;u, chấn thương chỉnh h&igrave;nh, tiết niệu, ti&ecirc;u ho&aacute;, thần kinh v&agrave; c&aacute;c trường hợp đặc biệt kh&aacute;c do tai nạn hay bệnh tật như phỏng, khuyết tật do bại liệt g&acirc;y ra.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<img alt="" class="alignnone wp-image-27453 size-large" height="366" loading="lazy" sizes="(max-width: 1024px) 100vw, 1024px" src="https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500-1024x366.png" srcset="https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500-1024x366.png 1024w, https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500-300x107.png 300w, https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500-768x274.png 768w, https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500-600x214.png 600w, https://givenow.vn/wp-content/uploads/2024/05/Banner_1400x500.png 1400w" style="border: none; vertical-align: middle; max-width: 100%; height: auto; box-sizing: border-box; border-radius: 0px; box-shadow: none;" width="1024" /></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">Ng&agrave;y hội &ldquo;C&aacute;nh Diều Hy Vọng, H&egrave; 2024&rdquo;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">H&egrave; l&agrave; khoảng thời gian trẻ em được vui chơi, kh&aacute;m ph&aacute; v&agrave; trải nghiệm c&aacute;c hoạt động &yacute; nghĩa. Tuy nhi&ecirc;n, quyền lợi ch&iacute;nh đ&aacute;ng n&agrave;y lại l&agrave; ước mơ xa vời với c&aacute;c em nhỏ kh&ocirc;ng may mắc bệnh hoặc gặp tai nạn. Đ&acirc;y l&agrave; động lực để Quỹ N&acirc;ng Bước Tuổi Thơ triển khai chiến dịch v&agrave; tổ chức ng&agrave;y hội g&acirc;y quỹ từ thiện &ldquo;C&aacute;nh Diều Hy Vọng, H&egrave; 2024&rdquo; nhằm huy động nguồn lực từ c&aacute;c c&aacute; nh&acirc;n, tổ chức th&ocirc;ng qua c&aacute;c hoạt động đa dạng, thiết thực.&nbsp;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">Năm 2024 l&agrave; năm đầu ti&ecirc;n chiến dịch &ldquo;C&aacute;nh Diều Hy Vọng, H&egrave; 2024&rdquo; được Quỹ N&acirc;ng Bước Tuổi Thơ tổ chức với định hướng duy tr&igrave; v&agrave; x&acirc;y dựng th&agrave;nh một hoạt động thường ni&ecirc;n &yacute; nghĩa, một di sản thiện nguyện l&acirc;u d&agrave;i của cộng đồng nhằm hướng tới một x&atilde; hội tốt đẹp hơn.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">B&agrave; L&ecirc; Thị Lan Khanh, Gi&aacute;m đốc điều h&agrave;nh Quỹ N&acirc;ng Bước Tuổi Thơ cho biết: &ldquo;Mỗi sự sẻ chia lu&ocirc;n mang lại nhiều điều kỳ diệu cho cuộc sống. Mong rằng ng&agrave;y hội &ldquo;C&aacute;nh diều hi vọng 2024&rdquo; sẽ mang lại triệu nụ cười hạnh ph&uacute;c, tạo n&ecirc;n một m&ugrave;a h&egrave; &yacute; nghĩa cho tất cả c&aacute;c em.&rdquo;</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="font-weight: 700; box-sizing: border-box;">&Yacute; nghĩa của C&aacute;nh Diều &ndash; Biểu tượng của hy vọng v&agrave; ph&eacute;p m&agrave;u</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">C&aacute;nh diều mỏng manh nhưng đầy sức mạnh, mang theo bao &yacute; nghĩa đẹp đẽ trong t&acirc;m hồn con người. N&oacute; l&agrave; biểu tượng cho&nbsp;</span><span style="font-weight: 700; box-sizing: border-box;">hy vọng</span><span style="box-sizing: border-box; padding-bottom: 25px;">, cho những ước mơ bay cao, vươn xa. Khi thả diều, ta gửi gắm v&agrave;o đ&oacute; niềm tin v&agrave;o tương lai tươi s&aacute;ng, v&agrave;o những điều tốt đẹp sẽ đến.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">C&aacute;nh diều c&ograve;n l&agrave; ph&eacute;p m&agrave;u của tuổi thơ. N&oacute; chở theo tiếng cười, niềm vui của trẻ nhỏ giữa bầu trời rộng lớn. Nh&igrave;n diều bay cao, thế giới diệu kỳ mở ra, nơi những ph&eacute;p mầu trở th&agrave;nh hiện thực.</span></p>
<p style="overflow-wrap: break-word; padding-top: 0px; margin: 0px 0px 28px; box-sizing: border-box; color: rgb(104, 108, 139); font-family: Roboto, sans-serif; font-size: 16px;">
	<span style="box-sizing: border-box; padding-bottom: 25px;">C&aacute;nh diều cũng l&agrave; sợi d&acirc;y kết nối giữa con người với con người, l&agrave; cầu nối cho những tấm l&ograve;ng hảo t&acirc;m c&ugrave;ng nhau đ&oacute;ng g&oacute;p cho cuộc sống tốt đẹp hơn.</span></p>
', N'638537793433317877_MINIAPP_1200x840-800x600.png', CAST(N'2024-06-12' AS Date), CAST(N'2024-06-20' AS Date), CAST(380000000.00 AS Decimal(18, 2)), 3, 1014, N'Open')
GO
INSERT [dbo].[post] ([id], [title], [description], [content], [image], [time_start], [time_end], [target], [cate_id], [partner_id], [status]) VALUES (4035, N'Một bài viết kêu gọi ủng hộ', N'', N'<p>
	Nội dung của b&agrave;i l&agrave;</p>
', N'638537814535490349_IMG_9877-768x768.jpg', CAST(N'2024-06-12' AS Date), CAST(N'2024-06-13' AS Date), CAST(10000000.00 AS Decimal(18, 2)), 1017, 1014, N'Open')
GO
SET IDENTITY_INSERT [dbo].[post] OFF
GO
SET IDENTITY_INSERT [dbo].[user] ON 
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (1, N'minhduc', N'epsjGLfTuiQ=', N'Lê Minh Đức', N'638524010892238083_FB_IMG_1706696901321.jpg', N'0907420625', N'leduc20198@gmail.com', N'admin', N'', N'', N'active')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (9, N'nguyenDung', N'epsjGLfTuiQ=', N'Anh Dũng', N'user-profile.png', N'', N'vuvunguyen@gmail.com', N'mod', N'', N'', N'active')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (11, N'admin', N'epsjGLfTuiQ=', N'ADMIN', N'638536519629429081_LogoGive2.png', N'0765500229', N'Give.AID@gmail.com', N'admin', N'', N'102 Nguyễn Đình Chính, phường Đính Đá, Quận Đình Chỉ, TPHCM', N'active')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (2017, N'tai123', N'Bmu1N4Ykn2VAApe4Lic3Tg==', N'Nguyên Văn Tài', N'638536521960686895_0cf76619231c6184873fd89753ade3ef.jpg', N'0908070605', N'taicute@gmail.com', N'mod', N'', N'102 Nguyễn Đình Chinh Phương Vĩnh Thiện Quận Phú Nhuận TPHCM', N'active')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (2018, N'test', N'e7Hh0IwkhszL9VfyerCKNg==', N'Test', N'user-profile.png', N'', N'testuser@gmail.com', N'user', N'', N'', N'banned')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (2019, N'bingiangho2002', N'DZvwCxQfpulbQfUHZZYm1A==', N'Truong', N'user-profile.png', N'', N'bingiangho2002@gmail.com', N'user', N'', N'', N'active')
GO
INSERT [dbo].[user] ([id], [username], [password], [fullname], [image], [phone], [email], [permission], [gender], [address], [status]) VALUES (2020, N'vana123', N'e7Hh0IwkhszL9VfyerCKNg==', N'nguyen van a', N'638537812402023823_LogoGive.png', N'0908070605', N'vana@gmail.com', N'mod', N'', N'115 tân tảo abc', N'active')
GO
SET IDENTITY_INSERT [dbo].[user] OFF
GO
ALTER TABLE [dbo].[payment] ADD  DEFAULT ('') FOR [banktran_no]
GO
ALTER TABLE [dbo].[payment] ADD  DEFAULT ('') FOR [pay_status]
GO
ALTER TABLE [dbo].[image_post]  WITH CHECK ADD  CONSTRAINT [FK_post_image_id] FOREIGN KEY([post_id])
REFERENCES [dbo].[post] ([id])
GO
ALTER TABLE [dbo].[image_post] CHECK CONSTRAINT [FK_post_image_id]
GO
ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK_post_id] FOREIGN KEY([post_id])
REFERENCES [dbo].[post] ([id])
GO
ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK_post_id]
GO
ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([id])
GO
ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK_user_id]
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD  CONSTRAINT [FK_cate_id] FOREIGN KEY([cate_id])
REFERENCES [dbo].[category] ([cate_id])
GO
ALTER TABLE [dbo].[post] CHECK CONSTRAINT [FK_cate_id]
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD  CONSTRAINT [FK_partner_id] FOREIGN KEY([partner_id])
REFERENCES [dbo].[partner] ([id])
GO
ALTER TABLE [dbo].[post] CHECK CONSTRAINT [FK_partner_id]
GO
