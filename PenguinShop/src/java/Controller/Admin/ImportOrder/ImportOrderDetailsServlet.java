package Controller.Admin.ImportOrder;

import DAL.ImportOrderDAO;
import Models.ImportOrder;
import Models.ImportOrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * ImportOrderDetailsServlet - Handles import order details viewing
 * @author TTC
 */
@WebServlet(name = "ImportOrderDetailsServlet", urlPatterns = {"/admin/ImportOrderDetails"})
public class ImportOrderDetailsServlet extends HttpServlet {
    
    private ImportOrderDAO importOrderDAO = new ImportOrderDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        doGet(request, response);
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays import order details with product list
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get import order ID from parameter
            String orderIdStr = request.getParameter("id");
            
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Không tìm thấy mã đơn nhập hàng");
                request.getRequestDispatcher("/Admin/ImportOrderList").forward(request, response);
                return;
            }
            
            int orderId;
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Mã đơn nhập hàng không hợp lệ");
                request.getRequestDispatcher("/Admin/ImportOrderList").forward(request, response);
                return;
            }
            
            // Get import order information
            ImportOrder importOrder = importOrderDAO.getImportOrderById(orderId);
            
            if (importOrder == null) {
                request.setAttribute("error", "Không tìm thấy đơn nhập hàng với ID: " + orderId);
                request.getRequestDispatcher("/Admin/ImportOrderList").forward(request, response);
                return;
            }
            
            // Get import order details with product information
            List<ImportOrderDetail> orderDetails = importOrderDAO.getImportOrderDetails(orderId);
            
            // Test một số variantID từ orderDetails
            if (orderDetails != null && !orderDetails.isEmpty()) {
                for (ImportOrderDetail detail : orderDetails) {
                    importOrderDAO.testVariantID(detail.getVariantID());
                }
            }
            
            // Set attributes for the JSP
            request.setAttribute("importOrder", importOrder);
            request.setAttribute("orderDetails", orderDetails);
            
            // Debug information
            System.out.println("ImportOrderDetailsServlet - Order ID: " + orderId);
            System.out.println("ImportOrderDetailsServlet - Order found: " + (importOrder != null));
            System.out.println("ImportOrderDetailsServlet - Order supplier: " + (importOrder != null ? importOrder.getSupplierName() : "null"));
            System.out.println("ImportOrderDetailsServlet - Details count: " + (orderDetails != null ? orderDetails.size() : 0));
            
            if (orderDetails != null && !orderDetails.isEmpty()) {
                for (int i = 0; i < Math.min(3, orderDetails.size()); i++) {
                    ImportOrderDetail detail = orderDetails.get(i);
                    System.out.println("ImportOrderDetailsServlet - Detail " + (i+1) + ": " +
                        "variantID=" + detail.getVariantID() + 
                        ", productName=" + detail.getProductName() +
                        ", color=" + detail.getColorName() +
                        ", size=" + detail.getSizeName());
                }
            }
            
            // Forward to the details page
            request.getRequestDispatcher("/Admin/ImportOrderDetails.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in ImportOrderDetailsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin đơn nhập hàng: " + e.getMessage());
            request.getRequestDispatcher("/Admin/ImportOrderList").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "ImportOrderDetailsServlet - Handles import order details viewing";
    }
}
