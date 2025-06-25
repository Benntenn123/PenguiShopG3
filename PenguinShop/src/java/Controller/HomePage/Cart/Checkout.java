/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Cart;

import Const.Delivery;
import Const.Shop;
import DAL.CartDAO;
import DAL.DeliveryDAO;
import DAL.TokenDAO;
import Models.CartSession;
import Models.DeliveryInfo;
import Models.User;
import Utils.DistanceCalculator;
import Utils.GetDateTime;
import Utils.SendMail;
import Utils.StringConvert;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "Checkout", urlPatterns = {"/checkout"})
public class Checkout extends HttpServlet {

    CartDAO cdao = new CartDAO();
    DeliveryDAO ddao = new DeliveryDAO();
    TokenDAO tdao = new TokenDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Checkout</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Checkout at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<Integer, CartSession> list = (Map<Integer, CartSession>) request.getSession().getAttribute("selectedCartItems");
        request.getSession().removeAttribute("selectedCartItems");
        Map<Integer, CartSession> cart = cdao.addInfoForCart(list);
        request.getSession().setAttribute("selectedCartItems", cart);
       
        double totalBill = 0;
        for (Map.Entry<Integer, CartSession> entry : cart.entrySet()) {
            totalBill += entry.getValue().getTotalAmount();

        }
        User user = (User) request.getSession().getAttribute("user");
        List<DeliveryInfo> deli = ddao.loadDefaultDelivery(user.getUserID());
        String defaultAddress = "";
        try {
            for (DeliveryInfo deliveryInfo : deli) {
                if (deliveryInfo.getIsDefault() == Delivery.DEFAULT_DELIVERY) {
                    defaultAddress = deliveryInfo.getAddessDetail();

                }
            }
            double distance = DistanceCalculator.getDistance(Shop.SHOP_ADDRESS, defaultAddress);
            double shipfee = DistanceCalculator.calculateShippingFee(distance);
            String dateShip = DistanceCalculator.calculateDeliveryTime(distance);
            request.getSession().setAttribute("shipfee", shipfee);
            request.setAttribute("shipfee", shipfee);
            request.setAttribute("dateShip", dateShip);
            request.setAttribute("totalBill", totalBill);
            request.setAttribute("totalBillShip", totalBill + shipfee);
        } catch (Exception e) {
        }

        Gson gson = new Gson();
        String deliJson = gson.toJson(deli);
        System.out.println(deliJson);

        request.setAttribute("deliList", deli);
        request.setAttribute("deli", deliJson);
        request.setAttribute("selectedCartItems", cart);
        request.getRequestDispatcher("HomePage/Checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("paymentMethod");
        String addressId = request.getParameter("addressId");
        String totalBill = request.getParameter("totalBill");
        String shipfee = request.getParameter("shipfee");
        Double shipfeeCheck = (Double) request.getSession().getAttribute("shipfee");
        String totalBillShip = request.getParameter("totalBillShip");
        User user = (User) request.getSession().getAttribute("user");
        System.out.println("1");
        Map<String, CartSession> map = (Map<String, CartSession>) request.getSession().getAttribute("selectedCartItems");
        if (StringConvert.isAnyFieldEmpty(method, addressId, totalBill, shipfee, totalBillShip)) {
            request.setAttribute("error", "Đã có lỗi xảy ra. Vui lòng thử lại sau!");
            response.sendRedirect("listCart");
            return;
        }
        try {
            System.out.println("2");
            if (map.size() == 0) { // check coi có bị chỉnh sửa submit form k
                request.getSession().setAttribute("error", "Hóa đơn không thể trống");
                response.sendRedirect("listCart");
                return;
            }
            System.out.println("3");
            if (!"cod".equals(method) && !"vnpay".equals(method)) {  // check coi có bị chỉnh sửa submit form k
                request.getSession().setAttribute("error", "Phương thức thanh toán không hợp lệ!");
                response.sendRedirect("listCart");
                return;
            }
            System.out.println("4");
            double totalBillCheck = 0;  // check coi có bị chỉnh sửa submit form k
            for (Map.Entry<String, CartSession> entry : map.entrySet()) {
                totalBillCheck += entry.getValue().getTotalAmount();

            }
            System.out.println("5");
            System.out.println(totalBillCheck);
            System.out.println(totalBill);
            if (totalBillCheck != Double.parseDouble(totalBill)) { // check coi có bị chỉnh sửa submit form k
                request.getSession().setAttribute("error", "Số tiền sản phẩm không khớp vui lòng thử lại!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }

            System.out.println("6");
            if (shipfeeCheck != Double.parseDouble(shipfee)) { // check coi có bị chỉnh sửa submit form k
                request.getSession().setAttribute("error", "Tiền ship không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }
            System.out.println("7");
            if (totalBillCheck + shipfeeCheck != Double.parseDouble(totalBillShip)) {  // check coi có bị chỉnh sửa submit form k
                request.getSession().setAttribute("error", "Tiền hóa đơn không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            } else {
                int deliID = Integer.parseInt(addressId);
                DeliveryInfo deli = ddao.getDeliyWithID(deliID);
                
                String otp = StringConvert.generateRandom6DigitNumber();
                List<CartSession> list = new ArrayList<>(map.values()); // tạo list cart sp còn gửi mail 
                if (tdao.saveToken(user.getUserID(), otp, GetDateTime.getCurrentTime(), 0)) {
                    SendMail.sendMailAsyncCartConfirm(user.getEmail(),
                            user.getFullName(), otp, list, shipfeeCheck, totalBillCheck + shipfeeCheck);
                    request.getSession().setAttribute("deliveryInfo", deli);
                    request.getSession().setAttribute("totalBill", totalBillCheck);
                    request.getSession().setAttribute("shipFee", shipfeeCheck);
                    request.getSession().setAttribute("totalBillShip", totalBillCheck + shipfeeCheck);
                    request.getSession().setAttribute("paymentMethod", method);
                    request.getSession().setAttribute("ms", "Gửi mã xác thực thành công. Vui lòng check email của bạn");
                    response.sendRedirect("confirm-order");
                } else {
                    request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại");
                    response.sendRedirect("checkout");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
