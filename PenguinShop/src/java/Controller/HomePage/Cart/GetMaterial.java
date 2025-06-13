/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Cart;

import DAL.ProductDao;
import Models.Color;
import Models.ProductVariant;
import Models.Size;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.Logger;


@WebServlet(name="GetMaterial", urlPatterns={"/getMaterial"})
public class GetMaterial extends HttpServlet {
    private ProductDao pdao = new ProductDao();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetMaterial</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetMaterial at " + request.getContextPath () + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String action = request.getParameter("action");
            int productId = Integer.parseInt(request.getParameter("productId"));

            switch (action) {
                case "getColors":
                    List<Color> colors = pdao.loadColorProduct(productId);
                    jsonResponse.put("status", "success");
                    jsonResponse.put("colors", colors);
                    break;

                case "getSizes":
                    List<Size> sizes = pdao.loadSizeProduct(productId);
                    jsonResponse.put("status", "success");
                    jsonResponse.put("sizes", sizes);
                    break;

                case "getVariant":
                    int colorId = Integer.parseInt(request.getParameter("colorId"));
                    int sizeId = Integer.parseInt(request.getParameter("sizeId"));
                    ProductVariant variant = pdao.loadProductVariant(productId, colorId, sizeId);
                    if (variant != null) {
                        jsonResponse.put("status", "success");
                        jsonResponse.put("variant", Map.of(
                            "variantID", variant.getVariantID(),
                            "price", variant.getPrice(),
                            "quantity", variant.getQuantity(),
                            "statuspro", variant.getStockStatus()
                        ));
                    } else {
                        jsonResponse.put("status", "error");
                        jsonResponse.put("message", "Không tìm thấy biến thể!");
                    }
                    break;

                default:
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Hành động không hợp lệ!");
            }
        } catch (NumberFormatException e) {
            jsonResponse.put("status", "invalid_input");
            jsonResponse.put("message", "Dữ liệu không hợp lệ!");
        } catch (Exception e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Lỗi hệ thống!");
            
        }
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
