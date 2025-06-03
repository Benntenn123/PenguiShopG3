package Controller.HomePage.Customer.Profile;

import APIKey.CloudinaryConfig;
import DAL.UserDAO;
import Models.User;
import Utils.StringConvert;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,     // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
@WebServlet(name = "UserProfile", urlPatterns = {"/userprofile"})
public class UserProfile extends HttpServlet {

    UserDAO udao = new UserDAO();
    private CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("HomePage/UserProfile.jsp").forward(request, response);
    }

    private User getUserData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("gmail");
        String phone = request.getParameter("telephone");
        String address = request.getParameter("addres");
        String birthdayStr = request.getParameter("birthday");
        String imageUser = request.getParameter("imageOld"); // Mặc định là ảnh cũ (public_id)
        String[] string = new String[]{fullName, email, phone, birthdayStr};

        // Kiểm tra trường trống
        if (StringConvert.isAnyFieldEmpty(string)) {
            request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin cá nhân!");
            if (!response.isCommitted()) {
                response.sendRedirect("userprofile");
                return null; // Thoát phương thức sau khi chuyển hướng
            } else {
                System.out.println("Phản hồi đã được commit, không thể chuyển hướng");
                return null; // Xử lý trường hợp lỗi
            }
        }

        Date birthday = null;
        try {
            // Phân tích ngày sinh
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);
            }

            // Ghi log để debug
            System.out.println("=== THÔNG TIN DEBUG ===");
            System.out.println("Họ tên: " + fullName);
            System.out.println("Email: " + email);
            System.out.println("Ảnh cũ: " + imageUser);

            // Xử lý upload ảnh lên Cloudinary
            Part filePart = request.getPart("input-file");
            System.out.println("FilePart: " + filePart);

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                System.out.println("Tên file gốc: " + fileName);

                // Kiểm tra định dạng file
                if (fileName != null && isImageFile(fileName)) {
                    InputStream imageStream = filePart.getInputStream();
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    System.out.println("Tên file duy nhất: " + uniqueFileName);

                    // Upload ảnh lên Cloudinary
                    String publicId = cloudinaryConfig.uploadImage(imageStream, uniqueFileName);
                    System.out.println("Kết quả upload publicId: " + publicId);

                    if (publicId != null && !publicId.trim().isEmpty()) {
                        imageUser = publicId; // Cập nhật ảnh mới
                        System.out.println("Ảnh được cập nhật thành: " + imageUser);
                    } else {
                        System.out.println("Upload thất bại, giữ ảnh cũ: " + imageUser);
                    }
                    imageStream.close();
                } else {
                    System.out.println("Định dạng file không hợp lệ: " + fileName);
                    request.getSession().setAttribute("error", "Định dạng file không hợp lệ!");
                    if (!response.isCommitted()) {
                        response.sendRedirect("userprofile");
                        return null; // Thoát sau khi chuyển hướng
                    }
                }
            } else {
                System.out.println("Không có file được chọn hoặc file trống");
            }

        } catch (Exception e) {
            System.out.println("Lỗi trong getUserData: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra khi xử lý thông tin!");
            if (!response.isCommitted()) {
                response.sendRedirect("userprofile");
                return null; // Thoát sau khi chuyển hướng
            }
        }

        User user = (User) request.getSession().getAttribute("user");
        System.out.println("Ảnh cuối cùng: " + imageUser);

        return new User(user.getUserID(), fullName, address, birthday, phone, email, imageUser);
    }

    private boolean isImageFile(String fileName) {
        if (fileName == null) return false;
        String lowerCaseFileName = fileName.toLowerCase();
        return lowerCaseFileName.endsWith(".jpg") ||
               lowerCaseFileName.endsWith(".jpeg") ||
               lowerCaseFileName.endsWith(".png") ||
               lowerCaseFileName.endsWith(".gif") ||
               lowerCaseFileName.endsWith(".bmp") ||
               lowerCaseFileName.endsWith(".webp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = getUserData(request, response);
            if (user == null) {
                return; // Thoát nếu getUserData đã xử lý chuyển hướng
            }

            System.out.println("User to update: " + user.getImage_user());
            boolean isUpdated = udao.updateUserProfile(user);

            if (isUpdated) {
                request.getSession().setAttribute("ms", "Cập nhật hồ sơ thành công!");
                request.getSession().setAttribute("user", user); // Cập nhật lại user trong session
                if (!response.isCommitted()) {
                    response.sendRedirect("trangchu");
                } else {
                    System.out.println("Phản hồi đã được commit, không thể chuyển hướng đến trangchu");
                }
            } else {
                request.getSession().setAttribute("error", "Cập nhật không thành công!");
                if (!response.isCommitted()) {
                    response.sendRedirect("userprofile");
                } else {
                    System.out.println("Phản hồi đã được commit, không thể chuyển hướng đến userprofile");
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi trong doPost: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            if (!response.isCommitted()) {
                response.sendRedirect("userprofile");
            } else {
                System.out.println("Phản hồi đã được commit, không thể chuyển hướng đến userprofile");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}