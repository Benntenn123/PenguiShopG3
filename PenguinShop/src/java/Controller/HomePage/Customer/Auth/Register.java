package Controller.HomePage.Customer.Auth;

import APIKey.Capcha;
import Const.Account;
import DAL.TokenDAO;
import Utils.HashPassword;
import Utils.VerifyCapcha;
import DAL.UserDAO;
import Utils.GetDateTime;
import Utils.SendMail;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;

@WebServlet(name = "Register", urlPatterns = {"/register"})
public class Register extends HttpServlet {

    private static final Logger LOGGER = LogManager.getLogger(Login.class);
    UserDAO udao = new UserDAO();
    TokenDAO tdao = new TokenDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("User vào trang /register");
        request.getRequestDispatcher("HomePage/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String res = "";
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (action.equals("checkPhone")) {
            String phone_number = request.getParameter("phone_number").trim();
            res = checkPhone(request, phone_number);
        }
        if (action.equals("checkEmail")) {
            String email = request.getParameter("email").trim();
            res = checkEmail(request, email);
        }
        response.getWriter().write(res);
        if (action.equals("register")) {
            String[] info = getInfoUser(request);
            if (info != null) {
                int newAccount = udao.addUser(info);
                if (newAccount > -1) {
                    request.getSession().setAttribute("ms", "Đăng kí thành công");
                    String token = StringConvert.combineUserIdAndUUID(String.valueOf(newAccount));
                    if (tdao.saveToken(newAccount, token, GetDateTime.getCurrentTime())) {
                        SendMail.sendMailAsync(info[2], info[0], String.valueOf(newAccount), token);
                    }
                    response.sendRedirect("success");
                } else {
                    request.getSession().setAttribute("error", "Đã có lỗi xảy ra. Vui Lòng Thử Lại!");
                    response.sendRedirect("login");
                }
            } else {
                response.sendRedirect("login");
            }
        }
    }

    private String[] getInfoUser(HttpServletRequest request) {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String rePass = request.getParameter("re-password");
        String img_avatar = Account.AVATAR_DEFAULT_USER;
        String error = "";

        String recaptchaResponse = request.getParameter("g-recaptcha-response");
        LOGGER.info("Register attempt: fname={}, lname={}, email={}, phone={}, password={}, repass={}",
                fname, lname, email, phone, password, rePass);
        LOGGER.info("Lấy thành công capcha{}", recaptchaResponse);
        // check null rỗng các trường
        if (isAnyFieldEmpty(fname, lname, email, phone, password, rePass)) {
            request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin.");
            return null;
        }
        // check trùng password
        if (!password.equals(rePass)) {
            request.getSession().setAttribute("error", "Mật khẩu xác nhận không khớp.");
            return null;
        }

        // Validate reCAPTCHA
        if (!VerifyCapcha.verifyRecaptcha(recaptchaResponse)) {
            request.getSession().setAttribute("error", "Vui lòng hoàn thành reCAPTCHA.");
            return null;
        }
        //check valid format email (có thể update kiểu check - trước mắt chỉ check có @)
        if (!isValidEmail(email)) {
            request.getSession().setAttribute("error", "Email phải chứa ký tự @.");
            return null;
        }

        // Check if email or phone already exists
        if (udao.checkExistEmail(email)) {
            request.getSession().setAttribute("error", "Email đã được sử dụng.");
            return null;
        }
        if (udao.checkExistPhoneUser(phone)) {
            request.getSession().setAttribute("error", "Số điện thoại đã được sử dụng.");
            return null;
        }
        return new String[]{fname, lname, email, phone, HashPassword.hashWithSHA256(password), img_avatar};

    }

    private boolean isValidEmail(String email) {
        return email != null && email.contains("@");
    }

    private String checkPhone(HttpServletRequest request, String phone_number) {
        String status = "oke";
        if (udao.checkExistPhoneUser(phone_number)) {
            status = "exist";
        }
        return "{\"status\":\"" + status + "\"}";
    }

    private String checkEmail(HttpServletRequest request, String email) {
        String status = "oke";
        if (udao.checkExistEmail(email)) {
            status = "exist";
        }
        return "{\"status\":\"" + status + "\"}";
    }

    private boolean isAnyFieldEmpty(String... fields) {
        for (String field : fields) {
            if (field == null || field.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
