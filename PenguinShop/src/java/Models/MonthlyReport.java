package Models;

import java.math.BigDecimal;

public class MonthlyReport {
    private int month;
    private int year;
    private BigDecimal revenue;
    private BigDecimal importCost;
    private BigDecimal profit;
    private int orderCount;
    private int importOrderCount;
    
    public MonthlyReport() {}
    
    public MonthlyReport(int month, int year, BigDecimal revenue, BigDecimal importCost, int orderCount, int importOrderCount) {
        this.month = month;
        this.year = year;
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
        this.importCost = importCost != null ? importCost : BigDecimal.ZERO;
        this.profit = this.revenue.subtract(this.importCost);
        this.orderCount = orderCount;
        this.importOrderCount = importOrderCount;
    }
    
    // Getters and Setters
    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }
    
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    
    public BigDecimal getRevenue() { return revenue; }
    public void setRevenue(BigDecimal revenue) { 
        this.revenue = revenue != null ? revenue : BigDecimal.ZERO;
        calculateProfit();
    }
    
    public BigDecimal getImportCost() { return importCost; }
    public void setImportCost(BigDecimal importCost) { 
        this.importCost = importCost != null ? importCost : BigDecimal.ZERO;
        calculateProfit();
    }
    
    public BigDecimal getProfit() { return profit; }
    
    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }
    
    public int getImportOrderCount() { return importOrderCount; }
    public void setImportOrderCount(int importOrderCount) { this.importOrderCount = importOrderCount; }
    
    private void calculateProfit() {
        if (revenue != null && importCost != null) {
            this.profit = revenue.subtract(importCost);
        }
    }
}
