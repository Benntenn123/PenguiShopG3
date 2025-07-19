package Controller.Admin.Sales;

import DAL.OrderDAO;
import DAL.RequestDAO;

import DAL.UserDAO;
import Models.CustomerRequest;
import Models.Order;

import Models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "SalesDashboard", urlPatterns = {"/admin/salesDashboard"})
public class SalesDashboard extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final RequestDAO requestSupportDAO = new RequestDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User sales = (User) (session != null ? session.getAttribute("uAdmin") : null);
            if (sales == null) {
                response.sendRedirect("loginAdmin");
                return;
            }

            // Số hóa đơn trong ngày
            int ordersToday = orderDAO.countOrdersToday();
            // Tổng request trong ngày
            int requestsToday = requestSupportDAO.countRequestsToday();
            // Số request đã xử lý trong ngày
            int requestsProcessedToday = requestSupportDAO.countRequestsProcessedToday();
            // Số request chưa xử lý trong ngày
            int requestsUnprocessedToday = requestSupportDAO.countRequestsUnprocessedToday();
            // Top 5 hóa đơn mới nhất
            List<Order> recentOrders = orderDAO.getLatestOrders(5);
            // Top 5 request mới nhất
            List<CustomerRequest> recentRequests = requestSupportDAO.getLatestRequests(5);

            request.setAttribute("ordersToday", ordersToday);
            request.setAttribute("requestsToday", requestsToday);
            request.setAttribute("requestsProcessedToday", requestsProcessedToday);
            request.setAttribute("requestsUnprocessedToday", requestsUnprocessedToday);
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("recentRequests", recentRequests);
            request.getRequestDispatcher("/Admin/SalesDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", e.getMessage());
            request.getRequestDispatcher("/Admin/SalesDashboard.jsp").forward(request, response);
        }
    }
}
