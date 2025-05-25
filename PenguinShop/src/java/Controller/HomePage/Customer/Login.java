/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer;

import Utils.HashPassword;
import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.util.UUID;

@WebServlet(name="Login", urlPatterns={"/login"})
public class Login extends HttpServlet {

    private static final Logger LOGGER = LogManager.getLogger(Login.class);

    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        LOGGER.info("Accessing login page");
        request.getRequestDispatcher("HomePage/Login.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        LOGGER.info("Processing POST request for /login");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        LOGGER.info("Remember Me checkbox: {}", rememberMe);

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            LOGGER.warn("Missing email or password for login attempt");
            request.getSession().setAttribute("error", "Email và Mật khẩu là bắt buộc.");
            response.sendRedirect("login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        boolean isAuthenticated = userDAO.authenticateUser(email, HashPassword.hashWithSHA256(password));

        if (isAuthenticated) {
            User user = userDAO.loadUserInfoByEmail(email);
            request.getSession().setAttribute("user", user);

            if ("on".equals(rememberMe)) {
                
                jakarta.servlet.http.Cookie emailCookie = new jakarta.servlet.http.Cookie("userEmail", URLEncoder.encode(email, "UTF-8"));
                jakarta.servlet.http.Cookie rememberMeCookie = new jakarta.servlet.http.Cookie("userPassword", URLEncoder.encode(password, "UTF-8"));

                emailCookie.setMaxAge(60 * 60 * 24 * 7); // 7 days
                emailCookie.setPath("/");
                emailCookie.setHttpOnly(true);
                emailCookie.setSecure(request.isSecure());
                
                rememberMeCookie.setMaxAge(60 * 60 * 24 * 7);
                rememberMeCookie.setPath("/");
                rememberMeCookie.setHttpOnly(true);
                rememberMeCookie.setSecure(request.isSecure());

                response.addCookie(emailCookie);
                response.addCookie(rememberMeCookie);
                
            }

            LOGGER.info("User {} logged in successfully", email);
            request.getSession().setAttribute("ms", "Đăng nhập thành công!");
            response.sendRedirect("trangchu");
        } else {
            LOGGER.warn("Login failed for user {}", email);
            request.getSession().setAttribute("error", "Email hoặc mật khẩu không hợp lệ.");
            response.sendRedirect("login");
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user login with secure remember-me functionality";
    }
}