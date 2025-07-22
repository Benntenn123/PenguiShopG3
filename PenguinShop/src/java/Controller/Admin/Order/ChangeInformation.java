/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Order;

import Const.Delivery;
import Const.StatusOrder;
import DAL.DeliveryDAO;
import DAL.OrderDAO;
import Models.DeliveryInfo;
import Models.Order;
import Utils.ReadFile;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ChangeInformation", urlPatterns = {"/admin/changeInformationOrder"})
public class ChangeInformation extends HttpServlet {

    OrderDAO odao = new OrderDAO();
    DeliveryDAO ddao = new DeliveryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangeInformation</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeInformation at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderID = request.getParameter("orderID");
        if (StringConvert.isEmpty(orderID)) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại");
            response.sendRedirect("listOrderAdmin");
            return;
        } else {
            try {
                int oID = Integer.parseInt(orderID);  // chuyển thành integer
                Order o = odao.getOrderDetails(oID);
                request.setAttribute("o", o);
                
                List<DeliveryInfo> deli = ddao.loadDefaultDelivery(o.getUser().getUserID());
                request.setAttribute("deli", deli);

                List<String> provinces = ReadFile.loadAllProvinces(request);
                request.setAttribute("provinces", provinces);
            } catch (Exception e) {
            }
        }
        request.getRequestDispatcher("../Admin/ChangeInformationOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String data[] = getData(request);

        if (StringConvert.isEmpty(data[0])) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại!");
            response.sendRedirect("listOrderAdmin");
        } else if (StringConvert.isAnyFieldEmpty(data)) {
            request.getSession().setAttribute("error", "Chỉnh sửa hóa đơn lỗi! Vui lòng thử lại!");
            response.sendRedirect("changeInformationOrder?orderID=" + data[5]);

        } else {
            try {
                int status = Integer.parseInt(data[6]);
                
                System.out.println(status);
                if (status == StatusOrder.DANG_CHO_XU_LI || status == StatusOrder.DA_XAC_NHAN) {   // chỉ cho đổi trong th chưa ship chưa giao xong như shoppee
                    if (odao.UpdateOrder(data)) {
                        request.getSession().setAttribute("ms", "Chỉnh sửa thông tin thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Chỉnh sửa thông tin không thành công!");
                    }
                } else {
                    request.getSession().setAttribute("error", "Không thể chỉnh sửa cho trạng thái hóa đơn này!");
                }
                response.sendRedirect("changeInformationOrder?orderID=" + data[5]);

            } catch (Exception e) {
            }
        }

    }

    private String[] getData(HttpServletRequest request) {
        String orderID = request.getParameter("orderID");
        String status = request.getParameter("orderStatus");
        String name_receiver = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String oldStatus = request.getParameter("statusOld");
        return new String[]{address, email, phone, name_receiver, status, orderID,oldStatus};
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
