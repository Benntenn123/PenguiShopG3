/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products.Promotion;

import Const.Batch;
import DAL.ProductDao;
import DAL.PromotionDAO;
import Models.Promotion;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ListPromotion", urlPatterns = {"/admin/listPromotion"})
public class ListPromotion extends HttpServlet {

    ProductDao pdao = new ProductDao();
    PromotionDAO promotionDAO = new PromotionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListPromotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListPromotion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int PAGE_SIZE = Batch.BATCH_SEARCH_PRODUCT;

        // Lấy tham số trang
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Lấy tham số tìm kiếm
        String searchName = request.getParameter("searchName");
        String searchStatus = request.getParameter("searchStatus");
        String searchType = request.getParameter("searchType");

        // Tính toán phân trang và danh sách khuyến mãi
        int totalPromotions = promotionDAO.getTotalPromotions(searchName, searchStatus, searchType);
        int totalPages = (int) Math.ceil((double) totalPromotions / PAGE_SIZE);
        int startRecord = (page - 1) * PAGE_SIZE + 1;
        int endRecord = Math.min(page * PAGE_SIZE, totalPromotions);

        // Lấy danh sách khuyến mãi với bộ lọc tìm kiếm
        List<Promotion> promotions = promotionDAO.getPromotionsByPage(page, PAGE_SIZE, searchName, searchStatus, searchType);
        request.setAttribute("promotions", promotions);
        request.setAttribute("totalPromotions", totalPromotions);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startRecord", startRecord);
        request.setAttribute("endRecord", endRecord);
        request.setAttribute("totalRecords", totalPromotions);

        // Lưu các tham số tìm kiếm để hiển thị lại trên form
        request.setAttribute("searchName", searchName);
        request.setAttribute("searchStatus", searchStatus);
        request.setAttribute("searchType", searchType);

        // Chuyển danh sách promotions sang JSON
        Gson gson = new Gson();
        String promotionsJson = gson.toJson(promotions);
        request.setAttribute("promotionsJson", promotionsJson);

        request.getRequestDispatcher("../Admin/PromotionManagement.jsp").forward(request, response);
    } catch (Exception e) {
        throw new ServletException("Lỗi truy vấn cơ sở dữ liệu", e);
    }
}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
