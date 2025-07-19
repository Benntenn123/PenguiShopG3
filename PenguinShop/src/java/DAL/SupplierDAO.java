package DAL;

import Models.Supplier;
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
                supplier.setNote(rs.getString("note"));
                supplier.setCreatedAt(rs.getTimestamp("created_at"));
                supplier.setUpdatedAt(rs.getTimestamp("updated_at"));
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
                supplier.setNote(rs.getString("note"));
                supplier.setCreatedAt(rs.getTimestamp("created_at"));
                supplier.setUpdatedAt(rs.getTimestamp("updated_at"));
                return supplier;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm nhà cung cấp mới
    public boolean addSupplier(Supplier supplier) {
        String sql = "INSERT INTO tbSupplier (supplierName, contactName, phone, email, address, note, created_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, supplier.getSupplierName());
            ps.setString(2, supplier.getContactName());
            ps.setString(3, supplier.getPhone());
            ps.setString(4, supplier.getEmail());
            ps.setString(5, supplier.getAddress());
            ps.setString(6, supplier.getNote());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật nhà cung cấp
    public boolean updateSupplier(Supplier supplier) {
        String sql = "UPDATE tbSupplier SET supplierName = ?, contactName = ?, phone = ?, " +
                    "email = ?, address = ?, note = ?, updated_at = GETDATE() WHERE supplierID = ?";
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
}
