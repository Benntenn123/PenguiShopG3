package Controller.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "WelcomeAdmin", urlPatterns = {"/admin/welcomeAdmin"})
public class WelcomeAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("uAdmin") == null) {
            // Nếu chưa đăng nhập, chuyển hướng về trang login
            response.sendRedirect(request.getContextPath() + "/loginAdmin");
            return;
        }
        // Đã đăng nhập, forward tới trang welcome
        request.getRequestDispatcher("/Admin/Welcome.jsp").forward(request, response);
    }
}