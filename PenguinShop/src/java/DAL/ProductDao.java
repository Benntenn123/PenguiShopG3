/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Category;
import Models.Product;
import Models.ProductVariant;
import Models.Type;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao extends DBContext {

    public List<Product> getAll() {
        String sql = "select * from tbProduct p join tbCategory c on p.categoryID = c.categoryID  join tbProductType t on p.productTypeID = t.productTypeID ";
        List<Product> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Type type = new Type(rs.getInt("productTypeId"), rs.getString("productTypeName"));
                Category category = new Category(rs.getInt("categoryId"), rs.getString("categoryName"), rs.getString("sportType"));
                Product prodcut = new Product(rs.getInt("productId"), rs.getString("productName"), rs.getString("SKU"), type, category, rs.getString("importDate"), rs.getString("description"), rs.getDouble("weight"));
                list.add(prodcut);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductVariant> getNewArrival() {
        String sql = "SELECT TOP 8 * FROM dbo.tbProduct p \n"
                + "JOIN dbo.tbProductCategory pc ON pc.productID = p.productID\n"
                + "JOIN dbo.tbCategory c ON c.categoryID = pc.categoryID\n"
                + "JOIN dbo.tbProductVariant pv ON pv.productID = p.productID\n"
                + "WHERE c.categoryID = 11\n"
                + "ORDER BY p.importDate desc";
        List<ProductVariant> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("imageMainProduct"));
                ProductVariant pv = new ProductVariant(rs.getInt("variantID"),
                        p, rs.getDouble("price"));
                list.add(pv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductVariant> getHotProduct() {
        String sql = "SELECT TOP 8 * FROM dbo.tbProduct p \n"
                + "JOIN dbo.tbProductCategory pc ON pc.productID = p.productID\n"
                + "JOIN dbo.tbCategory c ON c.categoryID = pc.categoryID\n"
                + "JOIN dbo.tbProductVariant pv ON pv.productID = p.productID\n"
                + "WHERE c.categoryID = 9\n"
                + "ORDER BY p.importDate DESC";
        List<ProductVariant> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("imageMainProduct"));
                ProductVariant pv = new ProductVariant(rs.getInt("variantID"),
                        p, rs.getDouble("price"));
                list.add(pv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
