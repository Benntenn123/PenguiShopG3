package Controller.Admin.Role;

import DAL.PermissionDAO;
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
import java.sql.Date;
import java.io.InputStream;
import jakarta.servlet.http.Part;
import APIKey.CloudinaryConfig;
import jakarta.servlet.annotation.MultipartConfig;

@WebServlet(name = "EditSalesProfile", urlPatterns = {"/admin/editSales"})
@MultipartConfig
public class EditSalesProfile extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    PermissionDAO pdao = new PermissionDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String salesIdStr = request.getParameter("id");
            if (salesIdStr != null && !salesIdStr.isEmpty()) {
                int salesID = Integer.parseInt(salesIdStr);
                
                User sales = userDAO.getUserById(salesID);
                request.setAttribute("sales", sales);
            }
            request.setAttribute("roles", pdao.getAllRole());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể load thông tin Sales: " + e.getMessage());
        }
        request.getRequestDispatcher("/Admin/EditSales.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        try {
            String salesID = request.getParameter("salesid");
            int userID = Integer.parseInt(salesID);
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String birthdayStr = request.getParameter("birthday");
            int status_account = Integer.parseInt(request.getParameter("status_account"));
            int roleID = Integer.parseInt(request.getParameter("roleID"));
            String password = request.getParameter("password");

            // Lấy user cũ để lấy ảnh nếu không upload mới
            User oldUser = userDAO.getUserById(userID);
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
            user.setUserID(userID);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setStatus_account(status_account);
            user.setRoleID(roleID);
            user.setImage_user(image_user);
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                user.setBirthday(Date.valueOf(birthdayStr));
            }

            String updatePassword = null;
            if (password != null && !password.trim().isEmpty()) {
                updatePassword = HashPassword.hashWithSHA256(password);
            }

            boolean success = userDAO.updateSalesProfile(user, updatePassword);
            if (success) {
                session.setAttribute("ms", "Cập nhật thông tin Sales thành công!");
            } else {
                session.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại!");
            }
            response.sendRedirect("listSales");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("listSales");
        }
    }
}
