package Controller.Admin.Banner;

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

@WebServlet(name = "EditBannerServlet", urlPatterns = {"/admin/editBanner"})
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class EditBannerServlet extends HttpServlet {
    CloudinaryConfig cloud = new CloudinaryConfig();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int bannerID = Integer.parseInt(request.getParameter("id"));
        BannerDAO dao = new BannerDAO();
        Banner banner = dao.getBannerById(bannerID);
        
        if (banner != null) {
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("../Admin/EditBanner.jsp").forward(request, response);
        } else {
            response.sendRedirect("listBanner");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Parse multipart form data
        String bannerIDStr = request.getParameter("bannerID");
        String bannerName = request.getParameter("bannerName");
        String bannerHref = request.getParameter("bannerHref");
        String bannerStatusStr = request.getParameter("bannerStatus");
        String currentBannerLink = request.getParameter("currentBannerLink");
        
        // Validation
        if (bannerIDStr == null || bannerName == null || bannerHref == null || bannerStatusStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("../Admin/EditBanner.jsp").forward(request, response);
            return;
        }
        
        int bannerID = Integer.parseInt(bannerIDStr);
        int bannerStatus = Integer.parseInt(bannerStatusStr);
        String bannerLink = currentBannerLink; // Default to current image
        
        // Handle file upload if new image is selected
        Part filePart = request.getPart("bannerImageFile");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                String fileName = "banner_" + bannerID + "_" + System.currentTimeMillis() + ".jpg";
                InputStream imageStream = filePart.getInputStream();
                bannerLink = cloud.uploadImage(imageStream, fileName);
                
                
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi khi tải lên hình ảnh: " + e.getMessage());
                BannerDAO dao = new BannerDAO();
                Banner banner = dao.getBannerById(bannerID);
                request.setAttribute("banner", banner);
                request.getRequestDispatcher("../Admin/EditBanner.jsp").forward(request, response);
                return;
            }
        }
        
        Banner banner = new Banner();
        banner.setBannerID(bannerID);
        banner.setBannerName(bannerName);
        banner.setBannerHref(bannerHref);
        banner.setBannerLink(bannerLink);
        banner.setBannerStatus(bannerStatus);
        
        BannerDAO dao = new BannerDAO();
        boolean success = dao.updateBanner(banner);
        
        if (success) {
            request.getSession().setAttribute("ms", "Chỉnh sửa banner thành công");
            response.sendRedirect("listBanner");
        } else {
            request.getSession().setAttribute("error", "Cập nhật banner thất bại!");
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("../Admin/EditBanner.jsp").forward(request, response);
        }
    }
}
