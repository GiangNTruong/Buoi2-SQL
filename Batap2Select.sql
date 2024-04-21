create database quanlybanhang;
create table khachhang(
                          MaKH char(4) primary key ,
                          TenKH varchar(30) not null,
                          Diachi varchar(50)  null,
                          Ngaysinh date  null ,
                          SoDT varchar(15) null,
                          unique (SoDT)
);

create table nhanvien(
                         MaNV char(4) primary key ,
                         HoTen varchar(30) not null ,
                         GioiTinh bit not null ,
                         Diachi varchar(50) not null,
                         NgaySinh date not null ,
                         DienThoai varchar(15) null ,
                         Email text null ,
                         NoiSinh varchar(20) not null ,
                         NgayVaoLam date null ,
                         MaNQL char(4)
);

create table nhacungcap(
                           MaNCC char(5) primary key ,
                           TenNCC varchar(50) not null ,
                           Diachi varchar(50) not null ,
                           Dienthoai varchar(15) not null ,
                           Email varchar(30) not null ,
                           Website varchar(30)
);

create table LOAISP(
                       MaloaiSP char(4) primary key ,
                       TenloaiSP varchar(30) not null ,
                       Ghichu varchar(100) not null
);

create table SANPHAM(
                        MaSP char(4) primary key ,
                        MaloaiSP char(4) not null ,
                        TenSP varchar(50) not null ,
                        Donvitinh varchar(10) not null ,
                        Ghichu varchar(100)
);

create table PHIEUNHAP(
                          SoPN char(5) primary key ,
                          MaNV char(4) not null ,
                          MaNCC char(5) not null ,
                          Ngaynhap date not null default (now()),
                          Ghichu varchar(100)
);

create table CTPHIEUNHAP(
                            MaSP char(4),
                            SoPN char(5),
                            Soluong smallint not null default 0,
                            Gianhap real not null check ( Gianhap>=0 ),
                            primary key (MaSP,SoPN)
);

create table PHIEUXUAT(
                          SoPX char(5) primary key ,
                          MaNV char(4) not null ,
                          MaKH varchar(4) not null ,
                          NgayBan date not null,
                          GhiChu text null
);

create table CTPHIEUXUAT(
                            SoPX char(5),
                            MaSP char(4),
                            SoLuong smallint not null ,
                            GiaBan real not null ,
                            primary key (SoPX,MaSP)
);

-- Thêm phiếu nhập thứ nhất
INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu)
VALUES ('PN001', 'NV01', 'NCC01', CURRENT_DATE, 'Ghi chú cho phiếu nhập 1');

-- Thêm sản phaamr vào phiếu nhập thứ nhất
INSERT INTO CTPHIEUNHAP (MaSP, SoPN, Soluong, Gianhap)
VALUES ('SP01','PN001',2,10000),
       ('SP02','PN001',2,15000);

-- Thêm phiếu nhập thứ hai
INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu)
VALUES ('PN002', 'NV02', 'NCC02', CURRENT_DATE, 'Ghi chú cho phiếu nhập 2');

-- Thêm sản phaamr vào phiếu nhập thứ hai
INSERT INTO CTPHIEUNHAP (MaSP, SoPN, Soluong, Gianhap)
VALUES ('SP03', 'PN002', 2, 20000),
       ('SP04', 'PN002', 2, 25000);


INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('PX001', 'NV01','KH01',CURRENT_DATE, 'Ghi chú cho phiếu xuất 1');


INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('PX001' , 'SP01' , 3, 20000),
       ('PX001' , 'SP02' , 3, 25000),
       ('PX001' , 'SP03' , 3, 30000);


INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('PX002', 'NV02','KH02',CURRENT_DATE, 'Ghi chú cho phiếu xuất 2');

-- thieu san pham vào phieu thu 2
INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('PX002' , 'SP04' , 3, 40000),
       ('PX002' , 'SP05' , 3, 5000),
       ('PX002' , 'SP06' , 3, 60000);

