# Báo cáo phân tích khoảng cách nghiệp vụ – HealthSync

## Ba điểm vênh nghiêm trọng

**1. Trạng thái lịch hẹn không phản ánh quy trình.** Bảng `Appointments` cũ dùng `is_active BOOLEAN`, chỉ phân biệt hai giá trị đúng/sai. Trong khi đó, quy trình nghiệp vụ có năm trạng thái: `PENDING`, `CONFIRMED`, `CHECKED_IN`, `COMPLETED` và `CANCELLED`. Vì vậy hệ thống không biết bệnh nhân đã xác nhận cọc, đã đến khám hay đã hoàn tất. Đề xuất dùng `ENUM` cho trạng thái và kiểm soát các bước chuyển hợp lệ bằng logic ứng dụng hoặc trigger.

**2. Không lưu được dòng tiền và thông tin hủy lịch.** Thiết kế cũ thiếu `deposit_amount`, `penalty_fee`, `cancel_reason`. Khi bệnh nhân hủy lịch đã xác nhận, hệ thống không thể ghi nhận lý do, số tiền bị khấu trừ hay số tiền phải hoàn. Điều này ảnh hưởng trực tiếp đến kiểm toán và đối soát kế toán. Đề xuất dùng `DECIMAL(12,2)` cho số tiền và ràng buộc phí phạt không vượt tiền cọc.

**3. Không có thực thể đơn thuốc.** Quy trình yêu cầu bác sĩ kê đơn sau khi khám hoàn tất, nhưng không có bảng `Prescriptions`. Đề xuất thêm bảng có khóa ngoại `appointment_id`, giới hạn một đơn thuốc cho một lịch hẹn bằng `UNIQUE` và dùng trigger chặn kê đơn khi trạng thái chưa phải `COMPLETED`.

## Kết luận

ERD mới phải phản ánh đầy đủ các trạng thái và dữ liệu phát sinh trong Activity Diagram. Khóa ngoại đảm bảo quan hệ dữ liệu; `CHECK` và trigger bổ sung tính toàn vẹn nghiệp vụ. Khi sửa cơ sở dữ liệu đang vận hành, cần sao lưu và chuyển đổi dữ liệu cũ trước khi xóa cột `is_active`.
