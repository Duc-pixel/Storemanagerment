-- Xóa database nếu tồn tại
IF DB_ID('QuanLyCuaHang_ThietBiDienTu') IS NOT NULL
    DROP DATABASE QuanLyCuaHang_ThietBiDienTu;
GO

-- Tạo lại database
CREATE DATABASE QuanLyCuaHang_ThietBiDienTu;
GO

USE QuanLyCuaHang_ThietBiDienTu;
GO

-- KHÁCH HÀNG
CREATE TABLE KHACHHANG (
    MaKH INT PRIMARY KEY,
    TenKh NVARCHAR(50),
    DiaChi NVARCHAR(50),
    DienThoai CHAR(10) CHECK (LEN(DienThoai) = 10)
);
GO

-- NHÂN VIÊN
CREATE TABLE NHANVIEN (
    MaNV INT PRIMARY KEY,
    TenNV NVARCHAR(50),
    ChucVu NVARCHAR(50),
    DienThoai CHAR(10) CHECK (LEN(DienThoai) = 10),
    NgayLam DATETIME,
    Luong DECIMAL(9,1)
);
GO

-- NHÀ PHÂN PHỐI (đã đổi MaNPP thành CHAR(3))
CREATE TABLE NHAPHANPHOI (
    MaNPP CHAR(3) PRIMARY KEY,
    TenNPP NVARCHAR(50),
    DiaChi NVARCHAR(50),
    SDT NVARCHAR(10) CHECK (LEN(SDT) = 10)
);
GO

-- SẢN PHẨM
CREATE TABLE SANPHAM (
    MaSP INT PRIMARY KEY,
    MaNPP CHAR(3),
    LoaiSP NVARCHAR(20),
    FOREIGN KEY (MaNPP) REFERENCES NHAPHANPHOI(MaNPP)
);
GO

