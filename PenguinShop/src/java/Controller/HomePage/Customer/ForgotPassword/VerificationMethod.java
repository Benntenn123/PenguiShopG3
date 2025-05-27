/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Customer.ForgotPassword;

import Const.StatusOTP;
import DAL.TokenDAO;
import Models.User;
import Utils.GetDateTime;
import static Utils.GetDateTime.parseDateTime;
import Utils.SendMail;
import Utils.StringConvert;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name="VerificationMethod", urlPatterns={"/verification_method"})
public class VerificationMethod extends HttpServlet {
   
    TokenDAO tdao = new TokenDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerificationMethod</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerificationMethod at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User userforget = (User) request.getSession().getAttribute("userforget");
        
        String email = StringConvert.maskEmail(userforget.getEmail());
        String phone = StringConvert.maskPhoneNumber(userforget.getPhone());
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("phone", phone);
                
        request.getRequestDispatcher("HomePage/VerificationMethod.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        // Đảm bảo encoding cho tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy user từ session
        HttpSession session = request.getSession();
        User userforgot = (User) session.getAttribute("userforget");
        if (userforgot == null) {
            session.setAttribute("error", "Phiên làm việc hết hạn. Vui lòng thử lại.");
            response.sendRedirect("forgotpassword");
            return;
        }

        // Lấy method từ form
        String method = request.getParameter("verification_method");
        if (method == null || (!method.equals("email") && !method.equals("phone"))) {
            session.setAttribute("error", "Phương thức xác thực không hợp lệ.");
            response.sendRedirect("forgotpassword");
            return;
        }

        // Load OTP mới nhất của user
        String[] newestToken = tdao.loadNewestToken(userforgot.getUserID());
        String existingOtp = newestToken[0];
        String createdAtStr = newestToken[1];
        String isUsedStr = newestToken[2];

        // Kiểm tra OTP hiện tại
        boolean shouldGenerateNewOTP = true;
        if (!existingOtp.isEmpty()) {
            boolean isUsed = "1".equals(isUsedStr);
            LocalDateTime createdAt = GetDateTime.parseDateTime(createdAtStr);
            boolean isWithinThreeMinutes = createdAt != null && GetDateTime.isWithinThreeMinutes(createdAt);

            if (!isUsed && isWithinThreeMinutes) {
                // OTP chưa sử dụng và chưa quá 3 phút → Báo lỗi
                session.setAttribute("error", "Một mã OTP đã được gửi trước đó. Vui lòng kiểm tra email của bạn.");
                response.sendRedirect("forgotpassword");
                return;
            }
            // Nếu OTP đã sử dụng hoặc quá 3 phút → Tạo OTP mới
        }

        // Tạo và lưu OTP mới
        String newOtp = StringConvert.generateRandom6DigitNumber();
        String currentTime = GetDateTime.getCurrentTime();
        boolean saved = tdao.saveToken(userforgot.getUserID(), newOtp, currentTime, StatusOTP.UNUSED);
        if (!saved) {
            session.setAttribute("error", "Lỗi hệ thống khi lưu mã OTP. Vui lòng thử lại.");
            response.sendRedirect("forgotpassword");
            return;
        }

        // Gửi OTP qua email (hoặc SMS nếu có)
        if (method.equals("email")) {
            try {
                SendMail.guiMailOTP(
                    userforgot.getEmail(),
                    userforgot.getFullName(),
                    newOtp,
                    currentTime
                );
                session.setAttribute("message", "Mã OTP đã được gửi đến email của bạn.");
            } catch (MessagingException ex) {
                session.setAttribute("error", "Không thể gửi mã OTP qua email. Vui lòng thử lại sau.");
                response.sendRedirect("forgotpassword");
                return;
            }
        } else if (method.equals("phone")) {
            // Giả định bạn có hàm gửi SMS (nếu cần)
            // SendSMS.sendOTP(userforgot.getPhone(), newOtp);
            session.setAttribute("message", "Mã OTP đã được gửi đến số điện thoại của bạn.");
        }

        // Lưu method vào session và chuyển hướng
        session.setAttribute("verificationMethod", method);
        response.sendRedirect("otpchecking");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
