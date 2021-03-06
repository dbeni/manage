USE [master]
GO
/****** Object:  Database [exercise]    Script Date: 10/02/2018 08:57:21 PM ******/
CREATE DATABASE [exercise]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'exercise', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\exercise.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'exercise_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\exercise_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [exercise] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [exercise].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [exercise] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [exercise] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [exercise] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [exercise] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [exercise] SET ARITHABORT OFF 
GO
ALTER DATABASE [exercise] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [exercise] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [exercise] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [exercise] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [exercise] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [exercise] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [exercise] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [exercise] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [exercise] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [exercise] SET  ENABLE_BROKER 
GO
ALTER DATABASE [exercise] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [exercise] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [exercise] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [exercise] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [exercise] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [exercise] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [exercise] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [exercise] SET RECOVERY FULL 
GO
ALTER DATABASE [exercise] SET  MULTI_USER 
GO
ALTER DATABASE [exercise] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [exercise] SET DB_CHAINING OFF 
GO
ALTER DATABASE [exercise] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [exercise] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [exercise] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'exercise', N'ON'
GO
ALTER DATABASE [exercise] SET QUERY_STORE = OFF
GO
USE [exercise]
GO
/****** Object:  Table [dbo].[assign]    Script Date: 10/02/2018 08:57:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assign](
	[idCreator] [int] NOT NULL,
	[idAssignee] [int] NOT NULL,
	[idTask] [int] NOT NULL,
 CONSTRAINT [PK_assign] PRIMARY KEY CLUSTERED 
(
	[idCreator] ASC,
	[idAssignee] ASC,
	[idTask] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 10/02/2018 08:57:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[idEmployee] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[position] [varchar](50) NULL,
	[picture] [image] NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[idEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[manage]    Script Date: 10/02/2018 08:57:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[manage](
	[idManager] [int] NOT NULL,
	[idManaged] [int] NOT NULL,
 CONSTRAINT [PK_manage] PRIMARY KEY CLUSTERED 
(
	[idManager] ASC,
	[idManaged] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 10/02/2018 08:57:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[idReport] [int] IDENTITY(1,1) NOT NULL,
	[idReportCreator] [int] NOT NULL,
	[reportContent] [text] NOT NULL,
	[reportDate] [datetime] NOT NULL,
 CONSTRAINT [PK_report] PRIMARY KEY CLUSTERED 
(
	[idReport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[task]    Script Date: 10/02/2018 08:57:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[task](
	[idTask] [int] IDENTITY(1,1) NOT NULL,
	[taskDescription] [text] NOT NULL,
	[assignDate] [datetime] NOT NULL,
	[dueDate] [datetime] NOT NULL,
 CONSTRAINT [PK_task] PRIMARY KEY CLUSTERED 
(
	[idTask] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 2, 1)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 2, 3)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 2, 5)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 2, 7)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 2, 8)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 3, 2)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 3, 4)
INSERT [dbo].[assign] ([idCreator], [idAssignee], [idTask]) VALUES (1, 3, 6)
SET IDENTITY_INSERT [dbo].[employee] ON 

INSERT [dbo].[employee] ([idEmployee], [firstName], [lastName], [position], [picture]) VALUES (1, N'John', N'Doe', N'CTO', NULL)
INSERT [dbo].[employee] ([idEmployee], [firstName], [lastName], [position], [picture]) VALUES (2, N'Diego', N'De La Vega', N'Project Manager', NULL)
INSERT [dbo].[employee] ([idEmployee], [firstName], [lastName], [position], [picture]) VALUES (3, N'Antoine', N'Corenereau', N'Developer', NULL)
SET IDENTITY_INSERT [dbo].[employee] OFF
INSERT [dbo].[manage] ([idManager], [idManaged]) VALUES (1, 2)
INSERT [dbo].[manage] ([idManager], [idManaged]) VALUES (1, 3)
SET IDENTITY_INSERT [dbo].[report] ON 

INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (4, 2, N'salut', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (5, 2, N'salut 2', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (6, 2, N'aaa', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (7, 2, N'bbb', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (8, 2, N'ccc', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (9, 2, N'ddd', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (10, 2, N'eee', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (11, 2, N'fff', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (12, 2, N'ggg', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (13, 2, N'hhh', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
INSERT [dbo].[report] ([idReport], [idReportCreator], [reportContent], [reportDate]) VALUES (14, 2, N'jjj', CAST(N'2018-09-29T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[report] OFF
SET IDENTITY_INSERT [dbo].[task] ON 

INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (1, N'try new task', CAST(N'2018-09-30T10:00:00.000' AS DateTime), CAST(N'2018-10-30T15:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (2, N'new task for cornereau', CAST(N'2018-10-01T00:00:00.000' AS DateTime), CAST(N'2018-10-06T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (3, N'new task de la vega', CAST(N'2018-10-01T00:00:00.000' AS DateTime), CAST(N'2018-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (4, N'cornereau 2!', CAST(N'2018-10-01T00:00:00.000' AS DateTime), CAST(N'2018-10-17T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (5, N'task date', CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-27T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (6, N'utc problem', CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-20T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (7, N'utc 2', CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[task] ([idTask], [taskDescription], [assignDate], [dueDate]) VALUES (8, N'utc 4', CAST(N'2018-10-02T00:00:00.000' AS DateTime), CAST(N'2018-11-03T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[task] OFF
ALTER TABLE [dbo].[assign]  WITH CHECK ADD  CONSTRAINT [FK_assign_employee] FOREIGN KEY([idCreator])
REFERENCES [dbo].[employee] ([idEmployee])
GO
ALTER TABLE [dbo].[assign] CHECK CONSTRAINT [FK_assign_employee]
GO
ALTER TABLE [dbo].[assign]  WITH CHECK ADD  CONSTRAINT [FK_assign_employee1] FOREIGN KEY([idAssignee])
REFERENCES [dbo].[employee] ([idEmployee])
GO
ALTER TABLE [dbo].[assign] CHECK CONSTRAINT [FK_assign_employee1]
GO
ALTER TABLE [dbo].[assign]  WITH CHECK ADD  CONSTRAINT [FK_assign_task] FOREIGN KEY([idTask])
REFERENCES [dbo].[task] ([idTask])
GO
ALTER TABLE [dbo].[assign] CHECK CONSTRAINT [FK_assign_task]
GO
ALTER TABLE [dbo].[manage]  WITH CHECK ADD  CONSTRAINT [FK_manage_employee] FOREIGN KEY([idManager])
REFERENCES [dbo].[employee] ([idEmployee])
GO
ALTER TABLE [dbo].[manage] CHECK CONSTRAINT [FK_manage_employee]
GO
ALTER TABLE [dbo].[manage]  WITH CHECK ADD  CONSTRAINT [FK_manage_employee1] FOREIGN KEY([idManaged])
REFERENCES [dbo].[employee] ([idEmployee])
GO
ALTER TABLE [dbo].[manage] CHECK CONSTRAINT [FK_manage_employee1]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK_report_report] FOREIGN KEY([idReportCreator])
REFERENCES [dbo].[employee] ([idEmployee])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK_report_report]
GO
USE [master]
GO
ALTER DATABASE [exercise] SET  READ_WRITE 
GO
