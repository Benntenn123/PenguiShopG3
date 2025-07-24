/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.checkout;

import DAL.DeliveryDAO;
import DAL.OrderDAO;
import DAL.TokenDAO;
import DAL.UserDAO;
import Models.CartSession;
import Models.DeliveryInfo;
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
import jakarta.servlet.http.HttpSession;
import java.util.Map;

@WebServlet(name = "ConfirmOrder", urlPatterns = {"/confirm-order"})
public class ConfirmOrder extends HttpServlet {

    TokenDAO tdao = new TokenDAO();
    OrderDAO odao = new OrderDAO();

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
        request.getRequestDispatcher("HomePage/ConfirmOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Map<Integer, CartSession> cartItems = (Map<Integer, CartSession>) session.getAttribute("cartDiscount");
        Double totalBill = (Double) session.getAttribute("totalBill");
        Double shipFee = (Double) session.getAttribute("shipFee");
        Double totalBillShip = (Double) session.getAttribute("totalBillShip");
        DeliveryInfo deliveryAddress = (DeliveryInfo) session.getAttribute("deliveryInfo");
        String paymentMethod = (String) session.getAttribute("paymentMethod");

        // Kiểm tra session
        if (user == null || cartItems == null || totalBill == null
                || shipFee == null || totalBillShip == null || deliveryAddress == null || paymentMethod == null) {
            session.setAttribute("error", "Phiên làm việc hết hạn. Vui lòng thử lại.");
            session.removeAttribute("selectedCartItems");
            response.sendRedirect("listCart");
            return;
        }

        // Giỏ hàng rỗng
        if (cartItems.isEmpty()) {
            session.setAttribute("error", "Giỏ hàng trống. Vui lòng chọn sản phẩm.");
            session.removeAttribute("selectedCartItems");
            response.sendRedirect("listCart");
            return;
        }

        // Lấy OTP từ DB
        String[] otpOld = tdao.loadNewestToken(user.getUserID());
        String storedOtp = otpOld[0];
        String createdAtStr = otpOld[1];
        String isUsedStr = otpOld[2];

        System.out.println("Stored OTP: " + storedOtp + ", Input OTP: " + otp + ", Created At: " + createdAtStr);

        if (storedOtp == null || storedOtp.isEmpty()) {
            session.setAttribute("error", "Không tìm thấy mã OTP. Vui lòng yêu cầu mã mới.");
            session.removeAttribute("selectedCartItems");
            response.sendRedirect("checkout");
            return;
        }

        boolean isUsed = "1".equals(isUsedStr);
        boolean isWithinThreeMinutes = createdAtStr != null && GetDateTime.isWithinThreeMinutes(createdAtStr);

        if (isUsed || !isWithinThreeMinutes) {
            session.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn.");
            response.sendRedirect("confirm-order");
            return;
        }

        if (!otp.equals(storedOtp)) {
            session.setAttribute("error", "Mã OTP không đúng. Vui lòng thử lại.");
            response.sendRedirect("confirm-order");
            return;
        }

        // ✅ OTP hợp lệ, tiếp tục xử lý đơn hàng
        try {
            tdao.markOTPAsUsed(user.getUserID(), storedOtp);

            int orderID = odao.createOrder(   // tạo order là trừ quantity luôn
                    user.getUserID(),
                    cartItems,
                    totalBill,
                    shipFee,
                    totalBillShip,
                    deliveryAddress,
                    paymentMethod,
                    GetDateTime.getCurrentTime()
            );
            String thongbao = "User tạo thành công order với id " + orderID;
                    UserDAO udao = new UserDAO();
                    udao.insertLog(user.getUserID(), thongbao, thongbao);

            if (orderID != 0) {
                // Lưu thông tin cần hiển thị
                request.setAttribute("shippingAddress", deliveryAddress.getAddessDetail());
                request.setAttribute("paymentMethod", "cod".equals(paymentMethod) ? "Thanh toán khi nhận hàng" : "Chuyển khoản");
                request.setAttribute("totalItems", cartItems.size());
                request.setAttribute("totalAmount", totalBill);

                // Xóa session
                session.removeAttribute("selectedCartItems");
                session.removeAttribute("totalBill");
                session.removeAttribute("shipFee");
                session.removeAttribute("totalBillShip");
                session.removeAttribute("deliveryInfo");
                session.removeAttribute("paymentMethod");

                // ✅ Điều hướng theo phương thức thanh toán
                if ("cod".equals(paymentMethod)) {
                    session.setAttribute("ms", "Đặt hàng thành công!");
                    request.getRequestDispatcher("HomePage/OrderSuccess.jsp").forward(request, response);
                } else if ("vnpay".equals(paymentMethod)) {
                    int total = totalBillShip.intValue(); // hoặc (int) Math.floor(totalBill)
                    response.sendRedirect("vnpay?orderID=" + orderID +"&amount="+total);  // chỉ truyền đc int k hàm bên vnpay chuyển số lỗi
                } else {
                    request.getSession().setAttribute("error", "Vui lòng chọn 1 cổng thanh toán");
                    response.sendRedirect("payment-gateway?orderID=" + orderID); // fallback cho các phương thức khác
                }

            } else {
                session.setAttribute("error", "Lỗi khi lưu đơn hàng!");
                response.sendRedirect("checkout");
            }

        } catch (Exception e) {
            session.setAttribute("error", "Lỗi xử lý đơn hàng: " + e.getMessage());
            response.sendRedirect("checkout");
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
