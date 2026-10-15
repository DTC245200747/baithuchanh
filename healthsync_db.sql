-- HEALTHSYNC: Bai thuc hanh sua thiet ke CSDL (MySQL 8.0.16+)
-- Chay tren CSDL thu nghiem. Script tao lai schema de co the thu nghiem doc lap.
-- Neu CSDL that da co du lieu, dung ALTER TABLE va ke hoach migration thay vi DROP.

CREATE DATABASE IF NOT EXISTS healthsync_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE healthsync_db;

DROP TRIGGER IF EXISTS trg_prescription_completed_insert;
DROP TRIGGER IF EXISTS trg_prescription_completed_update;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('PENDING','CONFIRMED','CHECKED_IN','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PENDING',
    deposit_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    penalty_fee DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    cancel_reason VARCHAR(255),
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    CONSTRAINT chk_deposit_nonnegative CHECK (deposit_amount >= 0),
    CONSTRAINT chk_penalty_range CHECK (penalty_fee >= 0 AND penalty_fee <= deposit_amount),
    CONSTRAINT chk_cancel_reason CHECK (status <> 'CANCELLED' OR (cancel_reason IS NOT NULL AND CHAR_LENGTH(TRIM(cancel_reason)) > 0)),
    CONSTRAINT chk_penalty_only_cancelled CHECK (status = 'CANCELLED' OR penalty_fee = 0)
);

CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    medication_details TEXT NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_prescription_appointment FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE RESTRICT
);

DELIMITER $$
CREATE TRIGGER trg_prescription_completed_insert
BEFORE INSERT ON Prescriptions FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Appointments WHERE appointment_id = NEW.appointment_id AND status = 'COMPLETED') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chi duoc ke don cho lich hen COMPLETED';
    END IF;
END$$
CREATE TRIGGER trg_prescription_completed_update
BEFORE UPDATE ON Prescriptions FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Appointments WHERE appointment_id = NEW.appointment_id AND status = 'COMPLETED') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Don thuoc phai gan voi lich hen COMPLETED';
    END IF;
END$$
DELIMITER ;

-- Du lieu mau
INSERT INTO Patients (full_name, phone) VALUES
('Nguyen Van A', '0900000001'), ('Tran Thi B', '0900000002');
INSERT INTO Doctors (full_name, specialty) VALUES
('BS Le Minh', 'Noi tong quat');

-- Kich ban 1: dat coc 500000, xac nhan, den kham, hoan tat, ke don
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (1, 1, '2026-10-20 09:00:00', 'PENDING', 500000.00);
UPDATE Appointments SET status = 'CONFIRMED' WHERE appointment_id = 1;
UPDATE Appointments SET status = 'CHECKED_IN' WHERE appointment_id = 1;
UPDATE Appointments SET status = 'COMPLETED' WHERE appointment_id = 1;
INSERT INTO Prescriptions (appointment_id, medication_details)
VALUES (1, 'Paracetamol 500mg: uong theo chi dinh cua bac si (du lieu minh hoa)');

-- Kich ban 2: da xac nhan coc 300000, huy va phat 150000
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (2, 1, '2026-10-21 14:00:00', 'CONFIRMED', 300000.00);
UPDATE Appointments
SET status = 'CANCELLED', cancel_reason = 'Bận việc đột xuất', penalty_fee = 150000.00
WHERE appointment_id = 2;

-- Kiem tra ket qua
SELECT a.appointment_id, p.full_name, a.status,
       a.deposit_amount, a.penalty_fee,
       (a.deposit_amount - a.penalty_fee) AS refundable_amount,
       a.cancel_reason
FROM Appointments a JOIN Patients p ON a.patient_id = p.patient_id
ORDER BY a.appointment_id;

SELECT p.full_name, a.appointment_id, a.status, pr.medication_details, pr.issued_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id
WHERE a.status = 'COMPLETED';

-- Kiem tra trigger: bo comment lenh sau de thay loi khi ke don cho lich CANCELLED.
-- INSERT INTO Prescriptions (appointment_id, medication_details) VALUES (2, 'Thuoc khong hop le');

-- Luu y: Trigger tren Prescriptions ngan tao/sua don thuoc sai trang thai.
-- De ngan thay doi trang thai lich hen da co don thuoc, can them trigger
-- BEFORE UPDATE ON Appointments hoac xu ly bang transaction trong ung dung.
