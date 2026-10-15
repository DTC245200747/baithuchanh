package com.codegym;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Locale;

@WebServlet(name = "ConverterServlet", urlPatterns = "/convert")
public class ConverterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String message;
        boolean success = false;
        try {
            BigDecimal rate = new BigDecimal(request.getParameter("rate").trim());
            BigDecimal usd = new BigDecimal(request.getParameter("usd").trim());
            if (rate.signum() <= 0 || usd.signum() < 0) {
                throw new IllegalArgumentException("Tỉ giá phải lớn hơn 0 và số USD không được âm.");
            }
            BigDecimal vnd = rate.multiply(usd).setScale(2, RoundingMode.HALF_UP);
            NumberFormat vndFormat = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN"));
            vndFormat.setMinimumFractionDigits(0);
            vndFormat.setMaximumFractionDigits(2);
            message = "<p>Tỉ giá: " + vndFormat.format(rate) + " VNĐ/USD</p>"
                    + "<p>Số tiền USD: " + usd.toPlainString() + " USD</p>"
                    + "<h2>Thành tiền: " + vndFormat.format(vnd) + " VNĐ</h2>";
            success = true;
        } catch (NumberFormatException | NullPointerException ex) {
            message = "Vui lòng nhập tỉ giá và số USD hợp lệ.";
        } catch (IllegalArgumentException ex) {
            message = ex.getMessage();
        }
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html><html lang='vi'><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width,initial-scale=1'><title>Kết quả chuyển đổi</title>");
            out.println("<style>body{font-family:Arial,sans-serif;background:#f3f6fb;display:grid;place-items:center;min-height:100vh;margin:0}.card{background:white;padding:32px;border-radius:14px;box-shadow:0 8px 28px #0001;max-width:520px;text-align:center}h1{color:#1b2a7a}.ok{color:#15803d}.err{color:#b91c1c}a{display:inline-block;margin-top:15px;background:#1b2a7a;color:white;padding:12px 22px;text-decoration:none;border-radius:8px}</style></head><body><main class='card'><h1>Kết quả chuyển đổi</h1>");
            out.println("<div class='" + (success ? "ok" : "err") + "'>" + message + "</div>");
            out.println("<a href='" + response.encodeURL(request.getContextPath() + "/") + "'>Quay lại</a></main></body></html>");
        }
    }
}
