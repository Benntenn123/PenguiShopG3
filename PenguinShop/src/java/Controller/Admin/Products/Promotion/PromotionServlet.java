/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products.Promotion;

import DAL.PromotionDAO;
import Models.Promotion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "Promotion", urlPatterns = {"/admin/promotion"})
public class PromotionServlet extends HttpServlet {

    private PromotionDAO promotionDAO = new PromotionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Promotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Promotion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int promotionID = Integer.parseInt(request.getParameter("promotionID"));
        int isActive = Integer.parseInt(request.getParameter("isActive"));
        System.out.println(promotionID);
        try {
            if (promotionDAO.togglePromotionStatus(promotionID, isActive)) {
                request.getSession().setAttribute("ms", "Update trạng thái thành công!");

            } else {
                request.getSession().setAttribute("error", "Update trạng thái không thành công!");
            }

        } catch (SQLException ex) {
            Logger.getLogger(PromotionServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("listPromotion");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Promotion promotion = new Promotion();
            promotion.setPromotionID(Integer.parseInt(request.getParameter("promotionID")));
            promotion.setPromotionName(request.getParameter("promotionName"));
            promotion.setDiscountType(request.getParameter("discountType"));
            promotion.setDiscountValue(Double.parseDouble(request.getParameter("discountValue")));
            promotion.setStartDate(request.getParameter("startDate"));
            promotion.setEndDate(request.getParameter("endDate"));
            promotion.setDescription(request.getParameter("description"));
            promotion.setIsActive(Integer.parseInt(request.getParameter("isActive")));// Sửa thành int
            System.out.println(promotion.toString());
            boolean updated = promotionDAO.updatePromotion(promotion);
            if (updated) {
                request.getSession().setAttribute("ms", "Cập nhật khuyến mãi thành công!");
            } else {
                request.getSession().setAttribute("error", "Cập nhật khuyến mãi thất bại!");
            }
            response.sendRedirect("listPromotion");

        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
