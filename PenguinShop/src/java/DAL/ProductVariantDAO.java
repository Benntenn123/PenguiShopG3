package DAL;

import Models.VariantDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO extends DBContext {
    
    // Tìm kiếm variant theo tên sản phẩm hoặc SKU (dùng VariantDTO)
    public List<VariantDTO> searchVariants(String keyword, int limit) {
        List<VariantDTO> variants = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " pv.*, p.productName, p.SKU, c.colorName, s.sizeName " +
                    "FROM tbProductVariant pv " +
                    "LEFT JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE p.productName LIKE ? OR p.SKU LIKE ? " +
                    "ORDER BY p.productName, c.colorName, s.sizeName";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                VariantDTO variant = new VariantDTO();
                variant.setVariantID(rs.getInt("variantID"));
                variant.setProductID(rs.getInt("productID"));
                variant.setColorID(rs.getInt("colorID"));
                variant.setSizeID(rs.getInt("sizeID"));
                variant.setQuantity(rs.getInt("quantity"));
                variant.setPrice(rs.getBigDecimal("price"));
                variant.setStockStatus(rs.getInt("stockStatus"));
                variant.setProductName(rs.getString("productName"));
                variant.setProductSKU(rs.getString("SKU"));
                variant.setColorName(rs.getString("colorName"));
                variant.setSizeName(rs.getString("sizeName"));
                variants.add(variant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }
    
    // Lấy variant theo ID (dùng VariantDTO)
    public VariantDTO getVariantDTOById(int variantID) {
        String sql = "SELECT pv.*, p.productName, p.SKU, c.colorName, s.sizeName " +
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
                VariantDTO variant = new VariantDTO();
                variant.setVariantID(rs.getInt("variantID"));
                variant.setProductID(rs.getInt("productID"));
                variant.setColorID(rs.getInt("colorID"));
                variant.setSizeID(rs.getInt("sizeID"));
                variant.setQuantity(rs.getInt("quantity"));
                variant.setPrice(rs.getBigDecimal("price"));
                variant.setStockStatus(rs.getInt("stockStatus"));
                variant.setProductName(rs.getString("productName"));
                variant.setProductSKU(rs.getString("SKU"));
                variant.setColorName(rs.getString("colorName"));
                variant.setSizeName(rs.getString("sizeName"));
                return variant;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Cập nhật số lượng khi nhập hàng
    public boolean updateVariantQuantity(int variantID, int additionalQuantity) {
        String sql = "UPDATE tbProductVariant SET quantity = quantity + ? WHERE variantID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, additionalQuantity);
            ps.setInt(2, variantID);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy danh sách variant theo productID (dùng VariantDTO)
    public List<VariantDTO> getVariantsByProductId(int productID) {
        List<VariantDTO> variants = new ArrayList<>();
        String sql = "SELECT pv.*, p.productName, p.SKU, c.colorName, s.sizeName " +
                    "FROM tbProductVariant pv " +
                    "LEFT JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE pv.productID = ? " +
                    "ORDER BY c.colorName, s.sizeName";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                VariantDTO variant = new VariantDTO();
                variant.setVariantID(rs.getInt("variantID"));
                variant.setProductID(rs.getInt("productID"));
                variant.setColorID(rs.getInt("colorID"));
                variant.setSizeID(rs.getInt("sizeID"));
                variant.setQuantity(rs.getInt("quantity"));
                variant.setPrice(rs.getBigDecimal("price"));
                variant.setStockStatus(rs.getInt("stockStatus"));
                variant.setProductName(rs.getString("productName"));
                variant.setProductSKU(rs.getString("SKU"));
                variant.setColorName(rs.getString("colorName"));
                variant.setSizeName(rs.getString("sizeName"));
                variants.add(variant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }
}
