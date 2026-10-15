-- AutoRide: bai thuc hanh MySQL 8.0.16+
-- Ban tham khao co giai thich; hoc vien can tu kiem thu va hieu cac rang buoc.
-- Chi chay tren CSDL thuc hanh, khong chay tren CSDL san xuat.
CREATE DATABASE IF NOT EXISTS autoride_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE autoride_db;

-- 1. Mo phong cau truc legacy
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status VARCHAR(50) DEFAULT 'BOOKED',
    CONSTRAINT fk_rentals_cars FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- 2. Nang cap bang bang ALTER TABLE (giu lai du lieu cu)
-- Truoc khi MODIFY, can kiem tra gia tri status cu co hop le hay khong:
SELECT DISTINCT status FROM Rentals;
ALTER TABLE Rentals
    MODIFY COLUMN status ENUM('BOOKED','ACTIVE','COMPLETED','CANCELLED') NOT NULL DEFAULT 'BOOKED',
    ADD COLUMN security_deposit DECIMAL(12,2) NOT NULL DEFAULT 0,
    ADD COLUMN late_fee DECIMAL(12,2) NOT NULL DEFAULT 0,
    ADD COLUMN damage_fee DECIMAL(12,2) NOT NULL DEFAULT 0,
    ADD CONSTRAINT chk_deposit_nonnegative CHECK (security_deposit >= 0),
    ADD CONSTRAINT chk_late_nonnegative CHECK (late_fee >= 0),
    ADD CONSTRAINT chk_damage_nonnegative CHECK (damage_fee >= 0);

-- 3. Bien ban kiem tra: moi hop dong co the co nhieu lan kiem tra.
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_inspections_rentals FOREIGN KEY (rental_id)
        REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);

-- 4. Du lieu mo phong: dung bien de khong phu thuoc ID co dinh.
INSERT INTO Cars(model_name, license_plate)
VALUES ('Toyota Vios', '30A-98765');
SET @car_id = LAST_INSERT_ID();
INSERT INTO Rentals(car_id, customer_name, rent_date, return_date, status, security_deposit)
VALUES (@car_id, 'Nguyen Van A', '2026-10-10 08:00:00', '2026-10-12 08:00:00', 'ACTIVE', 10000000.00);
SET @rental_id = LAST_INSERT_ID();
INSERT INTO Inspections(rental_id, inspection_date, damage_description, inspector_name)
VALUES (@rental_id, '2026-10-12 09:00:00', 'Vo den pha trai', 'Tran Van B');
UPDATE Rentals
SET status = 'COMPLETED', return_date = '2026-10-12 09:00:00',
    late_fee = 0.00, damage_fee = 2000000.00
WHERE rental_id = @rental_id;

-- 5. Doi soat tien coc (khong tra so am neu phi vuot tien coc).
SELECT r.rental_id, r.customer_name, r.status,
       r.security_deposit, r.late_fee, r.damage_fee,
       (r.security_deposit - r.late_fee - r.damage_fee) AS refund_balance,
       GREATEST(r.security_deposit - r.late_fee - r.damage_fee, 0) AS refundable_amount,
       GREATEST(r.late_fee + r.damage_fee - r.security_deposit, 0) AS additional_amount_due,
       i.damage_description, i.inspector_name
FROM Rentals r
LEFT JOIN Inspections i ON i.rental_id = r.rental_id
WHERE r.rental_id = @rental_id;

-- Ket qua mong doi: refundable_amount = 8000000.00
-- Luu y: ENUM khong tu ngan chuyen trang thai sai thu tu; can logic ung dung/trigger.
-- Luu y: chay lai toan bo script tren DB da nang cap se loi trung cot; dung tren DB moi.
