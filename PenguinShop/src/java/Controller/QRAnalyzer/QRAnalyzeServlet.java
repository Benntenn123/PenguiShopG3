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

// ZXing imports for real QR code reading
import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;

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
                
                // Check if product actually exists in database and is available
                if (productInfo.get("available") != null && (Boolean)productInfo.get("available") && 
                    !productInfo.get("productName").toString().contains("không tồn tại") &&
                    !productInfo.get("productName").toString().contains("không đầy đủ") &&
                    !productInfo.get("productName").toString().contains("không hợp lệ") &&
                    !productInfo.get("productName").toString().contains("Lỗi hệ thống")) {
                    
                    // Product exists and is available! Return success
                    System.out.println("🎯 Valid product found - returning success: " + productInfo.get("productName"));
                    
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
                    // Product doesn't exist, out of stock, or error - continue scanning
                    System.out.println("⚠️ QR detected but product not available: " + productInfo.get("productName"));
                    System.out.println("🔄 Continue scanning for valid product...");
                    String noQRResponse = "{\"status\":\"no_qr\",\"message\":\"Sản phẩm không khả dụng - tiếp tục quét\"}";
                    out.print(noQRResponse);
                }
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
     * Analyze image for QR codes using ZXing library - the most powerful QR reader
     */
    private String analyzeImageForQR(BufferedImage image) {
        try {
            System.out.println("🔍 Analyzing image for QR code with ZXing... Size: " + image.getWidth() + "x" + image.getHeight());
            
            // First try: Direct ZXing decode
            String qrData = decodeQRWithZXing(image);
            if (qrData != null && !qrData.isEmpty()) {
                System.out.println("✅ ZXing successfully decoded QR: " + qrData);
                return qrData;
            }
            
            // Second try: Enhance image then decode with ZXing
            System.out.println("🔄 First attempt failed, trying with image enhancement...");
            BufferedImage enhanced = enhanceImageForQR(image);
            qrData = decodeQRWithZXing(enhanced);
            if (qrData != null && !qrData.isEmpty()) {
                System.out.println("✅ ZXing decoded enhanced QR: " + qrData);
                return qrData;
            }
            
            // Third try: Different image preprocessing
            System.out.println("🔄 Trying with different preprocessing...");
            BufferedImage processed = preprocessImageForQR(image);
            qrData = decodeQRWithZXing(processed);
            if (qrData != null && !qrData.isEmpty()) {
                System.out.println("✅ ZXing decoded preprocessed QR: " + qrData);
                return qrData;
            }
            
            System.out.println("❌ ZXing could not decode QR from image");
            return null;
            
        } catch (Exception e) {
            System.err.println("ZXing QR detection error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Decode QR code using ZXing library
     */
    private String decodeQRWithZXing(BufferedImage image) {
        try {
            // Create luminance source from BufferedImage
            com.google.zxing.LuminanceSource source = new com.google.zxing.client.j2se.BufferedImageLuminanceSource(image);
            
            // Create binary bitmap from luminance source
            com.google.zxing.BinaryBitmap bitmap = new com.google.zxing.BinaryBitmap(new com.google.zxing.common.HybridBinarizer(source));
            
            // Set up decoding hints for better QR detection
            Map<com.google.zxing.DecodeHintType, Object> hints = new HashMap<>();
            hints.put(com.google.zxing.DecodeHintType.TRY_HARDER, Boolean.TRUE);
            hints.put(com.google.zxing.DecodeHintType.POSSIBLE_FORMATS, java.util.Arrays.asList(com.google.zxing.BarcodeFormat.QR_CODE));
            hints.put(com.google.zxing.DecodeHintType.CHARACTER_SET, "UTF-8");
            
            // Decode the QR code
            com.google.zxing.MultiFormatReader reader = new com.google.zxing.MultiFormatReader();
            com.google.zxing.Result result = reader.decode(bitmap, hints);
            
            String qrText = result.getText();
            System.out.println("🎯 ZXing decoded QR text: " + qrText);
            
            return qrText;
            
        } catch (com.google.zxing.NotFoundException e) {
            // QR not found - this is normal, not an error
            return null;
        } catch (Exception e) {
            System.err.println("ZXing decode error: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Enhance image specifically for QR code reading
     */
    private BufferedImage enhanceImageForQR(BufferedImage original) {
        try {
            int width = original.getWidth();
            int height = original.getHeight();
            
            BufferedImage enhanced = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);
            
            for (int x = 0; x < width; x++) {
                for (int y = 0; y < height; y++) {
                    int rgb = original.getRGB(x, y);
                    int r = (rgb >> 16) & 0xFF;
                    int g = (rgb >> 8) & 0xFF;
                    int b = rgb & 0xFF;
                    
                    // Convert to grayscale
                    int gray = (int) (0.299 * r + 0.587 * g + 0.114 * b);
                    
                    // Apply aggressive thresholding for QR codes
                    int threshold = 128;
                    int binaryGray = gray < threshold ? 0 : 255;
                    
                    int enhancedRGB = (binaryGray << 16) | (binaryGray << 8) | binaryGray;
                    enhanced.setRGB(x, y, enhancedRGB);
                }
            }
            
            return enhanced;
            
        } catch (Exception e) {
            System.err.println("Image enhancement error: " + e.getMessage());
            return original;
        }
    }
    
    /**
     * Preprocess image with different algorithms for QR reading
     */
    private BufferedImage preprocessImageForQR(BufferedImage original) {
        try {
            int width = original.getWidth();
            int height = original.getHeight();
            
            BufferedImage processed = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);
            
            // Apply Gaussian blur first to reduce noise
            BufferedImage blurred = applyGaussianBlur(original, 1.0);
            
            for (int x = 0; x < width; x++) {
                for (int y = 0; y < height; y++) {
                    int rgb = blurred.getRGB(x, y);
                    int gray = (rgb >> 16) & 0xFF; // Red component (same as others in grayscale)
                    
                    // Adaptive thresholding
                    int localThreshold = getAdaptiveThreshold(blurred, x, y, 15);
                    int binaryValue = gray < localThreshold ? 0 : 255;
                    
                    int processedRGB = (binaryValue << 16) | (binaryValue << 8) | binaryValue;
                    processed.setRGB(x, y, processedRGB);
                }
            }
            
            return processed;
            
        } catch (Exception e) {
            System.err.println("Image preprocessing error: " + e.getMessage());
            return original;
        }
    }
    
    /**
     * Apply simple Gaussian blur to reduce noise
     */
    private BufferedImage applyGaussianBlur(BufferedImage image, double sigma) {
        int width = image.getWidth();
        int height = image.getHeight();
        BufferedImage blurred = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        
        // Simple 3x3 Gaussian kernel
        double[][] kernel = {
            {0.0625, 0.125, 0.0625},
            {0.125,  0.25,  0.125},
            {0.0625, 0.125, 0.0625}
        };
        
        for (int x = 1; x < width - 1; x++) {
            for (int y = 1; y < height - 1; y++) {
                double r = 0, g = 0, b = 0;
                
                for (int dx = -1; dx <= 1; dx++) {
                    for (int dy = -1; dy <= 1; dy++) {
                        int rgb = image.getRGB(x + dx, y + dy);
                        double weight = kernel[dx + 1][dy + 1];
                        
                        r += ((rgb >> 16) & 0xFF) * weight;
                        g += ((rgb >> 8) & 0xFF) * weight;
                        b += (rgb & 0xFF) * weight;
                    }
                }
                
                int newRGB = ((int)r << 16) | ((int)g << 8) | (int)b;
                blurred.setRGB(x, y, newRGB);
            }
        }
        
        return blurred;
    }
    
    /**
     * Get adaptive threshold for better binarization
     */
    private int getAdaptiveThreshold(BufferedImage image, int centerX, int centerY, int windowSize) {
        int sum = 0;
        int count = 0;
        
        int halfWindow = windowSize / 2;
        
        for (int dx = -halfWindow; dx <= halfWindow; dx++) {
            for (int dy = -halfWindow; dy <= halfWindow; dy++) {
                int x = centerX + dx;
                int y = centerY + dy;
                
                if (x >= 0 && x < image.getWidth() && y >= 0 && y < image.getHeight()) {
                    int rgb = image.getRGB(x, y);
                    int gray = (rgb >> 16) & 0xFF; // Red component
                    sum += gray;
                    count++;
                }
            }
        }
        
        return count > 0 ? (sum / count) - 10 : 128; // Subtract 10 for more aggressive thresholding
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
