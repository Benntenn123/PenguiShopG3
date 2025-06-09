/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Cart;

import DAL.CartDAO;
import Models.CartSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@WebServlet(name="Checkout", urlPatterns={"/checkout"})
public class Checkout extends HttpServlet {
    CartDAO cdao = new CartDAO();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Checkout</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Checkout at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Map<Integer, CartSession> list = (Map<Integer, CartSession>) request.getSession().getAttribute("selectedCartItems");
        Map<Integer, CartSession> cart = cdao.addInfoForCart(list);
        for (Map.Entry<Integer, CartSession> entry : cart.entrySet()) {
            System.out.println(entry.getKey());
            System.out.println(entry.getValue().getCart().getVariant().getProduct().getProductName());
            System.out.println(entry.getValue().getCart().getVariant().getProduct().getImageMainProduct());
            System.out.println(entry.getValue().getCart().getVariant().getVariantID());
            System.out.println(entry.getValue().getCart().getVariant().getColor().getColorName());
            System.out.println(entry.getValue().getCart().getVariant().getSize().getSizeName());
            System.out.println(entry.getValue().getQuantity());
            System.out.println(entry.getValue().getTotalAmount());
        }
        request.setAttribute("selectedCartItems", cart);
        request.getRequestDispatcher("HomePage/Checkout.jsp").forward(request, response);
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
