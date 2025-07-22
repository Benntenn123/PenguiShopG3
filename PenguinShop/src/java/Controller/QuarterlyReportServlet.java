package Controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.MonthlyReport;
import Models.ProductSalesReport;

@WebServlet(name = "QuarterlyReportServlet", urlPatterns = {"/admin/quarterly-report"})
public class QuarterlyReportServlet extends HttpServlet {

    private final QuarterlyReportAction quarterlyReportAction = new QuarterlyReportAction();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get parameters
            String yearParam = request.getParameter("year");
            String quarterParam = request.getParameter("quarter");
            
            // Default values
            int year = yearParam != null ? Integer.parseInt(yearParam) : Calendar.getInstance().get(Calendar.YEAR);
            int quarter = quarterParam != null ? Integer.parseInt(quarterParam) : quarterlyReportAction.getCurrentQuarter();
            
            // Get data from controller
            BigDecimal quarterlyRevenue = quarterlyReportAction.getQuarterlyRevenue(year, quarter);
            BigDecimal quarterlyImportCost = quarterlyReportAction.getQuarterlyImportCost(year, quarter);
            int quarterlyOrderCount = quarterlyReportAction.getQuarterlyOrderCount(year, quarter);
            
            // Get reports
            List<MonthlyReport> monthlyReports = quarterlyReportAction.getMonthlyReports(year, quarter);
            List<ProductSalesReport> topSellingProducts = quarterlyReportAction.getTopSellingProducts(year, quarter, 5);
            List<ProductSalesReport> slowSellingProducts = quarterlyReportAction.getSlowSellingProducts(year, quarter, 5);
            
            for (MonthlyReport monthlyReport : monthlyReports) {
                System.out.println(monthlyReport.getMonth() +"hehe");
            }
            for (MonthlyReport monthlyReport : monthlyReports) {
                System.out.println(monthlyReport.getImportCost() +"hehe");
            }
            for (MonthlyReport monthlyReport : monthlyReports) {
                System.out.println(monthlyReport.getProfit() +"hehe");
            }
            for (MonthlyReport monthlyReport : monthlyReports) {
                System.out.println(monthlyReport.getRevenue()+"hehe");
            }
            
            // Set attributes for JSP display
            request.setAttribute("quarterlyRevenue", quarterlyRevenue);
            request.setAttribute("quarterlyImportCost", quarterlyImportCost);
            request.setAttribute("quarterlyOrderCount", quarterlyOrderCount);
            request.setAttribute("monthlyReports", monthlyReports);
            request.setAttribute("topSellingProducts", topSellingProducts);
            request.setAttribute("slowSellingProducts", slowSellingProducts);
            request.setAttribute("currentYear", year);
            request.setAttribute("currentQuarter", quarter);
            
            // Debug log
            System.out.println("=== QUARTERLY REPORT DEBUG ===");
            System.out.println("Year: " + year + ", Quarter: " + quarter);
            System.out.println("Revenue: " + quarterlyRevenue);
            System.out.println("Import Cost: " + quarterlyImportCost);
            System.out.println("Order Count: " + quarterlyOrderCount);
            System.out.println("Monthly Reports Count: " + (monthlyReports != null ? monthlyReports.size() : "null"));
            System.out.println("Top Products Count: " + (topSellingProducts != null ? topSellingProducts.size() : "null"));
            System.out.println("===============================");
            
            // Forward to JSP
            request.getRequestDispatcher("../Admin/QuarterlyReport.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in QuarterlyReportServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error processing report: " + e.getMessage());
            request.getRequestDispatcher("../Admin/QuarterlyReport.jsp").forward(request, response);
        }
    }
}
