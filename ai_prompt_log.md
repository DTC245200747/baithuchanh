# Nhật ký tương tác AI – HealthSync

> Ghi chú: Đây là nhật ký tham khảo dựa trên các câu hỏi đã được trao đổi trong cuộc trò chuyện. Hãy chỉnh sửa để phản ánh đúng các prompt bạn thực sự sử dụng khi thực hành.

| STT | Câu hỏi thảo luận | Kiến thức rút ra | Quyết định thiết kế |
|---|---|---|---|
| 1 | Vì sao dùng `is_active BOOLEAN` cho lịch hẹn đa trạng thái là không phù hợp? | Boolean chỉ có hai trạng thái, không phản ánh đầy đủ vòng đời. | Dùng `ENUM('PENDING','CONFIRMED','CHECKED_IN','COMPLETED','CANCELLED')`. |
| 2 | Nên dùng `FLOAT`, `DOUBLE` hay `DECIMAL` để lưu tiền cọc và phí phạt? | Kiểu dấu phẩy động có sai số biểu diễn; `DECIMAL` phù hợp số tiền cần đối soát. | Dùng `DECIMAL(12,2)` và `CHECK` không âm. |
| 3 | Khóa ngoại có ngăn được việc kê đơn cho lịch chưa khám xong không? | Khóa ngoại chỉ kiểm tra lịch hẹn tồn tại, không kiểm tra trạng thái. | Dùng `BEFORE INSERT` trigger và `SIGNAL SQLSTATE '45000'`. |
| 4 | Khi sửa bảng cũ bằng `ALTER TABLE`, cần chú ý gì? | Không xóa `is_active` trước khi chuyển dữ liệu; nên sao lưu và kiểm thử trên bản sao. | Thêm cột mới, chuyển dữ liệu, kiểm tra, sau đó mới xóa cột cũ. |

## Tự đánh giá

AI được dùng để giải thích lựa chọn kiểu dữ liệu, cú pháp và rủi ro toàn vẹn. Người học cần tự kiểm tra kết quả SQL trên MySQL 8.0+ và có khả năng giải thích từng ràng buộc khi vấn đáp.
