/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Delivery;

import Const.Delivery;
import DAL.DeliveryDAO;
import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateDeliveryDefault", urlPatterns = {"/updatedelidefault"})
public class UpdateDeliveryDefault extends HttpServlet {

    DeliveryDAO dao = new DeliveryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateDeliveryDefault</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDeliveryDefault at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deID = request.getParameter("deID");
        User user = (User) request.getSession().getAttribute("user");

        // Kiểm tra user có tồn tại không
        if (user == null) {
            request.getSession().setAttribute("error", "Vui lòng đăng nhập để thực hiện thao tác này!");
            response.sendRedirect("login");
            return;
        }

        try {
            int deId = Integer.parseInt(deID); // Chuyển deID thành int
            // Lấy ID địa chỉ mặc định hiện tại
            int defaultdeID = dao.getIDDeliveryInfo(Delivery.DEFAULT_DELIVERY, user.getUserID());

            // Trường hợp chưa có địa chỉ mặc định (set lần đầu)
            if (defaultdeID <= 0) { // Giả sử DAO trả về 0 hoặc -1 khi không có địa chỉ mặc định
                if (dao.updateStatusDeliveryInfo(Delivery.DEFAULT_DELIVERY, deId)) {
                    request.getSession().setAttribute("ms", "Set địa chỉ mặc định lần đầu thành công!");
                    response.sendRedirect("deliveryinfo");
                } else {
                    request.getSession().setAttribute("error", "Lỗi set địa chỉ mặc định lần đầu!");
                    response.sendRedirect("deliveryinfo");
                }
            } else {
                // Trường hợp đã có địa chỉ mặc định, bỏ mặc định cũ và set mới
                if (dao.updateStatusDeliveryInfo(Delivery.NOT_DEFAULT_DELIVERY, defaultdeID)) {
                    if (dao.updateStatusDeliveryInfo(Delivery.DEFAULT_DELIVERY, deId)) {
                        request.getSession().setAttribute("ms", "Thay đổi địa chỉ mặc định thành công!");
                        response.sendRedirect("deliveryinfo");
                    } else {
                        request.getSession().setAttribute("error", "Lỗi set trạng thái mặc định!");
                        response.sendRedirect("deliveryinfo");
                    }
                } else {
                    request.getSession().setAttribute("error", "Lỗi bỏ set trạng thái mặc định!");
                    response.sendRedirect("deliveryinfo");
                }
            }
            String thongbao = "User cập nhật địa chỉ người nhận";
            UserDAO udao = new UserDAO();
            udao.insertLog(user.getUserID(), thongbao, thongbao);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID địa chỉ không hợp lệ!");
            response.sendRedirect("deliveryinfo");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi thay đổi địa chỉ mặc định!");
            response.sendRedirect("deliveryinfo");
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
