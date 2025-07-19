package Utils;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import javax.imageio.ImageIO;

/**
 * Simple QR Code Generator utility 
 * Temporary implementation without ZXing - generates a placeholder QR-like image
 * 
 * @author PenguinShop Team
 */
public class SimpleQRCodeGenerator {
    
    private static final int DEFAULT_SIZE = 300;
    private static final String DEFAULT_FORMAT = "PNG";
    
    /**
     * Generate a simple placeholder QR code as Base64 string
     * This is a temporary implementation - will be replaced with ZXing
     * 
     * @param text Content to encode (will be displayed as text)
     * @param size Size of the image
     * @return Base64 encoded PNG image string
     * @throws IOException If image processing fails
     */
    public static String generateSimpleQRBase64(String text, int size) throws IOException {
        // Create a simple white image with black border and text
        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();
        
        // Fill background with white
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, size, size);
        
        // Draw black border
        graphics.setColor(Color.BLACK);
        graphics.drawRect(10, 10, size - 20, size - 20);
        graphics.drawRect(11, 11, size - 22, size - 22);
        
        // Draw some QR-like patterns
        drawQRPattern(graphics, size);
        
        // Add text info (for debugging)
        graphics.setColor(Color.BLACK);
        graphics.drawString("QR Code", size/2 - 25, size/2 - 10);
        graphics.drawString("Generated", size/2 - 30, size/2 + 10);
        
        graphics.dispose();
        
        // Convert to Base64
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, DEFAULT_FORMAT, baos);
        byte[] imageBytes = baos.toByteArray();
        
        return Base64.getEncoder().encodeToString(imageBytes);
    }
    
    /**
     * Generate simple QR with default size
     */
    public static String generateSimpleQRBase64(String text) throws IOException {
        return generateSimpleQRBase64(text, DEFAULT_SIZE);
    }
    
    /**
     * Draw simple QR-like pattern
     */
    private static void drawQRPattern(Graphics2D g, int size) {
        g.setColor(Color.BLACK);
        
        // Draw corner squares (simplified QR pattern)
        int cornerSize = 40;
        int margin = 20;
        
        // Top-left corner
        g.fillRect(margin, margin, cornerSize, cornerSize);
        g.setColor(Color.WHITE);
        g.fillRect(margin + 10, margin + 10, cornerSize - 20, cornerSize - 20);
        g.setColor(Color.BLACK);
        g.fillRect(margin + 15, margin + 15, cornerSize - 30, cornerSize - 30);
        
        // Top-right corner
        g.fillRect(size - margin - cornerSize, margin, cornerSize, cornerSize);
        g.setColor(Color.WHITE);
        g.fillRect(size - margin - cornerSize + 10, margin + 10, cornerSize - 20, cornerSize - 20);
        g.setColor(Color.BLACK);
        g.fillRect(size - margin - cornerSize + 15, margin + 15, cornerSize - 30, cornerSize - 30);
        
        // Bottom-left corner
        g.fillRect(margin, size - margin - cornerSize, cornerSize, cornerSize);
        g.setColor(Color.WHITE);
        g.fillRect(margin + 10, size - margin - cornerSize + 10, cornerSize - 20, cornerSize - 20);
        g.setColor(Color.BLACK);
        g.fillRect(margin + 15, size - margin - cornerSize + 15, cornerSize - 30, cornerSize - 30);
        
        // Add some random pattern dots
        for (int i = 0; i < 50; i++) {
            int x = margin + 60 + (i % 10) * 15;
            int y = margin + 60 + (i / 10) * 15;
            if (x < size - margin - 60 && y < size - margin - 60) {
                g.fillRect(x, y, 8, 8);
            }
        }
    }
}
