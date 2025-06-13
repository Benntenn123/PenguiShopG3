/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Brand;
import Models.Category;
import Models.Color;
import Models.Product;
import Models.ProductVariant;
import Models.Size;
import Models.Tag;
import Models.Type;
import Models.User;
import Utils.StringConvert;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductDao extends DBContext {

    public List<Product> getAll() {
        String sql = "select * from tbProduct p join tbCategory c "
                + "on p.categoryID = c.categoryID  "
                + "join tbProductType t on p.productTypeID = t.productTypeID ";
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
        String sql = "SELECT TOP 8 p.*, pv.*\n"
                + "FROM dbo.tbProduct p\n"
                + "JOIN dbo.tbProductCategory pc ON pc.productID = p.productID\n"
                + "JOIN dbo.tbCategory c ON c.categoryID = pc.categoryID\n"
                + "OUTER APPLY (\n"
                + "    SELECT TOP 1 *\n"
                + "    FROM dbo.tbProductVariant pv\n"
                + "    WHERE pv.productID = p.productID\n"
                + "    ORDER BY pv.price ASC -- lấy variant có giá rẻ nhất\n"
                + ") pv\n"
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

    public List<ProductVariant> getRelatedProduct(List<Integer> categoriesID) {

        if (categoriesID == null || categoriesID.isEmpty()) {
            return new ArrayList<>();
        }

        String sql = "SELECT TOP 4 * FROM dbo.tbProduct p \n"
                + "JOIN dbo.tbProductCategory pc ON pc.productID = p.productID\n"
                + "JOIN dbo.tbCategory c ON c.categoryID = pc.categoryID\n"
                + "JOIN dbo.tbProductVariant pv ON pv.productID = p.productID\n"
                + "WHERE c.categoryID IN ("
                + String.join(",", Collections.nCopies(categoriesID.size(), "?"))
                + ")\n"
                + "ORDER BY p.importDate DESC";

        List<ProductVariant> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            for (int i = 0; i < categoriesID.size(); i++) {
                ps.setInt(i + 1, categoriesID.get(i));
            }

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

    public List<ProductVariant> loadTop4ProductHotWeek() {
        String sql = "SELECT TOP 4 \n"
                + "    p.productID,\n"
                + "    p.productName,\n"
                + "    pv.variantID,\n"
                + "	pv.price,\n"
                + "    p.imageMainProduct,\n"
                + "    COALESCE(SUM(od.quantity_product), 0) AS totalSold\n"
                + "FROM tbProduct p\n"
                + "LEFT JOIN tbProductVariant pv ON p.productID = pv.productID\n"
                + "LEFT JOIN tbOrderDetail od ON pv.variantID = od.variantID\n"
                + "LEFT JOIN tbOrder o ON od.orderID = o.orderID\n"
                + "WHERE o.orderDate IS NULL \n"
                + "   OR o.orderDate BETWEEN DATEADD(DAY, -7, GETDATE()) AND GETDATE()\n"
                + "GROUP BY p.productID, p.productName,pv.variantID,pv.price,  p.imageMainProduct\n"
                + "ORDER BY totalSold DESC, p.productName ASC;";
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

    public ProductVariant loadProductWithID(int variantID) {
        String sql = "SELECT p.productID,p.productName,p.imageMainProduct,pv.variantID,pv.price,p.description,p.SKU,p.full_description FROM dbo.tbProduct p\n"
                + "JOIN dbo.tbProductVariant pv ON pv.productID = p.productID\n"
                + "JOIN dbo.tbBrand br ON br.brandID = p.brandID\n"
                + "JOIN dbo.tbProductType pt ON pt.productTypeID = p.productTypeID\n"
                + "WHERE pv.variantID = ?;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("imageMainProduct"),
                        rs.getString("description"),
                        rs.getString("SKU"),
                        rs.getString("full_description"));
                ProductVariant pv = new ProductVariant(rs.getInt("variantID"),
                        p, rs.getDouble("price"));
                return pv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> loadImageProductWithID(int productID) {
        String sql = "SELECT i.imageURL FROM tbProduct p \n"
                + "JOIN dbo.tbImages i ON i.productID = p.productID\n"
                + "WHERE i.productID = ?";
        List<String> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Tag> loadTagProduct(int productID) {
        String sql = "SELECT t.tagID, t.tagName FROM dbo.tbProduct p\n"
                + "JOIN dbo.tbProductTag pt ON pt.productID = p.productID\n"
                + "JOIN tbTag t ON pt.tagID = t.tagID\n"
                + "WHERE p.productID = ?";
        List<Tag> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Tag(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Size> loadSizeProduct(int productID) {
        String sql = "SELECT DISTINCT \n"
                + "	s.sizeID,\n"
                + "    s.sizeName\n"
                + "FROM tbProduct p\n"
                + "JOIN tbProductVariant pv ON p.productID = pv.productID\n"
                + "JOIN tbSize s ON pv.sizeID = s.sizeID\n"
                + "JOIN tbColor c ON pv.colorID = c.colorID\n"
                + "WHERE p.productID = ?;";
        List<Size> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Size(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Color> loadColorProduct(int productID) {
        String sql = "SELECT DISTINCT \n"
                + "	c.colorID,\n"
                + "    c.colorName\n"
                + "FROM tbProduct p\n"
                + "JOIN tbProductVariant pv ON p.productID = pv.productID\n"
                + "JOIN tbSize s ON pv.sizeID = s.sizeID\n"
                + "JOIN tbColor c ON pv.colorID = c.colorID\n"
                + "WHERE p.productID = ?;";
        List<Color> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Color(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductVariant> loadProductVariants(String[] categoryIDs, String[] brandIDs, String[] colorIDs,
            String[] sizeIDs, String from, String to, String q, int page, int pageSize) {

        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT p.productID, p.productName, p.imageMainProduct, pv.variantID, pv.price "
                + "FROM tbProduct p "
                + "JOIN tbProductVariant pv ON p.productID = pv.productID "
                + "LEFT JOIN tbBrand b ON p.brandID = b.brandID "
                + "LEFT JOIN tbColor col ON pv.colorID = col.colorID "
                + "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID "
                + "WHERE 1=1 "
        );

        List<Object> paramsList = new ArrayList<>();

        // Filter by category using EXISTS to avoid duplicates
        int[] categoryIntIDs = StringConvert.convertToIntArray(categoryIDs);
        if (categoryIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(categoryIntIDs.length, "?"));
            sql.append("AND EXISTS (SELECT 1 FROM tbProductCategory pc WHERE pc.productID = p.productID AND pc.categoryID IN (" + placeholders + ")) ");
            for (int id : categoryIntIDs) {
                paramsList.add(id);
            }
        }

        // Filter by brand
        int[] brandIntIDs = StringConvert.convertToIntArray(brandIDs);
        if (brandIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(brandIntIDs.length, "?"));
            sql.append("AND b.brandID IN (" + placeholders + ") ");
            for (int id : brandIntIDs) {
                paramsList.add(id);
            }
        }

        // Filter by color
        int[] colorIntIDs = StringConvert.convertToIntArray(colorIDs);
        if (colorIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(colorIntIDs.length, "?"));
            sql.append("AND col.colorID IN (" + placeholders + ") ");
            for (int id : colorIntIDs) {
                paramsList.add(id);
            }
        }

        // Filter by size
        int[] sizeIntIDs = StringConvert.convertToIntArray(sizeIDs);
        if (sizeIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(sizeIntIDs.length, "?"));
            sql.append("AND s.sizeID IN (" + placeholders + ") ");
            for (int id : sizeIntIDs) {
                paramsList.add(id);
            }
        }

        // Price range
        if (from != null && !from.trim().isEmpty()) {
            try {
                sql.append("AND pv.price >= ? ");
                paramsList.add(Double.parseDouble(from.trim()));
            } catch (NumberFormatException e) {
            }
        }
        if (to != null && !to.trim().isEmpty()) {
            try {
                sql.append("AND pv.price <= ? ");
                paramsList.add(Double.parseDouble(to.trim()));
            } catch (NumberFormatException e) {
            }
        }

        // Search query
        if (q != null && !q.trim().isEmpty()) {
            sql.append("AND p.productName LIKE ? ");
            paramsList.add("%" + q.trim() + "%");
        }

        // Pagination
        int offset = (page - 1) * pageSize;
        sql.append("ORDER BY pv.variantID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        paramsList.add(offset);
        paramsList.add(pageSize);

        List<ProductVariant> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < paramsList.size(); i++) {
                ps.setObject(i + 1, paramsList.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("imageMainProduct")
                );
                ProductVariant variant = new ProductVariant(
                        rs.getInt("variantID"),
                        product,
                        rs.getDouble("price")
                );
                list.add(variant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int calculateTotalProductVariants(String[] categoryIDs, String[] brandIDs, String[] colorIDs,
            String[] sizeIDs, String from, String to, String q) {

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT pv.variantID) "
                + "FROM tbProduct p "
                + "JOIN tbProductVariant pv ON p.productID = pv.productID "
                + "LEFT JOIN tbBrand b ON p.brandID = b.brandID "
                + "LEFT JOIN tbColor col ON pv.colorID = col.colorID "
                + "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID "
                + "WHERE 1=1 "
        );

        List<Object> paramsList = new ArrayList<>();

        // categoryID filter
        int[] categoryIntIDs = StringConvert.convertToIntArray(categoryIDs);
        if (categoryIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(categoryIntIDs.length, "?"));
            sql.append("AND EXISTS (SELECT 1 FROM tbProductCategory pc WHERE pc.productID = p.productID AND pc.categoryID IN (" + placeholders + ")) ");
            for (int id : categoryIntIDs) {
                paramsList.add(id);
            }
        }

        // brand
        int[] brandIntIDs = StringConvert.convertToIntArray(brandIDs);
        if (brandIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(brandIntIDs.length, "?"));
            sql.append("AND b.brandID IN (" + placeholders + ") ");
            for (int id : brandIntIDs) {
                paramsList.add(id);
            }
        }

        // color
        int[] colorIntIDs = StringConvert.convertToIntArray(colorIDs);
        if (colorIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(colorIntIDs.length, "?"));
            sql.append("AND col.colorID IN (" + placeholders + ") ");
            for (int id : colorIntIDs) {
                paramsList.add(id);
            }
        }

        // size
        int[] sizeIntIDs = StringConvert.convertToIntArray(sizeIDs);
        if (sizeIntIDs != null) {
            String placeholders = String.join(",", java.util.Collections.nCopies(sizeIntIDs.length, "?"));
            sql.append("AND s.sizeID IN (" + placeholders + ") ");
            for (int id : sizeIntIDs) {
                paramsList.add(id);
            }
        }

        // price
        if (from != null && !from.trim().isEmpty()) {
            try {
                sql.append("AND pv.price >= ? ");
                paramsList.add(Double.parseDouble(from.trim()));
            } catch (NumberFormatException e) {
            }
        }
        if (to != null && !to.trim().isEmpty()) {
            try {
                sql.append("AND pv.price <= ? ");
                paramsList.add(Double.parseDouble(to.trim()));
            } catch (NumberFormatException e) {
            }
        }

        // search
        if (q != null && !q.trim().isEmpty()) {
            sql.append("AND p.productName LIKE ? ");
            paramsList.add("%" + q.trim() + "%");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < paramsList.size(); i++) {
                ps.setObject(i + 1, paramsList.get(i));
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

    

    public boolean isValidProductAndVariant(int variantID, int productID) {
        String sql = "SELECT COUNT(*) FROM dbo.tbProductVariant"
                + " WHERE productID = ? AND variantID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setInt(2, variantID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int result = rs.getInt(1);
                if (result == 1) {
                    return true;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public ProductVariant loadProductVariant(int productId, int colorId, int sizeId) {
        String sql = "SELECT p.variantID, p.price, p.quantity,p.stockStatus FROM dbo.tbProductVariant p \n"
                + "JOIN dbo.tbProduct pr ON pr.productID = p.productID\n"
                + "JOIN dbo.tbColor c ON c.colorID = p.colorID\n"
                + "JOIN dbo.tbSize s ON s.sizeID = p.sizeID\n"
                + "WHERE c.colorID = ? AND p.productID = ? AND p.sizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, colorId);
            ps.setInt(2, productId);
            ps.setInt(3, sizeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant pv = new ProductVariant(rs.getInt(1)
                        , rs.getInt(3),
                        rs.getInt(2),rs.getString(4));
                return pv;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    
    }
    public List<ProductVariant> getProductVariants(String[] searchCriteria, int page, int pageSize) {
    List<ProductVariant> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
            "SELECT pv.variantID, pv.quantity, pv.price, pv.stockStatus, " +
            "p.productID, p.productName, p.SKU, p.importDate, p.imageMainProduct, p.description, p.full_description, p.weight, " +
            "c.colorID, c.colorName, s.sizeID, s.sizeName, " +
            "b.brandID, b.brandName, pt.productTypeID, pt.productTypeName, " +
            "STRING_AGG(cat.categoryName, ', ') AS categoryNames " +
            "FROM tbProductVariant pv " +
            "JOIN tbProduct p ON pv.productID = p.productID " +
            "JOIN tbColor c ON pv.colorID = c.colorID " +
            "JOIN tbSize s ON pv.sizeID = s.sizeID " +
            "JOIN tbBrand b ON p.brandID = b.brandID " +
            "JOIN tbProductType pt ON p.productTypeID = pt.productTypeID " +
            "LEFT JOIN tbProductCategory pc ON p.productID = pc.productID " +
            "LEFT JOIN tbCategory cat ON pc.categoryID = cat.categoryID " +
            "WHERE 1=1"
    );

    List<Object> params = new ArrayList<>();
    int quantityValue = -1;

    if (searchCriteria != null && searchCriteria.length > 0) {
        if (searchCriteria.length > 0 && searchCriteria[0] != null && !searchCriteria[0].trim().isEmpty()) {
            sql.append(" AND p.productName LIKE ?");
            params.add("%" + searchCriteria[0].trim() + "%");
        }
        if (searchCriteria.length > 1 && searchCriteria[1] != null && !searchCriteria[1].trim().isEmpty()) {
            sql.append(" AND c.colorName LIKE ?");
            params.add("%" + searchCriteria[1].trim() + "%");
        }
        if (searchCriteria.length > 2 && searchCriteria[2] != null && !searchCriteria[2].trim().isEmpty()) {
            sql.append(" AND s.sizeName LIKE ?");
            params.add("%" + searchCriteria[2].trim() + "%");
        }
        if (searchCriteria.length > 3 && searchCriteria[3] != null && !searchCriteria[3].trim().isEmpty()) {
            sql.append(" AND pv.stockStatus LIKE ?");
            params.add("%" + searchCriteria[3].trim() + "%");
        }
        if (searchCriteria.length > 4 && searchCriteria[4] != null && !searchCriteria[4].trim().isEmpty()) {
            try {
                quantityValue = Integer.parseInt(searchCriteria[4].trim());
                if (quantityValue >= 0) {
                    sql.append(" AND pv.quantity >= ?");
                    params.add(quantityValue);
                }
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không parse được
            }
        }
        if (searchCriteria.length > 5 && searchCriteria[5] != null && !searchCriteria[5].trim().isEmpty()) {
            sql.append(" AND pt.productTypeName LIKE ?");
            params.add("%" + searchCriteria[5].trim() + "%");
        }
        if (searchCriteria.length > 6 && searchCriteria[6] != null && !searchCriteria[6].trim().isEmpty()) {
            sql.append(" AND b.brandName LIKE ?");
            params.add("%" + searchCriteria[6].trim() + "%");
        }
        if (searchCriteria.length > 7 && searchCriteria[7] != null && !searchCriteria[7].trim().isEmpty()) {
            sql.append(" AND EXISTS (SELECT 1 FROM tbProductCategory pc2 " +
                       "JOIN tbCategory cat2 ON pc2.categoryID = cat2.categoryID " +
                       "WHERE pc2.productID = p.productID AND cat2.categoryName LIKE ?)");
            params.add("%" + searchCriteria[7].trim() + "%");
        }
    }

    sql.append(" GROUP BY pv.variantID, pv.quantity, pv.price, pv.stockStatus, " +
               "p.productID, p.productName, p.SKU, p.importDate, p.imageMainProduct, p.description, p.full_description, p.weight, " +
               "c.colorID, c.colorName, s.sizeID, s.sizeName, b.brandID, b.brandName, pt.productTypeID, pt.productTypeName " +
               "ORDER BY pv.variantID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ps.setInt(params.size() + 1, (page - 1) * pageSize);
        ps.setInt(params.size() + 2, pageSize);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Type type = new Type(rs.getInt("productTypeID"), rs.getString("productTypeName"));
                Brand brand = new Brand(rs.getString("brandName"));
                String categoryNames = rs.getString("categoryNames") != null ? rs.getString("categoryNames") : "Không có danh mục";
                Category category = new Category(0, categoryNames, null); // categoryID = 0 vì không có ID cụ thể
                Product product = new Product(
                    rs.getInt("productID"), rs.getString("productName"), rs.getString("SKU"),
                    type, category, rs.getString("importDate"), rs.getString("imageMainProduct"),
                    rs.getString("description"), rs.getDouble("weight"),
                    rs.getString("full_description"), brand
                );

                Color color = new Color(rs.getInt("colorID"), rs.getString("colorName"));
                Size size = new Size(rs.getInt("sizeID"), rs.getString("sizeName"));

                ProductVariant variant = new ProductVariant(
                    rs.getInt("variantID"), rs.getInt("quantity"), product, color, size,
                    rs.getDouble("price"), rs.getString("stockStatus")
                );
                list.add(variant);
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error fetching product variants: " + e.getMessage(), e);
    }
    return list;
}
    public int getTotalRecords(String[] searchCriteria) {
    List<Object> params = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
            "SELECT COUNT(DISTINCT pv.variantID) AS total " +
            "FROM tbProductVariant pv " +
            "JOIN tbProduct p ON pv.productID = p.productID " +
            "JOIN tbColor c ON pv.colorID = c.colorID " +
            "JOIN tbSize s ON pv.sizeID = s.sizeID " +
            "JOIN tbBrand b ON p.brandID = b.brandID " +
            "JOIN tbProductType pt ON p.productTypeID = pt.productTypeID " +
            "LEFT JOIN tbProductCategory pc ON p.productID = pc.productID " +
            "LEFT JOIN tbCategory cat ON pc.categoryID = cat.categoryID " +
            "WHERE 1=1"
    );

    int quantityValue = -1;

    if (searchCriteria != null && searchCriteria.length > 0) {
        if (searchCriteria.length > 0 && searchCriteria[0] != null && !searchCriteria[0].trim().isEmpty()) {
            sql.append(" AND p.productName LIKE ?");
            params.add("%" + searchCriteria[0].trim() + "%");
        }
        if (searchCriteria.length > 1 && searchCriteria[1] != null && !searchCriteria[1].trim().isEmpty()) {
            sql.append(" AND c.colorName LIKE ?");
            params.add("%" + searchCriteria[1].trim() + "%");
        }
        if (searchCriteria.length > 2 && searchCriteria[2] != null && !searchCriteria[2].trim().isEmpty()) {
            sql.append(" AND s.sizeName LIKE ?");
            params.add("%" + searchCriteria[2].trim() + "%");
        }
        if (searchCriteria.length > 3 && searchCriteria[3] != null && !searchCriteria[3].trim().isEmpty()) {
            sql.append(" AND pv.stockStatus LIKE ?");
            params.add("%" + searchCriteria[3].trim() + "%");
        }
        if (searchCriteria.length > 4 && searchCriteria[4] != null && !searchCriteria[4].trim().isEmpty()) {
            try {
                quantityValue = Integer.parseInt(searchCriteria[4].trim());
                if (quantityValue >= 0) {
                    sql.append(" AND pv.quantity >= ?");
                    params.add(quantityValue);
                }
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không parse được
            }
        }
        if (searchCriteria.length > 5 && searchCriteria[5] != null && !searchCriteria[5].trim().isEmpty()) {
            sql.append(" AND pt.productTypeName LIKE ?");
            params.add("%" + searchCriteria[5].trim() + "%");
        }
        if (searchCriteria.length > 6 && searchCriteria[6] != null && !searchCriteria[6].trim().isEmpty()) {
            sql.append(" AND b.brandName LIKE ?");
            params.add("%" + searchCriteria[6].trim() + "%");
        }
        if (searchCriteria.length > 7 && searchCriteria[7] != null && !searchCriteria[7].trim().isEmpty()) {
            sql.append(" AND EXISTS (SELECT 1 FROM tbProductCategory pc2 " +
                       "JOIN tbCategory cat2 ON pc2.categoryID = cat2.categoryID " +
                       "WHERE pc2.productID = p.productID AND cat2.categoryName LIKE ?)");
            params.add("%" + searchCriteria[7].trim() + "%");
        }
    }

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error counting product variants: " + e.getMessage(), e);
    }
    return 0;
}
    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        String[] searchCriteria = {
            "giày", "", "", "1", "", "", "", ""
        };
        int page = 1;
        int pageSize = 10;

        List<ProductVariant> variants = dao.getProductVariants(searchCriteria, page, pageSize);
        System.out.println("Found " + variants.size() + " variants:");
        for (ProductVariant v : variants) {
            System.out.println("Variant ID: " + v.getVariantID() +
                    ", Product: " + v.getProduct().getProductName() +
                    ", SKU: " + v.getProduct().getSku() +
                    ", Brand: " + v.getProduct().getBrand().getBrandName() +
                    ", Category: " + v.getProduct().getCategory().getCategoryName() +
                    ", Type: " + v.getProduct().getType().getTypeName() +
                    ", Color: " + v.getColor().getColorName() +
                    ", Size: " + v.getSize().getSizeName() +
                    ", Quantity: " + v.getQuantity() +
                    ", Price: " + v.getPrice() +
                    ", Stock Status: " + v.getStockStatus());
        }

        int totalRecords = dao.getTotalRecords(searchCriteria);
        System.out.println("Total Records: " + totalRecords);
    }

    
}
