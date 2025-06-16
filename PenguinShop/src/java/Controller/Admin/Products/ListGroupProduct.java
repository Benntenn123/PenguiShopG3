/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import Const.Batch;
import DAL.CategoriesDAO;
import DAL.MeterialDAO;
import DAL.ProductDao;
import Models.Brand;
import Models.Category;
import Models.Product;
import Models.Type;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.sql.SQLException;
@WebServlet(name="ListGroupProduct", urlPatterns={"/admin/listGroupProduct"})
public class ListGroupProduct extends HttpServlet {
    ProductDao productDAO = new ProductDao();
    CategoriesDAO cdao = new CategoriesDAO();
    MeterialDAO mdao = new MeterialDAO();
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListGroupProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListGroupProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    try {
        final int PAGE_SIZE = Batch.BATCH_SEARCH_PRODUCT;

        String[] data = getData(request);
        String pageRaw = request.getParameter("page");
        int page = 1;

        try {
            if (pageRaw != null) {
                page = Integer.parseInt(pageRaw);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        // Lấy danh sách sản phẩm & tổng số
        List<Product> list = productDAO.getProducts(data, page, PAGE_SIZE);
        int totalRecords = productDAO.getTotalProducts(data);

        // Các danh sách phụ trợ
        List<Brand> brandList = mdao.getAllBrand();
        List<Type> typeList = mdao.getAllProductType();
        List<Category> categoryList = cdao.getAllCategory();

        // Gán dữ liệu cho view
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("typeList", typeList);
        request.setAttribute("brandList", brandList);
        request.setAttribute("listP", list);
        request.setAttribute("totalProduct", totalRecords);

        request.setAttribute("startRecord", (page - 1) * PAGE_SIZE + 1);
        request.setAttribute("endRecord", Math.min(page * PAGE_SIZE, totalRecords));
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE);
        request.setAttribute("totalRecords", totalRecords);

        request.getRequestDispatcher("../Admin/ListGroupProductAdmin.jsp").forward(request, response);
    } catch (SQLException e) {
        request.getSession().setAttribute("error", "Đã có lỗi xảy ra với cơ sở dữ liệu!");
        e.printStackTrace();
        
    }
}


    private String[] getData(HttpServletRequest request) {
        String productName = request.getParameter("productName");
        String brand = request.getParameter("brand");
        String type = request.getParameter("type");
        String cate = request.getParameter("cate");

        return new String[]{productName, brand, type, cate};
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
