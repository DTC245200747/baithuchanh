# FlashMart – Thực hành INNER JOIN, LEFT JOIN và Anti-Join

## Các file
- `flashmart_reports.sql`: tạo CSDL, bảng, dữ liệu mẫu và 2 báo cáo.
- `join_analysis.md`: giải thích ngắn về COUNT và JOIN (dưới 150 từ).
- `ai_prompt_log.md`: nhật ký tham khảo, cần đối chiếu với quá trình thực tế.

## Cách chạy
1. Mở MySQL Workbench, kết nối MySQL 8+.
2. Mở `flashmart_reports.sql` và chạy toàn bộ.
3. Xem Result Grid của hai câu SELECT báo cáo.

## Kết quả mong đợi
Marketing: Alice = 2, Bob = 1, Charlie = 0 (3 dòng).
Kho vận: `103 | Keyboard` (1 dòng).

**Lưu ý:** Script dùng `DROP TABLE IF EXISTS` để tạo lại dữ liệu mẫu. Chỉ chạy trong môi trường thực hành, không dùng trên dữ liệu thật. Đây là kết quả dự kiến, chưa được kiểm chứng bằng MySQL thực tế.
