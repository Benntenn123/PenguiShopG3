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
import DAL.PromotionDAO;
import Models.CartSession;
import Models.DeliveryInfo;
import Models.User;
import Models.Promotion;
import Utils.DistanceCalculator;
import Utils.GetDateTime;
import Utils.SendMail;
import Utils.StringConvert;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Checkout", urlPatterns = {"/checkout"})
public class Checkout extends HttpServlet {

    CartDAO cdao = new CartDAO();
    DeliveryDAO ddao = new DeliveryDAO();
    TokenDAO tdao = new TokenDAO();
    PromotionDAO pdao = new PromotionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
            e.printStackTrace();
        }

        Gson gson = new Gson();
        String deliJson = gson.toJson(deli);
        System.out.println("Delivery JSON: " + deliJson);

        request.setAttribute("deliList", deli);
        request.setAttribute("deli", deliJson);
        request.setAttribute("selectedCartItems", cart);
        request.getRequestDispatcher("HomePage/Checkout.jsp").forward(request, response);
    }

    private double calculateDiscountedPrice(double originalPrice, Promotion promotion) {
        if (promotion == null) {
            return originalPrice;
        }
        String discountType = promotion.getDiscountType();
        double discountValue = promotion.getDiscountValue();
        double discountedPrice = originalPrice;
        if ("PERCENTAGE".equalsIgnoreCase(discountType)) {
            discountedPrice = originalPrice * (1 - discountValue / 100);
        } else if ("FIXED".equalsIgnoreCase(discountType)) {
            discountedPrice = Math.max(0, originalPrice - discountValue);
        }
        return Math.round(discountedPrice);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("paymentMethod");
        String addressId = request.getParameter("addressId");
        String totalBill = request.getParameter("totalBill");
        String shipfee = request.getParameter("shipfee");
        String totalBillShip = request.getParameter("totalBillShip");
        User user = (User) request.getSession().getAttribute("user");
        Map<Integer, CartSession> map = (Map<Integer, CartSession>) request.getSession().getAttribute("selectedCartItems");

        System.out.println("Thông tin đơn hàng: Phương thức thanh toán=" + method + ", ID địa chỉ=" + addressId + 
                          ", Tổng tiền hàng=" + totalBill + ", Phí vận chuyển=" + shipfee + ", Tổng cộng=" + totalBillShip);

        if (StringConvert.isAnyFieldEmpty(method, addressId, totalBill, shipfee, totalBillShip)) {
            request.getSession().setAttribute("error", "Thông tin không đầy đủ. Vui lòng thử lại!");
            response.sendRedirect("listCart");
            return;
        }

        try {
            if (map == null || map.isEmpty()) {
                request.getSession().setAttribute("error", "Giỏ hàng trống. Vui lòng chọn sản phẩm!");
                response.sendRedirect("listCart");
                return;
            }

            if (!"cod".equals(method) && !"vnpay".equals(method)) {
                request.getSession().setAttribute("error", "Phương thức thanh toán không hợp lệ!");
                response.sendRedirect("listCart");
                return;
            }

            // Get promotion IDs from form
            Map<Integer, String> promotions = new HashMap<>();
            for (Map.Entry<Integer, CartSession> entry : map.entrySet()) {
                String promotionId = request.getParameter("promotion_" + entry.getValue().getCart().getVariant().getVariantID());
                if (promotionId != null && !promotionId.isEmpty()) {
                    promotions.put(entry.getValue().getCart().getVariant().getVariantID(), promotionId);
                }
                
            }
            System.out.println(promotions.size() + "hẹ hẹ");
            System.out.println("Các khuyến mãi được chọn từ form: " + promotions);

            // Fetch promotion data using PromotionDAO
            List<Integer> variantIds = new ArrayList<>(map.keySet());
            Map<Integer, List<Promotion>> promotionsByVariant = pdao.getPromotionsByVariantIds(variantIds);
            System.out.println("Dữ liệu khuyến mãi từ PromotionDAO: " + promotionsByVariant);
            Map<Integer, String> promotionDetails = new HashMap<>(); // Lưu mô tả khuyến mãi

            // Calculate total with promotions and build promotion details
            double totalBillCheck = 0;
            for (Map.Entry<Integer, CartSession> entry : map.entrySet()) {
                int variantId = entry.getValue().getCart().getVariant().getVariantID();
                double unitPrice = entry.getValue().getCart().getVariant().getPrice();
                int quantity = entry.getValue().getQuantity();
                String promotionId = promotions.get(variantId);
                double discountedPrice = unitPrice;
                String promotionText = "Không áp dụng khuyến mãi";
                System.out.println("Sản phẩm abc" + variantId);
                for (Map.Entry<Integer, List<Promotion>> entry1 : promotionsByVariant.entrySet()) {
                    System.out.println("Sản phẩm" + entry1.getKey());
                    System.out.println("Số lượng giảm giá" + entry1.getValue());
                    
                }
                System.out.println("Khuyến mãi được chọn là"+promotionsByVariant.size());
                System.out.println("Khuyến mãi được chọn là" + promotionId);
                
                if (promotionId != null && promotionsByVariant.containsKey(variantId)) {
                    List<Promotion> promos = promotionsByVariant.get(variantId);
                    Promotion selectedPromo = promos.stream()
                            .filter(p -> String.valueOf(p.getPromotionID()).equals(promotionId))
                            .findFirst()
                            .orElse(null);
                    if (selectedPromo != null) {
                        discountedPrice = calculateDiscountedPrice(unitPrice, selectedPromo);
                        for (Map.Entry<Integer, CartSession> entry1 : map.entrySet()) {
                            if(entry1.getValue().getCart().getVariant().getVariantID() == variantId){
                                entry1.getValue().getCart().getVariant().setPrice(discountedPrice);
                            }
                            
                        }
                    } else {
                        System.out.println("Không tìm thấy khuyến mãi với promotionId=" + promotionId + " cho variant " + variantId);
                    }
                } else {
                    System.out.println("Không áp dụng khuyến mãi cho variant " + variantId + 
                                      " (promotionId=" + promotionId + ", promos=" + promotionsByVariant.get(variantId) + ")");
                }
                totalBillCheck += discountedPrice * quantity;
                System.out.println("Sản phẩm variant " + variantId + ": Giá đơn vị=" + unitPrice + 
                                  ", Giá sau giảm=" + discountedPrice + ", Số lượng=" + quantity + 
                                  ", Tổng=" + (discountedPrice * quantity));
            }

            double shipfeeCheck = (Double) request.getSession().getAttribute("shipfee");
            if (Math.abs(totalBillCheck - Double.parseDouble(totalBill)) > 0.1) {
                System.out.println("Tổng tiền hàng không khớp: Tính toán=" + totalBillCheck + ", Nhận được=" + totalBill);
                request.getSession().setAttribute("error", "Tổng tiền hàng không khớp. Vui lòng thử lại!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }

            if (Math.abs(shipfeeCheck - Double.parseDouble(shipfee)) > 0.1) {
                System.out.println("Phí vận chuyển không khớp: Tính toán=" + shipfeeCheck + ", Nhận được=" + shipfee);
                request.getSession().setAttribute("error", "Phí vận chuyển không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }

            if (Math.abs(totalBillCheck + shipfeeCheck - Double.parseDouble(totalBillShip)) > 0.1) {
                System.out.println("Tổng tiền thanh toán không khớp: Tính toán=" + (totalBillCheck + shipfeeCheck) + 
                                  ", Nhận được=" + totalBillShip);
                request.getSession().setAttribute("error", "Tổng tiền thanh toán không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }

            int deliID = Integer.parseInt(addressId);
            DeliveryInfo deli = ddao.getDeliyWithID(deliID);

            // Prepare promotion details for email
            StringBuilder promotionEmailText = new StringBuilder();
            for (Map.Entry<Integer, String> entry : promotionDetails.entrySet()) {
                promotionEmailText.append("Sản phẩm (Variant ID: ").append(entry.getKey())
                                  .append("): ").append(entry.getValue()).append("\n");
            }
            if (promotionEmailText.length() == 0) {
                promotionEmailText.append("Không có khuyến mãi được áp dụng.");
            }

            String otp = StringConvert.generateRandom6DigitNumber();
            List<CartSession> list = new ArrayList<>(map.values());
            if (tdao.saveToken(user.getUserID(), otp, GetDateTime.getCurrentTime(), 0)) {
                // Send email with promotion details
                SendMail.sendMailAsyncCartConfirm(deli.getEmail(),
                        deli.getFullName(), otp, list, shipfeeCheck, totalBillCheck + shipfeeCheck);
                request.getSession().setAttribute("deliveryInfo", deli);
                request.getSession().setAttribute("totalBill", totalBillCheck);
                request.getSession().setAttribute("shipFee", shipfeeCheck);
                request.getSession().setAttribute("totalBillShip", totalBillCheck + shipfeeCheck);
                request.getSession().setAttribute("paymentMethod", method);
                request.getSession().setAttribute("promotionDetails", promotionDetails);
                request.getSession().setAttribute("ms", "Gửi mã xác thực thành công. Vui lòng kiểm tra email của bạn!");
                response.sendRedirect("confirm-order");
            } else {
                request.getSession().setAttribute("error", "Đã có lỗi xảy ra. Vui lòng thử lại!");
                response.sendRedirect("checkout");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra. Vui lòng thử lại!");
            response.sendRedirect("checkout");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}