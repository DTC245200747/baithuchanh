<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Chuyển đổi USD sang VNĐ</title>
  <style>body{font-family:Arial,sans-serif;background:#f3f6fb;display:grid;place-items:center;min-height:100vh;margin:0}.card{width:min(390px,90vw);background:white;padding:32px;border-radius:14px;box-shadow:0 8px 28px #0001}h1{font-size:24px;color:#1b2a7a}label{display:block;margin:18px 0 8px;font-weight:bold}input{box-sizing:border-box;width:100%;padding:12px;border:1px solid #cbd5e1;border-radius:8px}button{width:100%;padding:13px;margin-top:24px;background:#1b2a7a;color:white;border:0;border-radius:8px;cursor:pointer}small{color:#64748b}</style>
</head>
<body><main class="card"><h1>Chuyển đổi USD sang VNĐ</h1><p>Nhập tỉ giá và số tiền cần chuyển đổi.</p>
<form method="post" action="<%= request.getContextPath() %>/convert">
  <label for="rate">Tỉ giá (VNĐ / USD)</label><input id="rate" name="rate" type="number" min="0.01" step="any" value="25000" required>
  <label for="usd">Số tiền USD</label><input id="usd" name="usd" type="number" min="0" step="any" placeholder="Ví dụ: 100" required>
  <button type="submit">Chuyển đổi</button>
</form><p><small>Tỉ giá do người dùng nhập, không phải tỉ giá thời gian thực.</small></p></main></body></html>
