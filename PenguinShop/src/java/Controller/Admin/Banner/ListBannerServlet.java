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
        List<Banner> bannerList = dao.getAllBannersList();
        request.setAttribute("bannerList", bannerList);
        request.getRequestDispatcher("../Admin/BannerList.jsp").forward(request, response);
    }
}
