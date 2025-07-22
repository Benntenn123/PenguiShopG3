/*
 * Click nbfs://nbhost/SystemFileSystem/Te5plates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.AboutUs;

import DAL.AboutDAO;
import DAL.BlogDAO;
import Models.AboutUs;
import Models.AboutService;
import Models.Blog;
import Models.CompanyStat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AboutUsController", urlPatterns = {"/aboutus"})
public class AboutUsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            AboutDAO aboutDAO = new AboutDAO();
            BlogDAO bdao = new BlogDAO();
            
            // Lấy thông tin About Us
            AboutUs aboutInfo = aboutDAO.getAboutInfo();
            
            // Lấy danh sách dịch vụ
            List<AboutService> aboutServices = aboutDAO.getAboutServices();
            
            // Lấy danh sách thống kê công ty
            List<CompanyStat> companyStats = aboutDAO.getCompanyStats();
            
            List<Blog> top3Blog = bdao.getTop3BlogNewest();
            
            
            // Xử lý highlight points để chuyển thành list cho JSP
            if (aboutInfo != null && aboutInfo.getHighlightPoints() != null) {
                String[] points = aboutInfo.getHighlightPoints().split("\\|");
                List<String> highlightPointsList = java.util.Arrays.asList(points);
                request.setAttribute("highlightPoints", highlightPointsList);
            }
            
            // Set attributes cho JSP
            request.setAttribute("blog", top3Blog);
            request.setAttribute("aboutInfo", aboutInfo);
            request.setAttribute("aboutServices", aboutServices);
            request.setAttribute("companyStats", companyStats);
            
            // Forward đến JSP
            request.getRequestDispatcher("HomePage/AboutUs.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in AboutUsController.doGet: " + e.getMessage());
            e.printStackTrace();
            
            // Trong trường hợp lỗi, vẫn cố gắng hiển thị trang với dữ liệu mặc định
//            request.setAttribute("aboutInfo", createDefaultAboutInfo());
            request.setAttribute("aboutServices", java.util.Collections.emptyList());
            request.setAttribute("companyStats", java.util.Collections.emptyList());
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin. Vui lòng thử lại sau.");
            
            request.getRequestDispatcher("HomePage/AboutUs.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể implement cho chức năng admin update thông tin sau
        response.sendRedirect("aboutus");
    }
    
    
}
