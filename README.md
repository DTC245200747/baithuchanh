# Bài tập: Xây dựng cơ sở dữ liệu quản lý bán hàng

**CSDL:** `QuanLyBanHang` — **Hệ quản trị:** MySQL 8.0+

## Các bảng

| Bảng | Chức năng | Khóa chính | Khóa ngoại |
|---|---|---|---|
| Customer | Lưu khách hàng, kể cả người chưa mua | cID | — |
| Orders | Lưu hóa đơn mua hàng | oID | cID → Customer |
| Product | Lưu sản phẩm | pID | — |
| OrderDetail | Lưu sản phẩm và số lượng theo hóa đơn | (oID, pID) | oID → Orders, pID → Product |

## Quan hệ

- `Customer (1) → (N) Orders`: Một khách hàng có thể có nhiều hóa đơn; khách chưa mua có 0 hóa đơn.
- `Orders (1) → (N) OrderDetail`: Một hóa đơn có nhiều dòng hàng.
- `Product (1) → (N) OrderDetail`: Một sản phẩm có thể xuất hiện trong nhiều hóa đơn.
- `odQTY > 0`: Số lượng sản phẩm trong một dòng hóa đơn là số nguyên dương.

## Cách chạy

1. Mở MySQL Workbench, kết nối MySQL Server.
2. Mở `QuanLyBanHang.sql`, chọn chạy toàn bộ script.
3. Kiểm tra `SHOW TABLES;` trả về 4 bảng.
4. Kiểm tra `SHOW CREATE TABLE OrderDetail;` để xem khóa chính ghép và khóa ngoại.

## Lưu ý về đề

Ảnh ERD trên CodeGym không truy cập được trong lúc tạo bài, nên script dùng các trường thường gặp trong mẫu bài: `Customer(cID,cName,cAge)`, `Orders(oID,cID,oDate,oTotalPrice)`, `Product(pID,pName,pPrice)`, `OrderDetail(oID,pID,odQTY)`. Nếu ảnh gốc khác về tên cột/kiểu dữ liệu, cần chỉnh theo ảnh trước khi nộp.

Trong MySQL, `ORDER` là từ khóa, vì vậy script dùng tên bảng `Orders`. Nếu đề yêu cầu chính xác tên `Order`, hãy dùng dấu backtick: `` `Order` `` ở mọi câu lệnh.

`oTotalPrice` được lưu trong bảng Orders để tương thích cấu trúc bài học, nhưng trong hệ thống thực tế cần đồng bộ với tổng `odQTY * pPrice` khi thêm/sửa chi tiết hóa đơn. Bài tập chỉ yêu cầu DDL, chưa triển khai logic đồng bộ này.
