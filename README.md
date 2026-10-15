# Thực hành: Tạo trang web hiển thị thời gian hệ thống

Dự án Maven Webapp theo bài thực hành CodeGym: Java 17, Jakarta Servlet 6.0, JSP 3.1, Tomcat 10.1+.

## Cấu trúc
- `pom.xml`: cấu hình Maven, đóng gói WAR
- `src/main/java/com/codegym/HelloServlet.java`: Servlet tại `/hello`
- `src/main/webapp/index.jsp`: trang hiển thị thời gian máy chủ
- `src/main/webapp/WEB-INF/web.xml`: cấu hình ứng dụng Jakarta Servlet

## Chạy trên Windows
1. Cài JDK 17, Maven và Apache Tomcat 10.1+; kiểm tra `java -version` và `mvn -version`.
2. Mở terminal tại thư mục `jsp-servlet-demo`.
3. Chạy `mvn clean package`.
4. Chép `target/jsp-servlet-demo.war` vào thư mục `webapps` của Tomcat.
5. Khởi động Tomcat bằng `bin/startup.bat` (hoặc khởi động từ IDE).
6. Mở `http://localhost:8080/jsp-servlet-demo/` để xem thời gian và `http://localhost:8080/jsp-servlet-demo/hello` để thử Servlet.

Thời gian hiển thị là thời gian của hệ điều hành nơi Tomcat chạy, được tạo khi trang JSP được yêu cầu.

## Nộp bài
Đưa toàn bộ mã nguồn lên GitHub và nộp đường dẫn repository hoặc thư mục dự án.

**Lưu ý:** Dự án chưa được chạy kiểm thử trên Tomcat trong môi trường tạo file này.
