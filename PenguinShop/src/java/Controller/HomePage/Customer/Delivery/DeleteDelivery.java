/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Customer.Delivery;

import DAL.DeliveryDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name="DeleteDelivery", urlPatterns={"/deletedelivery"})
public class DeleteDelivery extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteDelivery</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteDelivery at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String deID = request.getParameter("deID");
        DeliveryDAO de = new DeliveryDAO();
        try {
            int deId = Integer.parseInt(deID);
            if(de.deleteAllDeliveryInfo(deId)){
                request.setAttribute("ms", "Xóa địa chỉ thành công");
                response.sendRedirect("deliveryinfo");
            }
            else{
                request.setAttribute("error", "Xóa địa chỉ không thành công");
                response.sendRedirect("deliveryinfo");
            }
        } catch (Exception e) {
        }
        
        
        
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
