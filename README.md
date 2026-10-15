# Ứng dụng chuyển đổi USD sang VNĐ (JSP / Servlet)

Bài thực hành CodeGym, dự án Maven WAR chạy với **JDK 17**, **Maven 3.8+** và **Apache Tomcat 10.1+**.

## Cấu trúc

```text
jsp-servlet-currency-converter/
├── pom.xml
├── README.md
└── src/main/
    ├── java/com/codegym/ConverterServlet.java
    └── webapp/
        ├── index.jsp
        └── WEB-INF/web.xml
```

## Chạy trên Windows

1. Mở thư mục dự án trong IntelliJ IDEA (Open) hoặc Terminal.
2. Kiểm tra `java -version` (JDK 17) và `mvn -version`.
3. Chạy `mvn clean package` tại thư mục chứa `pom.xml`.
4. Chép `target/jsp-servlet-currency-converter.war` vào thư mục `webapps` của Tomcat 10.1.
5. Khởi động Tomcat bằng `bin/startup.bat` (Windows) hoặc `bin/startup.sh` (Linux/macOS).
6. Mở http://localhost:8080/jsp-servlet-currency-converter/

Nếu cổng 8080 đang được dùng, đổi cổng trong `conf/server.xml` của Tomcat và sửa URL tương ứng.

## Chức năng

- `index.jsp` có form POST gửi `rate` và `usd` tới `/convert`.
- `ConverterServlet` nhận tham số, kiểm tra dữ liệu và tính `VND = USD × rate` bằng `BigDecimal`.
- Kết quả và lỗi hiển thị **trực tiếp từ Servlet**, không phụ thuộc `result.jsp`.
- Ví dụ: `rate=25000`, `usd=100` → **2.500.000 VNĐ**.
- `rate=0`, `rate<0`, `usd<0`, dữ liệu trống hoặc không phải số → thông báo lỗi.

## Nộp GitHub

Tải **toàn bộ thư mục dự án giữ nguyên cấu trúc** vào repository, ví dụ `baithuchanh/jsp-servlet-currency-converter/`. Không đặt các file Java/JSP/XML rời rạc ở thư mục gốc của repository. GitHub không giải nén ZIP tự động: giải nén trên máy trước rồi upload thư mục con đúng cấu trúc, hoặc dùng Git.

## Lưu ý

Dự án không cần cơ sở dữ liệu. Chưa xác nhận build và deploy thực tế nếu máy kiểm thử không có Maven/Tomcat.
