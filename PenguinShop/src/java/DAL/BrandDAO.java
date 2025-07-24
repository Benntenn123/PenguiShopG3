
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO extends DBContext {

    public List<Brand> getAllBrand() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM tbBrand";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand b = new Brand(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
        // Lấy tất cả brand có phân trang
    public List<Brand> getAllBrandPaging(int page, int pageSize) {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand ORDER BY brandID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandID(rs.getInt("brandID"));
                brand.setBrandName(rs.getString("brandName"));
                brand.setLogo(rs.getString("logo"));
                brand.setDescription(rs.getString("description"));
                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    // Đếm tổng số brand
    public int countAllBrand() {
        String sql = "SELECT COUNT(*) FROM Brand";
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

    // Tìm kiếm brand có phân trang
    public List<Brand> searchBrandPaging(String name, int page, int pageSize) {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand WHERE brandName LIKE ? ORDER BY brandID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandID(rs.getInt("brandID"));
                brand.setBrandName(rs.getString("brandName"));
                brand.setLogo(rs.getString("logo"));
                brand.setDescription(rs.getString("description"));
                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    // Đếm tổng số brand theo điều kiện tìm kiếm
    public int countBrandSearch(String name) {
        String sql = "SELECT COUNT(*) FROM Brand WHERE brandName LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public List<Brand> gettop6BrandHighestOrder() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT TOP 6 \n"
                + "    b.brandID,\n"
                + "    b.brandName,\n"
                + "	b.logo,\n"
                + "    COALESCE(COUNT(DISTINCT od.orderID), 0) AS orderCount\n"
                + "FROM tbBrand b\n"
                + "LEFT JOIN tbProduct p ON b.brandID = p.brandID\n"
                + "LEFT JOIN tbProductVariant pv ON p.productID = pv.productID\n"
                + "LEFT JOIN tbOrderDetail od ON pv.variantID = od.variantID\n"
                + "LEFT JOIN tbOrder o ON od.orderID = o.orderID\n"
                + "GROUP BY b.brandID, b.brandName, b.logo\n"
                + "ORDER BY orderCount DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand b = new Brand(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3));

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
}
