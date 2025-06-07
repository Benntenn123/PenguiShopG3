/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import DAL.ProductDao;
import Models.Product;
import Models.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet(name="ListProduct", urlPatterns={"/admin/listProductAdmin"})
public class ListProduct extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ProductDao pd = new ProductDao();
        List<ProductVariant> list = pd.getProductVariants(getData(request), 0, 10);
        request.setAttribute("listP", list);
        request.getRequestDispatcher("../Admin/ListProductAdmin.jsp").forward(request, response);
    } 
    
    private String[] getData(HttpServletRequest request){
        String search = request.getParameter("productName");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String status = request.getParameter("status");
        String quantity = request.getParameter("quantity");
        String type = request.getParameter("type");
        String brand = request.getParameter("brand");
        String categories = request.getParameter("cate");
        return new String[]{search,color,size,status,
            quantity,type,brand,categories};
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
