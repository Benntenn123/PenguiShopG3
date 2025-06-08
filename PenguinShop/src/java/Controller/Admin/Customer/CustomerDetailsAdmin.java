/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Customer;

import DAL.UserDAO;
import Models.DeliveryInfo;
import Models.Logs;
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


@WebServlet(name="CustomerDetailsAdmin", urlPatterns={"/admin/customer_details"})
public class CustomerDetailsAdmin extends HttpServlet {
    private UserDAO udao = new UserDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerDetailsAdmin</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerDetailsAdmin at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            
            User user = udao.getUserById(userID);
            List<Logs> recentActivities = udao.getLatestLogByUserId(userID);
            List<Order> recentOrders = udao.getRecentOrdersByUserId(userID);
            List<DeliveryInfo> addresses = udao.getDeliveryAddressesByUserId(userID);
            
            request.setAttribute("customer", user);
            request.setAttribute("addresses", addresses);
            request.setAttribute("recentActivities", recentActivities);
            request.setAttribute("recentOrders", recentOrders);
        } catch (NumberFormatException e) {
            System.err.println("Invalid userID: " + request.getParameter("userID"));
            request.setAttribute("error", "Invalid user ID");
        } catch (Exception e) {
            System.err.println("Error loading customer details: " + e.getMessage());
            request.setAttribute("error", "Error loading customer details");
        }

        request.getRequestDispatcher("../Admin/CustomerDetailsAdmin.jsp").forward(request, response);
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
