package Controller.Admin.Supplier;

import DAL.ImportOrderDAO;
import DAL.SupplierDAO;
import Models.ImportOrder;
import Models.Supplier;
import java.util.List;

/**
 * Service class để xử lý logic nghiệp vụ cho Supplier
 * Có thể được gọi từ các Servlet khác
 */
public class SupplierService {
    
    private SupplierDAO supplierDAO;
    private ImportOrderDAO importOrderDAO;
    
    public SupplierService() {
        this.supplierDAO = new SupplierDAO();
        this.importOrderDAO = new ImportOrderDAO();
    }
    
    // Lấy danh sách nhà cung cấp với phân trang và tìm kiếm
    public List<Supplier> getAllSuppliers(int page, int pageSize, String search, String sortBy, String sortDir) {
        return supplierDAO.getAllSuppliers(page, pageSize, search, sortBy, sortDir);
    }
    
    // Đếm tổng số nhà cung cấp
    public int countSuppliers(String search) {
        return supplierDAO.countSuppliers(search);
    }
    
    // Lấy nhà cung cấp theo ID
    public Supplier getSupplierById(int supplierID) {
        return supplierDAO.getSupplierById(supplierID);
    }
    
    // Thêm nhà cung cấp mới
    public boolean addSupplier(Supplier supplier) {
        // Validate
        if (supplier.getSupplierName() == null || supplier.getSupplierName().trim().isEmpty()) {
            return false;
        }
        return supplierDAO.addSupplier(supplier);
    }
    
    // Cập nhật nhà cung cấp
    public boolean updateSupplier(Supplier supplier) {
        // Validate
        if (supplier.getSupplierName() == null || supplier.getSupplierName().trim().isEmpty()) {
            return false;
        }
        return supplierDAO.updateSupplier(supplier);
    }
    
    // Xóa nhà cung cấp
    public boolean deleteSupplier(int supplierID) {
        return supplierDAO.deleteSupplier(supplierID);
    }
    
    // Lấy tất cả nhà cung cấp (cho dropdown)
    public List<Supplier> getAllSuppliers() {
        return supplierDAO.getAllSuppliers();
    }
    
    // Lấy đơn nhập hàng gần đây
    public List<ImportOrder> getRecentImportOrders() {
        return importOrderDAO.getRecentImportOrders();
    }
    
    // Lấy danh sách đơn nhập hàng với phân trang
    public List<ImportOrder> getAllImportOrders(int page, int pageSize, String search, String sortBy, String sortDir) {
        return importOrderDAO.getAllImportOrders(page, pageSize, search, sortBy, sortDir);
    }
    
    // Đếm tổng số đơn nhập hàng
    public int countImportOrders(String search) {
        return importOrderDAO.countImportOrders(search);
    }
    
    // Lấy chi tiết đơn nhập hàng
    public ImportOrder getImportOrderById(int importOrderID) {
        return importOrderDAO.getImportOrderById(importOrderID);
    }
    
    // Thống kê nhanh
    public SupplierStatistics getSupplierStatistics() {
        SupplierStatistics stats = new SupplierStatistics();
        stats.totalSuppliers = supplierDAO.countSuppliers(null);
        
        List<ImportOrder> recentOrders = importOrderDAO.getRecentImportOrders();
        stats.totalRecentOrders = recentOrders.size();
        
        // Tính tổng tiền nhập gần đây
        double totalImportValue = 0;
        for (ImportOrder order : recentOrders) {
            if (order.getTotalImportAmount() != null) {
                totalImportValue += order.getTotalImportAmount().doubleValue();
            }
        }
        stats.totalImportValue = totalImportValue;
        
        return stats;
    }
    
    // Inner class để chứa thống kê
    public static class SupplierStatistics {
        public int totalSuppliers;
        public int totalRecentOrders;
        public double totalImportValue;
        
        public int getTotalSuppliers() { return totalSuppliers; }
        public int getTotalRecentOrders() { return totalRecentOrders; }
        public double getTotalImportValue() { return totalImportValue; }
    }
}
