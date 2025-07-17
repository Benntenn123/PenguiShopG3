/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products.Promotion;

import DAL.PromotionDAO;
import Models.Promotion;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AddPromotion", urlPatterns = {"/admin/addPromotion"})
public class AddPromotion extends HttpServlet {

    private PromotionDAO promotionDAO = new PromotionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPromotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPromotion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("../Admin/addPromotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = null;
        String[] data = getData(request);

        // Kiểm tra rỗng
        if (StringConvert.isAnyFieldEmpty(data[0], data[1], data[2], data[3], data[4], data[6])) {
            error = "Vui lòng điền đầy đủ các trường bắt buộc.";
        }

        if (error != null) {
            request.getSession().setAttribute("error", error);
            response.sendRedirect("addPromotion");
            return;
        }

        // Tạo đối tượng Promotion
        Promotion promotion = new Promotion();
        promotion.setPromotionName(data[0]);
        promotion.setDiscountType(data[1]);
        promotion.setDiscountValue(Double.parseDouble(data[2]));
        promotion.setDescription(data[5]);
        promotion.setIsActive(Integer.parseInt(data[6]));

        // Xử lý ngày và định dạng lại cho chuẩn SQL
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            Date start = inputFormat.parse(data[3]);
            Date end = inputFormat.parse(data[4]);

            if (!end.after(start)) {
                error = "Ngày kết thúc phải lớn hơn ngày bắt đầu.";
            } else {
                promotion.setStartDate(sqlFormat.format(start));
                promotion.setEndDate(sqlFormat.format(end));
            }
        } catch (Exception e) {
            error = "Định dạng ngày không hợp lệ.";
        }

        if (error != null) {
            request.getSession().setAttribute("error", error);
            response.sendRedirect("addPromotion");
            return;
        }

        // Gọi DAO thêm khuyến mãi
        try {
            if (promotionDAO.addPromotion(promotion)) {
                request.getSession().setAttribute("ms", "Thêm khuyến mãi thành công!");
                response.sendRedirect("listPromotion");
            } else {
                error = "Lỗi khi thêm khuyến mãi.";
                request.getSession().setAttribute("error", error);
                response.sendRedirect("addPromotion");
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "Lỗi cơ sở dữ liệu: " + e.getMessage();
            request.getSession().setAttribute("error", error);
            response.sendRedirect("addPromotion");
        }
    }

    private String[] getData(HttpServletRequest request) {
        String[] data = new String[7];
        data[0] = request.getParameter("promotionName");
        data[1] = request.getParameter("discountType");
        data[2] = request.getParameter("discountValue");
        data[3] = request.getParameter("startDate");
        data[4] = request.getParameter("endDate");
        data[5] = request.getParameter("description");
        data[6] = request.getParameter("isActive");

        return data;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
