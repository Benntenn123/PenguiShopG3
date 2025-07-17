package Controller.Admin.Role;

import Models.User;
import DAL.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfileAdmin", urlPatterns = {"/admin/profile"})
public class ProfileAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        if (uAdmin == null) {
            response.sendRedirect("loginAdmin");
            return;
        }
        // Load lại thông tin mới nhất từ DB nếu muốn (tùy chọn)
        UserDAO udao = new UserDAO();
        User user = udao.getUserById(uAdmin.getUserID());
        if (user == null) user = uAdmin;
        request.setAttribute("admin", user);
        request.getRequestDispatcher("../Admin/ProfileAdmin.jsp").forward(request, response);
    }
}
