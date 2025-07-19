package Utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import java.util.Base64;

/**
 * Utility class for generating QR codes using ZXing library
 * 
 * @author PenguinShop Team
 */
public class QRCodeGenerator {
    
    private static final int DEFAULT_SIZE = 300;
    private static final String DEFAULT_FORMAT = "PNG";

    public static String generateQRCodeBase64(String text, int size) throws WriterException, IOException {
        BufferedImage qrImage = generateQRCodeImage(text, size);
        
        // Convert BufferedImage to Base64
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(qrImage, DEFAULT_FORMAT, baos);
        byte[] imageBytes = baos.toByteArray();
        
        return Base64.getEncoder().encodeToString(imageBytes);
    }
    

    public static String generateQRCodeBase64(String text) throws WriterException, IOException {
        return generateQRCodeBase64(text, DEFAULT_SIZE);
    }

    public static BufferedImage generateQRCodeImage(String text, int size) throws WriterException {
        // Set QR code parameters
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 2);
        
        // Create QR code writer
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, size, size, hints);
        
        // Create BufferedImage
        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();
        
        // Fill background with white
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, size, size);
        
        // Draw QR code
        graphics.setColor(Color.BLACK);
        for (int x = 0; x < size; x++) {
            for (int y = 0; y < size; y++) {
                if (bitMatrix.get(x, y)) {
                    graphics.fillRect(x, y, 1, 1);
                }
            }
        }
        
        graphics.dispose();
        return image;
    }
    
    public static String createProductQRContent(int productId, int variantId, int quantity) {
        StringBuilder content = new StringBuilder();
        content.append("productID\n").append(productId);
        content.append("\nvariantID\n").append(variantId);
        content.append("\nquantity\n").append(quantity);
        return content.toString();
    }

    public static String createProductQRContent(int productId, int variantId) {
        return createProductQRContent(productId, variantId, 1);
    }
}
