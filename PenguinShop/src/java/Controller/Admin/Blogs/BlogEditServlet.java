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

@WebServlet(name = "BlogEditServlet", urlPatterns = {"/admin/BlogEdit"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class BlogEditServlet extends HttpServlet {
    private final CloudinaryConfig cloudinaryService = new CloudinaryConfig();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }
        
        String blogIdStr = request.getParameter("id");
        if (blogIdStr == null || blogIdStr.isEmpty()) {
            response.sendRedirect("BlogList");
            return;
        }
        
        try {
            int blogId = Integer.parseInt(blogIdStr);
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlogById(blogId);
            
            if (blog == null) {
                request.getSession().setAttribute("error", "Không tìm thấy blog!");
                response.sendRedirect("BlogList");
                return;
            }
            
            // Check permission
            if (uAdmin.getRoleID() != 1 && blog.getAuthorID() != uAdmin.getUserID()) {
                request.getSession().setAttribute("error", "Bạn không có quyền chỉnh sửa blog này!");
                response.sendRedirect("BlogList");
                return;
            }
            
            // Get current image URL if exists
            if (blog.getImage() != null && !blog.getImage().isEmpty()) {
                String imageUrl = cloudinaryService.getImageUrl(blog.getImage());
                request.setAttribute("currentImageUrl", imageUrl);
            }
            
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("/Admin/BlogEdit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID blog không hợp lệ!");
            response.sendRedirect("BlogList");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }
        
        String blogIdStr = request.getParameter("blogId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Part imagePart = request.getPart("image");
        
        if (blogIdStr == null || blogIdStr.isEmpty()) {
            response.sendRedirect("BlogList");
            return;
        }
        
        try {
            int blogId = Integer.parseInt(blogIdStr);
            BlogDAO blogDAO = new BlogDAO();
            Blog existingBlog = blogDAO.getBlogById(blogId);
            
            if (existingBlog == null) {
                request.getSession().setAttribute("error", "Không tìm thấy blog!");
                response.sendRedirect("BlogList");
                return;
            }
            
            // Check permission
            if (uAdmin.getRoleID() != 1 && existingBlog.getAuthorID() != uAdmin.getUserID()) {
                request.getSession().setAttribute("error", "Bạn không có quyền chỉnh sửa blog này!");
                response.sendRedirect("BlogList");
                return;
            }
            
            // Handle image upload
            String imageUrl = existingBlog.getImage(); // Keep existing image by default
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    String fileName = imagePart.getSubmittedFileName();
                    String imagePublicId = cloudinaryService.uploadImage(imagePart.getInputStream(), fileName);
                    if (imagePublicId != null) {
                        imageUrl = imagePublicId; // Update with new image
                        System.out.println("Blog image updated to Cloudinary with public_id: " + imagePublicId);
                    } else {
                        System.out.println("Failed to upload new blog image to Cloudinary, keeping existing image");
                    }
                } catch (Exception e) {
                    System.out.println("Error uploading new blog image: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            // Update blog
            Blog updatedBlog = new Blog();
            updatedBlog.setBlogID(blogId);
            updatedBlog.setTitle(title);
            updatedBlog.setContent(content);
            updatedBlog.setImage(imageUrl);
            updatedBlog.setUpdated_at(new Date());
            updatedBlog.setAuthorID(existingBlog.getAuthorID()); // Keep original author
            updatedBlog.setStatus(existingBlog.getStatus()); // Keep original status
            
            boolean success = blogDAO.updateBlog(updatedBlog);
            
            if (success) {
                request.getSession().setAttribute("ms", "Cập nhật blog thành công!");
                response.sendRedirect("BlogEdit?id=" + blogId);
            } else {
                request.getSession().setAttribute("error", "Cập nhật blog thất bại!");
                response.sendRedirect("BlogEdit?id=" + blogId);
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID blog không hợp lệ!");
            response.sendRedirect("BlogList");
        }
    }
}
