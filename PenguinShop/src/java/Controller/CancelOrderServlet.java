package Controller;

import DAL.OrderDAO;
import Const.StatusOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancelOrder"})
public class CancelOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderID");
        if (orderIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing orderID");
            return;
        }
        int orderID;
        try {
            orderID = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid orderID");
            return;
        }
        System.out.println(orderID+"hejjjj");
        OrderDAO dao = new OrderDAO();
        boolean success = dao.updateOrderStatuss(orderID, StatusOrder.CHO_HUY_DON);
        if (success) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Order cancellation requested");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Failed to update order status");
        }
    }
}
