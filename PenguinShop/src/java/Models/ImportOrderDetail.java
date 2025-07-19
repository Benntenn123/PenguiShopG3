package Models;

import java.math.BigDecimal;

public class ImportOrderDetail {
    private int importOrderDetailID;
    private int importOrderID;
    private int variantID;
    private int quantity;
    private BigDecimal importPrice;
    private String note;
    
    // Thông tin liên kết
    private String productName;
    private String colorName;
    private String sizeName;
    private String productSKU;
    
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
