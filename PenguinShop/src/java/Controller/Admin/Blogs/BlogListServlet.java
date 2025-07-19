package Controller.Admin.Blogs;

import DAL.BlogDAO;
import Models.Blog;
import Models.User;
import APIKey.CloudinaryConfig;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BlogListServlet", urlPatterns = {"/admin/BlogList"})
public class BlogListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }

        BlogDAO blogDAO = new BlogDAO();
        
        // Pagination parameters
        String pageStr = request.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        // Search parameters
        String searchTitle = request.getParameter("searchTitle");
        String searchStatus = request.getParameter("searchStatus");
        String searchDate = request.getParameter("searchDate");
        
        // Get blogs based on role
        List<Blog> blogs;
        int totalBlogs;
        
        if (uAdmin.getRoleID() == 1) {
            // Super admin sees all blogs
            blogs = blogDAO.searchBlogs(searchTitle, searchStatus, searchDate, offset, pageSize);
            totalBlogs = blogDAO.getTotalBlogsCount(searchTitle, searchStatus, searchDate);
        } else {
            // Other users see only their blogs
            blogs = blogDAO.searchBlogsByAuthor(uAdmin.getUserID(), searchTitle, searchStatus, searchDate, offset, pageSize);
            totalBlogs = blogDAO.getTotalBlogsByAuthorCount(uAdmin.getUserID(), searchTitle, searchStatus, searchDate);
        }
        
        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);
        
        // Get statistics
        int totalActiveBlog = blogDAO.countBlogByStatus(1, uAdmin.getRoleID(), uAdmin.getUserID());
        int totalInactiveBlog = blogDAO.countBlogByStatus(0, uAdmin.getRoleID(), uAdmin.getUserID());
        int totalAllBlogs = totalActiveBlog + totalInactiveBlog;
        
        // Set attributes for JSP
        request.setAttribute("blogs", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("searchTitle", searchTitle);
        request.setAttribute("searchStatus", searchStatus);
        request.setAttribute("searchDate", searchDate);
        
        // Statistics attributes
        request.setAttribute("totalAllBlogs", totalAllBlogs);
        request.setAttribute("totalActiveBlog", totalActiveBlog);
        request.setAttribute("totalInactiveBlog", totalInactiveBlog);
        
        request.getRequestDispatcher("/Admin/BlogList.jsp").forward(request, response);
    }
}
