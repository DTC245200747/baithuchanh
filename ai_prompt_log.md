# Nhật ký trao đổi AI – AutoRide

> Ghi chép mẫu để tham khảo. Hãy chỉnh sửa theo các câu hỏi bạn thực sự đã trao đổi, không nộp nguyên văn nếu không phản ánh quá trình làm bài.

| Câu hỏi kỹ thuật | Kiến thức rút ra | Quyết định thiết kế |
|---|---|---|
| Vì sao tiền cọc và phí phạt nên dùng DECIMAL thay vì FLOAT? | FLOAT có sai số biểu diễn nhị phân; DECIMAL phù hợp dữ liệu tài chính. | Dùng DECIMAL(12,2) cho ba khoản tiền. |
| Nên thiết kế Rentals–Inspections là 1-1 hay 1-N? | 1-N cho phép lưu nhiều biên bản kiểm tra theo thời gian; 1-1 phù hợp nếu chỉ có một biên bản cuối cùng. | Chọn 1-N và khóa ngoại rental_id. |
| ON DELETE RESTRICT có ý nghĩa gì? | Chặn xóa hợp đồng nếu đã có biên bản kiểm tra liên quan, bảo vệ lịch sử đối soát. | Dùng ON DELETE RESTRICT. |
| Nếu tiền cọc hoặc phí bị NULL thì tính hoàn trả ra sao? | Phép trừ với NULL trả về NULL; cần NOT NULL DEFAULT 0 hoặc COALESCE. | Dùng NOT NULL DEFAULT 0. |
| ENUM có chặn việc kiểm tra xe khi hợp đồng BOOKED không? | ENUM chỉ giới hạn tập giá trị; quy tắc liên bảng cần logic ứng dụng hoặc trigger. | Đề xuất trigger BEFORE INSERT cho Inspections nếu triển khai nâng cao. |
