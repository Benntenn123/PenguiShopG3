package Models;

import java.math.BigDecimal;

/**
 * DTO đơn giản để quản lý variant cho import
 */
public class VariantDTO {
    private int variantID;
    private int productID;
    private int colorID;
    private int sizeID;
    private int quantity;
    private BigDecimal price;
    private int stockStatus;
    
    // Thông tin mở rộng để hiển thị
    private String productName;
    private String productSKU;
    private String colorName;
    private String sizeName;
    
    // Default constructor
    public VariantDTO() {}
    
    // Getters and Setters
    public int getVariantID() {
        return variantID;
    }
    
    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }
    
    public int getProductID() {
        return productID;
    }
    
    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    public int getColorID() {
        return colorID;
    }
    
    public void setColorID(int colorID) {
        this.colorID = colorID;
    }
    
    public int getSizeID() {
        return sizeID;
    }
    
    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public int getStockStatus() {
        return stockStatus;
    }
    
    public void setStockStatus(int stockStatus) {
        this.stockStatus = stockStatus;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getProductSKU() {
        return productSKU;
    }
    
    public void setProductSKU(String productSKU) {
        this.productSKU = productSKU;
    }
    
    public String getColorName() {
        return colorName;
    }
    
    public void setColorName(String colorName) {
        this.colorName = colorName;
    }
    
    public String getSizeName() {
        return sizeName;
    }
    
    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }
    
    // Tạo string hiển thị đầy đủ
    public String getDisplayName() {
        return productName + " - " + colorName + " - " + sizeName + " (SKU: " + productSKU + ")";
    }
}
