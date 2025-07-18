package Controller.Admin.Profile;

import DAL.UserDAO;
import Models.User;
import APIKey.CloudinaryConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

@WebServlet(name = "EditProfileAdmin", urlPatterns = {"/admin/editProfileAdmin"})
@MultipartConfig
public class EditProfileAdmin extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/EditProfileAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        try {
            User uAdmin = (User) session.getAttribute("uAdmin");
            if (uAdmin == null) {
                session.setAttribute("error", "Vui lòng đăng nhập lại!");
                response.sendRedirect("loginAdmin");
                return;
            }
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String birthdayStr = request.getParameter("birthday");
            String address = request.getParameter("address");
            String email = request.getParameter("email"); // readonly, không update

            // Lấy user cũ để lấy ảnh nếu không upload mới
            User oldUser = userDAO.getUserById(uAdmin.getUserID());
            String image_user = oldUser != null ? oldUser.getImage_user() : null;

            // Xử lý upload file ảnh nếu có
            Part filePart = request.getPart("image_user");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                try (InputStream fileContent = filePart.getInputStream()) {
                    CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
                    String uploadedPublicId = cloudinaryConfig.uploadImage(fileContent, filePart.getSubmittedFileName());
                    if (uploadedPublicId != null) {
                        image_user = uploadedPublicId;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    // Nếu upload lỗi thì giữ ảnh cũ
                }
            }

            User user = new User();
            user.setUserID(uAdmin.getUserID());
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setImage_user(image_user);
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }
            user.setEmail(email); // giữ nguyên
            user.setRoleID(uAdmin.getRoleID());
            user.setStatus_account(uAdmin.getStatus_account());

            boolean success = userDAO.updateUserProfile(user);
            if (success) {
                // Đồng bộ lại session: chỉ cập nhật các trường thay đổi, giữ lại các trường khác từ session cũ
                User sessionUser = (User) session.getAttribute("uAdmin");
                if (sessionUser != null) {
                    sessionUser.setFullName(fullName);
                    sessionUser.setPhone(phone);
                    sessionUser.setAddress(address);
                    sessionUser.setImage_user(image_user);
                    if (birthdayStr != null && !birthdayStr.isEmpty()) {
                        sessionUser.setBirthday(Date.valueOf(birthdayStr));
                    }
                    // Email, role, created_at, ... giữ nguyên
                    session.setAttribute("uAdmin", sessionUser);
                } else {
                    // Nếu không có session cũ, set user mới
                    session.setAttribute("uAdmin", user);
                }
                session.setAttribute("ms", "Cập nhật thông tin thành công!");
            } else {
                session.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại!");
            }
            response.sendRedirect("editProfileAdmin");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("editProfileAdmin");
        }
    }
}
