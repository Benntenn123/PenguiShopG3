/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Order;
import Models.OrderDetail;
import Models.Product;
import Models.ProductVariant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO extends DBContext {

    public List<Order> getOrder(int userID, String[] info) {
        List<Order> orders = new ArrayList<>();
        int limit = 2;
        int page = Integer.parseInt(info[0]);
        String from = info[1];
        String to = info[2];
        int offset = (page - 1) * limit;

        StringBuilder sql = new StringBuilder(
                "WITH PagedOrders AS ( "
                + "   SELECT * FROM tbOrder "
                + "   WHERE userID = ? "
        );

        if (from != null && !from.isEmpty()) {
            sql.append("AND orderDate >= ? ");
        }
        if (to != null && !to.isEmpty()) {
            sql.append("AND orderDate <= ? ");
        }

        sql.append("ORDER BY orderID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY "
                + ") "
                + "SELECT o.*, od.detailID, od.price AS detailPrice, od.quantity_product, "
                + "       p.productName, p.imageMainProduct "
                + "FROM PagedOrders o "
                + "LEFT JOIN tbOrderDetail od ON o.orderID = od.orderID "
                + "JOIN tbProductVariant pv ON pv.variantID = od.variantID "
                + "JOIN tbProduct p ON p.productID = pv.productID "
                + "ORDER BY o.orderID"
        );

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            ps.setInt(paramIndex++, userID);

            if (from != null && !from.isEmpty()) {
                ps.setString(paramIndex++, from);
            }
            if (to != null && !to.isEmpty()) {
                ps.setString(paramIndex++, to);
            }

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, limit);

            ResultSet rs = ps.executeQuery();
            Map<Integer, Order> orderMap = new HashMap<>();

            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                Order order = orderMap.get(orderID);

                if (order == null) {
                    order = new Order(
                            orderID,
                            rs.getString("orderDate"),
                            rs.getDouble("total"),
                            null,
                            rs.getInt("orderStatus"),
                            rs.getString("shippingAddress"),
                            null,
                            rs.getBoolean("paymentStatus")
                    );
                    order.setOrderDetails(new ArrayList<>());
                    orderMap.put(orderID, order);
                    orders.add(order);
                }

                int detailID = rs.getInt("detailID");
                if (detailID != 0) {
                    OrderDetail detail = new OrderDetail(
                            detailID,
                            rs.getDouble("detailPrice"),
                            rs.getInt("quantity_product"),
                            new ProductVariant(
                                    new Product(rs.getString("productName"), rs.getString("imageMainProduct"))
                            )
                    );
                    order.getOrderDetails().add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalPages(int userID, String[] info) {
    int limit = 2;
    String from = info[1];
    String to = info[2];
    int totalRecords = 0;

    StringBuilder sql = new StringBuilder(
        "SELECT COUNT(*) AS total FROM tbOrder WHERE userID = ? "
    );

    if (from != null && !from.isEmpty()) {
        sql.append("AND orderDate >= ? ");
    }
    if (to != null && !to.isEmpty()) {
        sql.append("AND orderDate <= ? ");
    }

    try {
        PreparedStatement ps = connection.prepareStatement(sql.toString());
        int paramIndex = 1;
        ps.setInt(paramIndex++, userID);

        if (from != null && !from.isEmpty()) {
            ps.setString(paramIndex++, from);
        }
        if (to != null && !to.isEmpty()) {
            ps.setString(paramIndex++, to);
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            totalRecords = rs.getInt("total");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return (int) Math.ceil((double) totalRecords / limit);
}


    public static void main(String[] args) {
        OrderDAO odao = new OrderDAO();

    }

}
