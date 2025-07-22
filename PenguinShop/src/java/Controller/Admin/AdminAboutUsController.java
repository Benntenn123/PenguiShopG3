package Controller.Admin;

import APIKey.CloudinaryConfig;
import DAL.AboutDAO;
import Models.AboutUs;
import Models.AboutService;
import Models.CompanyStat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "AdminAboutUsController", urlPatterns = {"/admin/aboutus"})
@MultipartConfig(maxFileSize = 16177215) // 15MB
public class AdminAboutUsController extends HttpServlet {
    
    private AboutDAO aboutDAO = new AboutDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Load dữ liệu để hiển thị
            AboutUs aboutInfo = aboutDAO.getAboutInfo();
            List<AboutService> aboutServices = aboutDAO.getAboutServices();
            List<CompanyStat> companyStats = aboutDAO.getCompanyStats();
            
            // Convert publicId thành URL để hiển thị
            if (aboutInfo != null && aboutInfo.getMainImage() != null && !aboutInfo.getMainImage().trim().isEmpty()) {
                CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
                String imageUrl = cloudinaryConfig.getImageUrl(aboutInfo.getMainImage());
                aboutInfo.setMainImage(imageUrl); // Set URL thay vì publicId để hiển thị
            }
            
            // Set attributes cho JSP
            request.setAttribute("aboutInfo", aboutInfo);
            request.setAttribute("aboutServices", aboutServices);
            request.setAttribute("companyStats", companyStats);
            
