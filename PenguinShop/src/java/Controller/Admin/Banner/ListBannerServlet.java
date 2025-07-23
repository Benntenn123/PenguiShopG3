package Controller.Admin.Banner;

import DAL.BannerDAO;
import Models.Banner;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListBannerServlet", urlPatterns = {"/admin/listBanner"})
public class ListBannerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        BannerDAO dao = new BannerDAO();
        
        // Lấy tham số search từ request
        String bannerName = request.getParameter("bannerName");
        String bannerHref = request.getParameter("bannerHref");
        String bannerStatusStr = request.getParameter("bannerStatus");
        
        List<Banner> bannerList;
        
        // Kiểm tra nếu có tham số search thì gọi method search, không thì lấy tất cả
        if ((bannerName != null && !bannerName.trim().isEmpty()) ||
            (bannerHref != null && !bannerHref.trim().isEmpty()) ||
            (bannerStatusStr != null && !bannerStatusStr.trim().isEmpty())) {
            
            Integer bannerStatus = null;
            if (bannerStatusStr != null && !bannerStatusStr.trim().isEmpty()) {
                try {
                    bannerStatus = Integer.parseInt(bannerStatusStr);
                } catch (NumberFormatException e) {
                    // Ignore invalid status
                }
            }
            
            bannerList = dao.searchBanners(bannerName, bannerHref, bannerStatus);
        } else {
            bannerList = dao.getAllBannersList();
        }
        
        // Set attributes cho JSP
        request.setAttribute("bannerList", bannerList);
        request.setAttribute("bannerName", bannerName);
        request.setAttribute("bannerHref", bannerHref);
        request.setAttribute("bannerStatus", bannerStatusStr);
        
        request.getRequestDispatcher("../Admin/BannerList.jsp").forward(request, response);
    }
}
