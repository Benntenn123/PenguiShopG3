package DAL;

import Models.MonthlyReport;
import Models.ProductSalesReport;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuarterlyReportDAO extends DBContext {

    // Lấy doanh thu theo quý
    public BigDecimal getQuarterlyRevenue(int year, int quarter) {
        int startMonth = (quarter - 1) * 3 + 1;
        int endMonth = quarter * 3;
        
        String sql = "SELECT SUM(total) as revenue FROM tbOrder " +
                    "WHERE YEAR(orderDate) = ? AND MONTH(orderDate) BETWEEN ? AND ? " +
                    "AND paymentStatus = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, startMonth);
            ps.setInt(3, endMonth);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double revenue = rs.getDouble("revenue");
                    return new BigDecimal(revenue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Lấy chi phí nhập hàng theo quý
    public BigDecimal getQuarterlyImportCost(int year, int quarter) {
        int startMonth = (quarter - 1) * 3 + 1;
        int endMonth = quarter * 3;
        
        String sql = "SELECT SUM(io.totalAmount) as importCost FROM tbImportOrder io " +
                    "WHERE YEAR(io.importDate) = ? AND MONTH(io.importDate) BETWEEN ? AND ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, startMonth);
            ps.setInt(3, endMonth);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double cost = rs.getDouble("importCost");
                    return new BigDecimal(cost);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Đếm số đơn hàng trong quý
    public int getQuarterlyOrderCount(int year, int quarter) {
        int startMonth = (quarter - 1) * 3 + 1;
        int endMonth = quarter * 3;
        
        String sql = "SELECT COUNT(*) as orderCount FROM tbOrder " +
                    "WHERE YEAR(orderDate) = ? AND MONTH(orderDate) BETWEEN ? AND ? " +
                    "AND paymentStatus = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, startMonth);
            ps.setInt(3, endMonth);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("orderCount");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy doanh thu theo tháng
    public BigDecimal getMonthlyRevenue(int year, int month) {
        String sql = "SELECT SUM(total) as revenue FROM tbOrder " +
                    "WHERE YEAR(orderDate) = ? AND MONTH(orderDate) = ? AND paymentStatus = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new BigDecimal(rs.getDouble("revenue"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Lấy chi phí nhập hàng theo tháng
    public BigDecimal getMonthlyImportCost(int year, int month) {
        String sql = "SELECT SUM(totalAmount) as importCost FROM tbImportOrder " +
                    "WHERE YEAR(importDate) = ? AND MONTH(importDate) = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new BigDecimal(rs.getDouble("importCost"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    // Đếm số đơn hàng theo tháng
    public int getMonthlyOrderCount(int year, int month) {
        String sql = "SELECT COUNT(*) as orderCount FROM tbOrder " +
                    "WHERE YEAR(orderDate) = ? AND MONTH(orderDate) = ? AND paymentStatus = 1";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("orderCount");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Đếm số phiếu nhập theo tháng
    public int getMonthlyImportOrderCount(int year, int month) {
        String sql = "SELECT COUNT(*) as importOrderCount FROM tbImportOrder " +
                    "WHERE YEAR(importDate) = ? AND MONTH(importDate) = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("importOrderCount");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Lấy top sản phẩm bán chạy nhất trong quý
    public List<ProductSalesReport> getTopSellingProductsInQuarter(int year, int quarter, int limit) {
        List<ProductSalesReport> products = new ArrayList<>();
        int startMonth = (quarter - 1) * 3 + 1;
        int endMonth = quarter * 3;
        
        String sql = "SELECT TOP " + limit + " " +
                    "pv.variantID, p.productName, " +
                    "CONCAT(ISNULL(s.sizeName, 'N/A'), ' - ', ISNULL(c.colorName, 'N/A')) as variantName, " +
                    "ISNULL(p.imageMainProduct, 'Images/default.jpg') as productImage, " +
                    "SUM(od.quantity_product) as totalQuantity, " +
                    "SUM(od.quantity_product * od.price) as totalRevenue " +
                    "FROM tbOrderDetail od " +
                    "JOIN tbOrder o ON od.orderID = o.orderID " +
                    "JOIN tbProductVariant pv ON od.variantID = pv.variantID " +
                    "JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "WHERE YEAR(o.orderDate) = ? AND MONTH(o.orderDate) BETWEEN ? AND ? " +
                    "AND o.paymentStatus = 1 " +
                    "GROUP BY pv.variantID, p.productName, s.sizeName, c.colorName, p.imageMainProduct " +
                    "ORDER BY totalQuantity DESC";
        
        System.out.println("=== TOP SELLING PRODUCTS QUERY ===");
        System.out.println("Year: " + year + ", Quarter: " + quarter + " (Months " + startMonth + "-" + endMonth + ")");
        System.out.println("SQL: " + sql);
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, startMonth);
            ps.setInt(3, endMonth);
            
            try (ResultSet rs = ps.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    ProductSalesReport product = new ProductSalesReport(
                        rs.getInt("variantID"),
                        rs.getString("productName"),
                        rs.getString("variantName"),
                        rs.getString("productImage"),
                        rs.getInt("totalQuantity"),
                        new BigDecimal(rs.getDouble("totalRevenue"))
                    );
                    products.add(product);
                    
                    System.out.println("Product " + count + ": " + product.getProductName() + 
                                     " - " + product.getVariantName() + 
                                     " - Qty: " + product.getTotalQuantity() + 
                                     " - Revenue: " + product.getTotalRevenue());
                }
                System.out.println("Total products found: " + count);
            }
        } catch (Exception e) {
            System.out.println("Error in getTopSellingProductsInQuarter: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("=================================");
        return products;
    }
    
    // Lấy top sản phẩm bán chậm nhất trong quý (bao gồm cả sản phẩm chưa bán)
    public List<ProductSalesReport> getSlowSellingProductsInQuarter(int year, int quarter, int limit) {
        List<ProductSalesReport> products = new ArrayList<>();
        int startMonth = (quarter - 1) * 3 + 1;
        int endMonth = quarter * 3;
        
        String sql = "SELECT TOP " + limit + " " +
                    "pv.variantID, p.productName, " +
                    "CONCAT(ISNULL(s.sizeName, 'N/A'), ' - ', ISNULL(c.colorName, 'N/A')) as variantName, " +
                    "ISNULL(p.imageMainProduct, 'Images/default.jpg') as productImage, " +
                    "ISNULL(SUM(od.quantity_product), 0) as totalQuantity, " +
                    "ISNULL(SUM(od.quantity_product * od.price), 0) as totalRevenue " +
                    "FROM tbProductVariant pv " +
                    "JOIN tbProduct p ON pv.productID = p.productID " +
                    "LEFT JOIN tbSize s ON pv.sizeID = s.sizeID " +
                    "LEFT JOIN tbColor c ON pv.colorID = c.colorID " +
                    "LEFT JOIN tbOrderDetail od ON pv.variantID = od.variantID " +
                    "LEFT JOIN tbOrder o ON od.orderID = o.orderID " +
                    "    AND YEAR(o.orderDate) = ? AND MONTH(o.orderDate) BETWEEN ? AND ? " +
                    "    AND o.paymentStatus = 1 " +
                    "GROUP BY pv.variantID, p.productName, s.sizeName, c.colorName, p.imageMainProduct " +
                    "ORDER BY totalQuantity ASC, p.productName ASC";
        
        System.out.println("=== SLOW SELLING PRODUCTS QUERY (ALL PRODUCTS) ===");
        System.out.println("Year: " + year + ", Quarter: " + quarter + " (Months " + startMonth + "-" + endMonth + ")");
        System.out.println("SQL: " + sql);
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, startMonth);
            ps.setInt(3, endMonth);
            
            try (ResultSet rs = ps.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    ProductSalesReport product = new ProductSalesReport(
                        rs.getInt("variantID"),
                        rs.getString("productName"),
                        rs.getString("variantName"),
                        rs.getString("productImage"),
                        rs.getInt("totalQuantity"),
                        new BigDecimal(rs.getDouble("totalRevenue"))
                    );
                    products.add(product);
                    
                    System.out.println("Slow Product " + count + ": " + product.getProductName() + 
                                     " - " + product.getVariantName() + 
                                     " - Qty: " + product.getTotalQuantity() + 
                                     " - Revenue: " + product.getTotalRevenue());
                }
                System.out.println("Total slow products found: " + count);
            }
        } catch (Exception e) {
            System.out.println("Error in getSlowSellingProductsInQuarter: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("===================================");
        return products;
    }
    
    // Lấy báo cáo theo tháng trong quý
    public List<MonthlyReport> getMonthlyReports(int year, int quarter) {
        List<MonthlyReport> reports = new ArrayList<>();
        int startMonth = (quarter - 1) * 3 + 1;
        
        for (int i = 0; i < 3; i++) {
            int month = startMonth + i;
            
            // Lấy doanh thu tháng
            BigDecimal revenue = getMonthlyRevenue(year, month);
            
            // Lấy chi phí nhập hàng tháng
            BigDecimal importCost = getMonthlyImportCost(year, month);
            
            // Đếm số đơn hàng tháng
            int orderCount = getMonthlyOrderCount(year, month);
            
            // Đếm số phiếu nhập tháng  
            int importOrderCount = getMonthlyImportOrderCount(year, month);
            
            MonthlyReport report = new MonthlyReport(month, year, revenue, importCost, orderCount, importOrderCount);
            reports.add(report);
        }
        
        return reports;
    }
}
