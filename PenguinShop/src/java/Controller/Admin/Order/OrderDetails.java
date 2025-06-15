/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Order;

import DAL.OrderDAO;
import Models.Order;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="OrderDetails", urlPatterns={"/admin/orderDetailsAdmin"})
public class OrderDetails extends HttpServlet {
    
    OrderDAO odao = new OrderDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderDetails</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetails at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String orderID = request.getParameter("orderID");
       if(StringConvert.isEmpty(orderID)){
           request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại");
           response.sendRedirect("listOrderAdmin");
           return;
       }
       else{
           try {
               int oID = Integer.parseInt(orderID);  // chuyển thành integer
               Order o = odao.getOrderDetails(oID);
               request.setAttribute("o", o);
           } catch (Exception e) {
           }
       }
       request.getRequestDispatcher("../Admin/OrderDetailsAdmin.jsp").forward(request, response);
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
