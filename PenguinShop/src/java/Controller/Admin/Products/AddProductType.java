package Controller.Admin.Products;

import DAL.MeterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="AddProductType", urlPatterns={"/admin/add-product-type"})
public class AddProductType extends HttpServlet {
    MeterialDAO attributeDAO = new MeterialDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProductType</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductType at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

   
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String typeName = request.getParameter("typeName").trim();
            if (typeName == null || typeName.isEmpty()) {
                request.getSession().setAttribute("error", "Tên không được để trống");
                response.sendRedirect("managevariant");
                return;
            }

            if (attributeDAO.addProductType(typeName)) {
                request.getSession().setAttribute("ms", "Thêm loại sản phẩm thành công!");
                response.sendRedirect("managevariant");
            } else {
                request.getSession().setAttribute("error", "Thêm loại sản phẩm không thành công!");
                response.sendRedirect("managevariant");
            }
        } catch (Exception e) {
            System.out.println("Error in AddProductTypeServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("managevariant");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
