package DAL;

import Models.Supplier;
import Models.ImportOrder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO extends DBContext {
    
    // Lấy danh sách nhà cung cấp với phân trang và tìm kiếm
    public List<Supplier> getAllSuppliers(int page, int pageSize, String search, String sortBy, String sortDir) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM tbSupplier WHERE 1=1";
        
        // Thêm điều kiện tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (supplierName LIKE ? OR contactName LIKE ? OR phone LIKE ? OR email LIKE ?)";
        }
        
        // Thêm sắp xếp
        if (sortBy != null && !sortBy.isEmpty()) {
            sql += " ORDER BY " + sortBy + " " + (sortDir.equalsIgnoreCase("desc") ? "DESC" : "ASC");
        } else {
            sql += " ORDER BY supplierName ASC";
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
                ps.setString(paramIndex++, searchPattern);
            }
            
            // Set tham số phân trang
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setSupplierName(rs.getString("supplierName"));
                supplier.setContactName(rs.getString("contactName"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
                supplier.setNote(rs.getString("description")); // Map từ description sang note
                supplier.setStatus(1); // Mặc định là hoạt động
                // Không có created_at, updated_at trong database
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
    
    // Đếm tổng số nhà cung cấp (cho phân trang)
    public int countSuppliers(String search) {
        String sql = "SELECT COUNT(*) FROM tbSupplier WHERE 1=1";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (supplierName LIKE ? OR contactName LIKE ? OR phone LIKE ? OR email LIKE ?)";
        }
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
                ps.setString(3, searchPattern);
                ps.setString(4, searchPattern);
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
    
    // Lấy nhà cung cấp theo ID
    public Supplier getSupplierById(int supplierID) {
        String sql = "SELECT * FROM tbSupplier WHERE supplierID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setSupplierName(rs.getString("supplierName"));
                supplier.setContactName(rs.getString("contactName"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
                supplier.setNote(rs.getString("description")); // Map từ description sang note
                supplier.setStatus(1); // Mặc định là hoạt động
                // Không có created_at, updated_at trong database
                return supplier;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm nhà cung cấp mới
    public boolean addSupplier(Supplier supplier) {
        String sql = "INSERT INTO tbSupplier (supplierName, contactName, phone, email, address, description) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, supplier.getSupplierName());
            ps.setString(2, supplier.getContactName());
            ps.setString(3, supplier.getPhone());
            ps.setString(4, supplier.getEmail());
            ps.setString(5, supplier.getAddress());
            ps.setString(6, supplier.getNote()); // note sẽ map vào description
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật nhà cung cấp
    public boolean updateSupplier(Supplier supplier) {
        String sql = "UPDATE tbSupplier SET supplierName = ?, contactName = ?, phone = ?, " +
                    "email = ?, address = ?, description = ? WHERE supplierID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, supplier.getSupplierName());
            ps.setString(2, supplier.getContactName());
            ps.setString(3, supplier.getPhone());
            ps.setString(4, supplier.getEmail());
            ps.setString(5, supplier.getAddress());
            ps.setString(6, supplier.getNote());
            ps.setInt(7, supplier.getSupplierID());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa nhà cung cấp
    public boolean deleteSupplier(int supplierID) {
        String sql = "DELETE FROM tbSupplier WHERE supplierID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy danh sách tất cả nhà cung cấp (cho dropdown)
    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT supplierID, supplierName FROM tbSupplier ORDER BY supplierName ASC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setSupplierName(rs.getString("supplierName"));
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
    
    // Tìm kiếm nhà cung cấp với phân trang
    public List<Supplier> searchSuppliers(String searchName, String searchPhone, String searchStatus, int offset, int pageSize) {
        List<Supplier> suppliers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tbSupplier WHERE 1=1");
        
        // Thêm điều kiện tìm kiếm theo tên
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND (supplierName LIKE ? OR contactName LIKE ?)");
        }
        
        // Thêm điều kiện tìm kiếm theo số điện thoại
        if (searchPhone != null && !searchPhone.trim().isEmpty()) {
            sql.append(" AND phone LIKE ?");
        }
        
        // Bỏ tìm kiếm theo trạng thái vì chưa có cột status trong DB
        // if (searchStatus != null && !searchStatus.trim().isEmpty()) {
        //     sql.append(" AND status = ?");
        // }
        
        // Sắp xếp và phân trang
        sql.append(" ORDER BY supplierName ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            // Set tham số tìm kiếm theo tên
            if (searchName != null && !searchName.trim().isEmpty()) {
                String searchPattern = "%" + searchName.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            
            // Set tham số tìm kiếm theo số điện thoại
            if (searchPhone != null && !searchPhone.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchPhone.trim() + "%");
            }
            
            // Bỏ set tham số trạng thái vì chưa có cột status
            // if (searchStatus != null && !searchStatus.trim().isEmpty()) {
            //     ps.setInt(paramIndex++, Integer.parseInt(searchStatus));
            // }
            
            // Set tham số phân trang
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setSupplierName(rs.getString("supplierName"));
                supplier.setContactName(rs.getString("contactName"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
                supplier.setNote(rs.getString("description")); // Map từ description sang note
                // Bỏ set status vì chưa có cột này trong DB
                // supplier.setStatus(rs.getInt("status"));
                supplier.setStatus(1); // Mặc định là hoạt động
                // Không có created_at, updated_at trong database
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
    
    // Đếm tổng số nhà cung cấp với điều kiện tìm kiếm
    public int getTotalSuppliersCount(String searchName, String searchPhone, String searchStatus) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbSupplier WHERE 1=1");
        
        // Thêm điều kiện tìm kiếm theo tên
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND (supplierName LIKE ? OR contactName LIKE ?)");
        }
        
        // Thêm điều kiện tìm kiếm theo số điện thoại
        if (searchPhone != null && !searchPhone.trim().isEmpty()) {
            sql.append(" AND phone LIKE ?");
        }
        
        // Bỏ tìm kiếm theo trạng thái vì chưa có cột status trong DB
        // if (searchStatus != null && !searchStatus.trim().isEmpty()) {
        //     sql.append(" AND status = ?");
        // }
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            // Set tham số tìm kiếm theo tên
            if (searchName != null && !searchName.trim().isEmpty()) {
                String searchPattern = "%" + searchName.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            
            // Set tham số tìm kiếm theo số điện thoại
            if (searchPhone != null && !searchPhone.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchPhone.trim() + "%");
            }
            
            // Bỏ set tham số trạng thái vì chưa có cột status
            // if (searchStatus != null && !searchStatus.trim().isEmpty()) {
            //     ps.setInt(paramIndex++, Integer.parseInt(searchStatus));
            // }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Đếm số nhà cung cấp đang hoạt động (tạm thời đếm tất cả vì chưa có cột status)
    public int countActiveSuppliers() {
        String sql = "SELECT COUNT(*) FROM tbSupplier";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy 5 lần nhập hàng gần nhất của nhà cung cấp
    public List<ImportOrder> getRecentImportOrders(int supplierID, int limit) {
        List<ImportOrder> importOrders = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " io.importOrderID, io.importDate, io.totalAmount, io.note " +
                    "FROM tbImportOrder io " +
                    "WHERE io.supplierID = ? " +
                    "ORDER BY io.importDate DESC";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportOrder order = new ImportOrder();
                order.setImportOrderID(rs.getInt("importOrderID"));
                order.setImportDate(rs.getTimestamp("importDate"));
                order.setTotalImportAmount(rs.getBigDecimal("totalAmount"));
                order.setNote(rs.getString("note"));
                order.setSupplierID(supplierID);
                importOrders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return importOrders;
    }
    
    // Đếm tổng số lần nhập hàng của nhà cung cấp
    public int countImportOrdersBySupplier(int supplierID) {
        String sql = "SELECT COUNT(*) FROM tbImportOrder WHERE supplierID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Tính tổng giá trị nhập hàng từ nhà cung cấp
    public double getTotalImportValueBySupplier(int supplierID) {
        String sql = "SELECT ISNULL(SUM(totalAmount), 0) FROM tbImportOrder WHERE supplierID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, supplierID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
