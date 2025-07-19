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

@WebServlet(name = "HomeBlogListServlet", urlPatterns = {"/blog", "/blogs"})
public class HomeBlogListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        
        // Pagination parameters
        String pageStr = request.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 9; // 9 blogs per page for nice 3x3 grid
        int offset = (page - 1) * pageSize;
        
        // Search parameters
        String searchTitle = request.getParameter("searchTitle");
        String searchDate = request.getParameter("searchDate");
        
        // Only get published blogs (status = 1) for homepage
        String searchStatus = "1";
        
        // Get blogs with author info (only published ones)
        List<Blog> blogs = blogDAO.getBlogsWithAuthor(searchTitle, searchDate, offset, pageSize);
        int totalBlogs = blogDAO.countBlogsWithFilters(searchTitle, searchDate);
        
        // Set image URLs for display
        CloudinaryConfig cloudinary = new CloudinaryConfig();
        for (Blog blog : blogs) {
            if (blog.getImage() != null && !blog.getImage().isEmpty()) {
                String imageUrl = cloudinary.getImageUrl(blog.getImage());
                blog.setImageUrl(imageUrl);
            }
            // Set author image URL
            if (blog.getAuthorImage() != null && !blog.getAuthorImage().isEmpty()) {
                String authorImageUrl = cloudinary.getImageUrl(blog.getAuthorImage());
                blog.setAuthorImage(authorImageUrl);
            }
        }
        
        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);
        
        // Set attributes for JSP
        request.setAttribute("blogs", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("searchTitle", searchTitle);
        request.setAttribute("searchDate", searchDate);
        
        request.getRequestDispatcher("/HomePage/BlogList.jsp").forward(request, response);
    }
}
