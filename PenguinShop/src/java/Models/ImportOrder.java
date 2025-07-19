package Models;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class ImportOrder {
    private int importOrderID;
    private int supplierID;
    private Timestamp importDate;
    private BigDecimal totalImportAmount;
    private String note;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Thông tin liên kết
    private String supplierName;
    private String createdByName;
    private List<ImportOrderDetail> details;
    
    // Default constructor
    public ImportOrder() {}
    
    // Constructor
    public ImportOrder(int supplierID, BigDecimal totalImportAmount, String note, int createdBy) {
        this.supplierID = supplierID;
        this.totalImportAmount = totalImportAmount;
        this.note = note;
        this.createdBy = createdBy;
    }
    
    // Getters and Setters
    public int getImportOrderID() {
        return importOrderID;
    }
    
    public void setImportOrderID(int importOrderID) {
        this.importOrderID = importOrderID;
    }
    
    public int getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
    
    public Timestamp getImportDate() {
        return importDate;
    }
    
    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }
    
    public BigDecimal getTotalImportAmount() {
        return totalImportAmount;
    }
    
    public void setTotalImportAmount(BigDecimal totalImportAmount) {
        this.totalImportAmount = totalImportAmount;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getCreatedByName() {
        return createdByName;
    }
    
    public void setCreatedByName(String createdByName) {
        this.createdByName = createdByName;
    }
    
    public List<ImportOrderDetail> getDetails() {
        return details;
    }
    
    public void setDetails(List<ImportOrderDetail> details) {
        this.details = details;
    }
    
    @Override
    public String toString() {
        return "ImportOrder{" +
                "importOrderID=" + importOrderID +
                ", supplierID=" + supplierID +
                ", importDate=" + importDate +
                ", totalImportAmount=" + totalImportAmount +
                ", note='" + note + '\'' +
                ", createdBy=" + createdBy +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", supplierName='" + supplierName + '\'' +
                ", createdByName='" + createdByName + '\'' +
                '}';
    }
}
