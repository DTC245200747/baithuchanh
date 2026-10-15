# Phân tích lựa chọn JOIN và COUNT

Báo cáo Marketing phải bắt đầu từ bảng `Customers` và dùng `LEFT JOIN Orders` để giữ cả khách hàng chưa từng đặt hàng. Với Charlie, phép nối tạo một dòng mà các cột của `Orders` đều là `NULL`. Nếu dùng `COUNT(*)`, MySQL vẫn đếm dòng đó, khiến Charlie bị ghi nhận nhầm là có 1 đơn hàng. Ngược lại, `COUNT(o.order_id)` chỉ đếm các giá trị `order_id` khác `NULL`, nên kết quả chính xác là 0.

Báo cáo Kho vận bắt đầu từ `Products`, dùng `LEFT JOIN Orders` và `WHERE o.order_id IS NULL` để tìm sản phẩm chưa bán (anti-join). `INNER JOIN` loại các dòng không khớp ngay từ đầu nên không thể tìm được Keyboard.
