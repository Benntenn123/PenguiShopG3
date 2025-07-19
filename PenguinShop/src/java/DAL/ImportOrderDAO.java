package DAL;

import Models.ImportOrder;
import Models.ImportOrderDetail;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImportOrderDAO extends DBContext {
    
    // Lấy danh sách đơn nhập hàng với phân trang và tìm kiếm
    public List<ImportOrder> getAllImportOrders(int page, int pageSize, String search, String sortBy, String sortDir) {
        List<ImportOrder> orders = new ArrayList<>();
        String sql = "SELECT io.*, s.supplierName, u.fullName as createdByName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "LEFT JOIN tbUsers u ON io.created_by = u.userID " +
                    "WHERE 1=1";
        
        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR u.fullName LIKE ? OR io.note LIKE ?)";
        }
        
        // Thêm sắp xếp
        if (sortBy != null && !sortBy.isEmpty()) {
            sql += " ORDER BY " + sortBy + " " + (sortDir.equalsIgnoreCase("desc") ? "DESC" : "ASC");
        } else {
            sql += " ORDER BY io.importDate DESC";
        }
        
        // Thêm phân trang
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            
            // Set tham số tìm kiếm
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            
            // Set tham số phân trang
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ImportOrder order = new ImportOrder();
                order.setImportOrderID(rs.getInt("importOrderID"));
                order.setSupplierID(rs.getInt("supplierID"));
                order.setImportDate(rs.getTimestamp("importDate"));
                order.setTotalImportAmount(rs.getBigDecimal("totalImportAmount"));
                order.setNote(rs.getString("note"));
                order.setCreatedBy(rs.getInt("created_by"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                order.setSupplierName(rs.getString("supplierName"));
                order.setCreatedByName(rs.getString("createdByName"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    // Đếm tổng số đơn nhập hàng (cho phân trang)
    public int countImportOrders(String search) {
        String sql = "SELECT COUNT(*) FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "LEFT JOIN tbUsers u ON io.created_by = u.userID " +
                    "WHERE 1=1";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR u.fullName LIKE ? OR io.note LIKE ?)";
        }
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
                ps.setString(3, searchPattern);
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy đơn nhập hàng theo ID kèm chi tiết
    public ImportOrder getImportOrderById(int importOrderID) {
        String sql = "SELECT io.*, s.supplierName, u.fullName as createdByName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "LEFT JOIN tbUsers u ON io.created_by = u.userID " +
                    "WHERE io.importOrderID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importOrderID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ImportOrder order = new ImportOrder();
                order.setImportOrderID(rs.getInt("importOrderID"));
                order.setSupplierID(rs.getInt("supplierID"));
                order.setImportDate(rs.getTimestamp("importDate"));
                order.setTotalImportAmount(rs.getBigDecimal("totalImportAmount"));
                order.setNote(rs.getString("note"));
                order.setCreatedBy(rs.getInt("created_by"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                order.setSupplierName(rs.getString("supplierName"));
                order.setCreatedByName(rs.getString("createdByName"));
                
                // Lấy chi tiết đơn nhập
                order.setDetails(getImportOrderDetails(importOrderID));
                
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Lấy chi tiết đơn nhập hàng
    public List<ImportOrderDetail> getImportOrderDetails(int importOrderID) {
        List<ImportOrderDetail> details = new ArrayList<>();
        String sql = "SELECT iod.*, p.productName, p.SKU as productSKU, c.colorName, s.sizeName " +
                    "FROM tbImportOrderDetail iod " +
                    "LEFT JOIN tbProductVariant pv ON iod.variantID = pv.variantID " +
                    "LEFT JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE iod.importOrderID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importOrderID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportOrderDetail detail = new ImportOrderDetail();
                detail.setImportOrderDetailID(rs.getInt("importOrderDetailID"));
                detail.setImportOrderID(rs.getInt("importOrderID"));
                detail.setVariantID(rs.getInt("variantID"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setImportPrice(rs.getBigDecimal("importPrice"));
                detail.setNote(rs.getString("note"));
                detail.setProductName(rs.getString("productName"));
                detail.setProductSKU(rs.getString("productSKU"));
                detail.setColorName(rs.getString("colorName"));
                detail.setSizeName(rs.getString("sizeName"));
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
    
    // Thêm đơn nhập hàng mới
    public int addImportOrder(ImportOrder order) {
        String sql = "INSERT INTO tbImportOrder (supplierID, importDate, totalImportAmount, note, created_by, created_at) " +
                    "VALUES (?, GETDATE(), ?, ?, ?, GETDATE())";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getSupplierID());
            ps.setBigDecimal(2, order.getTotalImportAmount());
            ps.setString(3, order.getNote());
            ps.setInt(4, order.getCreatedBy());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Trả về ID của đơn nhập vừa tạo
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Thêm chi tiết đơn nhập hàng
    public boolean addImportOrderDetail(ImportOrderDetail detail) {
        String sql = "INSERT INTO tbImportOrderDetail (importOrderID, variantID, quantity, importPrice, note) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, detail.getImportOrderID());
            ps.setInt(2, detail.getVariantID());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getImportPrice());
            ps.setString(5, detail.getNote());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật tổng tiền đơn nhập
    public boolean updateImportOrderTotal(int importOrderID, BigDecimal totalAmount) {
        String sql = "UPDATE tbImportOrder SET totalImportAmount = ?, updated_at = GETDATE() WHERE importOrderID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBigDecimal(1, totalAmount);
            ps.setInt(2, importOrderID);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy đơn nhập gần đây (top 10)
    public List<ImportOrder> getRecentImportOrders() {
        List<ImportOrder> orders = new ArrayList<>();
        String sql = "SELECT TOP 10 io.*, s.supplierName, u.fullName as createdByName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "LEFT JOIN tbUsers u ON io.created_by = u.userID " +
                    "ORDER BY io.importDate DESC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportOrder order = new ImportOrder();
                order.setImportOrderID(rs.getInt("importOrderID"));
                order.setSupplierID(rs.getInt("supplierID"));
                order.setImportDate(rs.getTimestamp("importDate"));
                order.setTotalImportAmount(rs.getBigDecimal("totalImportAmount"));
                order.setNote(rs.getString("note"));
                order.setCreatedBy(rs.getInt("created_by"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                order.setSupplierName(rs.getString("supplierName"));
                order.setCreatedByName(rs.getString("createdByName"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    // Xóa đơn nhập hàng (cascade xóa chi tiết)
    public boolean deleteImportOrder(int importOrderID) {
        try {
            connection.setAutoCommit(false);
            
            // Xóa chi tiết trước
            String deleteDetailsSQL = "DELETE FROM tbImportOrderDetail WHERE importOrderID = ?";
            PreparedStatement psDetails = connection.prepareStatement(deleteDetailsSQL);
            psDetails.setInt(1, importOrderID);
            psDetails.executeUpdate();
            
            // Xóa đơn nhập
            String deleteOrderSQL = "DELETE FROM tbImportOrder WHERE importOrderID = ?";
            PreparedStatement psOrder = connection.prepareStatement(deleteOrderSQL);
            psOrder.setInt(1, importOrderID);
            int result = psOrder.executeUpdate();
            
            connection.commit();
            return result > 0;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
