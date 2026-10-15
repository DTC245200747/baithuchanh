<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Kết quả chuyển đổi</title><link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"></head>
<body><main class="card"><h1>Kết quả chuyển đổi</h1>
<p>Tỉ giá: <strong>${rate} VNĐ/USD</strong></p><p>Số USD: <strong>${usd} USD</strong></p>
<div class="result">${vnd} VNĐ</div><a class="back" href="${pageContext.request.contextPath}/">Quay lại</a>
</main></body></html>
