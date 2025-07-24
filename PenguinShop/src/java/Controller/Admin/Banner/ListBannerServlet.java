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
        
        // Phân trang
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) { }
        }

        List<Banner> bannerList;
        int totalRecords = 0;
        int totalPages = 1;

        if ((bannerName != null && !bannerName.trim().isEmpty()) ||
            (bannerHref != null && !bannerHref.trim().isEmpty()) ||
            (bannerStatusStr != null && !bannerStatusStr.trim().isEmpty())) {
            Integer bannerStatus = null;
            if (bannerStatusStr != null && !bannerStatusStr.trim().isEmpty()) {
                try {
                    bannerStatus = Integer.parseInt(bannerStatusStr);
                } catch (NumberFormatException e) { }
            }
            // Cần thêm 2 hàm mới trong BannerDAO: searchBannersPaging và countBannersSearch
            bannerList = dao.searchBannersPaging(bannerName, bannerHref, bannerStatus, page, pageSize);
            totalRecords = dao.countBannersSearch(bannerName, bannerHref, bannerStatus);
        } else {
            bannerList = dao.getAllBannersPaging(page, pageSize);
            totalRecords = dao.countAllBanners();
        }
        totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Set attributes cho JSP
        request.setAttribute("bannerList", bannerList);
        request.setAttribute("bannerName", bannerName);
        request.setAttribute("bannerHref", bannerHref);
        request.setAttribute("bannerStatus", bannerStatusStr);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("../Admin/BannerList.jsp").forward(request, response);
    }
}
