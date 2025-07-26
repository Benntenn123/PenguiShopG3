/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import Const.PaymentStatus;
import DAL.OrderDAO;
import Models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet to handle VNPAY payment return
 *
 * @author APC
 */
@WebServlet(name = "vnpayReturn", urlPatterns = {"/vnpayReturn"})
public class vnpayReturn extends HttpServlet {

    OrderDAO odao = new OrderDAO();
    private static final Logger LOGGER = Logger.getLogger(vnpayReturn.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from request
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
            String vnp_BankCode = request.getParameter("vnp_BankCode");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_PayDate = request.getParameter("vnp_PayDate");
            String vnp_Amount = request.getParameter("vnp_Amount");
            String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");

            // Parse vnp_OrderInfo to extract checkoutCode, orderID/userID, and transaction type
            String checkoutCode = "";
            String id = ""; // Could be orderID or userID based on type
            String transactionType = "";
            if (vnp_OrderInfo != null && !vnp_OrderInfo.isEmpty()) {
                String[] parts = vnp_OrderInfo.split("_");
                if (vnp_OrderInfo.startsWith("Thanh toan don hang")) {
                    transactionType = "thanhtoan";
                    checkoutCode = parts[0].replace("Thanh toan don hang: ", "").trim();
                    id = parts.length > 1 ? parts[1] : "";
                } else if (vnp_OrderInfo.startsWith("Nap tien tai khoan")) {
                    transactionType = "naptien";
                    checkoutCode = parts[0].replace("Nap tien tai khoan: ", "").trim();
                    id = parts.length > 1 ? parts[1] : "";
                }
            }

            String status = "00".equals(vnp_ResponseCode) ? "SUCCESS" : "FAILURE";
            if ("SUCCESS".equals(status) && !id.isEmpty()) {
                try {
                    double vnpAmountInDouble = Integer.parseInt(vnp_Amount) / 100.0; // VNPay amount is in VND * 100
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("user");

                    if ("thanhtoan".equals(transactionType)) {
                        // Handle order payment
                        int orderId = Integer.parseInt(id);
                        double orderTotal = odao.getTotalOrder(orderId);

                        boolean success = odao.updateOrderStatus(orderId, PaymentStatus.DA_THANH_TOAN);
                        if (success && user != null) {
                            user.setWallet(odao.getWalletBalance(user.getUserID()));
                            session.setAttribute("user", user);
                        }
                        LOGGER.log(Level.INFO, "Order {0} payment status updated: {1}", new Object[]{orderId, success});

                    } else if ("naptien".equals(transactionType)) {
                        // Handle wallet top-up
                        int userId = Integer.parseInt(id);

                        boolean success = odao.plusWallet(vnpAmountInDouble, userId);
                        if (success && user != null && user.getUserID() == userId) {
                            user.setWallet(odao.getWalletBalance(userId));
                            session.setAttribute("user", user);
                        }
                        LOGGER.log(Level.INFO, "Wallet top-up for user {0}: Amount={1}, Success={2}",
                                new Object[]{userId, vnpAmountInDouble, success});
                    }
                } catch (NumberFormatException e) {
                    LOGGER.log(Level.SEVERE, "Error parsing ID or amount: {0}", e.getMessage());
                    status = "FAILURE";
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error processing transaction: {0}", e.getMessage());
                    status = "FAILURE";
                }
            }

            // Log parameters for debugging
            LOGGER.log(Level.INFO, "vnp_SecureHash: {0}", vnp_SecureHash);
            LOGGER.log(Level.INFO, "vnp_TxnRef: {0}", vnp_TxnRef);
            LOGGER.log(Level.INFO, "vnp_TransactionNo: {0}", vnp_TransactionNo);
            LOGGER.log(Level.INFO, "vnp_BankCode: {0}", vnp_BankCode);
            LOGGER.log(Level.INFO, "vnp_ResponseCode: {0}", vnp_ResponseCode);
            LOGGER.log(Level.INFO, "vnp_PayDate: {0}", vnp_PayDate);
            LOGGER.log(Level.INFO, "vnp_Amount: {0}", vnp_Amount);
            LOGGER.log(Level.INFO, "vnp_OrderInfo: {0}", vnp_OrderInfo);
            LOGGER.log(Level.INFO, "checkoutCode: {0}", checkoutCode);
            LOGGER.log(Level.INFO, "id: {0}", id);
            LOGGER.log(Level.INFO, "transactionType: {0}", transactionType);
            LOGGER.log(Level.INFO, "status: {0}", status);

            // Set attributes for JSP
            request.setAttribute("vnp_TxnRef", vnp_TxnRef != null ? vnp_TxnRef : "N/A");
            request.setAttribute("vnp_TransactionNo", vnp_TransactionNo != null ? vnp_TransactionNo : "N/A");
            request.setAttribute("vnp_BankCode", vnp_BankCode != null ? vnp_BankCode : "N/A");
            request.setAttribute("vnp_ResponseCode", vnp_ResponseCode != null ? vnp_ResponseCode : "N/A");
            request.setAttribute("vnp_PayDate", vnp_PayDate != null ? vnp_PayDate : "N/A");
            request.setAttribute("vnp_Amount", vnp_Amount != null ? vnp_Amount : "N/A");
            request.setAttribute("vnp_OrderInfo", vnp_OrderInfo != null ? vnp_OrderInfo : "N/A");
            request.setAttribute("orderID", id);
            request.setAttribute("status", status);
            request.setAttribute("transactionType", transactionType);

            // Forward to JSP
            request.getRequestDispatcher("HomePage/vnpay/vnpay_info.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing VNPAY return", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing payment return");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST to GET to handle VNPAY return consistently
        response.sendRedirect(request.getContextPath() + "/vnpayReturn?" + request.getQueryString());
    }

    @Override
    public String getServletInfo() {
        return "VNPAY Payment Return Servlet";
    }
}
