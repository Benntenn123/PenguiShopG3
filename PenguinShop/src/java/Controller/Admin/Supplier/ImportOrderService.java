package Controller.Admin.Supplier;

import DAL.ImportOrderDAO;
import DAL.ProductVariantDAO;
import Models.ImportOrder;
import Models.ImportOrderDetail;
import Models.VariantDTO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class để xử lý logic nghiệp vụ cho Import Order
 */
public class ImportOrderService {
    
    private final ImportOrderDAO importOrderDAO;
    private final ProductVariantDAO productVariantDAO;
    
    public ImportOrderService() {
        this.importOrderDAO = new ImportOrderDAO();
        this.productVariantDAO = new ProductVariantDAO();
    }
    
    // Lấy danh sách đơn nhập hàng với phân trang
    public List<ImportOrder> getAllImportOrders(int page, int pageSize, String search, String sortBy, String sortDir) {
        return importOrderDAO.getAllImportOrders(page, pageSize, search, sortBy, sortDir);
    }
    
    // Đếm tổng số đơn nhập hàng
    public int countImportOrders(String search) {
        return importOrderDAO.countImportOrders(search);
    }
    
    // Lấy chi tiết đơn nhập hàng theo ID
    public ImportOrder getImportOrderById(int importOrderID) {
        return importOrderDAO.getImportOrderById(importOrderID);
    }
    
    // Lấy đơn nhập gần đây
    public List<ImportOrder> getRecentImportOrders() {
        return importOrderDAO.getRecentImportOrders();
    }
    
    // Tìm kiếm variants cho việc tạo đơn nhập
    public List<VariantDTO> searchVariants(String keyword) {
        return productVariantDAO.searchVariants(keyword, 20); // Giới hạn 20 kết quả
    }
    
    // Lấy thông tin variant theo ID
    public VariantDTO getVariantById(int variantID) {
        return productVariantDAO.getVariantDTOById(variantID);
    }
    
    // Tạo đơn nhập hàng mới
    public boolean createImportOrder(ImportOrderRequest request) {
        try {
            // Validate input
            if (request.supplierID <= 0 || request.createdBy <= 0 || 
                request.details == null || request.details.isEmpty()) {
                return false;
            }
            
            // Tính tổng tiền
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (ImportOrderDetailRequest detail : request.details) {
                if (detail.quantity <= 0 || detail.importPrice.compareTo(BigDecimal.ZERO) <= 0) {
                    return false; // Invalid detail
                }
                totalAmount = totalAmount.add(detail.importPrice.multiply(new BigDecimal(detail.quantity)));
            }
            
            // Tạo đơn nhập
            ImportOrder order = new ImportOrder();
            order.setSupplierID(request.supplierID);
            order.setTotalImportAmount(totalAmount);
            order.setNote(request.note);
            order.setCreatedBy(request.createdBy);
            
            int importOrderID = importOrderDAO.addImportOrder(order);
            
            if (importOrderID > 0) {
                // Thêm chi tiết đơn nhập
                boolean allDetailsAdded = true;
                for (ImportOrderDetailRequest detailRequest : request.details) {
                    ImportOrderDetail detail = new ImportOrderDetail();
                    detail.setImportOrderID(importOrderID);
                    detail.setVariantID(detailRequest.variantID);
                    detail.setQuantity(detailRequest.quantity);
                    detail.setImportPrice(detailRequest.importPrice);
                    detail.setNote(detailRequest.note);
                    
                    if (!importOrderDAO.addImportOrderDetail(detail)) {
                        allDetailsAdded = false;
                        break;
                    }
                    
                    // Cập nhật số lượng trong kho
                    productVariantDAO.updateVariantQuantity(detailRequest.variantID, detailRequest.quantity);
                }
                
                return allDetailsAdded;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa đơn nhập hàng
    public boolean deleteImportOrder(int importOrderID) {
        return importOrderDAO.deleteImportOrder(importOrderID);
    }
    
    // DTO class cho request tạo đơn nhập
    public static class ImportOrderRequest {
        public int supplierID;
        public String note;
        public int createdBy;
        public List<ImportOrderDetailRequest> details = new ArrayList<>();
        
        // Constructor
        public ImportOrderRequest() {}
        
        public ImportOrderRequest(int supplierID, String note, int createdBy) {
            this.supplierID = supplierID;
            this.note = note;
            this.createdBy = createdBy;
        }
        
        // Add detail
        public void addDetail(int variantID, int quantity, BigDecimal importPrice, String note) {
            details.add(new ImportOrderDetailRequest(variantID, quantity, importPrice, note));
        }
    }
    
    // DTO class cho chi tiết đơn nhập
    public static class ImportOrderDetailRequest {
        public int variantID;
        public int quantity;
        public BigDecimal importPrice;
        public String note;
        
        public ImportOrderDetailRequest() {}
        
        public ImportOrderDetailRequest(int variantID, int quantity, BigDecimal importPrice, String note) {
            this.variantID = variantID;
            this.quantity = quantity;
            this.importPrice = importPrice;
            this.note = note;
        }
    }
    
    // Thống kê đơn nhập hàng
    public ImportStatistics getImportStatistics() {
        ImportStatistics stats = new ImportStatistics();
        
        List<ImportOrder> recentOrders = importOrderDAO.getRecentImportOrders();
        stats.totalRecentOrders = recentOrders.size();
        
        // Tính tổng tiền và số lượng đơn nhập trong tháng
        BigDecimal totalValue = BigDecimal.ZERO;
        for (ImportOrder order : recentOrders) {
            if (order.getTotalImportAmount() != null) {
                totalValue = totalValue.add(order.getTotalImportAmount());
            }
        }
        stats.totalImportValue = totalValue;
        
        return stats;
    }
    
    // Inner class cho thống kê
    public static class ImportStatistics {
        public int totalRecentOrders;
        public BigDecimal totalImportValue = BigDecimal.ZERO;
        
        public int getTotalRecentOrders() { return totalRecentOrders; }
        public BigDecimal getTotalImportValue() { return totalImportValue; }
    }
}
