/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Cart;

import DAL.CartDAO;
import DAL.ProductDao;
import Models.Cart;
import Models.Product;
import Models.ProductVariant;
import Models.User;
import Utils.StringConvert;
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

@WebServlet(name = "AddCart", urlPatterns = {"/addCart"})
public class AddCart extends HttpServlet {

    CartDAO cdao = new CartDAO();
    ProductDao pdao = new ProductDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCart at " + request.getContextPath() + "</h1>");
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
            // Lấy thông tin từ request
            String[] info = getInfo(request);
            int productId = Integer.parseInt(info[1]);
            int variantId = Integer.parseInt(info[2]);
            
            // Kiểm tra session user
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                message = "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!";
                status = "not_logged_in";
            } else if (productId == 0 || variantId == 0) {
                message = "Thông tin sản phẩm không hợp lệ!";
                status = "invalid_input";
            } else {
                // Kiểm tra sản phẩm/biến thể tồn tại
                if (!pdao.isValidProductAndVariant(variantId,productId)) {
                    message = "Sản phẩm hoặc biến thể không tồn tại!";
                    status = "invalid_product";
                } else {
                    // Check sản phẩm đã có trong giỏ hàng
                    if (cdao.checkExistProductInCart(user.getUserID(), variantId)) {
                        // Tăng quantity lên 1
                        if (cdao.updateQuantity(user.getUserID(), variantId)) {
                            message = "Thêm sản phẩm vào giỏ hàng thành công!";
                            status = "success";
                        } else {
                            message = "Không thể cập nhật số lượng!";
                            status = "update_failed";
                        }
                    } else {
                        // Thêm mới với quantity = 1
                        Cart cart = new Cart(user, new ProductVariant(variantId), 1, new Product(productId));
                        if (cdao.addToCart(cart)) {
                            message = "Thêm sản phẩm vào giỏ hàng thành công!";
                            status = "success";
                        } else {
                            message = "Không thể thêm sản phẩm!";
                            status = "add_failed";
                        }
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

    private String[] getInfo(HttpServletRequest request) {
        String productID = request.getParameter("productID");
        String variantID = request.getParameter("variantID");
        String quantity = request.getParameter("quantity");
        return new String[]{"", productID, variantID, quantity}; // userID không cần từ request
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
