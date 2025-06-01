/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Cart;
import Models.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartDAO extends DBContext {

    public Cart gerCartUser() {
        String sql = "SELECT\n"
                + "    c.cartID,\n"
                + "    c.userID,\n"
                + "    c.quantity,\n"
                + "    p.productID,\n"
                + "    p.productName,\n"
                + "    p.imageMainProduct,\n"
                + "    v.variantID,\n"
                + "    v.price,\n"
                + "    col.colorName,\n"
                + "    s.sizeName\n"
                + "FROM tbCart c\n"
                + "INNER JOIN tbProductVariant v ON c.variantID = v.variantID\n"
                + "INNER JOIN tbProduct p ON c.productID = p.productID AND v.productID = p.productID\n"
                + "INNER JOIN tbColor col ON v.colorID = col.colorID\n"
                + "INNER JOIN tbSize s ON v.sizeID = s.sizeID\n"
                + "WHERE c.userID = ? AND v.variantID = ?;\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkExistProductInCart(int userID, int variantID) {
        String sql = "SELECT \n"
                + "   COUNT(*)\n"
                + "FROM tbCart c\n"
                + "INNER JOIN tbProductVariant v ON c.variantID = v.variantID\n"
                + "INNER JOIN tbProduct p ON c.productID = p.productID AND v.productID = p.productID\n"
                + "INNER JOIN tbColor col ON v.colorID = col.colorID\n"
                + "INNER JOIN tbSize s ON v.sizeID = s.sizeID\n"
                + "WHERE c.userID = ? AND v.variantID = ?;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
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


    public boolean updateQuantity(int userID, int variantID) {
        String sql = "UPDATE dbo.tbCart SET quantity= quantity +1 WHERE userID = ?"
                + " AND variantID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, variantID);
            int result = ps.executeUpdate();
            if (result == 1) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public boolean addToCart(Cart cart) {
        String sql = "INSERT INTO dbo.tbCart\n"
                + "(userID,variantID,quantity,productID)\n"
                + "VALUES(?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cart.getUser().getUserID());
            ps.setInt(2, cart.getVariant().getVariantID());
            ps.setInt(3, cart.getQuantity());
            ps.setInt(4, cart.getProduct().getProductId());
            int result = ps.executeUpdate();
            if (result == 1) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }
}
