/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Profile;
import APIKey.CloudinaryConfig;
import DAL.UserDAO;
import Models.User;
import com.cloudinary.utils.ObjectUtils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
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
    
    private User getUserData(HttpServletRequest request) {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("gmail");
        String phone = request.getParameter("telephone");
        String address = request.getParameter("addres");
        String birthdayStr = request.getParameter("birthday");
        String imageUser = request.getParameter("imageOld"); // Default to old image (public_id)
        
        Date birthday = null;
        
        try {
            // Parse ngày sinh
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);
            }
            
            // Debug: In ra thông tin các parameters
            System.out.println("=== DEBUG INFO ===");
            System.out.println("fullName: " + fullName);
            System.out.println("email: " + email);
            System.out.println("imageOld: " + imageUser);
            
            // Xử lý upload ảnh lên Cloudinary
            Part filePart = request.getPart("input-file");
            System.out.println("FilePart: " + filePart);
            
            if (filePart != null) {
                System.out.println("File size: " + filePart.getSize());
                System.out.println("Content type: " + filePart.getContentType());
                
                if (filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    System.out.println("Original fileName: " + fileName);
                    
                    // Kiểm tra file type
                    if (fileName != null && isImageFile(fileName)) {
                        InputStream imageStream = filePart.getInputStream();
                        
                        // Tạo tên file unique để tránh trùng lặp
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        System.out.println("Unique fileName: " + uniqueFileName);
                        
                        // Upload ảnh lên Cloudinary và lấy public_id
                        String publicId = cloudinaryConfig.uploadImage(imageStream, uniqueFileName);
                        System.out.println("Upload result publicId: " + publicId);
                        
                        if (publicId != null && !publicId.trim().isEmpty()) {
                            imageUser = publicId; // Cập nhật public_id mới
                            System.out.println("Image updated to: " + imageUser);
                        } else {
                            System.out.println("Upload failed, keeping old image: " + imageUser);
                        }
                        
                        // Đóng stream
                        imageStream.close();
                    } else {
                        System.out.println("Invalid file type: " + fileName);
                    }
                } else {
                    System.out.println("No file selected or file is empty");
                }
            } else {
                System.out.println("FilePart is null");
            }
            
        } catch (Exception e) {
            System.out.println("Error in getUserData: " + e.getMessage());
            e.printStackTrace();
        }
        
        User user = (User) request.getSession().getAttribute("user");
        System.out.println("Final imageUser: " + imageUser);
        
        return new User(user.getUserID(), fullName, address, birthday, phone, email, imageUser);
    }
    
    // Helper method để kiểm tra file có phải là ảnh không
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
            User user = getUserData(request);
            System.out.println("User to update: " + user.getImage_user());
            
            boolean isUpdated = udao.updateUserProfile(user);
            
            if (isUpdated) {
                request.getSession().setAttribute("ms", "Update profile thành công!");
                request.getSession().setAttribute("user", user); // Cập nhật lại user trong session
                response.sendRedirect("trangchu");
            } else {
                request.getSession().setAttribute("error", "Update không thành công!");
                response.sendRedirect("trangchu");
            }
            
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("trangchu");
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}