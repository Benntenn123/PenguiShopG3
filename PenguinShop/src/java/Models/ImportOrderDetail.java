package Models;

import java.math.BigDecimal;

public class ImportOrderDetail {
    private int importOrderDetailID;
    private int importOrderID;
    private int variantID;
    private int quantity;
    private BigDecimal importPrice;
    private String note;
    private int productID;
    // Thông tin liên kết
    private String productName;
    private String colorName;
    private String sizeName;
    private String productSKU;
    private String productDescription;
    private String productImage;
    private BigDecimal unitPrice; // Alias for importPrice for JSP
    
    // Default constructor
    public ImportOrderDetail() {}
    
    // Constructor
    public ImportOrderDetail(int importOrderID, int variantID, int quantity, BigDecimal importPrice, String note) {
        this.importOrderID = importOrderID;
        this.variantID = variantID;
        this.quantity = quantity;
        this.importPrice = importPrice;
        this.note = note;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    // Getters and Setters
    public int getImportOrderDetailID() {
        return importOrderDetailID;
    }
    
    public void setImportOrderDetailID(int importOrderDetailID) {
        this.importOrderDetailID = importOrderDetailID;
    }
    
    public int getImportOrderID() {
        return importOrderID;
    }
    
    public void setImportOrderID(int importOrderID) {
        this.importOrderID = importOrderID;
    }
    
    public int getVariantID() {
        return variantID;
    }
    
    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getImportPrice() {
        return importPrice;
    }
    
    public void setImportPrice(BigDecimal importPrice) {
        this.importPrice = importPrice;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
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
    
    public String getProductSKU() {
        return productSKU;
    }
    
    public void setProductSKU(String productSKU) {
        this.productSKU = productSKU;
    }
    
    public String getProductDescription() {
        return productDescription;
    }
    
    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }
    
    public String getProductImage() {
        return productImage;
    }
    
    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
    
    public BigDecimal getUnitPrice() {
        return unitPrice != null ? unitPrice : importPrice;
    }
    
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    // Tính tổng tiền cho chi tiết này
    public BigDecimal getTotalAmount() {
        return importPrice.multiply(new BigDecimal(quantity));
    }
    
    @Override
    public String toString() {
        return "ImportOrderDetail{" +
                "importOrderDetailID=" + importOrderDetailID +
                ", importOrderID=" + importOrderID +
                ", variantID=" + variantID +
                ", quantity=" + quantity +
                ", importPrice=" + importPrice +
                ", note='" + note + '\'' +
                ", productName='" + productName + '\'' +
                ", colorName='" + colorName + '\'' +
                ", sizeName='" + sizeName + '\'' +
                ", productSKU='" + productSKU + '\'' +
                '}';
    }
}