            // Forward đến JSP
            request.getRequestDispatcher("/Admin/ManageAboutUs.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu");
            response.sendRedirect("aboutus");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        try {
            if ("update".equals(action)) {
                handleUpdateAboutUs(request, session);
            } else if ("addService".equals(action)) {
                handleAddService(request, session);
            } else if ("editService".equals(action)) {
                handleEditService(request, session);
            } else if ("deleteService".equals(action)) {
                handleDeleteService(request, session);
            } else if ("addStat".equals(action)) {
                handleAddStat(request, session);
            } else if ("editStat".equals(action)) {
                handleEditStat(request, session);
            } else if ("deleteStat".equals(action)) {
                handleDeleteStat(request, session);
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect("aboutus");
    }
    
    private void handleUpdateAboutUs(HttpServletRequest request, HttpSession session) {
        String title = request.getParameter("title");
        String subtitle = request.getParameter("subtitle");
        String content = request.getParameter("content");
        String highlightPoints = request.getParameter("highlightPoints");
        String videoUrl = request.getParameter("videoUrl");
        boolean isActive = "1".equals(request.getParameter("isActive"));
        
        System.out.println(title + " Địt mẹ mày");
        System.out.println(subtitle);
        System.out.println(content);
        System.out.println(highlightPoints);
        System.out.println(videoUrl);
        System.out.println(isActive);
        
        if (title == null || title.trim().isEmpty()) {
            session.setAttribute("error", "Tiêu đề không được để trống");
            return;
        }

        try {
            AboutUs aboutInfo = aboutDAO.getAboutInfo();
            if (aboutInfo != null) {
                aboutInfo.setTitle(title.trim());
                aboutInfo.setSubtitle(subtitle != null ? subtitle.trim() : "");
                aboutInfo.setContent(content != null ? content.trim() : "");
                aboutInfo.setHighlightPoints(highlightPoints != null ? highlightPoints.trim() : "");
                aboutInfo.setVideoUrl(videoUrl != null ? videoUrl.trim() : null);
                aboutInfo.setActive(isActive);
                
                // Xử lý upload ảnh
                try {
                    Part filePart = request.getPart("mainImage");
                    if (filePart != null && filePart.getSize() > 0) {
                        System.out.println("File upload detected, size: " + filePart.getSize());
                        String fileName = filePart.getSubmittedFileName();
                        
                        if (fileName != null && !fileName.trim().isEmpty()) {
                            System.out.println("Uploading file: " + fileName);
                            
                            CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
                            try (InputStream fileInputStream = filePart.getInputStream()) {
                                String publicId = cloudinaryConfig.uploadImage(fileInputStream, fileName);
                                
                                if (publicId != null) {
                                    System.out.println("Upload successful, publicId: " + publicId);
                                    aboutInfo.setMainImage(publicId); // Lưu publicId vào database
                                } else {
                                    System.out.println("Upload failed");
                                    session.setAttribute("error", "Lỗi upload ảnh");
                                    return;
                                }
                            }
                        }
                    } else {
                        System.out.println("No file uploaded or file is empty");
                    }
                } catch (Exception uploadEx) {
                    System.out.println("Upload error: " + uploadEx.getMessage());
                    uploadEx.printStackTrace();
                    session.setAttribute("error", "Lỗi upload ảnh: " + uploadEx.getMessage());
                    return;
                }

                boolean success = aboutDAO.updateAboutInfo(aboutInfo);
                if (success) {
                    session.setAttribute("success", "Cập nhật thành công!");
                } else {
                    session.setAttribute("error", "Cập nhật thất bại");
                }
            } else {
                session.setAttribute("error", "Không tìm thấy thông tin để cập nhật");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi cập nhật: " + e.getMessage());
        }
    }
    
    private void handleAddService(HttpServletRequest request, HttpSession session) {
        String serviceName = request.getParameter("serviceName");
        String serviceDescription = request.getParameter("serviceDescription");
        int displayOrder = 1;
        try {
            displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
        } catch (NumberFormatException e) {}
        
        if (serviceName == null || serviceName.trim().isEmpty()) {
            session.setAttribute("error", "Tên dịch vụ không được để trống");
            return;
        }
        
        // Check max 4 services
        List<AboutService> currentServices = aboutDAO.getAboutServices();
        if (currentServices.size() >= 4) {
            session.setAttribute("error", "Chỉ được phép tối đa 4 dịch vụ");
            return;
        }
        
        AboutService service = new AboutService(serviceName.trim(), serviceDescription.trim(), null, displayOrder, true);
        boolean success = aboutDAO.addAboutService(service);
        
        if (success) {
            session.setAttribute("success", "Thêm dịch vụ thành công!");
        } else {
            session.setAttribute("error", "Thêm dịch vụ thất bại");
        }
    }
    
    private void handleEditService(HttpServletRequest request, HttpSession session) {
        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String serviceName = request.getParameter("serviceName");
            String serviceDescription = request.getParameter("serviceDescription");
            int displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
            boolean isActive = "1".equals(request.getParameter("isActive"));
            
            if (serviceName == null || serviceName.trim().isEmpty()) {
                session.setAttribute("error", "Tên dịch vụ không được để trống");
                return;
            }
            
            AboutService service = new AboutService();
            service.setServiceID(serviceId);
            service.setServiceName(serviceName.trim());
            service.setServiceDescription(serviceDescription != null ? serviceDescription.trim() : "");
            service.setDisplayOrder(displayOrder);
            service.setActive(isActive);
            
            boolean success = aboutDAO.updateAboutService(service);
            if (success) {
                session.setAttribute("success", "Cập nhật dịch vụ thành công!");
            } else {
                session.setAttribute("error", "Cập nhật dịch vụ thất bại");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Dữ liệu không hợp lệ");
        }
    }
    
    private void handleDeleteService(HttpServletRequest request, HttpSession session) {
        try {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            boolean success = aboutDAO.deleteAboutService(serviceId);
            if (success) {
                session.setAttribute("success", "Xóa dịch vụ thành công!");
            } else {
                session.setAttribute("error", "Xóa dịch vụ thất bại");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID không hợp lệ");
        }
    }
    
    private void handleAddStat(HttpServletRequest request, HttpSession session) {
        String statName = request.getParameter("statName");
        String statValue = request.getParameter("statValue");
        String statIcon = request.getParameter("statIcon");
        int displayOrder = 1;
        try {
            displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
        } catch (NumberFormatException e) {}
        
        if (statName == null || statName.trim().isEmpty() || statValue == null || statValue.trim().isEmpty()) {
            session.setAttribute("error", "Tên và giá trị thống kê không được để trống");
            return;
        }
        
        // Check max 4 stats
        List<CompanyStat> currentStats = aboutDAO.getCompanyStats();
        if (currentStats.size() >= 4) {
            session.setAttribute("error", "Chỉ được phép tối đa 4 thống kê");
            return;
        }
        
        CompanyStat stat = new CompanyStat(statName.trim(), statValue.trim(), statIcon != null ? statIcon.trim() : null, displayOrder, true);
        boolean success = aboutDAO.addCompanyStat(stat);
        
        if (success) {
            session.setAttribute("success", "Thêm thống kê thành công!");
        } else {
            session.setAttribute("error", "Thêm thống kê thất bại");
        }
    }
    
    private void handleEditStat(HttpServletRequest request, HttpSession session) {
        try {
            int statId = Integer.parseInt(request.getParameter("statId"));
            String statName = request.getParameter("statName");
            String statValue = request.getParameter("statValue");
            String statIcon = request.getParameter("statIcon");
            int displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
            boolean isActive = "1".equals(request.getParameter("isActive"));
            
            if (statName == null || statName.trim().isEmpty() || statValue == null || statValue.trim().isEmpty()) {
                session.setAttribute("error", "Tên và giá trị thống kê không được để trống");
                return;
            }
            
            CompanyStat stat = new CompanyStat();
            stat.setStatID(statId);
            stat.setStatName(statName.trim());
            stat.setStatValue(statValue.trim());
            stat.setStatIcon(statIcon != null ? statIcon.trim() : null);
            stat.setDisplayOrder(displayOrder);
            stat.setActive(isActive);
            
            boolean success = aboutDAO.updateCompanyStat(stat);
            if (success) {
                session.setAttribute("success", "Cập nhật thống kê thành công!");
            } else {
                session.setAttribute("error", "Cập nhật thống kê thất bại");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Dữ liệu không hợp lệ");
        }
    }
    
    private void handleDeleteStat(HttpServletRequest request, HttpSession session) {
        try {
            int statId = Integer.parseInt(request.getParameter("id"));
            boolean success = aboutDAO.deleteCompanyStat(statId);
            if (success) {
                session.setAttribute("success", "Xóa thống kê thành công!");
            } else {
                session.setAttribute("error", "Xóa thống kê thất bại");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID không hợp lệ");
        }
    }
}
