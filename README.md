# HealthSync – Khủng hoảng tại phòng khám

Bộ bài thực hành gồm:
- `healthsync_db.sql`: thiết kế schema, dữ liệu mô phỏng, truy vấn đối soát, trigger kiểm tra trạng thái.
- `consistency_report.md`: báo cáo Gap Analysis.
- `ai_prompt_log.md`: nhật ký thảo luận AI tham khảo (cần xác nhận lại nội dung thực tế).

**Chạy:** MySQL 8.0.16+ / MySQL Workbench. Mở và chạy toàn bộ `healthsync_db.sql`.

**Chú ý:** SQL xóa và tạo lại các bảng của database `healthsync_db`, chỉ chạy trong môi trường thử nghiệm, không chạy trên dữ liệu thật. Script chưa được thực thi trên máy chủ MySQL trong môi trường tạo file.
