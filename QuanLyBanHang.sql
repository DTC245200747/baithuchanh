-- BAI TAP: XAY DUNG CO SO DU LIEU QUAN LY BAN HANG
-- MySQL 8.0+
-- Luu y: So do anh cua de chua truy cap duoc; cac cot cName, cAge,
-- oTotalPrice, pName, pPrice duoc chon theo mau CodeGym thong dung.

CREATE DATABASE IF NOT EXISTS QuanLyBanHang
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE QuanLyBanHang;

-- Khach hang: co the chua mua hang
CREATE TABLE Customer (
    cID INT NOT NULL AUTO_INCREMENT,
    cName VARCHAR(100) NOT NULL,
    cAge INT,
    PRIMARY KEY (cID),
    CONSTRAINT chk_customer_age CHECK (cAge IS NULL OR cAge >= 0)
);

-- San pham
CREATE TABLE Product (
    pID INT NOT NULL AUTO_INCREMENT,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (pID),
    CONSTRAINT chk_product_price CHECK (pPrice >= 0)
);

-- `Order` la tu khoa SQL: dung ten Orders de tranh xung dot
CREATE TABLE Orders (
    oID INT NOT NULL AUTO_INCREMENT,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(14,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (oID),
    CONSTRAINT fk_orders_customer FOREIGN KEY (cID)
        REFERENCES Customer(cID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_order_total CHECK (oTotalPrice >= 0)
);

-- Chi tiet hoa don: khoa chinh ghep (oID, pID)
CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL,
    PRIMARY KEY (oID, pID),
    CONSTRAINT fk_orderdetail_orders FOREIGN KEY (oID)
        REFERENCES Orders(oID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_orderdetail_product FOREIGN KEY (pID)
        REFERENCES Product(pID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_orderdetail_qty CHECK (odQTY > 0)
);

-- Kiem tra cau truc
SHOW TABLES;
SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Orders;
SHOW CREATE TABLE Product;
SHOW CREATE TABLE OrderDetail;
