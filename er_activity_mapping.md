# Đối chiếu Activity Diagram và ERD – AutoRide

Trong quy trình thuê xe, tiền cọc được thu khi đặt xe, còn phí phạt trễ và phí hư hỏng chỉ được xác định sau khi kiểm tra xe lúc trả. Thiết kế cũ không lưu `security_deposit`, `late_fee` và đặc biệt là `damage_fee`, nên kế toán không thể tính đúng số tiền hoàn trả. Nếu thiếu `damage_fee`, trường hợp vỡ đèn pha trị giá 2.000.000 đồng có thể bị hoàn trả thừa tiền cọc, làm sai doanh thu và gây tranh chấp vì không có căn cứ đối soát.

Bảng `Inspections` lưu ngày kiểm tra, người kiểm tra và mô tả hư hỏng, liên kết tới hợp đồng bằng khóa ngoại. Nhờ tách bảng, hệ thống có thể lưu nhiều lần kiểm tra mà không lặp thông tin hợp đồng. `Rentals.status` được giới hạn bằng `ENUM` để tránh giá trị tùy tiện. Các khoản tiền dùng `DECIMAL`, không dùng `FLOAT`, nhằm tránh sai số khi tính toán.

Với tiền cọc 10.000.000 đồng, phí trễ 0 đồng và phí hư hỏng 2.000.000 đồng, tiền hoàn lại là **8.000.000 đồng**. Cần thêm logic nghiệp vụ hoặc trigger để ngăn lập biên bản kiểm tra khi hợp đồng còn `BOOKED`.
