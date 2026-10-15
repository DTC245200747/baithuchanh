<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDateTime,java.time.format.DateTimeFormatter" %>
<%
    String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CodeGym - Thời gian hệ thống</title>
    <style>
        body { font-family: Arial,sans-serif; background:#f5f7fb; margin:0; display:flex; align-items:center; justify-content:center; min-height:100vh; }
        main { background:white; text-align:center; padding:42px; border-radius:14px; box-shadow:0 8px 30px #172b4d18; max-width:560px; }
        h1 { color:#1b2a7a; } .clock { font-size:30px; font-weight:bold; color:#f15a24; margin:24px 0; }
        a { display:inline-block; background:#1b2a7a; color:white; padding:12px 20px; border-radius:6px; text-decoration:none; }
        p { color:#475569; }
    </style>
</head>
<body>
<main>
    <h1>Chào mừng tới lớp học Java Web!</h1>
    <p>Thời gian hiện tại của máy chủ:</p>
    <div class="clock"><%= currentTime %></div>
    <p>Làm mới trang để cập nhật thời gian.</p>
    <a href="hello">Đi tới HelloServlet</a>
</main>
</body>
</html>
