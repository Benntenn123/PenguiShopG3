package Controller.Admin.ImportOrder;

import DAL.ProductDao;
import Models.Product;
import Models.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ProductSearchAPI", urlPatterns = {"/admin/api/product-search"})
public class ProductSearchAPI extends HttpServlet {
    
    private ProductDao productDao;
    
    @Override
    public void init() throws ServletException {
        productDao = new ProductDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String query = request.getParameter("q");
        int limit = 10; // Giới hạn 10 kết quả
        
        try {
            String limitParam = request.getParameter("limit");
            if (limitParam != null && !limitParam.isEmpty()) {
                limit = Integer.parseInt(limitParam);
            }
        } catch (NumberFormatException e) {
            limit = 10;
        }
        
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\"status\":\"success\",\"data\":[");
        
        try {
            if (query != null && query.trim().length() >= 1) {
                // Tìm kiếm các variant theo tên sản phẩm
                List<ProductVariant> variants = productDao.searchProductVariants(query.trim(), limit);
                
                for (int i = 0; i < variants.size(); i++) {
                    ProductVariant variant = variants.get(i);
                    if (i > 0) jsonResponse.append(",");
                    
                    jsonResponse.append("{")
                        .append("\"id\":").append(variant.getProduct().getProductId()).append(",")
                        .append("\"variantId\":").append(variant.getVariantID()).append(",")
                        .append("\"name\":\"").append(escapeJson(variant.getProduct().getProductName())).append("\",")
                        .append("\"brandName\":\"").append(variant.getProduct().getBrand() != null ? escapeJson(variant.getProduct().getBrand().getBrandName()) : "").append("\",")
                        .append("\"colorName\":\"").append(variant.getColor() != null ? escapeJson(variant.getColor().getColorName()) : "").append("\",")
                        .append("\"sizeName\":\"").append(variant.getSize() != null ? escapeJson(variant.getSize().getSizeName()) : "").append("\",")
                        .append("\"price\":").append(variant.getPrice()).append(",")
                        .append("\"quantity\":").append(variant.getQuantity()).append(",")
                        .append("\"image\":\"").append(variant.getProduct().getImageMainProduct() != null ? escapeJson(variant.getProduct().getImageMainProduct()) : "default-product.png").append("\"")
                        .append("}");
                }
            }
            
            jsonResponse.append("],\"total\":").append(limit).append("}");
            
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
            
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"error\",\"message\":\"Có lỗi xảy ra khi tìm kiếm sản phẩm\"}");
            out.flush();
        }
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
