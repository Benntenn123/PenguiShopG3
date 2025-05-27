/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Profile;

import Controller.HomePage.Customer.Auth.Login;
import DAL.OrderDAO;
import Models.Order;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(name = "OrderHistory", urlPatterns = {"/orderhistory"})
public class OrderHistory extends HttpServlet {

    OrderDAO odao = new OrderDAO();

    private static final Logger LOGGER = LogManager.getLogger(Login.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String error = "";
        String ms = "";
        if (user == null) {
            LOGGER.warn("Hết session User");
            error = "Đã có lỗi xảy ra. Vui lòng đăng nhập lại";
            request.getSession().setAttribute("error", error);
            response.sendRedirect("trangchu");
            return;
        }

        String[] info = getData(request);

        int currentPage = convertString(info[0]);

        // get All order
        List<Order> orders = odao.getOrder(user.getUserID(), info);
        LOGGER.info("Load order user " + user.getFullName() + ": " + orders.size());

        request.setAttribute("totalPages", odao.getTotalPages(user.getUserID(), info));
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("HomePage/OrderHistory.jsp").forward(request, response);
    }

    private int convertString(String page) {
        int result = 0;
        try {
            result = Integer.parseInt(page);
        } catch (Exception e) {
        }
        return result;
    }

    private String[] getData(HttpServletRequest request) {
        String page = request.getParameter("page");
        if(page == null || page.isEmpty()){
            page = "1";
        }
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        return new String[]{page, fromDate, toDate};
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
