/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author APC
 */
@WebServlet(name="vnpayReturn", urlPatterns={"/vnpayReturn"})
public class vnpayReturn extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet vnpayReturn</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet vnpayReturn at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        // Get parameters from request
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        String[] parts = vnp_OrderInfo.split("_");
        String checkoutCode = parts[0].replace("Thanh toan don hang: ", "").trim();
        String appointment_id = parts.length > 1 ? parts[1] : "";

        String status = "00".equals(vnp_ResponseCode) ? "SUCCESS" : "FAILURE";
//        List<Appointments> appointments = dao.getAppointment(appointment_id);
//        Appointments a = appointments.get(appointments.size() - 1);
//        boolean check = dao.confirmPaymentAppointment(Integer.parseInt(appointment_id), "Payed");
//        Account acc = new Account();
//        if (check) {
//            double totalBill = a.getActualCost();
//            Checkout Checkout = new Checkout(Integer.parseInt(appointment_id), "VNPay", "Completed", totalBill, vnp_TxnRef);
//            boolean isInsert = dao.insertCheckout(Checkout);
//            if (isInsert) {
//                sendMail(a);
//                try {
//                    Thread.sleep(3000);
//                } catch (InterruptedException ex) {
//                    Logger.getLogger(vnpayReturn.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//            acc = userDao.getAccountByAppointmentId(Integer.parseInt(appointment_id));
//            int account_id = acc.getAccount_id();
//            List<Rank> ranks = userDao.getAllRank();
//            double totalSpending = userDao.getAmountSpendingByCusId(account_id);
//            int rank = 0;
//            for (Rank rank1 : ranks) {
//                if (totalSpending >= rank1.getMinAmount()) {
//                    rank = rank1.getRankId();
//                }
//            }
//            boolean updateRank = userDao.updateRank(rank, account_id);

//        }
        // Forward to JSP with payment details
        request.setAttribute("vnp_TxnRef", vnp_TxnRef);
        request.setAttribute("vnp_TransactionNo", vnp_TransactionNo);
        request.setAttribute("vnp_BankCode", vnp_BankCode);
        request.setAttribute("vnp_ResponseCode", vnp_ResponseCode);
        request.setAttribute("vnp_PayDate", vnp_PayDate);
        request.setAttribute("vnp_Amount", vnp_Amount);
        request.setAttribute("vnp_OrderInfo", vnp_OrderInfo);
        request.setAttribute("appointment_id", appointment_id);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/vnpay/test.jsp").forward(request, response);
    }

//    private static void sendMail(Appointments a) {
//        Thread emailThread = new Thread(() -> {  // thread gửi mail khác luồng
//            try {
//                System.out.println("đến 3");
//                SendMail.MailConfirmPaymentAppointment(a);
//
//            } catch (Exception e) {
//                e.printStackTrace();  // Log lỗi nếu có
//            }
//        });
//        emailThread.start();
//    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