-- thêm nhân vien moi
INSERT INTO nhanvien (MaNV, HoTen, GioiTinh, Diachi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES ('NV03', 'Nguyen Van A', 1, '123 Đường ABC, Quận 1', '1990-01-01', '0123456789', 'email@example.com', 'TPHCM', CURRENT_DATE, 'NV01');

INSERT INTO khachhang(MaKH, TenKH, Diachi, Ngaysinh, SoDT)
values ('KH01','Nguyen Giang','HungYen','2024-01-01','0977414302');

UPDATE khachhang
SET SoDT = '0911111111'
WHERE MaKH ='KH01';

UPDATE nhanvien
SET Diachi = 'Hà Nội'
WHERE MaNV = 'NV03';

-- Bai 5
DELETE FROM nhanvien
WHERE MaNV = 'NV03';

INSERT INTO sanpham(MaSP, MaloaiSP, TenSP, Donvitinh, Ghichu)
VALUES ('SP15','1','Lenovo','5','xịn xịn');

DELETE FROM sanpham
WHERE MaSP = 'SP15';


-- Bài 6 :
-- 6.7
SELECT * FROM khachhang
WHERE MONTH(Ngaysinh) = MONTH(CURRENT_DATE);

-- 6.8
SELECT PX.SoPX ,  NV.HoTen , PX.NgayBan ,  SP.MaSP , SP.TenSP,SP.Donvitinh , CT.SoLuong, CT.GiaBan,(CT.SoLuong * CT.GiaBan)
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
         JOIN  nhanvien NV ON PX.MaNV = NV.MaNV
WHERE
    PX.NgayBan BETWEEN '2024-04-15' AND '2024-05-15';

-- 6.9
SELECT PX.SoPX , PX.NgayBan , KH.MaKH, KH.TenKH , SUM(CT.SoLuong * CT.GiaBan) AS 'Trị Giá'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN khachhang KH ON PX.MaKH = KH.MaKH
GROUP BY KH.MaKH, PX.SoPX;

-- 6.10
SELECT SUM(CT.SoLuong) AS 'tổng số lượng'
FROM CTPHIEUXUAT CT
         JOIN PHIEUXUAT PX ON CT.SoPX = PX.SoPX
         JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE  SP.TenSP = 'Comfort' AND PX.NgayBan BETWEEN '2024-01-01' AND '2024-06-30';

-- 6.11
SELECT MONTH(PX.NgayBan) AS 'tháng',KH.MaKH ,KH.TenKH ,
       KH.Diachi,SUM(CT.SoLuong * CT.GiaBan) AS 'tổng tiền'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN khachhang KH ON PX.MaKH = KH.MaKH
GROUP BY MONTH(PX.NgayBan), KH.MaKH;

-- 6.12
SELECT
    YEAR(PX.NgayBan) AS 'năm', MONTH(PX.NgayBan) AS 'tháng', SP.MaSP ,
    SP.TenSP , SP.Donvitinh, SUM(CT.SoLuong) AS 'Tổng Số Lượng'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
GROUP BY YEAR(PX.NgayBan), MONTH(PX.NgayBan), SP.MaSP;

-- 6.13
SELECT MONTH(PX.NgayBan) AS 'Tháng', SUM(CT.SoLuong * CT.GiaBan) AS 'Doanh Thu'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
WHERE PX.NgayBan BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY MONTH(PX.NgayBan);

-- 6.14
SELECT PX.SoPX , PX.NgayBan , NV.HoTen , KH.TenKH ,
       SUM(CT.SoLuong * CT.GiaBan) AS 'tongtrigia'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN nhanvien NV ON PX.MaNV = NV.MaNV
         JOIN khachhang KH ON PX.MaKH = KH.MaKH
WHERE PX.NgayBan BETWEEN '2024-04-01' AND '2024-06-30'
GROUP BY PX.SoPX;

-- 6.15
SELECT PX.SoPX, KH.MaKH , KH.TenKH , NV.HoTen , PX.NgayBan ,
       SUM(CT.SoLuong * CT.GiaBan) AS 'Trị Giá'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN nhanvien NV ON PX.MaNV = NV.MaNV
         JOIN khachhang KH ON PX.MaKH = KH.MaKH
WHERE DATE(PX.NgayBan) = CURDATE()
GROUP BY PX.SoPX;

-- 6.16
SELECT NV.MaNV , NV.HoTen , SP.MaSP , SP.TenSP , SP.Donvitinh ,
       SUM(CT.SoLuong) AS 'Tổng Số Lượng'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN nhanvien NV ON PX.MaNV = NV.MaNV
         JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
GROUP BY NV.MaNV, SP.MaSP;

-- 6.17
SELECT PX.SoPX , PX.NgayBan , SP.MaSP , SP.TenSP ,SP.Donvitinh , CT.SoLuong,
       CT.GiaBan, (CT.SoLuong * CT.GiaBan) AS 'Thành Tiền'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE PX.MaKH = 'KH01' AND
    PX.NgayBan BETWEEN '2024-04-01' AND '2024-06-30';

-- 6.18
SELECT SP.MaSP , SP.TenSP , LSP.TenloaiSP , SP.Donvitinh
FROM SANPHAM SP
         JOIN LOAISP LSP ON SP.MaloaiSP = LSP.MaloaiSP
WHERE SP.MaSP NOT IN (
    SELECT CT.MaSP
    FROM CTPHIEUXUAT CT
             JOIN PHIEUXUAT PX ON CT.SoPX = PX.SoPX
    WHERE PX.NgayBan BETWEEN '2018-01-01' AND '2018-06-30'
);
-- 6.19
SELECT NCC.MaNCC , NCC.TenNCC , NCC.Diachi , NCC.Dienthoai
FROM nhacungcap NCC
WHERE NCC.MaNCC NOT IN (
    SELECT PN.MaNCC
    FROM PHIEUNHAP PN
    WHERE PN.Ngaynhap BETWEEN '2023-04-01' AND '2023-06-30'
);

-- 6.20
SELECT PX.MaKH , KH.TenKH ,
       SUM(CT.SoLuong * CT.GiaBan) AS 'Tổng Trị Giá'
FROM PHIEUXUAT PX
         JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
         JOIN khachhang KH ON PX.MaKH = KH.MaKH
WHERE PX.NgayBan BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY PX.MaKH
ORDER BY SUM(CT.SoLuong * CT.GiaBan) DESC
LIMIT 1;

-- 6.21
SELECT PX.MaKH , COUNT(PX.SoPX) AS 'so luong don dat hang'
FROM PHIEUXUAT PX
GROUP BY PX.MaKH;

-- 6.22
SELECT NV.MaNV , NV.HoTen , KH.TenKH
FROM nhanvien NV
         LEFT JOIN PHIEUXUAT PX ON NV.MaNV = PX.MaNV
         LEFT JOIN khachhang KH ON PX.MaKH = KH.MaKH;

-- 6.23
SELECT
    *,
    CASE
        WHEN GioiTinh = 1 THEN 'Nam'
        ELSE 'Nữ'
        END AS GioiTinh
FROM nhanvien;

SELECT MaNV, HoTen,
       CASE
           WHEN GioiTinh = 1 THEN 'Nam'
           ELSE 'Nữ'
           END AS GioiTinh,
       Diachi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL
FROM
    nhanvien;

-- 6.24
SELECT MaNV , HoTen ,
       TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) AS 'năm làm vc'
