/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products.Promotion;

import Const.Batch;
import DAL.ProductDao;
import DAL.PromotionDAO;
import Models.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name="PromotionVariant", urlPatterns={"/admin/promotionVariant"})
public class PromotionVariant extends HttpServlet {
    
    private PromotionDAO promotionDAO = new PromotionDAO();
    ProductDao pdao = new ProductDao();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PromotionVariant</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PromotionVariant at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int promotionID = Integer.parseInt(request.getParameter("promotionID"));
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = Batch.BATCH_SEARCH_PRODUCT; // Có thể cấu hình
        String[] searchCriteria = new String[] {
            request.getParameter("productName"),
            request.getParameter("colorName"),
            request.getParameter("sizeName"),
            request.getParameter("stockStatus"),
            request.getParameter("quantity"),
            request.getParameter("productTypeName"),
            request.getParameter("brandName"),
            request.getParameter("categoryName")
        };

        try {
            java.util.List<ProductVariant> variants = pdao.getProductVariants(searchCriteria, page, pageSize);
            java.util.List<Integer> variantIDs = promotionDAO.getVariantIDsByPromotion(promotionID);
            int totalPage = pdao.getTotalRecords(searchCriteria);
            request.setAttribute("variants", variants);
            request.setAttribute("variantIDs", variantIDs);
            request.setAttribute("promotionID", promotionID);
            request.setAttribute("totalPages", (int)totalPage/Batch.BATCH_SEARCH_PRODUCT +1);
            request.setAttribute("page", page);
            request.getRequestDispatcher("../Admin/AddPromotionVariants.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/promotion");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int promotionID = Integer.parseInt(request.getParameter("promotionID"));
        int variantID = Integer.parseInt(request.getParameter("variantID"));

        try {
            boolean success;
            if ("add".equals(action)) {
                success = promotionDAO.addPromotionVariant(promotionID, variantID);
            } else if ("remove".equals(action)) {
                success = promotionDAO.removePromotionVariant(promotionID, variantID);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"error\": \"Invalid action\"}");
                return;
            }

            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + success + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
