package Models;

import java.sql.Timestamp;
import java.util.List;

public class Supplier {
    private int supplierID;
    private String supplierName;
    private String contactName;
    private String phone;
    private String email;
    private String address;
    private String note;
    private int status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
     private List<ImportOrder> recentImportOrders;
        private int totalImportOrders;
        private String error;
    
    // Default constructor
    public Supplier() {}
    
    // Constructor với tham số
    public Supplier(String supplierName, String contactName, String phone, String email, String address, String note) {
        this.supplierName = supplierName;
        this.contactName = contactName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.note = note;
    }

    public List<ImportOrder> getRecentImportOrders() {
        return recentImportOrders;
    }

    public void setRecentImportOrders(List<ImportOrder> recentImportOrders) {
        this.recentImportOrders = recentImportOrders;
    }

    public int getTotalImportOrders() {
        return totalImportOrders;
    }

    public void setTotalImportOrders(int totalImportOrders) {
        this.totalImportOrders = totalImportOrders;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
    // Getters and Setters
    public int getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getContactName() {
        return contactName;
    }
    
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
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
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "Supplier{" +
                "supplierID=" + supplierID +
                ", supplierName='" + supplierName + '\'' +
                ", contactName='" + contactName + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", note='" + note + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
