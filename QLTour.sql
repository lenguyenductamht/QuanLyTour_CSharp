USE [master]
GO
/****** Object:  Database [QL_TOUR]    Script Date: 10/12 18:18:16 ******/
CREATE DATABASE [QL_TOUR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_TOUR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QL_TOUR.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QL_TOUR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QL_TOUR_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QL_TOUR] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_TOUR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_TOUR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_TOUR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_TOUR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_TOUR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_TOUR] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_TOUR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_TOUR] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QL_TOUR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_TOUR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_TOUR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_TOUR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_TOUR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_TOUR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_TOUR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_TOUR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_TOUR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_TOUR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_TOUR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_TOUR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_TOUR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_TOUR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_TOUR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_TOUR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_TOUR] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QL_TOUR] SET  MULTI_USER 
GO
ALTER DATABASE [QL_TOUR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_TOUR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_TOUR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_TOUR] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QL_TOUR]
GO
/****** Object:  StoredProcedure [dbo].[HoaDonTour]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[HoaDonTour]
AS
    select ID_KhachHang, HoTen, SDT, ID_Tour, TenTour, NgayDK, NgayBD, NgayKT, Gia, GiamGia, (Gia - (Gia * GiamGia)/100) as TongTien from KhachHang kh, DangKyTour dk, Tour t where kh.ID_KhachHang = dk.IdKhachHang and dk.IdTour = t.ID_Tour


GO
/****** Object:  StoredProcedure [dbo].[InsertNhanVien_TaiKhoan]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNhanVien_TaiKhoan]
	@HoTen nvarchar(100),
	@SDT nchar(11),
	@GioiTinh nvarchar(5),
	@NgaySinh date,
	@NgayVaoLam date,
	@Luong float,
	@IdChucVu int,
	@DiaChi nvarchar(250),
	@TenDangNhap nchar(30),
	@MatKhau nchar(20)
AS
begin
	INSERT INTO [dbo].[NhanVien]
			   ([HoTen]
			   ,[SDT]
			   ,[GioiTinh]
			   ,[NgaySinh]
			   ,[NgayVaoLam]
			   ,[Luong]
			   ,[IdChucVu]
			   ,[DiaChi]
			   ,[TrangThai])
		 VALUES
			   (@HoTen, @SDT, @GioiTinh, @NgaySinh, @NgayVaoLam, @Luong, @IdChucVu, @DiaChi, 1)
	declare @Identity int
	SET @Identity = SCOPE_IDENTITY()
	INSERT INTO [dbo].[TaiKhoan]
			   ([TenDangNhap]
			   ,[MatKhau]
			   ,[IdNhanVien])
		 VALUES
			   (@TenDangNhap, @MatKhau, @Identity)
end



GO
/****** Object:  StoredProcedure [dbo].[TTKhachSan]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TTKhachSan]

AS
    SELECT ID_KhachSan, TenKhachSan, SoSao, SDT, TenKhuVuc, tt.TrangThai as TrangThai FROM KhachSan ks, KhuVuc kv, TrangThaiKS tt where ks.TrangThai = tt.ID_TrangThai and ID_KhuVuc = IdKhuVuc

RETURN 0 

GO
/****** Object:  StoredProcedure [dbo].[XuatDiaDiemTheoTour]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[XuatDiaDiemTheoTour]
AS
    select ID_DiaDiem, TenDiaDiem, dd.TrangThai, Mota, TenKhuVuc,tdd.NgayThem as NgayMo, TenTour, ID_Tour, Gia, GiamGia, SoVe, NgayBD, NgayKT, nv1.HoTen as NguoiMo, nv2.HoTen as NVDanDoan, ks.TenKhachSan, pt.TenPhuongTien, ttt.TrangThai from DiaDiem dd, Tour_DiaDiem tdd, KhuVuc kv, Tour t, NhanVien nv1, NhanVien nv2, TrangThaiTour ttt, KhachSan ks, PhuongTien pt  where dd.ID_DiaDiem = tdd.idDiaDiem and kv.ID_KhuVuc = dd.idKhuVuc and t.ID_Tour = tdd.idTour and nv1.ID_NhanVien = t.NguoiMo and nv2.ID_NhanVien = t.idNhanVienDanDoan and t.TrangThai = ttt.ID_TrangThai and t.idKhachSan = ks.ID_KhachSan and t.idPhuongTien = pt.ID_PhuongTien
RETURN 0 

GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[ID_ChucVu] [int] IDENTITY(1,1) NOT NULL,
	[TenChucVu] [nvarchar](250) NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[ID_ChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DangKyTour]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKyTour](
	[ID_DangKyTour] [int] IDENTITY(1,1) NOT NULL,
	[IdTour] [int] NULL,
	[IdKhachHang] [int] NULL,
	[IdNhanVien] [int] NULL,
	[NgayDK] [date] NULL,
 CONSTRAINT [PK_DangKyTour] PRIMARY KEY CLUSTERED 
(
	[ID_DangKyTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiaDiem]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaDiem](
	[ID_DiaDiem] [int] IDENTITY(1,1) NOT NULL,
	[TenDiaDiem] [ntext] NULL,
	[IdNhanVien] [int] NULL,
	[TrangThai] [nvarchar](250) NULL,
	[Mota] [ntext] NULL,
	[NgayThem] [date] NULL,
	[idKhuVuc] [int] NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[ID_DiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[ID_KhachHang] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](150) NULL,
	[SDT] [nchar](11) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgaySinh] [date] NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[ID_KhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachSan]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachSan](
	[ID_KhachSan] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachSan] [nvarchar](200) NULL,
	[SoSao] [int] NULL,
	[IdKhuVuc] [int] NULL,
	[SDT] [nchar](10) NULL,
	[TrangThai] [int] NULL CONSTRAINT [DF_KhachSan_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_KhachSan] PRIMARY KEY CLUSTERED 
(
	[ID_KhachSan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuVuc](
	[ID_KhuVuc] [int] IDENTITY(1,1) NOT NULL,
	[TenKhuVuc] [nvarchar](200) NULL,
 CONSTRAINT [PK_KhuVuc] PRIMARY KEY CLUSTERED 
(
	[ID_KhuVuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiPT]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPT](
	[ID_LoaiPT] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiPT] [nvarchar](200) NULL,
 CONSTRAINT [PK_LoaiPT] PRIMARY KEY CLUSTERED 
(
	[ID_LoaiPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[ID_NhanVien] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](100) NULL,
	[SDT] [nchar](11) NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgaySinh] [date] NULL,
	[NgayVaoLam] [date] NULL,
	[Luong] [float] NULL,
	[IdChucVu] [int] NULL,
	[DiaChi] [nvarchar](250) NULL,
	[TrangThai] [int] NULL CONSTRAINT [df_TrangThai]  DEFAULT ((1)),
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[ID_NhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhuongTien]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuongTien](
	[ID_PhuongTien] [int] IDENTITY(1,1) NOT NULL,
	[TenPhuongTien] [nvarchar](200) NULL,
	[ID_LoaiPT] [int] NULL,
 CONSTRAINT [PK_PhuongTien] PRIMARY KEY CLUSTERED 
(
	[ID_PhuongTien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID_TaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nchar](30) NULL,
	[MatKhau] [nchar](200) NULL,
	[IdNhanVien] [int] NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tour]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour](
	[ID_Tour] [int] IDENTITY(1,1) NOT NULL,
	[NgayBD] [date] NULL,
	[NgayKT] [date] NULL,
	[SoVe] [int] NULL,
	[idPhuongTien] [int] NULL,
	[idKhachSan] [int] NULL,
	[idNhanVienDanDoan] [int] NULL,
	[Gia] [money] NULL,
	[GiamGia] [int] NULL,
	[NguoiMo] [int] NULL,
	[TenTour] [ntext] NULL,
	[TrangThai] [int] NULL CONSTRAINT [df_TrangThaiTour]  DEFAULT ((1)),
 CONSTRAINT [PK_Tour_1] PRIMARY KEY CLUSTERED 
(
	[ID_Tour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tour_DiaDiem]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour_DiaDiem](
	[ID_TourDiaDiem] [int] IDENTITY(1,1) NOT NULL,
	[idTour] [int] NULL,
	[idDiaDiem] [int] NULL,
	[NgayThem] [date] NULL,
 CONSTRAINT [PK_Tour_DiaDiem] PRIMARY KEY CLUSTERED 
(
	[ID_TourDiaDiem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrangThaiKS]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiKS](
	[ID_TrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TrangThaiKS] PRIMARY KEY CLUSTERED 
(
	[ID_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrangThaiNV]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiNV](
	[ID_TrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrangThaiTour]    Script Date: 10/12 18:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiTour](
	[ID_TrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ChucVu] ON 

INSERT [dbo].[ChucVu] ([ID_ChucVu], [TenChucVu]) VALUES (1, N'Giám Đốc')
INSERT [dbo].[ChucVu] ([ID_ChucVu], [TenChucVu]) VALUES (2, N'Quản Lý')
INSERT [dbo].[ChucVu] ([ID_ChucVu], [TenChucVu]) VALUES (3, N'Nhân Viên Đăng Ký')
INSERT [dbo].[ChucVu] ([ID_ChucVu], [TenChucVu]) VALUES (4, N'Nhân Viên Dẫn Đoàn')
SET IDENTITY_INSERT [dbo].[ChucVu] OFF
SET IDENTITY_INSERT [dbo].[DangKyTour] ON 

INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (14, 6, 4, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (15, 6, 1, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (19, 6, 24, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (20, 6, 23, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (21, 6, 25, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (25, 18, 4, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (27, 17, 25, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (28, 18, 24, 29, CAST(N'2021-12-09' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (29, 17, 24, 29, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (30, 26, 24, 29, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[DangKyTour] ([ID_DangKyTour], [IdTour], [IdKhachHang], [IdNhanVien], [NgayDK]) VALUES (31, 26, 27, 29, CAST(N'2021-12-10' AS Date))
SET IDENTITY_INSERT [dbo].[DangKyTour] OFF
SET IDENTITY_INSERT [dbo].[DiaDiem] ON 

INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (29, N'Thủ đô Hà Nội', 16, N'Hoạt động', N'dqwd', CAST(N'2021-12-08' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (31, N'Săn mây tại Sa Pa', 16, N'Hoạt động', N'qwdqw', CAST(N'2021-12-08' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (33, N' Check-in mùa hoa tam giác mạch tháng 10 ở Hà Giang', 16, N'Hoạt động', N'ưadwqd', CAST(N'2021-12-08' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (34, N'Phong Nha- Kẻ Bàng – kiệt tác của tạo hoá', 16, N'Hoạt động', N'dqwdqwd', CAST(N'2021-12-08' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (35, N'Ninh Bình', 16, N'Hoạt động', N'dqwd', CAST(N'2021-12-08' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (36, N'Phong Nha- Kẻ Bàng – kiệt tác của tạo hoá', 16, N'Hoạt động', N'dqwdqwdqwd', CAST(N'2021-12-08' AS Date), 2)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (39, N'Khám phá Đà Nẵng', 16, N'Tạm ngưng', N'đwddwd', CAST(N'2021-12-07' AS Date), 9)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (40, N'Phố cổ Hội An', 16, N'Hoạt động', N'Di du lịch thôi nào', CAST(N'2021-12-09' AS Date), 11)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (41, N'Di lịch Tây Nguyên', 16, N'Hoạt động', N'Ahihi', CAST(N'2021-12-09' AS Date), 10)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (42, N'Đồng bằng sông Cửu Long', 16, N'Hoạt động', N'Ahihi', CAST(N'2021-12-09' AS Date), 4)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (43, N'Đảo Phú Quốc', 16, N'Tạm ngưng', N'Du lịch thôi nào', CAST(N'2021-12-09' AS Date), 60)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (44, N' phố cổ Hội An', 16, N'Hoạt động', N'Đi du lịch thôi nào', CAST(N'2021-12-09' AS Date), 1)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (46, N'Công viên 7 kỳ quan', 16, N'Hoạt động', N'Tham quan ', CAST(N'2021-12-01' AS Date), 49)
INSERT [dbo].[DiaDiem] ([ID_DiaDiem], [TenDiaDiem], [IdNhanVien], [TrangThai], [Mota], [NgayThem], [idKhuVuc]) VALUES (48, N'Cao Bằng Land', 16, N'Hoạt động', N'kskgkdk', CAST(N'2021-12-10' AS Date), 7)
SET IDENTITY_INSERT [dbo].[DiaDiem] OFF
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (1, N'Hùng Trần', N'0366625406 ', N'TP HCM', N'Nam', CAST(N'2001-07-06' AS Date))
INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (4, N'đức tâm', N'0354403111 ', N'long an', N'Nam', CAST(N'2001-03-14' AS Date))
INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (23, N'fewfew', N'4234234423 ', N'2344234', N'Nam', CAST(N'1988-12-26' AS Date))
INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (24, N'Hello', N'0123312314 ', N'1231', N'Nam', CAST(N'2018-12-30' AS Date))
INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (25, N'hùng', N'0366625402 ', N'123456', N'Nam', CAST(N'1990-01-29' AS Date))
INSERT [dbo].[KhachHang] ([ID_KhachHang], [HoTen], [SDT], [DiaChi], [GioiTinh], [NgaySinh]) VALUES (27, N'Đức tâm', N'0354403117 ', N'le trọng tấn', N'Nam', CAST(N'2021-12-08' AS Date))
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
SET IDENTITY_INSERT [dbo].[KhachSan] ON 

INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (1, N'Hồng Hà', 4, 1, N'0366625406', 2)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (2, N'Đại Bàng', 5, 1, N'0366625407', 1)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (3, N'Hoàng Gia', 5, 2, N'0366625408', 1)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (4, N'Ngọc Hoàng', 3, 4, N'036625407 ', 1)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (5, N'Hoàng Long', 2, 3, N'036662547 ', 1)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (6, N'Hoàng Ngọc Châu', 4, 32, N'0366625405', 2)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (7, N'Cao Bằng', 1, 8, N'0366625400', 2)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (8, N'gh', 3, 1, N'5         ', NULL)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (9, N'123', 1, 1, N'0354403118', NULL)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (10, N'1234', 3, 1, N'3454532432', NULL)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (11, N'1345', 5, 4, N'9345983920', 2)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (12, N'Tran tran a', 3, 1, N'554556    ', 2)
INSERT [dbo].[KhachSan] ([ID_KhachSan], [TenKhachSan], [SoSao], [IdKhuVuc], [SDT], [TrangThai]) VALUES (15, N'Cao Bằng Hotel', 4, 7, N'0354403117', 1)
SET IDENTITY_INSERT [dbo].[KhachSan] OFF
SET IDENTITY_INSERT [dbo].[KhuVuc] ON 

INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (1, N'Hà Nội')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (2, N'TP Hồ Chi Minh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (3, N'TP Hải Phòng')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (4, N'TP Đà Nẵng')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (5, N'TP Cần Thơ')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (6, N'Hà Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (7, N'Cao Bằng')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (8, N'Lai Châu')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (9, N'Lào Cai')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (10, N'Tuyên Quang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (11, N'Lạng Sơn')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (12, N'Bắc Kạn')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (13, N'Thái Nguyên')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (14, N'Yên Bái')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (15, N'Sơn La')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (16, N'Phú Thọ')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (17, N'Vĩnh Phúc')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (18, N'Quảng Ninh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (19, N'Bắc Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (20, N'Bắc Ninh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (21, N'Hải Dương')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (22, N'Hưng Yên')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (23, N'Hòa Bình')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (24, N'Hà Nam')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (25, N'Nam Định')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (26, N'Thái Bình')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (27, N'Ninh Bình')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (28, N'Thanh Hóa')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (29, N'Nghệ An')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (30, N'Hà Tĩnh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (31, N'Quảng Bình')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (32, N'Quảng Trị')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (33, N'Thừa Thiên Huế')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (34, N'Quảng Nam')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (35, N'Quảng Ngãi')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (36, N'Kon Tum')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (37, N'Bình Định')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (38, N'Gia Lai')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (39, N'Phú Yên')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (40, N'Đăk LăK')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (41, N'Khánh Hòa')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (42, N'Lâm Đồng')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (43, N'Bình Phước')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (44, N'Bình Dương')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (45, N'Ninh Thuận')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (46, N'Tây Ninh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (47, N'Bình Thuận')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (48, N'Đồng Nai')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (49, N'Long An')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (50, N'Đồng Tháp')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (51, N'An Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (52, N'Bà Rịa Vũng Tàu')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (53, N'Tiền Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (54, N'Kiên Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (55, N'Trà Vinh')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (56, N'Bến Tre')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (57, N'Vĩnh Long')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (58, N'Sóc Trăng')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (59, N'Bạc Liêu')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (60, N'Cà Mau')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (61, N'Điện Biên')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (62, N'Đắk Nông')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (63, N'Hậu Giang')
INSERT [dbo].[KhuVuc] ([ID_KhuVuc], [TenKhuVuc]) VALUES (64, N'Khánh Hòa')
SET IDENTITY_INSERT [dbo].[KhuVuc] OFF
SET IDENTITY_INSERT [dbo].[LoaiPT] ON 

INSERT [dbo].[LoaiPT] ([ID_LoaiPT], [TenLoaiPT]) VALUES (1, N'Máy bay')
INSERT [dbo].[LoaiPT] ([ID_LoaiPT], [TenLoaiPT]) VALUES (2, N'Ô tô')
SET IDENTITY_INSERT [dbo].[LoaiPT] OFF
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (16, N'Lê Hoài Nam', N'0354403117 ', N'Nữ', CAST(N'2001-01-10' AS Date), CAST(N'2001-01-10' AS Date), 14000000, 1, N'TpHCM', 2)
INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (25, N'Lê Ngọc Hồng', N'0354403113 ', N'Nam', CAST(N'2021-12-07' AS Date), CAST(N'2021-12-07' AS Date), 14000000, 2, N'TpHCM', 1)
INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (26, N'Đức Tâm', N'0355555455 ', N'Nam', CAST(N'2021-12-07' AS Date), CAST(N'2021-12-07' AS Date), 14000000, 4, N'TpHCM', 1)
INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (29, N'Hoàng Thanh Thao', N'0354403117 ', N'Nữ', CAST(N'1998-05-21' AS Date), CAST(N'1998-05-21' AS Date), 14000000, 4, N'TpHCM', 1)
INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (37, N'Hùng Trần', N'0366625406 ', N'Nữ', CAST(N'1989-01-03' AS Date), CAST(N'1989-01-03' AS Date), 14000000, 4, N'TP HCM', 1)
INSERT [dbo].[NhanVien] ([ID_NhanVien], [HoTen], [SDT], [GioiTinh], [NgaySinh], [NgayVaoLam], [Luong], [IdChucVu], [DiaChi], [TrangThai]) VALUES (44, N'Nguyễn Hữu Luân', N'0354403123 ', N'Nam', CAST(N'2021-12-10' AS Date), CAST(N'2021-12-10' AS Date), 5000000, 3, N'hcm', 1)
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
SET IDENTITY_INSERT [dbo].[PhuongTien] ON 

INSERT [dbo].[PhuongTien] ([ID_PhuongTien], [TenPhuongTien], [ID_LoaiPT]) VALUES (1, N'May bay', 1)
INSERT [dbo].[PhuongTien] ([ID_PhuongTien], [TenPhuongTien], [ID_LoaiPT]) VALUES (2, N'Ô tô 16 chỗ', 2)
INSERT [dbo].[PhuongTien] ([ID_PhuongTien], [TenPhuongTien], [ID_LoaiPT]) VALUES (3, N'Ô tô 32 chỗ', 2)
INSERT [dbo].[PhuongTien] ([ID_PhuongTien], [TenPhuongTien], [ID_LoaiPT]) VALUES (4, N'Ô tô 7 chỗ', 2)
SET IDENTITY_INSERT [dbo].[PhuongTien] OFF
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenDangNhap], [MatKhau], [IdNhanVien]) VALUES (11, N'admin1                        ', N'7110eda4d09e62aa5e4a390b0a572acd2c220                                                                                                                                                                   ', 16)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenDangNhap], [MatKhau], [IdNhanVien]) VALUES (20, N'admin2                        ', N'7110eda4d09e62aa5e4a390b0a572acd2c220                                                                                                                                                                   ', 25)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenDangNhap], [MatKhau], [IdNhanVien]) VALUES (22, N'admin4                        ', N'7110eda4d09e62aa5e4a390b0a572acd2c220                                                                                                                                                                   ', 37)
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [TenDangNhap], [MatKhau], [IdNhanVien]) VALUES (30, N'admin3                        ', N'7110eda4d09e62aa5e4a390b0a572acd2c220                                                                                                                                                                   ', 44)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
SET IDENTITY_INSERT [dbo].[Tour] ON 

INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (6, CAST(N'2021-12-07' AS Date), CAST(N'2021-12-09' AS Date), 50, 1, 1, 26, 50000.0000, 0, 26, N'Xuyên vi?t', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (7, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 32, 1, 1, 29, 4000000.0000, 0, 26, N'Tour m?i di', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (11, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 53, 1, 1, 29, 4333.0000, 3, 26, N'563', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (12, CAST(N'2021-12-16' AS Date), CAST(N'2021-12-25' AS Date), 43, 2, 1, 29, 333.0000, 33, 26, N'56333', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (13, CAST(N'2021-12-16' AS Date), CAST(N'2021-12-24' AS Date), 23, 1, 2, 37, 324234.0000, 3, 26, N'Touw BCCC', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (15, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 33, 1, 1, 29, 233232.0000, 23, 26, N'2222', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (17, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 32, 1, 1, 29, 232332.0000, 23, 26, N'fffff', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (18, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 22, 1, 1, 37, 22.0000, 2, 26, N'duqdqwdqwd', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (19, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-23' AS Date), 22, 1, 1, 37, 32.0000, 33, 26, N'32322323', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (20, CAST(N'2021-12-08' AS Date), CAST(N'2021-12-08' AS Date), 32, 1, 1, 37, 32.0000, 2222, 26, N'323223232222222', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (21, CAST(N'2021-12-15' AS Date), CAST(N'2021-12-24' AS Date), 32423, 1, 1, 29, 232323.0000, 22, 26, N'aaaaa', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (22, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-11' AS Date), 15, 1, 2, 29, 115000.0000, 5, 26, N'abcd', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (23, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-11' AS Date), 4, 1, 1, 26, 423432.0000, 0, 26, N'sgf', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (24, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-11' AS Date), 4, 2, 15, 29, 45453.0000, 3, 26, N'Cao Bằng CarTour', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (25, CAST(N'2021-12-11' AS Date), CAST(N'2021-12-12' AS Date), 4, 1, 15, 26, 54545.0000, 1, 26, N'Cao Bnagư 2', 1)
INSERT [dbo].[Tour] ([ID_Tour], [NgayBD], [NgayKT], [SoVe], [idPhuongTien], [idKhachSan], [idNhanVienDanDoan], [Gia], [GiamGia], [NguoiMo], [TenTour], [TrangThai]) VALUES (26, CAST(N'2021-12-10' AS Date), CAST(N'2021-12-11' AS Date), 4, 1, 1, 26, 4543.0000, 0, 26, N'sgfg', 1)
SET IDENTITY_INSERT [dbo].[Tour] OFF
SET IDENTITY_INSERT [dbo].[Tour_DiaDiem] ON 

INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (2, 6, 34, CAST(N'2021-01-02' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (6, 19, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (7, 20, 36, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (8, 20, 34, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (9, 20, 29, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (10, 21, 36, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (11, 21, 33, CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (12, 22, 34, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (13, 23, 35, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (14, 24, 48, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (15, 25, 48, CAST(N'2021-12-10' AS Date))
INSERT [dbo].[Tour_DiaDiem] ([ID_TourDiaDiem], [idTour], [idDiaDiem], [NgayThem]) VALUES (16, 26, 33, CAST(N'2021-12-10' AS Date))
SET IDENTITY_INSERT [dbo].[Tour_DiaDiem] OFF
SET IDENTITY_INSERT [dbo].[TrangThaiKS] ON 

INSERT [dbo].[TrangThaiKS] ([ID_TrangThai], [TrangThai]) VALUES (1, N'Hợp tác')
INSERT [dbo].[TrangThaiKS] ([ID_TrangThai], [TrangThai]) VALUES (2, N'Hủy hợp tác')
SET IDENTITY_INSERT [dbo].[TrangThaiKS] OFF
SET IDENTITY_INSERT [dbo].[TrangThaiNV] ON 

INSERT [dbo].[TrangThaiNV] ([ID_TrangThai], [TrangThai]) VALUES (1, N'Đang làm')
INSERT [dbo].[TrangThaiNV] ([ID_TrangThai], [TrangThai]) VALUES (2, N'Đã nghỉ việc')
SET IDENTITY_INSERT [dbo].[TrangThaiNV] OFF
SET IDENTITY_INSERT [dbo].[TrangThaiTour] ON 

INSERT [dbo].[TrangThaiTour] ([ID_TrangThai], [TrangThai]) VALUES (1, N'Còn vé')
INSERT [dbo].[TrangThaiTour] ([ID_TrangThai], [TrangThai]) VALUES (2, N'Hết vé')
SET IDENTITY_INSERT [dbo].[TrangThaiTour] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNQ_SDT_KH]    Script Date: 10/12 18:18:16 ******/
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [UNQ_SDT_KH] UNIQUE NONCLUSTERED 
(
	[SDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DangKyTour]  WITH CHECK ADD  CONSTRAINT [FK_DangKyTour_KhachHang] FOREIGN KEY([IdKhachHang])
REFERENCES [dbo].[KhachHang] ([ID_KhachHang])
GO
ALTER TABLE [dbo].[DangKyTour] CHECK CONSTRAINT [FK_DangKyTour_KhachHang]
GO
ALTER TABLE [dbo].[DangKyTour]  WITH CHECK ADD  CONSTRAINT [FK_DangKyTour_NhanVien] FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([ID_NhanVien])
GO
ALTER TABLE [dbo].[DangKyTour] CHECK CONSTRAINT [FK_DangKyTour_NhanVien]
GO
ALTER TABLE [dbo].[DangKyTour]  WITH CHECK ADD  CONSTRAINT [FK_DangKyTour_Tour] FOREIGN KEY([IdTour])
REFERENCES [dbo].[Tour] ([ID_Tour])
GO
ALTER TABLE [dbo].[DangKyTour] CHECK CONSTRAINT [FK_DangKyTour_Tour]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_KhuVuc] FOREIGN KEY([idKhuVuc])
REFERENCES [dbo].[KhuVuc] ([ID_KhuVuc])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_KhuVuc]
GO
ALTER TABLE [dbo].[DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_DiaDiem_NhanVien] FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([ID_NhanVien])
GO
ALTER TABLE [dbo].[DiaDiem] CHECK CONSTRAINT [FK_DiaDiem_NhanVien]
GO
ALTER TABLE [dbo].[KhachSan]  WITH CHECK ADD  CONSTRAINT [FK_KhachSan_KhachSan] FOREIGN KEY([TrangThai])
REFERENCES [dbo].[TrangThaiKS] ([ID_TrangThai])
GO
ALTER TABLE [dbo].[KhachSan] CHECK CONSTRAINT [FK_KhachSan_KhachSan]
GO
ALTER TABLE [dbo].[KhachSan]  WITH CHECK ADD  CONSTRAINT [FK_KhachSan_KhuVuc] FOREIGN KEY([IdKhuVuc])
REFERENCES [dbo].[KhuVuc] ([ID_KhuVuc])
GO
ALTER TABLE [dbo].[KhachSan] CHECK CONSTRAINT [FK_KhachSan_KhuVuc]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ChucVu] FOREIGN KEY([IdChucVu])
REFERENCES [dbo].[ChucVu] ([ID_ChucVu])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_ChucVu]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [fk_nv_ttnv] FOREIGN KEY([TrangThai])
REFERENCES [dbo].[TrangThaiNV] ([ID_TrangThai])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [fk_nv_ttnv]
GO
ALTER TABLE [dbo].[PhuongTien]  WITH CHECK ADD  CONSTRAINT [FK_PhuongTien_LoaiPT] FOREIGN KEY([ID_LoaiPT])
REFERENCES [dbo].[LoaiPT] ([ID_LoaiPT])
GO
ALTER TABLE [dbo].[PhuongTien] CHECK CONSTRAINT [FK_PhuongTien_LoaiPT]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_NhanVien] FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([ID_NhanVien])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_NhanVien]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_KhachSan] FOREIGN KEY([idKhachSan])
REFERENCES [dbo].[KhachSan] ([ID_KhachSan])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_KhachSan]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_NhanVien1] FOREIGN KEY([idNhanVienDanDoan])
REFERENCES [dbo].[NhanVien] ([ID_NhanVien])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_NhanVien1]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_NhanVien2] FOREIGN KEY([NguoiMo])
REFERENCES [dbo].[NhanVien] ([ID_NhanVien])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_NhanVien2]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK_Tour_PhuongTien] FOREIGN KEY([idPhuongTien])
REFERENCES [dbo].[PhuongTien] ([ID_PhuongTien])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK_Tour_PhuongTien]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [fk_tour_tttour] FOREIGN KEY([TrangThai])
REFERENCES [dbo].[TrangThaiTour] ([ID_TrangThai])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [fk_tour_tttour]
GO
ALTER TABLE [dbo].[Tour_DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_Tour_DiaDiem_DiaDiem] FOREIGN KEY([idDiaDiem])
REFERENCES [dbo].[DiaDiem] ([ID_DiaDiem])
GO
ALTER TABLE [dbo].[Tour_DiaDiem] CHECK CONSTRAINT [FK_Tour_DiaDiem_DiaDiem]
GO
ALTER TABLE [dbo].[Tour_DiaDiem]  WITH CHECK ADD  CONSTRAINT [FK_Tour_DiaDiem_Tour] FOREIGN KEY([idTour])
REFERENCES [dbo].[Tour] ([ID_Tour])
GO
ALTER TABLE [dbo].[Tour_DiaDiem] CHECK CONSTRAINT [FK_Tour_DiaDiem_Tour]
GO
USE [master]
GO
ALTER DATABASE [QL_TOUR] SET  READ_WRITE 
GO
