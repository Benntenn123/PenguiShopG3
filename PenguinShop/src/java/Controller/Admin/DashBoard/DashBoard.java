/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.DashBoard;

import DAL.FeedbackDAO;
import DAL.OrderDAO;
import DAL.UserDAO;
import DAL.RequestDAO;
import Models.MonthValue;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Year;
import java.util.List;


@WebServlet(name="DashBoard", urlPatterns={"/admin/dashboard"})
public class DashBoard extends HttpServlet {
    
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DashBoard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashBoard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int year = Year.now().getValue();
        try {
            year = Integer.parseInt(request.getParameter("year"));
        } catch (Exception e) {}

        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        RequestDAO requestDAO = new RequestDAO();

        List<MonthValue> revenueList = orderDAO.getMonthlyRevenue(year);
        // Tổng doanh thu tháng hiện tại
        double totalRevenueThisMonth = 0;
        int currentMonth = java.time.LocalDate.now().getMonthValue();
        for (MonthValue mv : revenueList) {
            if (mv.getMonth() == currentMonth) {
                totalRevenueThisMonth = mv.getValue();
                break;
            }
        }
        List<MonthValue> orderList = orderDAO.getMonthlyOrderCount(year);
        List<MonthValue> userList = userDAO.getMonthlyNewUsers(year);
        List<MonthValue> feedbackList = feedbackDAO.getMonthlyFeedbacks(year);

        // 5 request gần nhất
        var latestRequests = requestDAO.getLatestRequests(5);
        // 5 đơn hàng gần nhất
        var latestOrders = orderDAO.getLatestOrders(5);
        // top 5 user chi nhiều tiền nhất
        var topUserSpending = orderDAO.getTopUserSpending(5);

        request.setAttribute("revenueList", revenueList);
        request.setAttribute("totalRevenueThisMonth", totalRevenueThisMonth);
        request.setAttribute("orderList", orderList);
        request.setAttribute("userList", userList);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("latestRequests", latestRequests);
        request.setAttribute("latestOrders", latestOrders);
        request.setAttribute("topUserSpending", topUserSpending);
        request.setAttribute("year", year);
        request.getRequestDispatcher("/Admin/TrangChu.jsp").forward(request, response);
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
