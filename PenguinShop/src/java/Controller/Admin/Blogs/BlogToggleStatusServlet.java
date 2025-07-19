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

@WebServlet(name = "BlogToggleStatusServlet", urlPatterns = {"/admin/BlogToggleStatus"})
public class BlogToggleStatusServlet extends HttpServlet {
    
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
                
                // Check if user has permission to modify this blog
                if (uAdmin.getRoleID() != 1) { // Not super admin
                    Blog blog = blogDAO.getBlogById(blogId);
                    if (blog == null || blog.getAuthorID() != uAdmin.getUserID()) {
                        request.getSession().setAttribute("error", "Bạn không có quyền chỉnh sửa blog này!");
                        response.sendRedirect("BlogList");
                        return;
                    }
                }
                
                // Get current blog to toggle status
                Blog blog = blogDAO.getBlogById(blogId);
                if (blog != null) {
                    int newStatus = (blog.getStatus() == 1) ? 0 : 1; // Toggle status
                    boolean success = blogDAO.updateBlogStatus(blogId, newStatus);
                    
                    if (success) {
                        String statusText = (newStatus == 1) ? "kích hoạt" : "vô hiệu hóa";
                        request.getSession().setAttribute("ms", "Đã " + statusText + " blog thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Cập nhật trạng thái blog thất bại!");
                    }
                } else {
                    request.getSession().setAttribute("error", "Không tìm thấy blog!");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID blog không hợp lệ!");
            }
        }
        response.sendRedirect("BlogList");
    }
}
