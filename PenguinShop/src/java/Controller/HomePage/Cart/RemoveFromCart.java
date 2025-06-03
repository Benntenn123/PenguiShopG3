/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Cart;

import DAL.CartDAO;
import Models.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


@WebServlet(name="RemoveFromCart", urlPatterns={"/removeFromCart"})
public class RemoveFromCart extends HttpServlet {
    private CartDAO cdao = new CartDAO();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RemoveFromCart</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveFromCart at " + request.getContextPath () + "</h1>");
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
        response.setCharacterEncoding("UTF-8");

        String message = "";
        String status = "";
        Gson gson = new Gson();
        Map<String, String> jsonResponse = new HashMap<>();

        try {
            // Lấy cartId từ request
            String cartIdStr = request.getParameter("cartId");
            if (cartIdStr == null || cartIdStr.trim().isEmpty()) {
                message = "Thông tin giỏ hàng không hợp lệ!";
                status = "invalid_input";
            } else {
                int cartId = Integer.parseInt(cartIdStr);

                // Kiểm tra session user
                User user = (User) request.getSession().getAttribute("user");
                if (user == null) {
                    message = "Vui lòng đăng nhập để xóa sản phẩm khỏi giỏ hàng!";
                    status = "not_logged_in";
                } else {
                    // Kiểm tra cartId thuộc về user và xóa
                    if (cdao.isValidCartItem(cartId, user.getUserID())) {
                        if (cdao.deleteCart(user.getUserID(),cartId)) {
                            message = "Xóa sản phẩm khỏi giỏ hàng thành công!";
                            status = "success";
                        } else {
                            message = "Không thể xóa sản phẩm khỏi giỏ hàng!";
                            status = "delete_failed";
                        }
                    } else {
                        message = "Sản phẩm không tồn tại trong giỏ hàng của bạn!";
                        status = "invalid_cart_item";
                    }
                }
            }
        } catch (NumberFormatException e) {
            message = "Dữ liệu không hợp lệ!";
            status = "invalid_input";
            e.printStackTrace();
        } catch (Exception e) {
            message = "Lỗi hệ thống, vui lòng thử lại!";
            status = "error";
            e.printStackTrace();
        }

        // Tạo JSON response
        jsonResponse.put("status", status);
        jsonResponse.put("message", message);
        response.getWriter().write(gson.toJson(jsonResponse));
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
