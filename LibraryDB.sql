USE [master]
GO
/****** Object:  Database [LibraryDb]    Script Date: 11-08-2019 14:39:43 ******/
CREATE DATABASE [LibraryDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibraryDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\LibraryDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibraryDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\LibraryDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LibraryDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LibraryDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LibraryDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LibraryDb] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibraryDb] SET QUERY_STORE = OFF
GO
USE [LibraryDb]
GO
/****** Object:  Table [dbo].[tblBookDetails]    Script Date: 11-08-2019 14:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [varchar](50) NOT NULL,
	[ReleaseDate] [datetime] NULL,
	[Author] [varchar](30) NULL,
	[Genre] [varchar](20) NULL,
	[Price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblError]    Script Date: 11-08-2019 14:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblError](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorNo] [varchar](50) NULL,
	[ErrSeverity] [varchar](50) NULL,
	[ErrProcedure] [varchar](100) NULL,
	[ErrLine] [varchar](10) NULL,
	[ErrMessage] [varchar](150) NULL,
	[CrtDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddBookDetail]    Script Date: 11-08-2019 14:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddBookDetail]
(
@BookName varchar(200),
@ReleaseDate Datetime,
@Author varchar(30),
@Genre varchar(20),
@Price decimal(18,2)
)
AS
BEGIN TRANSACTION
BEGIN TRY
	
	INSERT INTO tblBookDetails VALUES(
	@BookName,
	@ReleaseDate,
	@Author,
	@Genre,
	@Price
	)

	SELECT 'Y'
END TRY
BEGIN CATCH
	
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  

	INSERT INTO tblError(ErrorNo,ErrSeverity,ErrProcedure,ErrLine,ErrMessage,CrtDate)
	SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity          
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage
		,GETDATE() as CrtDate

	SELECT 'N'

END CATCH

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
/****** Object:  StoredProcedure [dbo].[BookList]    Script Date: 11-08-2019 14:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BookList]
(
@Id int = null
)
AS
BEGIN TRANSACTION
BEGIN TRY
	
	SELECT Id,BookName,ReleaseDate,Author,Genre,Price FROM tblBookDetails
	where @Id is null OR Id = @Id

END TRY
BEGIN CATCH
	
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  

	INSERT INTO tblError(ErrorNo,ErrSeverity,ErrProcedure,ErrLine,ErrMessage,CrtDate)
	SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity          
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage
		,GETDATE() as CrtDate	

END CATCH

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
/****** Object:  StoredProcedure [dbo].[EditBookDetail]    Script Date: 11-08-2019 14:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditBookDetail]
(
@BookName varchar(200),
@ReleaseDate Datetime,
@Author varchar(30),
@Genre varchar(20),
@Price decimal(18,2),
@Id Int
)
AS
BEGIN TRANSACTION
BEGIN TRY
	 
	UPDATE tblBookDetails
	SET 
	BookName = @BookName,
	ReleaseDate = @ReleaseDate,
	Author = @Author,
	Genre = @Genre,
	Price = @Price
	Where Id = @id

	SELECT 'Y'
END TRY
BEGIN CATCH
	
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  

	INSERT INTO tblError(ErrorNo,ErrSeverity,ErrProcedure,ErrLine,ErrMessage,CrtDate)
	SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity          
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage
		,GETDATE() as CrtDate

	SELECT 'N'

END CATCH

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
/****** Object:  StoredProcedure [dbo].[RemoveDetail]    Script Date: 11-08-2019 14:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RemoveDetail]
(
@Id Int
)
AS
BEGIN TRANSACTION
BEGIN TRY
	 
	Delete from tblBookDetails where Id = @Id

	SELECT 'Y'

END TRY
BEGIN CATCH
	
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  

	INSERT INTO tblError(ErrorNo,ErrSeverity,ErrProcedure,ErrLine,ErrMessage,CrtDate)
	SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity          
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage
		,GETDATE() as CrtDate

	SELECT 'N'

END CATCH

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
USE [master]
GO
ALTER DATABASE [LibraryDb] SET  READ_WRITE 
GO
