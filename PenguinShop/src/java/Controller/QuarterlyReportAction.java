package Controller;

import DAL.QuarterlyReportDAO;
import Models.MonthlyReport;
import Models.ProductSalesReport;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

public class QuarterlyReportAction {
    
    private final QuarterlyReportDAO quarterlyReportDAO = new QuarterlyReportDAO();
    
    public BigDecimal getQuarterlyRevenue(int year, int quarter) {
        return quarterlyReportDAO.getQuarterlyRevenue(year, quarter);
    }
    
    public BigDecimal getQuarterlyImportCost(int year, int quarter) {
        return quarterlyReportDAO.getQuarterlyImportCost(year, quarter);
    }
    
    public int getQuarterlyOrderCount(int year, int quarter) {
        return quarterlyReportDAO.getQuarterlyOrderCount(year, quarter);
    }
    
    public List<MonthlyReport> getMonthlyReports(int year, int quarter) {
        return quarterlyReportDAO.getMonthlyReports(year, quarter);
    }
    
    public List<ProductSalesReport> getTopSellingProducts(int year, int quarter, int limit) {
        return quarterlyReportDAO.getTopSellingProductsInQuarter(year, quarter, limit);
    }
    
    public List<ProductSalesReport> getSlowSellingProducts(int year, int quarter, int limit) {
        return quarterlyReportDAO.getSlowSellingProductsInQuarter(year, quarter, limit);
    }
    
    public int getCurrentQuarter() {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        return (month - 1) / 3 + 1;
    }
}
