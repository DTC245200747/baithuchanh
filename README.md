# Thực hành: Tạo CSDL quản lý sinh viên

Bài thực hành CodeGym sử dụng MySQL 8.0+.

## Nội dung
- Tạo database `QuanLySinhVien`.
- Tạo bảng `Class`, `Student`, `Subject`, `Mark`.
- Đầy đủ PRIMARY KEY, AUTO_INCREMENT, FOREIGN KEY, NOT NULL, DEFAULT, CHECK, UNIQUE.

## Hướng dẫn chạy
1. Mở MySQL Workbench, kết nối MySQL.
2. Mở `QuanLySinhVien.sql` và thực thi toàn bộ.
3. Chạy `USE QuanLySinhVien; SHOW TABLES;` để kiểm tra.
4. Chạy `SHOW CREATE TABLE Mark;` để kiểm tra các ràng buộc.

## Quan hệ
- `Class` (1) — (N) `Student`
- `Student` (1) — (N) `Mark`
- `Subject` (1) — (N) `Mark`

Lưu ý: UNIQUE(SubID, StudentID) là theo đề, nên không lưu được nhiều lần thi cho cùng một cặp sinh viên–môn học.
