
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.PaymentStatus;
import Const.StatusOrder;
import Models.CartSession;
import Models.Color;
import Models.DeliveryInfo;
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
        // Thống kê doanh thu theo tháng
    public List<Models.MonthValue> getMonthlyRevenue(int year) {
        List<Models.MonthValue> list = new ArrayList<>();
        String sql = "SELECT MONTH(orderDate) as month, SUM(total) as revenue FROM tbOrder WHERE YEAR(orderDate) = ? AND paymentStatus = 1 GROUP BY MONTH(orderDate) ORDER BY month";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Models.MonthValue(rs.getInt("month"), rs.getDouble("revenue")));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
        // Lấy top N user chi nhiều tiền nhất
    public List<Models.MonthValue> getTopUserSpending(int top) {
        List<Models.MonthValue> list = new ArrayList<>();
        String sql = "SELECT TOP " + top + " u.userID, SUM(o.total) as totalSpent FROM tbOrder o JOIN tbUsers u ON o.userID = u.userID WHERE o.paymentStatus = 1 GROUP BY u.userID ORDER BY totalSpent DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Models.MonthValue(rs.getInt("userID"), rs.getDouble("totalSpent")));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    // Lấy 5 đơn hàng gần nhất
    public List<Order> getLatestOrders(int top) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT TOP " + top + " orderID, orderDate, total, userID, name_receiver, orderStatus FROM tbOrder ORDER BY orderDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                User user = new User();
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("orderID"));
                    o.setOrderDate(rs.getString("orderDate"));
                    o.setTotal(rs.getDouble("total"));
                    user.setUserID(rs.getInt("userID"));
                    o.setName_receiver(rs.getString("name_receiver"));
                    o.setUser(user);
                    o.setOrderStatus(rs.getInt("orderStatus"));
                    list.add(o);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }


    // Thống kê số đơn hàng theo tháng
    public List<Models.MonthValue> getMonthlyOrderCount(int year) {
        List<Models.MonthValue> list = new ArrayList<>();
        String sql = "SELECT MONTH(orderDate) as month, COUNT(*) as count FROM tbOrder WHERE YEAR(orderDate) = ? AND paymentStatus = 1 GROUP BY MONTH(orderDate) ORDER BY month";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Models.MonthValue(rs.getInt("month"), rs.getInt("count")));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
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

        sql.append("ORDER BY orderID DESC " // Sắp xếp từ mới nhất
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY "
                + ") "
                + "SELECT o.*, od.detailID, od.price AS detailPrice, od.quantity_product, "
                + "      p.productId ,p.productName, p.imageMainProduct, pv.variantID "
                + "FROM PagedOrders o "
                + "LEFT JOIN tbOrderDetail od ON o.orderID = od.orderID "
                + "JOIN tbProductVariant pv ON pv.variantID = od.variantID "
                + "JOIN tbProduct p ON p.productID = pv.productID "
                + "ORDER BY o.orderID DESC");

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
        String sql
                = "SELECT o.orderID, o.orderDate, o.total, o.orderStatus, o.shippingAddress, o.paymentStatus, "
                + "pm.paymentMethodID, pm.paymentMethodName, u.userID, u.fullName, u.email, u.phone, o.shippingAddress, "
                + "od.detailID, od.variantID, od.quantity_product, od.price, o.emall_receiver, o.phone_receiver, o.name_receiver, o.shipFee, "
                + "p.productID, p.productName, c.colorID, c.colorName, s.sizeID, s.sizeName "
                + "FROM tbOrder o "
                + "LEFT JOIN tbPaymentMethod pm ON o.paymentMethod = pm.paymentMethodID "
                + "LEFT JOIN tbUsers u ON o.userID = u.userID "
                + "LEFT JOIN tbOrderDetail od ON o.orderID = od.orderID "
                + "LEFT JOIN tbProductVariant pv ON od.variantID = pv.variantID "
                + "LEFT JOIN tbProduct p ON pv.productID = p.productID "
                + "LEFT JOIN tbColor c ON pv.colorID = c.colorID "
                + "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID "
                + "WHERE o.orderID = ?";

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
            if (result > 0) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public int createOrder(int userId, Map<Integer, CartSession> cartItems, double totalBill,
            double shipFee, double totalBillShip, DeliveryInfo deli,
            String paymentMethod, String dateTime) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Ánh xạ paymentMethod: cod -> 2, vnpay -> 1
            int paymentMethodCode = "cod".equalsIgnoreCase(paymentMethod) ? PaymentStatus.COD : PaymentStatus.VNPAY;

            // INSERT vào tbOrder
            String insertOrderSql = "INSERT INTO dbo.tbOrder (orderDate, total, userID, orderStatus, "
                    + "shippingAddress, paymentMethod, paymentStatus, emall_receiver, "
                    + "phone_receiver, name_receiver, shipFee) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(insertOrderSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, dateTime);
                ps.setDouble(2, totalBill);
                ps.setInt(3, userId);
                ps.setInt(4, StatusOrder.DANG_CHO_XU_LI);
                ps.setString(5, deli.getAddessDetail());
                ps.setInt(6, paymentMethodCode);
                ps.setInt(7, PaymentStatus.CHUA_THANH_TOAN);
                ps.setString(8, deli.getEmail());
                ps.setString(9, deli.getPhone());
                ps.setString(10, deli.getFullName());
                ps.setDouble(11, shipFee);
                System.out.println(insertOrderSql);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected == 0) {
                    connection.rollback();
                    System.out.println("No rows affected when inserting order.");
                    return 0;
                }

                rs = ps.getGeneratedKeys();
                int orderId;
                if (rs.next()) {
                    orderId = rs.getInt(1);
                } else {
                    connection.rollback();
                    System.out.println("Failed to retrieve order ID.");
                    return 0;
                }

                // INSERT vào tbOrderDetail
                String insertDetailSql = "INSERT INTO dbo.tbOrderDetail (price, quantity_product, orderID, variantID) "
                        + "VALUES (?, ?, ?, ?)";
                try (PreparedStatement psDetail = connection.prepareStatement(insertDetailSql)) {
                    for (CartSession item : cartItems.values()) {
                        psDetail.setDouble(1, item.getCart().getVariant().getPrice());
                        psDetail.setInt(2, item.getQuantity());
                        psDetail.setInt(3, orderId);
                        psDetail.setInt(4, item.getCart().getVariant().getVariantID());
                        psDetail.addBatch();
                    }

                    int[] batchResults = psDetail.executeBatch();
                    for (int result : batchResults) {
                        if (result == 0) {
                            connection.rollback();
                            System.out.println("Failed to insert order detail.");
                            return 0;
                        }
                    }
                }

                // Giảm số lượng tồn kho
                if (!updateInventory(cartItems)) {
                    connection.rollback();
                    System.out.println("Failed to update inventory.");
                    return 0;
                }

                connection.commit();
                System.out.println("Order created successfully.");
                return orderId;
            }

        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                System.err.println("Rollback error in createOrder: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
            System.err.println("SQLException in createOrder: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return 0;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException closeEx) {
                System.err.println("Close error in createOrder: " + closeEx.getMessage());
                closeEx.printStackTrace();
            }
        }
    }

    private boolean updateInventory(Map<Integer, CartSession> cartItems) {
        PreparedStatement pstmt = null;

        try {
            String sql = "UPDATE dbo.tbProductVariant SET quantity = quantity - ? WHERE variantID = ? AND quantity >= ?";
            pstmt = connection.prepareStatement(sql);

            for (CartSession item : cartItems.values()) {
                pstmt.setInt(1, item.getQuantity());
                pstmt.setInt(2, item.getCart().getVariant().getVariantID());
                pstmt.setInt(3, item.getQuantity());
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected == 0) {
                    return false;
                }
            }
            return true;

        } catch (SQLException e) {
            System.err.println("SQLException in updateInventory: " + e.getMessage());
            return false;
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException closeEx) {
                System.err.println("Close error in updateInventory: " + closeEx.getMessage());
            }
        }
    }

    public double getTotalOrder(int orderID) {
        String sql = "SELECT total FROM dbo.tbOrder WHERE orderID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            return rs.getDouble(1);
        } catch (Exception e) {
        }
        return 0.0;
    }

    public boolean updateOrderStatus(int orderID, int status) {
        String sql = "UPDATE dbo.tbOrder SET orderStatus = ? WHERE orderID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            int row = ps.executeUpdate();
            if (row > 0) {
                return true;
            }
        } catch (Exception e) {
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
