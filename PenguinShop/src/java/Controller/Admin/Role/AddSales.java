/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Role;

import APIKey.CloudinaryConfig;
import DAL.PermissionDAO;
import DAL.UserDAO;
import Models.Role;
import Models.User;
import Utils.HashPassword;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
@MultipartConfig
@WebServlet(name = "AddSales", urlPatterns = {"/admin/addSales"})
public class AddSales extends HttpServlet {

    UserDAO usersDAO = new UserDAO();
    PermissionDAO pdao = new PermissionDAO();
    public CloudinaryConfig cloudinaryService = new CloudinaryConfig();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddSales</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSales at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Role> role = pdao.getAllRole();
        request.setAttribute("roles", role);
        request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String birthdayStr = request.getParameter("birthday");
            Part imagePart = request.getPart("image_user");
            String status_account = request.getParameter("status_account");
            String roleID = request.getParameter("roleID");
            System.out.println(request.getParameter("dit"));
            System.out.println(fullName);
            System.out.println(email);
            System.out.println(phone);
            System.out.println(password);
            System.out.println(birthdayStr);
            System.out.println(status_account);
            System.out.println(roleID);

            // Kiểm tra trường bắt buộc
            if (StringConvert.isAnyFieldEmpty(fullName, email, phone, password, status_account, roleID)) {
                request.getSession().setAttribute("error", "Vui lòng nhập đầy đủ các trường bắt buộc!");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("birthday", birthdayStr);
                request.setAttribute("status_account", status_account);
                request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
                return;
            }

            // Validate
            if (usersDAO.isEmailExists(email)) {
                request.getSession().setAttribute("error", "Email đã tồn tại!");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("birthday", birthdayStr);
                request.setAttribute("status_account", status_account);
                request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
                return;
            }

            if (!phone.matches("[0-9]{10,15}")) {
                request.getSession().setAttribute("error", "Số điện thoại không hợp lệ!");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("birthday", birthdayStr);
                request.setAttribute("status_account", status_account);
                request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
                return;
            }

            // Parse birthday
            Date birthday = null;
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                try {
                    birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);
                } catch (ParseException e) {
                    request.getSession().setAttribute("error", "Ngày sinh không hợp lệ!");
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("birthday", birthdayStr);
                    request.setAttribute("status_account", status_account);
                    request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
                    return;
                }
            }

            // Upload ảnh lên Cloudinary
            String image_user = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = imagePart.getSubmittedFileName();
                image_user = cloudinaryService.uploadImage(imagePart.getInputStream(), fileName);
                if (image_user == null) {
                    request.getSession().setAttribute("error", "Lỗi khi upload ảnh!");
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("birthday", birthdayStr);
                    request.setAttribute("status_account", status_account);
                    request.getRequestDispatcher("/Admin/AddSales.jsp").forward(request, response);
                    return;
                }
            }

            // Mã hóa password
            String hashedPassword = HashPassword.hashWithSHA256(password);

            // Tạo User object
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(hashedPassword);
            user.setBirthday(birthday != null ? new java.sql.Date(birthday.getTime()) : null);
            user.setImage_user(image_user); // Lưu public_id
            user.setStatus_account(Integer.parseInt(status_account));
            user.setRoleID(Integer.parseInt(roleID));
            Role role = new Role();
            role.setRoleID(Integer.parseInt(roleID));
            user.setRole(role);

            // Thêm vào DB
            usersDAO.addSales(user);

            // Chuyển về danh sách với thông báo
            request.getSession().setAttribute("success", "Thêm Sales thành công!");
            response.sendRedirect("listSales");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
