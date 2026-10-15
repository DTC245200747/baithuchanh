<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chuyển đổi USD sang VNĐ</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body><main class="card"><h1>Chuyển đổi USD sang VNĐ</h1><p>Nhập tỉ giá và số USD cần quy đổi.</p>
<% if (request.getAttribute("error") != null) { %><div class="error"><%= request.getAttribute("error") %></div><% } %>
<form method="post" action="${pageContext.request.contextPath}/convert">
<label for="rate">Tỉ giá (VNĐ / USD)</label><input id="rate" type="number" name="rate" min="0.01" step="any" value="25000" required>
<label for="usd">Lượng USD</label><input id="usd" type="number" name="usd" min="0" step="any" placeholder="Ví dụ: 100" required>
<button type="submit">Chuyển đổi</button></form></main></body></html>
