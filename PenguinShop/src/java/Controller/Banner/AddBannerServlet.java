package Controller.Banner;

import APIKey.CloudinaryConfig;
import DAL.BannerDAO;
import Models.Banner;
import Utils.ImageCloud;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

@WebServlet(name = "AddBannerServlet", urlPatterns = {"/admin/addBanner"})
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddBannerServlet extends HttpServlet {
    CloudinaryConfig  cloud = new CloudinaryConfig();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("../Admin/AddBanner.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String bannerName = request.getParameter("bannerName");
        String bannerHref = request.getParameter("bannerHref");
        String bannerStatusStr = request.getParameter("bannerStatus");
        
        // Validation
        if (bannerName == null || bannerHref == null || bannerStatusStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("../Admin/AddBanner.jsp").forward(request, response);
            return;
        }
        
        int bannerStatus = Integer.parseInt(bannerStatusStr);
        String bannerLink = "";
        
        // Handle file upload
        Part filePart = request.getPart("bannerImageFile");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String fileName = "banner_" + System.currentTimeMillis() + ".jpg";
                InputStream imageStream = filePart.getInputStream();
                bannerLink = cloud.uploadImage(imageStream, fileName);
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
                request.getRequestDispatcher("../Admin/AddBanner.jsp").forward(request, response);
                return;
            }
        }
        
        Banner banner = new Banner();
        banner.setBannerName(bannerName);
        banner.setBannerHref(bannerHref);
        banner.setBannerLink(bannerLink);
        banner.setBannerStatus(bannerStatus);
        banner.setCreatedAt(new Date());
        
        BannerDAO dao = new BannerDAO();
        boolean success = dao.addBanner(banner);
        
        if (success) {
            request.getSession().setAttribute("ms", "Thêm banner thành công");
            response.sendRedirect("listBanner");
        } else {
            request.getSession().setAttribute("error", "Thêm banner thất bại!");
            request.getRequestDispatcher("../Admin/AddBanner.jsp").forward(request, response);
        }
    }
}
