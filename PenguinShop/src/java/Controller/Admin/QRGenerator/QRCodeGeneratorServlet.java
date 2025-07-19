package Controller.Admin.QRGenerator;

import DAL.ProductDao;
import Models.ProductVariant;
import Utils.SimpleQRCodeGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QRCodeGeneratorServlet", urlPatterns = {"/admin/QRCodeGenerator"})
public class QRCodeGeneratorServlet extends HttpServlet {
    
    private ProductDao productDao = new ProductDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy parameters
            String search = request.getParameter("search");
            String pageParam = request.getParameter("page");
            String pageSizeParam = request.getParameter("pageSize");
            
            // Set default values
            int page = 1;
            int pageSize = 12; // 12 sản phẩm per page
            
            // Parse page parameters
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeParam);
                    if (pageSize < 6) pageSize = 6;
                    if (pageSize > 50) pageSize = 50;
                } catch (NumberFormatException e) {
                    pageSize = 12;
                }
            }
            
            // Lấy data với search và phân trang
            List<ProductVariant> variants = productDao.getAllProductVariantsForQR(search, page, pageSize);
            int totalVariants = productDao.countProductVariantsForQR(search);
            int totalPages = (int) Math.ceil((double) totalVariants / pageSize);
            
            // Set dữ liệu cho JSP
            request.setAttribute("variants", variants);
            request.setAttribute("totalVariants", totalVariants);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("search", search);
            
            // Pagination info
            request.setAttribute("hasNext", page < totalPages);
            request.setAttribute("hasPrevious", page > 1);
            request.setAttribute("nextPage", page + 1);
            request.setAttribute("previousPage", page - 1);
            
            // Chuyển đến trang JSP
            request.getRequestDispatcher("/Admin/QRCodeGenerator.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/Admin/QRCodeGenerator.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("generateQR".equals(action)) {
            String productId = request.getParameter("productID");
            String variantId = request.getParameter("variantID");
            
            // Debug logging
            System.out.println("🔍 QR Generation Request Received:");
            System.out.println("   Product ID: " + productId);
            System.out.println("   Variant ID: " + variantId);
            System.out.println("   Action: " + action);
            
            if (productId != null && variantId != null) {
                try {
                    // Tạo nội dung QR code theo format yêu cầu
                    String qrContent = "productID\n" + productId + "\nvariantID\n" + variantId + "\nquantity\n1";
                    
                    // Tạo QR code bằng Backend và trả về Base64 image
                    String qrImageBase64 = SimpleQRCodeGenerator.generateSimpleQRBase64(qrContent);
                    
                    System.out.println("✅ QR Code generated successfully");
                    System.out.println("   Content length: " + qrContent.length());
                    System.out.println("   Base64 length: " + qrImageBase64.length());
                    
                    // Trả về JSON với QR image
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{" +
                        "\"success\": true, " +
                        "\"qrContent\": \"" + qrContent.replace("\n", "\\n") + "\", " +
                        "\"qrImage\": \"data:image/png;base64," + qrImageBase64 + "\", " +
                        "\"method\": \"backend_generation\"" +
                        "}");
                    
                } catch (Exception e) {
                    System.err.println("❌ Error generating QR code: " + e.getMessage());
                    e.printStackTrace();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"error\": \"" + 
                        e.getMessage() + "\"}");
                }
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"error\": \"Thiếu thông tin sản phẩm\"}");
            }
        } else {
            doGet(request, response);
        }
    }
}
