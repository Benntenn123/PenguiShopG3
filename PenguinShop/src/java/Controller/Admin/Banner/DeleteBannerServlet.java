package Controller.Admin.Banner;

import DAL.BannerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteBannerServlet", urlPatterns = {"/admin/deleteBanner"})
public class DeleteBannerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int bannerID = Integer.parseInt(request.getParameter("id"));
        BannerDAO dao = new BannerDAO();
        boolean success = dao.deleteBanner(bannerID);
        
        if (success) {
            request.getSession().setAttribute("ms", "Xóa banner thành công");
            response.sendRedirect("listBanner");
        } else {
            request.getSession().setAttribute("error", "Xóa banner thất bại!");
            response.sendRedirect("listBanner");
        }
    }
}
