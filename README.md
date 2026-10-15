# Ứng dụng chuyển đổi tiền tệ - Servlet

Bài thực hành CodeGym: nhập tỉ giá (`rate`) và số USD (`usd`), gửi POST đến `/convert`, hiển thị `VND = USD × rate`.

## Yêu cầu
- JDK 17
- Apache Maven 3.8+
- Apache Tomcat 10.1+ (không dùng Tomcat 9 vì sử dụng `jakarta.servlet`)

## Chạy trên Windows / IntelliJ IDEA
1. Giải nén ZIP và mở thư mục `jsp-servlet-currency-converter` trong IntelliJ (Open).
2. Chờ Maven tải dependencies. Kiểm tra Project SDK là JDK 17.
3. Mở Terminal tại thư mục chứa `pom.xml` và chạy `mvn clean package`.
4. Khi BUILD SUCCESS, lấy file `target/jsp-servlet-currency-converter.war` chép vào thư mục `webapps` của Tomcat 10.1.
5. Chạy `bin/startup.bat` trong thư mục Tomcat (hoặc chạy Tomcat qua IDE).
6. Mở http://localhost:8080/jsp-servlet-currency-converter/

## Thử chức năng
- Rate = 25000; USD = 100 → 2.500.000 VNĐ.
- Rate = 26000; USD = 10 → 260.000 VNĐ.
- Nhập tỉ giá <= 0 hoặc USD âm: hiển thị thông báo lỗi.

**Ghi chú:** Không mở `index.jsp` trực tiếp bằng trình duyệt hoặc Live Server; JSP/Servlet phải chạy qua Tomcat. Không cần MySQL cho bài này.
