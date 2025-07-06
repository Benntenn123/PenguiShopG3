package Controller.HomePage.Cart;

import Const.Delivery;
import Const.Shop;
import DAL.CartDAO;
import DAL.DeliveryDAO;
import DAL.TokenDAO;
import DAL.PromotionDAO;
import Models.Cart;
import Models.CartSession;
import Models.DeliveryInfo;
import Models.ProductVariant;
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
        System.out.println("DiscountType cho" + originalPrice);
        if ("PERCENTAGE".equalsIgnoreCase(discountType)) {
            discountedPrice = originalPrice * (1 - discountValue / 100);
        } else if ("FIXED".equalsIgnoreCase(discountType)) {
            System.out.println("Sản phẩm áp dụng" + originalPrice);
            discountedPrice = Math.max(0, originalPrice - discountValue);
        }
        return Math.round(discountedPrice * 100.0) / 100.0; // Làm tròn đến 2 chữ số thập phân
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

            // ✅ Clone lại cart
            Map<Integer, CartSession> newCart = new HashMap<>();
            for (Map.Entry<Integer, CartSession> entry : map.entrySet()) {
                CartSession original = entry.getValue();
                CartSession copy = new CartSession();
                Cart cart = new Cart();
                ProductVariant variant = new ProductVariant();
                
                ProductVariant originalVariant = original.getCart().getVariant();
                variant.setVariantID(originalVariant.getVariantID());
                variant.setPrice(originalVariant.getPrice());
                
                variant.setProduct(originalVariant.getProduct());                
                variant.setColor(originalVariant.getColor());
                variant.setSize(originalVariant.getSize());
                cart.setVariant(variant);
                copy.setCart(cart);
                copy.setQuantity(original.getQuantity());
                newCart.put(entry.getKey(), copy); // giữ nguyên cartID làm key
            }

            // ✅ Lấy khuyến mãi từ form
            Map<Integer, String> promotions = new HashMap<>();
            for (Map.Entry<Integer, CartSession> entry : map.entrySet()) {
                String promotionId = request.getParameter("promotion_" + entry.getValue().getCart().getVariant().getVariantID());
                if (promotionId != null && !promotionId.isEmpty()) {
                    promotions.put(entry.getValue().getCart().getVariant().getVariantID(), promotionId);
                }
            }

            // ✅ Lấy danh sách khuyến mãi từ DB
            List<Integer> variantIds = new ArrayList<>();
            for (CartSession cs : map.values()) {
                variantIds.add(cs.getCart().getVariant().getVariantID());
            }
            Map<Integer, List<Promotion>> promotionsByVariant = pdao.getPromotionsByVariantIds(variantIds);
            
            Map<Integer, String> promotionDetails = new HashMap<>();
            double totalBillCheck = 0;

            // ✅ Tính giá sau khuyến mãi và set lại giá vào newCart
            for (Map.Entry<Integer, CartSession> entry : newCart.entrySet()) {
                CartSession cartSession = entry.getValue();
                int variantId = cartSession.getCart().getVariant().getVariantID();
                double unitPrice = cartSession.getCart().getVariant().getPrice();
                int quantity = cartSession.getQuantity();
                String promotionId = promotions.get(variantId);
                
                double discountedPrice = unitPrice;
                String promotionText = "Không áp dụng khuyến mãi";
                
                if (promotionsByVariant.containsKey(variantId)) {
                    List<Promotion> promos = promotionsByVariant.get(variantId);
                    Promotion selectedPromo = promos.stream()
                            .filter(p -> String.valueOf(p.getPromotionID()).equals(promotionId))
                            .findFirst()
                            .orElse(null);
                    
                    if (selectedPromo != null) {
                        discountedPrice = calculateDiscountedPrice(unitPrice, selectedPromo);
                        promotionText = selectedPromo.getPromotionName();
                    }
                }

                // ✅ Gán giá mới vào variant
                cartSession.getCart().getVariant().setPrice(discountedPrice);
                cartSession.setTotalAmount(discountedPrice * cartSession.getQuantity());
                totalBillCheck += discountedPrice * quantity;
                promotionDetails.put(variantId, promotionText);
            }
            
            double shipfeeCheck = (Double) request.getSession().getAttribute("shipfee");
            
            if (Math.abs(totalBillCheck - Double.parseDouble(totalBill)) > 1.0) {
                request.getSession().setAttribute("error", "Tổng tiền hàng không khớp. Vui lòng thử lại!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }
            
            if (Math.abs(shipfeeCheck - Double.parseDouble(shipfee)) > 1.0) {
                request.getSession().setAttribute("error", "Phí vận chuyển không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }
            
            if (Math.abs(totalBillCheck + shipfeeCheck - Double.parseDouble(totalBillShip)) > 1.0) {
                request.getSession().setAttribute("error", "Tổng tiền thanh toán không chính xác!");
                request.getSession().removeAttribute("selectedCartItems");
                response.sendRedirect("listCart");
                return;
            }
            
            int deliID = Integer.parseInt(addressId);
            DeliveryInfo deli = ddao.getDeliyWithID(deliID);

            // ✅ Chuẩn bị mô tả khuyến mãi
            StringBuilder promotionEmailText = new StringBuilder();
            for (Map.Entry<Integer, String> entry : promotionDetails.entrySet()) {
                promotionEmailText.append("Sản phẩm (Variant ID: ").append(entry.getKey())
                        .append("): ").append(entry.getValue()).append("\n");
            }
            if (promotionEmailText.length() == 0) {
                promotionEmailText.append("Không có khuyến mãi được áp dụng.");
            }

            // ✅ Gửi OTP và lưu thông tin vào session
            String otp = StringConvert.generateRandom6DigitNumber();
            List<CartSession> list = new ArrayList<>(newCart.values());
            
            if (tdao.saveToken(user.getUserID(), otp, GetDateTime.getCurrentTime(), 0)) {
                SendMail.sendMailAsyncCartConfirm(
                        deli.getEmail(), deli.getFullName(), otp, list, shipfeeCheck, totalBillCheck + shipfeeCheck
                );
                request.getSession().setAttribute("cartDiscount", newCart);
                request.getSession().setAttribute("deliveryInfo", deli);
                request.getSession().setAttribute("totalBill", totalBillCheck);
                request.getSession().setAttribute("shipFee", shipfeeCheck);
                request.getSession().setAttribute("totalBillShip", totalBillCheck + shipfeeCheck);
                request.getSession().setAttribute("paymentMethod", method);
                request.getSession().setAttribute("promotionDetails", promotionDetails);
                request.getSession().setAttribute("selectedCartItems", newCart); // cập nhật lại giỏ hàng đã áp dụng KM
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
