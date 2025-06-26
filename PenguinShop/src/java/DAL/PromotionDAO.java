/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Color;
import Models.Product;
import Models.ProductVariant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Models.Promotion;
import Models.Size;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class PromotionDAO extends DBContext {

    public List<Promotion> getAllPromotionsWithDetails() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT p.* FROM tbPromotion p";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionID(rs.getInt("promotionID"));
                promotion.setPromotionName(rs.getString("promotionName"));
                promotion.setDiscountType(rs.getString("discountType"));
                promotion.setDiscountValue(rs.getDouble("discountValue"));
                // Chuyển DATETIME sang String
                promotion.setStartDate(rs.getString("startDate") != null ? rs.getString("startDate") : null);
                promotion.setEndDate(rs.getString("endDate") != null ? rs.getString("endDate") : null);
                promotion.setDescription(rs.getString("description"));
                promotion.setIsActive(rs.getInt("isActive"));

                // Chỉ lấy variant cho modal
                promotion.setVariant(getVariantsForPromotion(promotion.getPromotionID()));

                promotions.add(promotion);
            }
        } catch (Exception e) {

        }
        return promotions;
    }

    public int getTotalPromotions() throws SQLException {
        String sql = "SELECT COUNT(*) FROM tbPromotion";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Promotion> getPromotionsByPage(int page, int pageSize) throws SQLException {
        List<Promotion> promotions = new ArrayList<>();

        String sql = "SELECT "
                + "p.promotionID, p.promotionName, p.discountType, p.discountValue, "
                + "p.startDate, p.endDate, p.description, p.isActive, "
                + "COUNT(DISTINCT pp.variantID) AS totalCount "
                + "FROM tbPromotion p "
                + "LEFT JOIN tbProductPromotion pp ON p.promotionID = pp.promotionID "
                + "GROUP BY p.promotionID, p.promotionName, p.discountType, p.discountValue, "
                + "p.startDate, p.endDate, p.description, p.isActive "
                + "ORDER BY p.promotionID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize); // OFFSET
            stmt.setInt(2, pageSize);              // FETCH NEXT

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Promotion promotion = new Promotion();
                    promotion.setPromotionID(rs.getInt("promotionID"));
                    promotion.setPromotionName(rs.getString("promotionName"));
                    promotion.setDiscountType(rs.getString("discountType"));
                    promotion.setDiscountValue(rs.getDouble("discountValue"));
                    promotion.setStartDate(rs.getString("startDate"));
                    promotion.setEndDate(rs.getString("endDate"));
                    promotion.setDescription(rs.getString("description"));
                    promotion.setIsActive(rs.getInt("isActive"));
                    promotion.setTotalCount(rs.getInt("totalCount"));

                    // Lấy danh sách variant áp dụng cho promotion
                    List<ProductVariant> variants = getVariantsForPromotion(promotion.getPromotionID());
                    promotion.setVariant(variants);

                    promotions.add(promotion);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL error in getPromotionsByPage: " + e.getMessage());
            throw e; // ném tiếp để xử lý bên trên nếu cần
        }

        return promotions;
    }

    private List<ProductVariant> getVariantsForPromotion(int promotionID) throws SQLException {
        List<ProductVariant> variants = new ArrayList<>();
        System.out.println("1");
        String sql = "SELECT pv.*, p.productName, s.sizeName, c.colorName "
                + "FROM tbProductVariant pv "
                + "JOIN tbProductPromotion pp ON pv.variantID = pp.variantID "
                + "JOIN tbProduct p ON pv.productID = p.productID "
                + "JOIN tbSize s ON pv.sizeID = s.sizeID "
                + "JOIN tbColor c ON pv.colorID = c.colorID "
                + "WHERE pp.promotionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, promotionID);
            System.out.println(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductVariant variant = new ProductVariant();
                    variant.setVariantID(rs.getInt("variantID"));
                    variant.setQuantity(rs.getInt("quantity"));
                    variant.setPrice(rs.getDouble("price"));
                    variant.setStockStatus(rs.getString("stockStatus"));
                    variant.setStockSta(rs.getInt("stockStatus"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("productID"));
                    product.setProductName(rs.getString("productName"));
                    variant.setProduct(product);

                    Size size = new Size();
                    size.setSizeID(rs.getInt("sizeID"));
                    size.setSizeName(rs.getString("sizeName"));
                    variant.setSize(size);

                    Color color = new Color();
                    color.setColorID(rs.getInt("colorID"));
                    color.setColorName(rs.getString("colorName"));
                    variant.setColor(color);

                    variants.add(variant);
                }
            }
        }
        return variants;
    }

    public boolean updatePromotion(Promotion promotion) throws SQLException {
        String sql = "UPDATE tbPromotion SET promotionName = ?, discountType = ?, discountValue = ?, "
                + "startDate = ?, endDate = ?, description = ?, isActive = ? WHERE promotionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, promotion.getPromotionName());
            stmt.setString(2, promotion.getDiscountType());
            stmt.setDouble(3, promotion.getDiscountValue());

            // Convert String → Timestamp (nếu không null hoặc rỗng)
            Timestamp startTs = null;
            Timestamp endTs = null;

            if (promotion.getStartDate() != null && !promotion.getStartDate().isEmpty()) {
                startTs = Timestamp.valueOf(promotion.getStartDate().replace("T", " ") + ":00");
            }
            if (promotion.getEndDate() != null && !promotion.getEndDate().isEmpty()) {
                endTs = Timestamp.valueOf(promotion.getEndDate().replace("T", " ") + ":00");
            }

            stmt.setTimestamp(4, startTs);
            stmt.setTimestamp(5, endTs);
            stmt.setString(6, promotion.getDescription());
            stmt.setInt(7, promotion.getIsActive());
            stmt.setInt(8, promotion.getPromotionID());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean togglePromotionStatus(int promotionID, int isActive) throws SQLException {
        String sql = "UPDATE tbPromotion SET isActive = ? WHERE promotionID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, isActive == 1 ? 0 : 1); // Đảo trạng thái: 1 -> 0, 0 -> 1
            stmt.setInt(2, promotionID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    // JDBC DAO Method: Load Promotion with 4 Products of Soon-Expiring Promotion

    public Promotion getSoonExpiringPromotionWithProducts() throws SQLException {
        Promotion promotion = null;
        String sql = "SELECT TOP 4 "
                + "    p.productID, p.productName, p.imageMainProduct, "
                + "    pv.variantID, pv.price, pv.colorID, c.colorName, "
                + "    pv.sizeID, s.sizeName, pv.quantity, "
                + "    pr.promotionID, pr.promotionName, pr.discountType, pr.discountValue, pr.endDate "
                + "FROM tbPromotion pr "
                + "JOIN tbProductPromotion pp ON pr.promotionID = pp.promotionID "
                + "JOIN tbProductVariant pv ON pp.variantID = pv.variantID "
                + "JOIN tbProduct p ON pv.productID = p.productID "
                + "LEFT JOIN tbColor c ON pv.colorID = c.colorID "
                + "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID "
                + "WHERE pr.isActive = 1 AND GETDATE() BETWEEN pr.startDate AND pr.endDate "
                + "AND pr.promotionID = (SELECT TOP 1 promotionID FROM tbPromotion WHERE isActive = 1 AND GETDATE() BETWEEN startDate AND endDate ORDER BY endDate ASC)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            System.out.println(sql);
            ResultSet rs = ps.executeQuery();
            List<ProductVariant> variantList = new ArrayList<>();
            
            while (rs.next()) {
                if (promotion == null) {
                    promotion = new Promotion();
                    promotion.setPromotionID(rs.getInt("promotionID"));
                    promotion.setPromotionName(rs.getString("promotionName"));
                    promotion.setDiscountType(rs.getString("discountType"));
                    promotion.setDiscountValue(rs.getDouble("discountValue"));
                    promotion.setEndDate(rs.getString("endDate"));
                    promotion.setVariant(new ArrayList<>());
                }

                Product product = new Product();
                product.setProductId(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setImageMainProduct(rs.getString("imageMainProduct"));

                ProductVariant variant = new ProductVariant();
                variant.setVariantID(rs.getInt("variantID"));
                variant.setPrice(rs.getDouble("price"));
                variant.setQuantity(rs.getInt("quantity"));
                variant.setProduct(product);

                Color color = new Color();
                color.setColorID(rs.getInt("colorID"));
                color.setColorName(rs.getString("colorName"));
                variant.setColor(color);

                Size size = new Size();
                size.setSizeID(rs.getInt("sizeID"));
                size.setSizeName(rs.getString("sizeName"));
                variant.setSize(size);

                promotion.getVariant().add(variant);
            }
        }
        return promotion;
    }
    public boolean addPromotion(Promotion promotion) throws SQLException {
        String sql = "INSERT INTO tbPromotion (promotionName, discountType, discountValue, startDate, endDate, description, isActive) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, promotion.getPromotionName());
            stmt.setString(2, promotion.getDiscountType());
            stmt.setDouble(3, promotion.getDiscountValue());
            stmt.setString(4, promotion.getStartDate());
            stmt.setString(5, promotion.getEndDate());
            stmt.setString(6, promotion.getDescription() != null ? promotion.getDescription() : "");
            stmt.setInt(7, promotion.getIsActive());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    

    public List<Integer> getVariantIDsByPromotion(int promotionID) throws SQLException {
        List<Integer> variantIDs = new ArrayList<>();
        String sql = "SELECT variantID FROM tbProductPromotion WHERE promotionID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, promotionID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    variantIDs.add(rs.getInt("variantID"));
                }
            }
        }
        return variantIDs;
    }

    public boolean addPromotionVariant(int promotionID, int variantID) throws SQLException {
        String sql = "INSERT INTO tbProductPromotion (promotionID, variantID) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, promotionID);
            stmt.setInt(2, variantID);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean removePromotionVariant(int promotionID, int variantID) throws SQLException {
        String sql = "DELETE FROM tbProductPromotion WHERE promotionID = ? AND variantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, promotionID);
            stmt.setInt(2, variantID);
            return stmt.executeUpdate() > 0;
        }
    }

    public static void main(String[] args) {
        PromotionDAO pdao = new PromotionDAO();
        try {
            List<Promotion> list = pdao.getPromotionsByPage(1, 10);
            for (Promotion promotion : list) {
                System.out.println(promotion.getVariant().size());
            }
//                List<ProductVariant> list = pdao.getVariantsForPromotion(1);
//                System.out.println(list.size());
        } catch (Exception e) {
        }

    }

}
