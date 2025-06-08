/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Cart;

import Models.CartSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

@WebServlet(name = "AddWhist", urlPatterns = {"/addWhist"})
public class AddWhist extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddWhist</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddWhist at " + request.getContextPath() + "</h1>");
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
            int cartID = Integer.parseInt(request.getParameter("cartId"));
            String action = request.getParameter("action"); // "add" hoặc "remove"
            HttpSession session = request.getSession();
            Map<Integer, CartSession> selectedCartItems = (Map<Integer, CartSession>) session.getAttribute("selectedCartItems");

            if (selectedCartItems == null) {
                selectedCartItems = new HashMap<>();
                session.setAttribute("selectedCartItems", selectedCartItems);
            }

            if ("add".equals(action)) {
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double totalAmount = Double.parseDouble(request.getParameter("total"));
                selectedCartItems.put(cartID, new CartSession(cartID, quantity, totalAmount));
                json.put("success", true);
                json.put("message", "Đã thêm vào danh sách thanh toán!");
            } else if ("remove".equals(action)) {
                selectedCartItems.remove(cartID);
                json.put("success", true);
                json.put("message", "Đã xóa khỏi danh sách thanh toán!");
            } else {
                json.put("success", false);
                json.put("message", "Hành động không hợp lệ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", "Lỗi: " + e.getMessage());
        }

        out.print(json.toString());
        out.flush();
    }


@Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
