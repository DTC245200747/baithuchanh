# Thực hành: Tạo bảng trong CSDL — QuanLyDiemThi

- `index.html`: Bài báo cáo HTML có sơ đồ các bảng, giải thích quan hệ và SQL.
- `QuanLyDiemThi.sql`: SQL tạo cơ sở dữ liệu và bốn bảng, khóa chính/khóa ngoại (MySQL).

## Chạy SQL
Mở MySQL Workbench hoặc phpMyAdmin, chạy nội dung `QuanLyDiemThi.sql` trong cơ sở dữ liệu MySQL chưa có các bảng trùng tên.

## Đăng GitHub Pages
Tạo repository public, upload các file ở thư mục gốc. Vào Settings → Pages → Deploy from a branch → main → /(root) → Save.

Lưu ý: ví dụ CodeGym ghi MaMH VARCHAR(20) ở bước 4, nhưng bảng đặc tả ghi VARCHAR(50). Bài này dùng VARCHAR(50) nhất quán.
