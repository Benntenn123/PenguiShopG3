/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import DAL.CategoriesDAO;
import DAL.MeterialDAO;
import Models.Brand;
import Models.Category;
import Models.Color;
import Models.Size;
import Models.Type;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name="ManageVariant", urlPatterns={"/admin/managevariant"})
public class ManageVariant extends HttpServlet {
    
    MeterialDAO attributeDAO = new MeterialDAO();
    CategoriesDAO cdao = new CategoriesDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageVariant</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageVariant at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Load data from DB
            List<Size> sizes = attributeDAO.getAllSize();
            List<Color> colors = attributeDAO.getAllColor();
            List<Brand> brands = attributeDAO.getAllBrand();
            List<Category> categories = cdao.getAllCategory();
            List<Type> types = attributeDAO.getAllProductType();

            // Set attributes for JSP
            request.setAttribute("sizes", sizes);
            request.setAttribute("colors", colors);
            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
            request.setAttribute("types", types);

            // Forward to JSP
            request.getRequestDispatcher("../Admin/VariantManagement.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Error in LoadAttributesServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to load attributes");
        }
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
