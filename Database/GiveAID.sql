use master

create database GiveAID

use GiveAID

create table [user]
(
	id int primary key identity,
	username varchar(50),
	[password] varchar(50),
	fullname nvarchar(100),
	[image] varchar(max),
	job nvarchar(100),
	phone varchar(11),
	email varchar(100)
)

create table [admin]
(
	id int primary key identity,
	username varchar(50),
	[password] varchar(50)
)

create table category
(
	cate_id int primary key identity,
	[name] nvarchar(max)
)

create table post
(
	id int primary key identity,
	title nvarchar(max),
	[description] nvarchar(max),
	content ntext,
	[image] varchar(max),
	time_start date,
	time_end date,
	[target] decimal(18,2),
	cate_id int,
	constraint FK_cate_id foreign key (cate_id) references category(cate_id)
)

create table contact
(
	id int primary key identity,
	phone varchar(11),
	email varchar(100),
	[address] nvarchar(max),
	mission nvarchar(max),
	content ntext,
	achievement nvarchar(max),
	[image] varchar(max)
)

create table payment
(
	id int primary key identity,
	post_id int,
	[user_id] int,
	transaction_no varchar(max),
	transaction_date datetime,
	constraint FK_post_id foreign key (post_id) references post(id),
	constraint FK_user_id foreign key ([user_id]) references [user](id)
)