-- PC
CREATE TABLE PC (
    MaSP INT PRIMARY KEY,
    Speed FLOAT,
    RAM INT,
    HD INT,
    Gia INT,
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
GO

-- LAPTOP
CREATE TABLE LAPTOP (
    MaSP INT PRIMARY KEY,
    Speed FLOAT,
    RAM INT,
    HD INT,
    Screen FLOAT,
    Gia INT,
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
GO

-- PRINTER
CREATE TABLE PRINTER (
    MaSP INT PRIMARY KEY,
    Color BIT,
    Type NVARCHAR(20),
    Gia INT,
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
GO

-- HOÁ ĐƠN (đã đổi MaNPP sang CHAR(3))
CREATE TABLE HOADON (
    MaHD NVARCHAR(20) PRIMARY KEY,
    LoaiHD NVARCHAR(10) CHECK (LoaiHD IN ('Ban', 'Nhap')),
    MaKH INT NULL,
    MaNV INT NOT NULL,
    MaNPP CHAR(3) NULL,
    NgayBanHang DATETIME,
    NgayNhanHang DATETIME,
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY (MaNPP) REFERENCES NHAPHANPHOI(MaNPP)
);
GO

-- CHI TIẾT HOÁ ĐƠN
CREATE TABLE CHITIET_HOADON (
    MaHD NVARCHAR(20),
    MaSP INT,
    SoLuong INT CHECK (SoLuong > 0),
    Gia INT,
    Tong AS (SoLuong * Gia),
    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
GO

-- KHO HÀNG
CREATE TABLE KHOHANG (
    MaKho INT PRIMARY KEY,
    MaSP INT,
    NgayCapNhat DATETIME,
    SoLuong INT CHECK (SoLuong >= 0),
    TrangThai NVARCHAR(20) CHECK (TrangThai IN ('Còn Hàng', 'Hết hàng')),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);
GO

-- TÀI KHOẢN
CREATE TABLE TAIKHOAN (
    MaNV INT PRIMARY KEY,
    TenDangNhap NVARCHAR(50),
    MatKhau NVARCHAR(50),
    ChucVu NVARCHAR(50) CHECK (ChucVu IN ('QuanLy', 'NhanVien')),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);
GO



INSERT INTO NHANVIEN (MaNV, TenNV, ChucVu, DienThoai, NgayLam, Luong)
VALUES 
('001', N'Pham Lan Anh', N'Quan ly', '0383529295', '2023-01-01', 20000000.0),
('002', N'Lang Van Duc', N'Nhan vien', '0999999999', '2023-06-15', 12000000.0),
('003', N'Bui Thi Phuong Linh', N'Nhan vien', '0111111111', '2024-02-01', 12500000.0);
GO


INSERT INTO NHAPHANPHOI (MaNPP, TenNPP, DiaChi, SDT)
VALUES 
    ('001', 'AA', '123 Kim Ma, Ba Dinh', '0911222333'),
    ('002', 'BB', '45 Tran Duy Hung, Cau Giay', '0903444555'),
    ('003', 'CC', '78 Le Duan, Hoan Kiem', '0939888777'),
    ('004', 'DD', '12 Giai Phong, Hoang Mai', '0977001122');


INSERT INTO SANPHAM (MaSP, MaNPP, LoaiSP)
VALUES 
    (1001, '001', 'PC'),
    (1002, '002', 'PC'),
    (1003, '003', 'PC'),
    (1004, '004', 'PC'),
    (1005, '001', 'PC'),
    (1006, '002', 'PC'),
    (1007, '003', 'PC'),
    (1008, '004', 'PC'),
    (1009, '001', 'PC'),
    (1010, '002', 'PC'),
    (1011, '003', 'PC'),
    (1012, '004', 'PC'),
    (1013, '001', 'PC');


INSERT INTO SANPHAM (MaSP, MaNPP, LoaiSP)
VALUES
(2001, '001', N'Laptop'),
(2002, '001', N'Laptop'),
(2003, '002', N'Laptop'),
(2004, '002', N'Laptop'),
(2005, '003', N'Laptop'),
(2006, '004', N'Laptop'),
(2007, '004', N'Laptop');

INSERT INTO SANPHAM (MaSP, MaNPP, LoaiSP)
VALUES
(3004, '001', N'Máy in'),
(3005, '001', N'Máy in'),
(3006, '002', N'Máy in'),
(3007, '003', N'Máy in'),
(3008, '004', N'Máy in');


INSERT INTO PC (MaSP, Speed, RAM, HD, Gia)
VALUES
    (1001, 2.66, 1024, 250, 2114),
    (1002, 2.1, 512, 250, 995),
    (1003, 1.42, 512, 80, 478),
    (1004, 2.8, 1024, 250, 649),
    (1005, 3.2, 512, 250, 630),
    (1006, 3.2, 1024, 320, 1049),
    (1007, 2.2, 1024, 250, 850),
    (1008, 2.0, 512, 160, 600),
    (1009, 3.0, 1024, 500, 1400),
    (1010, 3.1, 2048, 750, 2000),
    (1011, 3.3, 4096, 1000, 3000),
    (1012, 2.8, 2048, 500, 1900),
    (1013, 2.4, 1024, 250, 1200);

INSERT INTO PRINTER (MaSP, Color, Type, Gia)
VALUES
(3004, 1, 'ink-jet', 99),
(3005, 0, 'laser', 239),
(3006, 1, 'laser', 899),
(3007, 1, 'ink-jet', 120),
(3008, 0, 'laser', 120);


INSERT INTO LAPTOP (MaSP, Speed, RAM, HD, Screen, Gia)
VALUES
(2001, 2.00, 2048, 240, 20.1, 3673),
(2002, 1.73, 1024, 80, 17.0, 949),
(2003, 1.80, 512, 60, 15.4, 549),
(2004, 2.00, 512, 60, 13.3, 1150),
(2005, 2.16, 1024, 120, 17.0, 2500),
(2006, 2.10, 2048, 320, 15.6, 2700),
(2007, 2.30, 2048, 500, 14.0, 2900);

INSERT INTO HOADON (MaHD, LoaiHD, MaKH, MaNV, MaNPP, NgayBanHang, NgayNhanHang)
VALUES 
('HD001', 'Ban', 1, 2, NULL, '2025-05-01', '2025-05-02'),
('HD002', 'Ban', 2, 2, NULL, '2025-05-02', '2025-05-03'),
('HD003', 'Ban', 3, 3, NULL, '2025-05-03', '2025-05-04'),
('HD004', 'Nhap', NULL, 1, 'AA', '2025-05-04', '2025-05-05'),
('HD005', 'Nhap', NULL, 1, 'DD', '2025-05-05', '2025-05-06');


INSERT INTO KHACHHANG (MaKH, TenKH, DiaChi, DienThoai)
VALUES
(1, 'A', '123 Phạm Văn Đồng, Cổ Nhuế, Hà Nội', '0111111111'),
(2, 'B', '270 Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '0222222222'),
(3, 'C', '155 Nguyễn Phong Sắc, Hà Nội', '0333333333'),
(4, 'D', '1 Đức Thắng, Bắc Từ Liêm, Hà Nội', '0444444444'),
(5, 'E', 'Ngõ Văn Hội, Cổ Nhuế 2, Hà Nội', '0555555555'),
(6, 'F', 'đường Cầu Vồng, Bắc Từ Liêm, Hà Nội', '0666666666'),
(7, 'G', '167 Trần Cung, Cổ Nhuế 1, Hà Nội', '0777777777'),
(8, 'H', '290 Trần Bình, Hà Nội', '0888888888'),
(9, 'I', '123 Xuân Đỉnh, Bắc Từ Liêm, Hà Nội', '0999999999'),
(10, 'K', '521 Mỹ Đình, Nam Từ Liêm, Hà Nội', '0123456789');


INSERT INTO HOADON (MaHD, LoaiHD, MaKH, MaNV, MaNPP, NgayBanHang, NgayNhanHang)
VALUES 
('HD001', 'Ban', 1, 2, NULL, '2025-05-01', '2025-05-02'),
('HD002', 'Ban', 2, 2, NULL, '2025-05-02', '2025-05-03'),
('HD003', 'Ban', 3, 3, NULL, '2025-05-03', '2025-05-04'),
('HD004', 'Nhap', NULL, 1, '001', '2025-05-04', '2025-05-05'), 
('HD005', 'Nhap', NULL, 1, '004', '2025-05-05', '2025-05-06');  

INSERT INTO CHITIET_HOADON (MaHD, MaSP, SoLuong, Gia)
VALUES 
('HD001', 1001, 2, 2114),
('HD001', 3006, 1, 899),
('HD002', 2003, 1, 549),
('HD003', 1005, 3, 630),
('HD004', 2005, 2, 2500),
('HD005', 3005, 1, 239),
('HD005', 1002, 1, 995);