FROM nhanvien
WHERE TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) = (
    SELECT max(TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()))
    FROM nhanvien );

-- 6.25
SELECT HoTen
FROM nhanvien
WHERE (GioiTinh = 1 AND TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) >= 60)
   OR (GioiTinh = 0 AND TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) >= 55);

-- 6.26
SELECT
    HoTen ,
    CASE
        WHEN GioiTinh = 1 THEN YEAR(DATE_ADD(NgaySinh, INTERVAL 60 YEAR))
        ELSE YEAR(DATE_ADD(NgaySinh, INTERVAL 55 YEAR))
        END AS 'nam ve huu'
FROM nhanvien;

-- 6.27
SELECT HoTen ,
       CASE
           WHEN TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) < 1 THEN 200000
           WHEN TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) >= 1 AND TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) < 3 THEN 400000
           WHEN TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) >= 3 AND TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) < 5 THEN 600000
           WHEN TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) >= 5 AND TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) < 10 THEN 800000
           WHEN TIMESTAMPDIFF(YEAR, NgayVaoLam, CURDATE()) >= 10 THEN 1000000
           END AS 'tiền thưởng tet duong lich'
FROM nhanvien;

-- 6.28 , 29
SELECT TenSP
FROM SANPHAM
WHERE MaloaiSP = 'LSP1';

-- 6.30
SELECT COUNT(*)
FROM SANPHAM
WHERE MaloaiSP = 'LSP1';
-- 6.32
SELECT MaloaiSP, COUNT(*)
FROM SANPHAM
GROUP BY MaloaiSP;
