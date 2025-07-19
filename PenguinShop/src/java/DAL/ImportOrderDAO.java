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
        String sql = "SELECT io.*, s.supplierName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "WHERE 1=1";
        
        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR io.note LIKE ?)";
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
                order.setTotalImportAmount(rs.getBigDecimal("totalAmount"));
                order.setNote(rs.getString("note"));
                order.setSupplierName(rs.getString("supplierName"));
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
                    "WHERE 1=1";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR io.note LIKE ?)";
        }
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
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
        String sql = "SELECT io.*, s.supplierName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
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
                order.setTotalImportAmount(rs.getBigDecimal("totalAmount"));
                order.setNote(rs.getString("note"));
                order.setSupplierName(rs.getString("supplierName"));
                
                // Lấy chi tiết đơn nhập
                order.setDetails(getImportOrderDetails(importOrderID));
                
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Lấy chi tiết đơn nhập hàng với thông tin sản phẩm đầy đủ
    public List<ImportOrderDetail> getImportOrderDetails(int importOrderID) {
        List<ImportOrderDetail> details = new ArrayList<>();
        String sql = "SELECT iod.importOrderDetailID, iod.importOrderID, iod.variantID, iod.quantity, iod.importPrice, " +
                    "p.productID, p.productName, p.SKU as productSKU, p.description as productDescription, " +
                    "p.imageMainProduct as productImage, c.colorName, s.sizeName, " +
                    "pv.quantity as variantStock " +
                    "FROM tbImportOrderDetail iod " +
                    "INNER JOIN tbProductVariant pv ON iod.variantID = pv.variantID " +
                    "INNER JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE iod.importOrderID = ? " +
                    "ORDER BY iod.importOrderDetailID";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importOrderID);
            
            System.out.println("ImportOrderDAO - Executing query for import order: " + importOrderID);
            System.out.println("ImportOrderDAO - Query: " + sql);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportOrderDetail detail = new ImportOrderDetail();
                detail.setImportOrderDetailID(rs.getInt("importOrderDetailID"));
                detail.setImportOrderID(rs.getInt("importOrderID"));
                detail.setVariantID(rs.getInt("variantID"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setImportPrice(rs.getBigDecimal("importPrice"));
                detail.setProductID(rs.getInt("productID"));
                
                // Thông tin sản phẩm
                detail.setProductName(rs.getString("productName"));
                detail.setProductSKU(rs.getString("productSKU"));
                detail.setProductDescription(rs.getString("productDescription"));
                
                // Xử lý đường dẫn ảnh chính
                String mainImage = rs.getString("productImage");
                if (mainImage != null && !mainImage.isEmpty()) {
                    detail.setProductImage("../api/img/" + mainImage);
                } else {
                    detail.setProductImage("../api/img/default-product.jpg"); // Ảnh mặc định
                }
                
                detail.setColorName(rs.getString("colorName"));
                detail.setSizeName(rs.getString("sizeName"));
                
                // Set unitPrice for JSP compatibility  
                detail.setUnitPrice(rs.getBigDecimal("importPrice"));
                
                details.add(detail);
                
                // Debug thông tin từng detail
                System.out.println("ImportOrderDAO - Detail loaded: variantID=" + detail.getVariantID() + 
                    ", productName=" + detail.getProductName() + 
                    ", colorName=" + detail.getColorName() + 
                    ", sizeName=" + detail.getSizeName() +
                    ", quantity=" + detail.getQuantity() +
                    ", price=" + detail.getImportPrice() +
                    ", image=" + detail.getProductImage());
            }
            
            System.out.println("ImportOrderDAO - Total details loaded: " + details.size());
            
        } catch (SQLException e) {
            System.out.println("ImportOrderDAO - SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return details;
    }
    
    // Test method để kiểm tra variantID có tồn tại không
    public void testVariantID(int variantID) {
        String sql = "SELECT pv.variantID, pv.productID, p.productName, c.colorName, s.sizeName " +
                    "FROM tbProductVariant pv " +
                    "LEFT JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE pv.variantID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                System.out.println("testVariantID - Found variant: " +
                    "variantID=" + rs.getInt("variantID") + 
                    ", productID=" + rs.getInt("productID") +
                    ", productName=" + rs.getString("productName") +
                    ", color=" + rs.getString("colorName") +
                    ", size=" + rs.getString("sizeName"));
            } else {
                System.out.println("testVariantID - No variant found for ID: " + variantID);
            }
        } catch (SQLException e) {
            System.out.println("testVariantID - Error: " + e.getMessage());
        }
    }
    
    // Thêm đơn nhập hàng mới
    public int addImportOrder(ImportOrder order) {
        String sql = "INSERT INTO tbImportOrder (supplierID, importDate, totalAmount, note) " +
                    "VALUES (?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getSupplierID());
            ps.setTimestamp(2, new Timestamp(order.getImportDate().getTime()));
            ps.setBigDecimal(3, order.getTotalImportAmount());
            ps.setString(4, order.getNote());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int importOrderID = generatedKeys.getInt(1);
                    
                    // Lưu từng detail nếu có
                    if (order.getDetails() != null && !order.getDetails().isEmpty()) {
                        for (ImportOrderDetail detail : order.getDetails()) {
                            detail.setImportOrderID(importOrderID);
                            addImportOrderDetail(detail);
                        }
                    }
                    
                    return importOrderID; // Trả về ID của đơn nhập vừa tạo
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Thêm chi tiết đơn nhập hàng
    public boolean addImportOrderDetail(ImportOrderDetail detail) {
        String sql = "INSERT INTO tbImportOrderDetail (importOrderID, variantID, quantity, importPrice) " +
                    "VALUES (?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, detail.getImportOrderID());
            ps.setInt(2, detail.getVariantID());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getImportPrice());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật tổng tiền đơn nhập
    public boolean updateImportOrderTotal(int importOrderID, BigDecimal totalAmount) {
        String sql = "UPDATE tbImportOrder SET totalAmount = ? WHERE importOrderID = ?";
        
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
        String sql = "SELECT TOP 10 io.*, s.supplierName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "ORDER BY io.importDate DESC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportOrder order = new ImportOrder();
                order.setImportOrderID(rs.getInt("importOrderID"));
                order.setSupplierID(rs.getInt("supplierID"));
                order.setImportDate(rs.getTimestamp("importDate"));
                order.setTotalImportAmount(rs.getBigDecimal("totalAmount"));
                order.setNote(rs.getString("note"));
                order.setSupplierName(rs.getString("supplierName"));
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
    
    // Lấy danh sách đơn nhập hàng theo supplier ID
    public List<ImportOrder> getImportOrdersBySupplier(int supplierId, int page, int pageSize, String search, String sortBy, String sortDir) {
        List<ImportOrder> orders = new ArrayList<>();
        String sql = "SELECT io.*, s.supplierName " +
                    "FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "WHERE io.supplierID = ?";
        
        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR io.note LIKE ?)";
        }
        
        // Thêm sắp xếp
        if (sortBy != null && !sortBy.isEmpty()) {
            sql += " ORDER BY " + sortBy + " " + (sortDir != null && sortDir.equalsIgnoreCase("ASC") ? "ASC" : "DESC");
        } else {
            sql += " ORDER BY io.importDate DESC";
        }
        
        // Thêm phân trang
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            
            // Set supplier ID
            ps.setInt(paramIndex++, supplierId);
            
            // Set tham số tìm kiếm
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
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
                order.setTotalImportAmount(rs.getBigDecimal("totalAmount"));
                order.setNote(rs.getString("note"));
                order.setSupplierName(rs.getString("supplierName"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    // Đếm tổng số đơn nhập hàng theo supplier ID
    public int countImportOrdersBySupplier(int supplierId, String search) {
        String sql = "SELECT COUNT(*) FROM tbImportOrder io " +
                    "LEFT JOIN tbSupplier s ON io.supplierID = s.supplierID " +
                    "WHERE io.supplierID = ?";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (s.supplierName LIKE ? OR io.note LIKE ?)";
        }
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            
            // Set supplier ID
            ps.setInt(paramIndex++, supplierId);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
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

}
