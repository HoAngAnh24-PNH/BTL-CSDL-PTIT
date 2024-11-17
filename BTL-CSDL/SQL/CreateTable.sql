CREATE DATABASE DoiBong
CREATE TABLE DoiBong(
	TenDoi NVARCHAR(40) PRIMARY KEY,
	MauAo NVARCHAR(20),
	KhuVuc NVARCHAR(30),
	TenCSH NVARCHAR(40)
)

GO

CREATE TABLE CauThu(
	TenDoi NVARCHAR(40),
	SoAo INT,
	QuocTich NVARCHAR(30),
	Ten NVARCHAR(40),
	NgaySinh DATE,
	TenDoiDoiTruong NVARCHAR(40),
	SoAoDoiTruong INT,
	PRIMARY KEY (TenDoi,SoAo),
	FOREIGN KEY (TenDoi) REFERENCES DoiBong(TenDoi)
)

GO
-- Tạo bảng Huấn Luyện Viên
CREATE TABLE HuanLuyenVien(
	MaHLV CHAR(15),
	Ten NVARCHAR(30),
	QuocTich NVARCHAR(20),
	NamKinhNghiem INT,
	TenDoiHuanLuyen NVARCHAR(40),
	PRIMARY KEY (MaHLV),
	FOREIGN KEY (TenDoiHuanLuyen) REFERENCES DoiBong(TenDoi)
)

GO
-- Tạo bảng Giải đấu
CREATE TABLE GiaiDau(
	TenGiai NVARCHAR(100),
	MuaGiai CHAR(10),
	TheThucThiDau NVARCHAR(30),
	BanToChuc NVARCHAR(30),
	PRIMARY KEY (TenGiai,MuaGiai)
)

GO
-- Tạo bảng Nhà tài trợ
CREATE TABLE NhaTaiTro (
    MaNhaTaiTro CHAR(10) PRIMARY KEY,
    TenNhaTaiTro NVARCHAR(100),
    QuocGiaXuatXu NVARCHAR(50)
)
GO
-- Tạo bảng Tài trợ
CREATE TABLE TaiTro (
	TenGiai NVARCHAR(100),
	MuaGiai CHAR(10),
    	MaNhaTaiTro CHAR(10),
    	BatDau DATE,
	KetThuc DATE,
	HinhThuc NVARCHAR(20),
	FOREIGN KEY (TenGiai,MuaGiai) REFERENCES GiaiDau(TenGiai,MuaGiai),
	FOREIGN KEY (MaNhaTaiTro) REFERENCES NhaTaiTro(MaNhaTaiTro)
)
GO
-- Tạo bảng Trận đấu
CREATE TABLE TranDau(
	MaTran CHAR(15),
	SanDau NVARCHAR(50),
	Thoigian DATE,
	TenGiaiThuoc NVARCHAR(100),
	MuaGiaiThuoc CHAR(10),
	PRIMARY KEY (MaTran),
	FOREIGN KEY (TenGiaiThuoc,MuaGiaiThuoc) REFERENCES GiaiDau(TenGiai,MuaGiai)
)

GO
-- Tạo bảng Tham gia
CREATE TABLE ThamGia (
    TenDoi NVARCHAR(40),
    MaTran CHAR(15),
    DiemGhiDuoc INT,
    PRIMARY KEY (TenDoi, MaTran),
    FOREIGN KEY (TenDoi) REFERENCES DoiBong(TenDoi),
    FOREIGN KEY (MaTran) REFERENCES TranDau(MaTran)
);

GO
-- Tạo bảng Trọng tài
CREATE TABLE TrongTai (
    MaTrongTai CHAR(15) PRIMARY KEY,
    Ten NVARCHAR(50),
    QuocTich NVARCHAR(50)
);

GO
-- Tạo bảng Điều khiển
CREATE TABLE DieuKhien (
    MaTran CHAR(15),
    MaTrongTai CHAR(15),
    PRIMARY KEY (MaTran, MaTrongTai),
    FOREIGN KEY (MaTran) REFERENCES TranDau(MaTran),
    FOREIGN KEY (MaTrongTai) REFERENCES TrongTai(MaTrongTai)
);

GO
-- Tạo bảng Hỗ trợ
CREATE TABLE HoTro (
    MaTran CHAR(15),
    MaTrongTaiHoTro CHAR(15),
    PRIMARY KEY (MaTran, MaTrongTaiHoTro),
    FOREIGN KEY (MaTran) REFERENCES TranDau(MaTran),
    FOREIGN KEY (MaTrongTaiHoTro) REFERENCES TrongTai(MaTrongTai)
);

-- sau khi cho thêm dl cầu thủ vào bảng cầu thủ mới chạy dòng dưới
ALTER TABLE CauThu
ADD CONSTRAINT CauThu_DoiTruong FOREIGN KEY (TenDoiDoiTruong, SoAoDoiTruong) REFERENCES CauThu(TenDoi, SoAo);


