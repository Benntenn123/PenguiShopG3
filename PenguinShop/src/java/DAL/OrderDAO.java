/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Color;
import Models.Order;
import Models.OrderDetail;
import Models.PaymentMethod;
import Models.Product;
import Models.ProductVariant;
import Models.Size;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.sql.SQLException;
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
                + "      p.productId ,p.productName, p.imageMainProduct,pv.variantID "
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
            System.out.println(sql);
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
                            new ProductVariant(rs.getInt("variantID"),
                                    new Product(rs.getInt("productId"), rs.getString("productName"), rs.getString("imageMainProduct"))
                            )
                    );
                    System.out.println("DB" + rs.getInt("variantID"));
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

    public int countOrdered(String[] params) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                + "FROM tbOrder o "
                + "LEFT JOIN tbUsers u ON o.userID = u.userID "
                + "WHERE 1=1 "
        );

        List<Object> queryParams = new ArrayList<>();

        if (params != null && params.length >= 5) {
            // orderID
            if (params[0] != null && !params[0].trim().isEmpty()) {
                try {
                    sql.append(" AND o.orderID = ? ");
                    queryParams.add(Integer.parseInt(params[0].trim()));
                } catch (NumberFormatException e) {
                    // Skip invalid orderID
                }
            }

            // fromDate
            if (params[1] != null && !params[1].trim().isEmpty()) {
                sql.append(" AND o.orderDate >= ? ");
                queryParams.add(params[1].trim());
            }

            // toDate
            if (params[2] != null && !params[2].trim().isEmpty()) {
                sql.append(" AND o.orderDate <= ? ");
                queryParams.add(params[2].trim());
            }

            // status
            if (params[3] != null && !params[3].trim().isEmpty()) {
                try {
                    sql.append(" AND o.orderStatus = ? ");
                    queryParams.add(Integer.parseInt(params[3].trim()));
                } catch (NumberFormatException e) {
                    // Skip invalid status
                }
            }

            // email
            if (params[4] != null && !params[4].trim().isEmpty()) {
                sql.append(" AND u.email LIKE ? ");
                queryParams.add("%" + params[4].trim() + "%");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < queryParams.size(); i++) {
                ps.setObject(i + 1, queryParams.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error counting orders: " + e.getMessage(), e);
        }
        return 0;
    }

    public List<Order> listOrders(String[] params, int page, int pageSize) throws SQLException {
        List<Order> orders = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT o.orderID, o.orderDate, o.total, o.userID, o.orderStatus, o.shippingAddress, u.email ,u.fullName "
                + "FROM tbOrder o "
                + "LEFT JOIN tbUsers u ON o.userID = u.userID "
                + "WHERE 1=1 "
        );

        List<Object> queryParams = new ArrayList<>();

        if (params != null && params.length >= 5) {
            // orderID
            if (params[0] != null && !params[0].trim().isEmpty()) {
                try {
                    sql.append(" AND o.orderID = ? ");
                    queryParams.add(Integer.parseInt(params[0].trim()));
                } catch (NumberFormatException e) {
                    // Skip invalid orderID
                }
            }

            // fromDate
            if (params[1] != null && !params[1].trim().isEmpty()) {
                sql.append(" AND o.orderDate >= ? ");
                queryParams.add(params[1].trim());
            }

            // toDate
            if (params[2] != null && !params[2].trim().isEmpty()) {
                sql.append(" AND o.orderDate <=? ");
                queryParams.add(params[2].trim());
            }

            // status
            if (params[3] != null && !params[3].trim().isEmpty()) {
                try {
                    sql.append(" AND o.orderStatus = ? ");
                    queryParams.add(Integer.parseInt(params[3].trim()));
                } catch (NumberFormatException e) {
                    // Skip invalid status
                }
            }

            // email
            if (params[4] != null && !params[4].trim().isEmpty()) {
                sql.append(" AND u.email LIKE ? ");
                queryParams.add("%" + params[4].trim() + "%");
            }
        }

        sql.append(" ORDER BY o.orderDate DESC ");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        queryParams.add((page - 1) * pageSize);
        queryParams.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < queryParams.size(); i++) {
                ps.setObject(i + 1, queryParams.get(i));
            }
            System.out.println(sql);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderDate(rs.getString("orderDate"));
                    order.setTotal(rs.getDouble("total"));
                    User u = new User(rs.getInt("userID"), rs.getString("fullName"));
                    order.setUser(u);
                    order.setOrderStatus(rs.getInt("orderStatus"));
                    order.setShippingAddress(rs.getString("shippingAddress"));
                    order.getUser().setEmail(rs.getString("email"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching orders: " + e.getMessage(), e);
        }
        return orders;
    }

    public Order getOrderDetails(int orderID) throws SQLException {
    Order order = null;
    String sql = 
            "SELECT o.orderID, o.orderDate, o.total, o.orderStatus, o.shippingAddress, o.paymentStatus, " +
            "pm.paymentMethodID, pm.paymentMethodName, u.userID, u.fullName, u.email, u.phone, o.shippingAddress, " +
            "od.detailID, od.variantID, od.quantity_product, od.price, o.emall_receiver, o.phone_receiver, o.name_receiver, o.shipFee, " +
            "p.productID, p.productName, c.colorID, c.colorName, s.sizeID, s.sizeName " +
            "FROM tbOrder o " +
            "LEFT JOIN tbPaymentMethod pm ON o.paymentMethod = pm.paymentMethodID " +
            "LEFT JOIN tbUsers u ON o.userID = u.userID " +
            "LEFT JOIN tbOrderDetail od ON o.orderID = od.orderID " +
            "LEFT JOIN tbProductVariant pv ON od.variantID = pv.variantID " +
            "LEFT JOIN tbProduct p ON pv.productID = p.productID " +
            "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
            "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
            "WHERE o.orderID = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, orderID);
        System.out.println(sql);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Initialize Order once
                if (order == null) {
                    order = new Order();
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderDate(rs.getString("orderDate")); // DB format: yyyy-MM-dd HH:mm:ss
                    order.setTotal(rs.getDouble("total"));
                    order.setOrderStatus(rs.getInt("orderStatus"));
                    order.setShippingAddress(rs.getString("shippingAddress"));
                    order.setEmall_receiver(rs.getString("emall_receiver"));
                    order.setPhone_receiver(rs.getString("phone_receiver"));
                    order.setName_receiver(rs.getString("name_receiver"));
                    order.setShipFee(rs.getDouble("shipFee"));
                    order.setPaymentStatus(rs.getBoolean("paymentStatus"));
                    order.setOrderDetails(new ArrayList<>());
                    // Set User
                    User user = new User();
                    user.setUserID(rs.getInt("userID"));
                    user.setFullName(rs.getString("fullName"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("shippingAddress"));
                    order.setUser(user);
                    
                    // Set PaymentMethod
                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setPaymentMethodID(rs.getInt("paymentMethodID"));
                    paymentMethod.setPaymentMethodName(rs.getString("paymentMethodName"));
                    order.setPaymentMethod(paymentMethod);
                }
                // Add OrderDetail if exists
                if (rs.getObject("detailID") != null) {
                    OrderDetail detail = new OrderDetail();
                    detail.setDetailID(rs.getInt("detailID"));
                    detail.setQuantity_product(rs.getInt("quantity_product"));
                    detail.setPrice(rs.getDouble("price"));
                    
                    // Set ProductVariant with additional details
                    ProductVariant variant = new ProductVariant();
                    variant.setVariantID(rs.getInt("variantID"));

                    // Set Product
                    Product product = new Product();
                    product.setProductId(rs.getInt("productID"));
                    product.setProductName(rs.getString("productName"));
                    variant.setProduct(product);
                    // Set Color
                    Color color = new Color();
                    color.setColorID(rs.getInt("colorID"));
                    color.setColorName(rs.getString("colorName"));
                    variant.setColor(color);
                    // Set Size
                    Size size = new Size();
                    size.setSizeID(rs.getInt("sizeID"));
                    size.setSizeName(rs.getString("sizeName"));
                    variant.setSize(size);

                    detail.setVariant(variant);
                    detail.setOrder(order);
                    order.getOrderDetails().add(detail);
                }
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error fetching order details: " + e.getMessage(), e);
    }
    return order != null ? order : new Order(); // Return empty Order if not found
}

    public boolean UpdateOrder(String[] data) {
        String sql = "UPDATE dbo.tbOrder SET shippingAddress = ?,emall_receiver = ?, phone_receiver = ?,\n"
                + "name_receiver = ? ,orderStatus = ?\n"
                + "WHERE orderID = ?;";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int status = Integer.parseInt(data[4]);
            int orderID = Integer.parseInt(data[5]);
            ps.setString(1, data[0]);
            ps.setString(2, data[1]);
            ps.setString(3, data[2]);
            ps.setString(4, data[3]);
            ps.setInt(5, status);
            ps.setInt(6, orderID);
            int result = ps.executeUpdate();
            if(result >0){
                return true;
            }
        }
        catch (Exception e) {
        }    
        return false;
    }

    public static void main(String[] args) {
        OrderDAO odao = new OrderDAO();
        try {
//            String[] params1 = {"", "2025-04-21", "2025-04-30", "", ""};
//            System.out.println("Test 1: Orders from 2025-04-01 to 2025-04-30");
////            int count1 = odao.countOrdered(params1);
////            System.out.println(count1);
//            List<Order> list = odao.listOrders(params1, 1, 10);
//            for (Order order : list) {
//                System.out.println(order.getOrderID());
//            }
//            System.out.println(size);
            Order od = odao.getOrderDetails(1);
            List<OrderDetail> details = od.getOrderDetails();
            for (OrderDetail detail : details) {
                System.out.println(detail.getDetailID());
            }
        } catch (Exception e) {
        }
    }

}
