# AutoRide – Bài tập đối chiếu UML và ERD

## File nộp
- `autoride_db.sql`: MySQL DDL/DML, nâng cấp từ legacy bằng ALTER TABLE, kiểm thử và đối soát.
- `er_activity_mapping.md`: phân tích chênh lệch nghiệp vụ–dữ liệu dưới 200 từ.
- `ai_prompt_log.md`: mẫu nhật ký kỹ thuật; cần cá nhân hóa theo quá trình thực tế.

## Cách chạy
1. Mở MySQL Workbench kết nối MySQL 8.0.16+.
2. Chạy `autoride_db.sql` trên môi trường thử nghiệm chưa có bảng AutoRide.
3. Xem kết quả SELECT cuối: `refundable_amount = 8000000.00`.
4. Chụp màn hình kết quả và kiểm tra khóa ngoại `Inspections.rental_id`.

## Ghi chú
- Script mô phỏng legacy rồi nâng cấp bằng ALTER TABLE, không xóa dữ liệu cũ.
- Không chạy lại toàn bộ trên cùng database vì các cột mới đã tồn tại.
- Để kiểm soát chuyển trạng thái và ngăn kiểm tra khi BOOKED cần trigger hoặc logic ứng dụng.
- Bài nộp yêu cầu tự phân tích và sử dụng AI đúng quy định của giảng viên; đọc hiểu và điều chỉnh trước khi nộp.
