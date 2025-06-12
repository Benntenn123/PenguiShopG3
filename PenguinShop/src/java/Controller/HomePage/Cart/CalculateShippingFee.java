/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Cart;

import Const.Shop;
import DAL.DeliveryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import Utils.DistanceCalculator;

@WebServlet(name="CalculateShippingFee", urlPatterns={"/calculateShippingFee"})
public class CalculateShippingFee extends HttpServlet {
    DeliveryDAO dao = new DeliveryDAO();
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CalculateShippingFee</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CalculateShippingFee at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();

        try {
            String customerAddress = request.getParameter("addressId");
            int addID = Integer.parseInt(customerAddress);
            System.out.println(customerAddress);
            if (customerAddress == null || customerAddress.trim().isEmpty()) {
                throw new Exception("Địa chỉ không hợp lệ!");
            }

            double distance = DistanceCalculator.getDistance(Shop.SHOP_ADDRESS,dao.getDeliyFromID(addID));
            double shippingFee = DistanceCalculator.calculateShippingFee(distance);
            String timeDeli = DistanceCalculator.calculateDeliveryTime(distance);
            // Lưu phí ship vào session
            request.getSession().setAttribute("shippingFee", shippingFee);

            json.put("success", true);
            json.put("shippingFee", shippingFee);
            json.put("time", timeDeli);
            json.put("message", "Thay đổi địa chỉ thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", "Lỗi tính phí ship: " + e.getMessage());
        }

        out.print(json.toString());
        out.flush();
    
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
