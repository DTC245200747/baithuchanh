package com.codegym;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        try {
            String rateInput = request.getParameter("rate");
            String usdInput = request.getParameter("usd");
            if (rateInput == null || usdInput == null) throw new NumberFormatException("Thiếu dữ liệu");
            BigDecimal rate = new BigDecimal(rateInput.trim());
            BigDecimal usd = new BigDecimal(usdInput.trim());
            if (rate.signum() <= 0 || usd.signum() < 0) throw new NumberFormatException("Giá trị không hợp lệ");
            BigDecimal vnd = usd.multiply(rate).setScale(2, RoundingMode.HALF_UP);
            NumberFormat vn = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN"));
            vn.setMinimumFractionDigits(0);
            vn.setMaximumFractionDigits(2);
            request.setAttribute("rate", vn.format(rate));
            request.setAttribute("usd", usd.toPlainString());
            request.setAttribute("vnd", vn.format(vnd));
            request.getRequestDispatcher("/result.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Vui lòng nhập tỉ giá lớn hơn 0 và số USD không âm, đúng định dạng số.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
