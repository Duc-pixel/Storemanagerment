
USE QuanLyCuaHang_ThietBiDienTu;
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'user_quanly')
    CREATE LOGIN user_quanly WITH PASSWORD = 'Password123!';
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'user_nhanvien')
    CREATE LOGIN user_nhanvien WITH PASSWORD = 'Password123!';
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'user_quanly')
    DROP USER user_quanly;
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'user_nhanvien')
    DROP USER user_nhanvien;
GO

CREATE USER user_quanly FOR LOGIN user_quanly;
CREATE USER user_nhanvien FOR LOGIN user_nhanvien;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON NHANVIEN TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON SANPHAM TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON HOADON TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIET_HOADON TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON NHAPHANPHOI TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON PC TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON LAPTOP TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRINTER TO user_quanly;
GRANT SELECT, INSERT, UPDATE, DELETE ON KHOHANG TO user_quanly;
GO

GRANT INSERT ON HOADON TO user_nhanvien;
GRANT INSERT ON CHITIET_HOADON TO user_nhanvien;
GRANT SELECT ON KHACHHANG TO user_nhanvien;
GRANT SELECT ON SANPHAM TO user_nhanvien;
GRANT SELECT ON PC TO user_nhanvien;
GRANT SELECT ON LAPTOP TO user_nhanvien;
GRANT SELECT ON PRINTER TO user_nhanvien;
GRANT SELECT ON KHOHANG TO user_nhanvien;
GO
