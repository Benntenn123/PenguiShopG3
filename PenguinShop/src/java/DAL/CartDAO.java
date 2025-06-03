/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Cart;
import Models.Category;
import Models.Color;
import Models.Product;
import Models.ProductVariant;
import Models.Size;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends DBContext {

     public List<Cart> getCartUser(int userID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.cartID, c.userID, pv.variantID, p.productID, p.productName, p.imageMainProduct, " +
                    "pv.price, pv.quantity AS variantQuantity, pv.stockStatus, c.quantity AS cartQuantity, " +
                    "col.colorID, col.colorName, s.sizeID, s.sizeName " +
                    "FROM dbo.tbCart c " +
                    "JOIN dbo.tbProductVariant pv ON c.variantID = pv.variantID " +
                    "JOIN dbo.tbProduct p ON pv.productID = p.productID " +
                    "JOIN dbo.tbColor col ON pv.colorID = col.colorID " +
                    "JOIN dbo.tbSize s ON pv.sizeID = s.sizeID " +
                    "WHERE c.userID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User(rs.getInt("userID"));
                    Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("imageMainProduct")
                    );
                    Color color = new Color(
                        rs.getInt("colorID"),
                        rs.getString("colorName")
                    );
                    Size size = new Size(
                        rs.getInt("sizeID"),
                        rs.getString("sizeName")
                    );
                    ProductVariant variant = new ProductVariant(
                        rs.getInt("variantID"),
                        rs.getInt("variantQuantity"),
                        product,
                        color,
                        size,
                        rs.getDouble("price"),
                        String.valueOf(rs.getInt("stockStatus")) // Convert INT to String
                    );
                    Cart cart = new Cart(
                        rs.getInt("cartID"),
                        user,
                        variant,
                        rs.getInt("cartQuantity"),
                        product
                    );
                    cartItems.add(cart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework in production
        }
        return cartItems;
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
    public boolean deleteCart(int userID, int cartID) {
        String sql = "DELETE FROM dbo.tbCart WHERE cartID = ? AND userID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartID);
            ps.setInt(2, userID);
            int result = ps.executeUpdate();
            if (result == 1) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }
    
    
    public static void main(String[] args) {
        CartDAO cdao = new CartDAO();
        System.out.println(cdao.isValidCartItem(7, 1));
    }

    public boolean isValidCartItem(int cartId, int userID) {
        String sql = "select count(*) FROM dbo.tbCart WHERE cartID = ? AND userID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.setInt(2, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                int row = rs.getInt(1);
                if(row == 1){
                    return true;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    
    }
}
