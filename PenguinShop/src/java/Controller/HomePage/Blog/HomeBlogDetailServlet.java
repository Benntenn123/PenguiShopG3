package Controller.HomePage.Blog;

import DAL.BlogDAO;
import Models.Blog;
import APIKey.CloudinaryConfig;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeBlogDetailServlet", urlPatterns = {"/blogDetail"})
public class HomeBlogDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("blog");
            return;
        }

        try {
            int blogId = Integer.parseInt(idStr);
            BlogDAO blogDAO = new BlogDAO();
            
            Blog blog = blogDAO.getBlogById(blogId);
            
            // Check if blog exists and is published
            if (blog == null || blog.getStatus() != 1) {
                response.sendRedirect("blog");
                return;
            }
            
            // Set image URL for display
            CloudinaryConfig cloudinary = new CloudinaryConfig();
            if (blog.getImage() != null && !blog.getImage().isEmpty()) {
                String imageUrl = cloudinary.getImageUrl(blog.getImage());
                blog.setImageUrl(imageUrl);
            }
            
            // Get related blogs based on title similarity
            List<Blog> relatedBlogs = blogDAO.getRelatedBlogs(blog.getBlogID(), blog.getTitle(), 5);
            for (Blog relatedBlog : relatedBlogs) {
                if (relatedBlog.getImage() != null && !relatedBlog.getImage().isEmpty()) {
                    String imageUrl = cloudinary.getImageUrl(relatedBlog.getImage());
                    relatedBlog.setImageUrl(imageUrl);
                }
                // Set author image URL
                if (relatedBlog.getAuthorImage() != null && !relatedBlog.getAuthorImage().isEmpty()) {
                    String authorImageUrl = cloudinary.getImageUrl(relatedBlog.getAuthorImage());
                    relatedBlog.setAuthorImage(authorImageUrl);
                }
            }
            
            request.setAttribute("blog", blog);
            request.setAttribute("relatedBlogs", relatedBlogs);
            request.getRequestDispatcher("/HomePage/BlogDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("blog");
        }
    }
}
