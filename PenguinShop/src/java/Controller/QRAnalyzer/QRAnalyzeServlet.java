package Controller.QRAnalyzer;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import DAL.ProductDao;
import Models.ProductVariant;

@WebServlet(name = "QRAnalyzeServlet", urlPatterns = {"/qrAnalyze"})
public class QRAnalyzeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get parameters
            String imageData = request.getParameter("imageData");
            String userID = request.getParameter("userID");
            
            HttpSession session = request.getSession();
            
            if (imageData == null || imageData.isEmpty()) {
                String errorResponse = "{\"status\":\"error\",\"message\":\"No image data provided\"}";
                out.print(errorResponse);
                return;
            }
            
            // Decode base64 image
            byte[] imageBytes = Base64.getDecoder().decode(imageData);
            ByteArrayInputStream bis = new ByteArrayInputStream(imageBytes);
            BufferedImage image = ImageIO.read(bis);
            
            if (image == null) {
                String errorResponse = "{\"status\":\"error\",\"message\":\"Invalid image format\"}";
                out.print(errorResponse);
                return;
            }
            
            // TODO: Replace with actual QR detection logic
            // For now, simulate QR detection
            String qrResult = analyzeImageForQR(image);
            
            if (qrResult != null && !qrResult.isEmpty()) {
                // QR detected! Parse the data
                Map<String, String> qrData = parseQRData(qrResult);
                Map<String, Object> productInfo = getProductInfo(qrData.get("productID"), qrData.get("variantID"));
                
                // Build JSON response manually - get productID from database instead of QR
                StringBuilder json = new StringBuilder();
                json.append("{\"status\":\"success\",");
                json.append("\"qrData\":{");
                json.append("\"productID\":\"").append(productInfo.get("productID") != null ? productInfo.get("productID") : qrData.get("productID")).append("\",");
                json.append("\"variantID\":\"").append(qrData.get("variantID")).append("\",");
                json.append("\"quantity\":\"").append(qrData.get("quantity")).append("\"");
                json.append("},");
                json.append("\"productInfo\":{");
                json.append("\"productName\":\"").append(productInfo.get("productName")).append("\",");
                json.append("\"variantName\":\"").append(productInfo.get("variantName")).append("\",");
                json.append("\"price\":\"").append(productInfo.get("price")).append("\",");
                json.append("\"imageUrl\":\"").append(productInfo.get("imageUrl")).append("\"");
                json.append("}}");
                
                out.print(json.toString());
            } else {
                // No QR found
                String noQRResponse = "{\"status\":\"no_qr\",\"message\":\"No QR code detected in image\"}";
                out.print(noQRResponse);
            }
            
        } catch (Exception e) {
            System.err.println("QR Analysis error: " + e.getMessage());
            e.printStackTrace();
            
            String errorResponse = "{\"status\":\"error\",\"message\":\"Internal server error: " + e.getMessage() + "\"}";
            out.print(errorResponse);
        }
    }
    
    /**
     * Analyze image for QR codes using image processing
     * TODO: Implement actual QR detection (ZXing, OpenCV, or cloud API)
     */
    private String analyzeImageForQR(BufferedImage image) {
        try {
            /* TODO: Implement ZXing QR detection when library is properly configured
            // Use ZXing library for actual QR detection
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
            
            try {
                // Try to detect QR code
                Result result = new MultiFormatReader().decode(bitmap);
                String qrText = result.getText();
                
                // Log successful detection
                System.out.println("QR detected: " + qrText);
                return qrText;
                
            } catch (NotFoundException e) {
                // No QR code found in this image
                return null;
            }
            */
            
            // TEMPORARY: Simulate QR detection for testing (15% chance)
            if (Math.random() < 0.15) {
                // Return demo QR data with real variantID from your database
                // Format: key\nvalue\nkey\nvalue
                return "variantID\n1\nproductID\n1\nquantity\n1";  // Include productID
            }
            
            return null; // No QR detected
            
        } catch (Exception e) {
            System.err.println("QR detection error: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Parse QR data string into key-value pairs
     */
    private Map<String, String> parseQRData(String qrText) {
        Map<String, String> qrData = new HashMap<>();
        
        try {
            String[] lines = qrText.split("\n");
            for (int i = 0; i < lines.length; i += 2) {
                if (i + 1 < lines.length) {
                    String key = lines[i].trim();
                    String value = lines[i + 1].trim();
                    qrData.put(key, value);
                }
            }
        } catch (Exception e) {
            System.err.println("QR data parsing error: " + e.getMessage());
        }
        
        return qrData;
    }
    
    /**
     * Get product information from database using ProductDao
     */
    private Map<String, Object> getProductInfo(String productID, String variantID) {
        Map<String, Object> productInfo = new HashMap<>();
        
        try {
            if (variantID != null && !variantID.isEmpty()) {
                // Use ProductDao to get real product data by variantID
                ProductDao productDao = new ProductDao();
                ProductVariant variant = productDao.getProductVariantWithID(Integer.parseInt(variantID));
                
                if (variant != null) {
                    // Extract product info from variant
                    productInfo.put("productName", variant.getProduct().getProductName());
                    productInfo.put("variantName", getVariantDisplayName(variant));
                    productInfo.put("price", formatPrice(variant.getPrice()));
                    productInfo.put("imageUrl",  variant.getProduct().getImageMainProduct());
                    productInfo.put("available", variant.getQuantity() > 0);
                    productInfo.put("stock", variant.getQuantity());
                    productInfo.put("variantID", variant.getVariantID());
                    productInfo.put("productID", variant.getProduct().getProductId());
                    productInfo.put("brand", variant.getProduct().getBrand() != null ? variant.getProduct().getBrand().getBrandName() : "");
                    productInfo.put("sku", variant.getProduct().getSku());
                    productInfo.put("description", variant.getProduct().getDescription());
                    
                    System.out.println("✅ QR Product found: " + variant.getProduct().getProductName() + 
                                     " (Variant: " + variantID + ", Stock: " + variant.getQuantity() + ")");
                } else {
                    // Variant not found
                    productInfo.put("productName", "Sản phẩm không tồn tại");
                    productInfo.put("variantName", "Variant ID: " + variantID);
                    productInfo.put("price", "N/A");
                    productInfo.put("imageUrl", "./Images/default-product.jpg");
                    productInfo.put("available", false);
                    productInfo.put("stock", 0);
                    
                    System.out.println("❌ QR Variant not found: " + variantID);
                }
            } else {
                // Fallback for missing variantID
                productInfo.put("productName", "Thông tin QR không đầy đủ");
                productInfo.put("variantName", "Vui lòng quét lại mã QR");
                productInfo.put("price", "N/A");
                productInfo.put("imageUrl", "./Images/default-product.jpg");
                productInfo.put("available", false);
                productInfo.put("stock", 0);
                
                System.out.println("⚠️ QR Missing variantID");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid variantID format: " + variantID);
            productInfo.put("productName", "Mã QR không hợp lệ");
            productInfo.put("variantName", "ID sản phẩm: " + variantID);
            productInfo.put("price", "N/A");
            productInfo.put("imageUrl", "./Images/default-product.jpg");
            productInfo.put("available", false);
            productInfo.put("stock", 0);
            
        } catch (Exception e) {
            System.err.println("Database error in getProductInfo: " + e.getMessage());
            e.printStackTrace();
            
            // Return error info
            productInfo.put("productName", "Lỗi hệ thống");
            productInfo.put("variantName", "Không thể tải thông tin sản phẩm");
            productInfo.put("price", "N/A");
            productInfo.put("imageUrl", "./Images/default-product.jpg");
            productInfo.put("available", false);
            productInfo.put("stock", 0);
        }
        
        return productInfo;
    }
    
    /**
     * Create display name for product variant (Color + Size)
     */
    private String getVariantDisplayName(ProductVariant variant) {
        StringBuilder displayName = new StringBuilder();
        
        if (variant.getColor() != null && variant.getColor().getColorName() != null) {
            displayName.append(variant.getColor().getColorName());
        }
        
        if (variant.getSize() != null && variant.getSize().getSizeName() != null) {
            if (displayName.length() > 0) {
                displayName.append(" - ");
            }
            displayName.append("Size ").append(variant.getSize().getSizeName());
        }
        
        return displayName.length() > 0 ? displayName.toString() : "Phân loại mặc định";
    }
    
    /**
     * Format price to Vietnamese currency
     */
    private String formatPrice(double price) {
        return String.format("%,.0f VND", price);
    }
}
