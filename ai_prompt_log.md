# Nhật ký trao đổi với AI – FlashMart

> Nhật ký tham khảo dựa trên nội dung trao đổi trong phiên này. Chỉ giữ lại những câu hỏi bạn thực sự đã hỏi và tự điều chỉnh theo quá trình học của mình trước khi nộp.

## 1. Vấn đề JOIN trong bài toán
**Nội dung đã đưa ra:** Đề bài FlashMart có truy vấn `JOIN` làm mất khách hàng chưa mua và không tìm được sản phẩm chưa bán.

**Kiến thức được AI giải thích:** `JOIN` không ghi loại là `INNER JOIN`, chỉ giữ bản ghi có khóa khớp ở hai bảng. `LEFT JOIN` giữ mọi bản ghi của bảng trái, bổ sung `NULL` ở phía phải nếu không khớp.

## 2. COUNT và GROUP BY
**Nội dung đã đưa ra:** Yêu cầu đếm số đơn hàng, kể cả khách hàng có 0 đơn.

**Kiến thức được AI giải thích:** `COUNT(*)` đếm cả dòng được sinh ra từ `LEFT JOIN`; `COUNT(o.order_id)` bỏ qua `NULL` và trả về 0 cho khách chưa mua.

## 3. Anti-Join
**Nội dung đã đưa ra:** Yêu cầu tìm sản phẩm chưa từng xuất hiện trong đơn hàng.

**Kiến thức được AI giải thích:** `LEFT JOIN` từ `Products` sang `Orders`, sau đó `WHERE o.order_id IS NULL` sẽ tìm bản ghi không có đối ứng.

## Tự đánh giá
Tôi cần tự chạy hai báo cáo trên MySQL, xác nhận Alice 2, Bob 1, Charlie 0 và sản phẩm chưa bán là Keyboard; lưu ảnh Result Grid nếu giảng viên yêu cầu.
