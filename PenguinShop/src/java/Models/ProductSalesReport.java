package Models;

import java.math.BigDecimal;

public class ProductSalesReport {
    private int variantID;
    private String productName;
    private String variantName;
    private String productImage;
    private int totalQuantity;
    private BigDecimal totalRevenue;
    
    public ProductSalesReport() {}
    
    public ProductSalesReport(int variantID, String productName, String variantName, 
                             String productImage, int totalQuantity, BigDecimal totalRevenue) {
        this.variantID = variantID;
        this.productName = productName;
        this.variantName = variantName;
        this.productImage = productImage;
        this.totalQuantity = totalQuantity;
        this.totalRevenue = totalRevenue != null ? totalRevenue : BigDecimal.ZERO;
    }
    
    // Getters and Setters
    public int getVariantID() { return variantID; }
    public void setVariantID(int variantID) { this.variantID = variantID; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public String getVariantName() { return variantName; }
    public void setVariantName(String variantName) { this.variantName = variantName; }
    
    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
    
    public int getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(int totalQuantity) { this.totalQuantity = totalQuantity; }
    
    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { 
        this.totalRevenue = totalRevenue != null ? totalRevenue : BigDecimal.ZERO; 
    }
}
