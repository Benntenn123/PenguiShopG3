/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.ForgotPassword;

import DAL.TokenDAO;
import Models.User;
import Utils.GetDateTime;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;

@WebServlet(name = "OTPChecking", urlPatterns = {"/otpchecking"})
public class OTPChecking extends HttpServlet {

    TokenDAO tdao = new TokenDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OTPChecking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OTPChecking at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("HomePage/OTPChecking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        User userforgot = (User) session.getAttribute("userforget");

        if (userforgot == null) {
            session.setAttribute("error", "Phiên làm việc hết hạn. Vui lòng thử lại.");
            response.sendRedirect("forgotpassword");
            return;
        }

        String[] otpOld = tdao.loadNewestToken(userforgot.getUserID());
        String storedOtp = otpOld[0];
        String createdAtStr = otpOld[1];
        String isUsedStr = otpOld[2];

        if (storedOtp.isEmpty()) {
            session.setAttribute("error", "Không tìm thấy mã OTP. Vui lòng yêu cầu mã mới.");
            response.sendRedirect("forgotpassword");
            return;
        }

       
        boolean isUsed = "1".equals(isUsedStr);
        boolean isWithinThreeMinutes = createdAtStr != null && GetDateTime.isWithinThreeMinutes(createdAtStr);

        if (isUsed || !isWithinThreeMinutes) {
            session.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn.");
            response.sendRedirect("otpchecking");
            return;
        }

        if (!otp.equals(storedOtp)) {
            session.setAttribute("error", "Mã OTP không đúng. Vui lòng thử lại.");
            response.sendRedirect("otpchecking");
            return;
        }

        // OTP hợp lệ
        tdao.markOTPAsUsed(userforgot.getUserID(), storedOtp);
        session.setAttribute("ms", "Xác nhận OTP thành công!");
        response.sendRedirect("reset_password");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
