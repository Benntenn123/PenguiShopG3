package Controller.Admin.Blogs;

import DAL.BlogDAO;
import Models.Blog;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BlogDeleteServlet", urlPatterns = {"/admin/BlogDelete"})
public class BlogDeleteServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }
        
        String blogIdStr = request.getParameter("id");
        if (blogIdStr != null && !blogIdStr.isEmpty()) {
            try {
                int blogId = Integer.parseInt(blogIdStr);
                BlogDAO blogDAO = new BlogDAO();
                
                // Check if user has permission to delete this blog
                if (uAdmin.getRoleID() != 1) { // Not super admin
                    Blog blog = blogDAO.getBlogById(blogId);
                    if (blog == null || blog.getAuthorID() != uAdmin.getUserID()) {
                        request.getSession().setAttribute("error", "Bạn không có quyền xóa blog này!");
                        response.sendRedirect("BlogList");
                        return;
                    }
                }
                
                boolean success = blogDAO.deleteBlog(blogId);
                
                if (success) {
                    request.getSession().setAttribute("ms", "Xóa blog thành công!");
                } else {
                    request.getSession().setAttribute("error", "Xóa blog thất bại!");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID blog không hợp lệ!");
            }
        }
        response.sendRedirect("BlogList");
    }
}
