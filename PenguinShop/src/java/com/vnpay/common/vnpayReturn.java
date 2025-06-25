/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import Const.PaymentStatus;
import DAL.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

            // Parse vnp_OrderInfo to extract checkoutCode and orderID
            String checkoutCode = "";
            String orderID = "";
            if (vnp_OrderInfo != null && !vnp_OrderInfo.isEmpty()) {
                String[] parts = vnp_OrderInfo.split("_");
                checkoutCode = parts[0].replace("Thanh toan don hang: ", "").trim();
                orderID = parts.length > 1 ? parts[1] : "";
            }

            String status = "00".equals(vnp_ResponseCode) ? "SUCCESS" : "FAILURE";
            if ("SUCCESS".equals(status) && orderID != null) {
                // tiền vnpay trả double -> string -> chia 100 
                try {
                    double vnpAmountInDouble = Integer.parseInt(vnp_Amount) / 100.0;
                    int orderId = Integer.parseInt(orderID);
                    double orderTotal = odao.getTotalOrder(orderId);
                    if (Math.abs(orderTotal - vnpAmountInDouble) < 0.01) { // double -> so sanh 0.01
                        odao.updateOrderStatus(orderId, PaymentStatus.DA_THANH_TOAN); // Update status to COMPLETED
                    }
                } catch (Exception e) {

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
            LOGGER.log(Level.INFO, "orderID: {0}", orderID);
            LOGGER.log(Level.INFO, "status: {0}", status);

            // Set attributes for JSP
            request.setAttribute("vnp_TxnRef", vnp_TxnRef != null ? vnp_TxnRef : "N/A");
            request.setAttribute("vnp_TransactionNo", vnp_TransactionNo != null ? vnp_TransactionNo : "N/A");
            request.setAttribute("vnp_BankCode", vnp_BankCode != null ? vnp_BankCode : "N/A");
            request.setAttribute("vnp_ResponseCode", vnp_ResponseCode != null ? vnp_ResponseCode : "N/A");
            request.setAttribute("vnp_PayDate", vnp_PayDate != null ? vnp_PayDate : "N/A");
            request.setAttribute("vnp_Amount", vnp_Amount != null ? vnp_Amount : "N/A");
            request.setAttribute("vnp_OrderInfo", vnp_OrderInfo != null ? vnp_OrderInfo : "N/A");
            request.setAttribute("orderID", orderID);
            request.setAttribute("status", status);

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
