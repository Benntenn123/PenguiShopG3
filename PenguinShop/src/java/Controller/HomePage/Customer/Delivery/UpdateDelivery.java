/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Delivery;

import DAL.DeliveryDAO;
import DAL.UserDAO;
import Models.User;
import Utils.GetDateTime;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "updateDelivery", urlPatterns = {"/updateDelivery"})
public class UpdateDelivery extends HttpServlet {

    DeliveryDAO dao = new DeliveryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updateDelivery</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateDelivery at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    private String[] getData(HttpServletRequest request) {
        String deliveryId = request.getParameter("deliveryId");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String addressDetail = request.getParameter("addressDetail");
        return new String[]{fullname, phone, email, province, district, ward, addressDetail, deliveryId};
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] info = getData(request);
        User user = (User) request.getSession().getAttribute("user");
        if (StringConvert.isAnyFieldEmpty(info)) {
            request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin!");
            response.sendRedirect("deliveryinfo");
        } else {
            int deid = 0;
            try {
                deid = Integer.parseInt(info[7]);
            } catch (Exception e) {
            }
            if (deid > 0) {
                Models.DeliveryInfo di = new Models.DeliveryInfo(deid, user,
                        info[0],
                        info[1],
                        info[2],
                        info[6] + " - " + info[5] + " - " + info[4] + " - " + info[3],
                        info[3],
                        GetDateTime.getCurrentTime(),
                        GetDateTime.getCurrentTime());
                if (dao.updateDeliveryInfo(di)) {
                    String thongbao = "User cập nhật địa chỉ người nhận";
                    UserDAO udao = new UserDAO();
                    udao.insertLog(user.getUserID(), thongbao, thongbao);
                    request.getSession().setAttribute("ms", "Thay đổi địa chỉ nhận thành công");
                    response.sendRedirect("deliveryinfo");
                } else {
                    request.getSession().setAttribute("error", "Thay địa chỉ nhận không thành công");
                    response.sendRedirect("deliveryinfo");
                }

            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
