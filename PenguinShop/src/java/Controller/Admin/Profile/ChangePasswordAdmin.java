package Controller.Admin.Profile;

import DAL.UserDAO;
import Models.User;
import Utils.HashPassword;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ChangePasswordAdmin", urlPatterns = {"/admin/changePasswordAdmin"})
public class ChangePasswordAdmin extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng về trang đổi mật khẩu (JSP)
        request.getRequestDispatcher("/Admin/ChangePasswordAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        try {
            User admin = (User) session.getAttribute("uAdmin");
            if (admin == null) {
                session.setAttribute("error", "Vui lòng đăng nhập lại!");
                response.sendRedirect("loginAdmin");
                return;
            }
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (oldPassword == null || newPassword == null || confirmPassword == null
                || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                response.sendRedirect("changePasswordAdmin");
                return;
            }

            // Kiểm tra mật khẩu cũ
            String hashedOld = HashPassword.hashWithSHA256(oldPassword);
            if (!userDAO.checkCorrectPassword(admin.getUserID(), hashedOld)) {
                session.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                response.sendRedirect("changePasswordAdmin");
                return;
            }
           

            // Kiểm tra xác nhận mật khẩu mới
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
                response.sendRedirect("changePasswordAdmin");
                return;
            }

            // Không cho phép trùng mật khẩu cũ
            if (oldPassword.equals(newPassword)) {
                session.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu cũ!");
                response.sendRedirect("changePasswordAdmin");
                return;
            }

            // Cập nhật mật khẩu
            String hashedNew = HashPassword.hashWithSHA256(newPassword);
            boolean success = userDAO.updatePassword(admin.getUserID(), hashedNew);
            if (success) {
                // Cập nhật lại session admin
                admin.setPassword(hashedNew);
                session.setAttribute("admin", admin);
                session.setAttribute("ms", "Đổi mật khẩu thành công!");
            } else {
                session.setAttribute("error", "Đổi mật khẩu thất bại. Vui lòng thử lại!");
            }
            response.sendRedirect("changePasswordAdmin");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("changePasswordAdmin");
        }
    }
}
