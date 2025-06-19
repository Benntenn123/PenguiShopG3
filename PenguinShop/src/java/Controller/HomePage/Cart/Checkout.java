/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Cart;

import Const.Delivery;
import Const.Shop;
import DAL.CartDAO;
import DAL.DeliveryDAO;
import Models.CartSession;
import Models.DeliveryInfo;
import Models.User;
import Utils.DistanceCalculator;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@WebServlet(name = "Checkout", urlPatterns = {"/checkout"})
public class Checkout extends HttpServlet {

    CartDAO cdao = new CartDAO();
    DeliveryDAO ddao = new DeliveryDAO();

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
        Map<Integer, CartSession> cart = cdao.addInfoForCart(list);
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
