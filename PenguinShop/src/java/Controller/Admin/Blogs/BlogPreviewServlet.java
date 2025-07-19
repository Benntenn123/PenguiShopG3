package Controller.Admin.Blogs;

import DAL.BlogDAO;
import Models.Blog;
import Models.User;
import APIKey.CloudinaryConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BlogPreviewServlet", urlPatterns = {"/admin/BlogPreview"})
public class BlogPreviewServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("BlogList");
            return;
        }

        try {
            int blogId = Integer.parseInt(idStr);
            BlogDAO blogDAO = new BlogDAO();
            
            Blog blog = blogDAO.getBlogById(blogId);
            
            if (blog == null) {
                response.sendRedirect("BlogList");
                return;
            }
            
            // Check permission: users can only preview their own blogs unless they're super admin
            if (uAdmin.getRoleID() != 1 && blog.getAuthorID() != uAdmin.getUserID()) {
                response.sendRedirect("BlogList");
                return;
            }
            
            // Set image URL for display
            if (blog.getImage() != null && !blog.getImage().isEmpty()) {
                CloudinaryConfig cloudinary = new CloudinaryConfig();
                String imageUrl = cloudinary.getImageUrl(blog.getImage());
                blog.setImageUrl(imageUrl);
            }
            
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("/BlogPreview.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("BlogList");
        }
    }
}
