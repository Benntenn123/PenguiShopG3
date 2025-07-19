package Controller.Admin.Blogs;

import DAL.BlogDAO;
import Models.Blog;
import Models.User;
import APIKey.CloudinaryConfig;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "BlogAddServlet", urlPatterns = {"/admin/BlogAdd"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class BlogAddServlet extends HttpServlet {
    private final CloudinaryConfig cloudinaryService = new CloudinaryConfig();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/BlogAdd.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Part imagePart = request.getPart("image");
        
        String imageUrl = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                String fileName = imagePart.getSubmittedFileName();
                // Upload ảnh lên Cloudinary và lấy public_id
                String imagePublicId = cloudinaryService.uploadImage(imagePart.getInputStream(), fileName);
                if (imagePublicId != null) {
                    // Lưu public_id để sau này có thể generate URL
                    imageUrl = imagePublicId;
                    System.out.println("Blog image uploaded to Cloudinary with public_id: " + imagePublicId);
                } else {
                    System.out.println("Failed to upload blog image to Cloudinary");
                }
            } catch (Exception e) {
                System.out.println("Error uploading blog image: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        // Lấy authorID từ session uAdmin
        HttpSession session = request.getSession();
        Models.User uAdmin = (Models.User) session.getAttribute("uAdmin");
        Integer authorID = (uAdmin != null) ? uAdmin.getUserID() : 1; // fallback
        
        Blog blog = new Blog();
        blog.setTitle(title);
        blog.setContent(content);
        blog.setImage(imageUrl); // Lưu public_id thay vì tên file
        blog.setCreated_at(new Date());
        blog.setUpdated_at(new Date());
        blog.setAuthorID(authorID);
        blog.setStatus(1);
        
        BlogDAO dao = new BlogDAO();
        boolean success = dao.insertBlog(blog);
        
        if (success) {
            request.getSession().setAttribute("ms", "Thêm blog thành công!");
            response.sendRedirect("BlogAdd");
        } else {
            request.getSession().setAttribute("error", "Thêm blog thất bại!");
            response.sendRedirect("BlogAdd");
        }
    }
}
