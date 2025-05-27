/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Product;

import DAL.BrandDAO;
import DAL.CategoriesDAO;
import DAL.MeterialDAO;
import DAL.ProductDao;
import Models.Brand;
import Models.Category;
import Models.Color;
import Models.ProductVariant;
import Models.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "SearchProduct", urlPatterns = {"/search"})
public class SearchProduct extends HttpServlet {

    CategoriesDAO cdao = new CategoriesDAO();
    BrandDAO bdao = new BrandDAO();
    MeterialDAO mdao = new MeterialDAO();
    ProductDao pdao = new ProductDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> cate = cdao.getAllCategory();   // load hết danh mục sản phẩm
        request.setAttribute("cate", cate);

        List<Brand> br = bdao.getAllBrand();   //load hết brand
        request.setAttribute("br", br);

        List<Color> color = mdao.getAllColor(); // load hết màu sắc
        request.setAttribute("color", color);

        List<Size> size = mdao.getAllSize(); // load hết cỡ
        request.setAttribute("size", size);

        String[] categories = request.getParameterValues("cate"); // Lấy tất cả giá trị của "cate"
        String[] brands = request.getParameterValues("brand");    // Lấy tất cả giá trị của "brand"
        String[] colors = request.getParameterValues("color");    // Lấy tất cả giá trị của "color"
        String[] sizes = request.getParameterValues("size");      // Lấy tất cả giá trị của "size"
        String from = request.getParameter("from");               // Giá từ
        String page = request.getParameter("page");
        String to = request.getParameter("to");                   // Giá đến
        String q = request.getParameter("q");
        int pages = 1;
        if (page != null) {
            try {
                pages = Integer.parseInt(page);
            } catch (Exception e) {
            }
        }
        List<ProductVariant> list = pdao.loadProductVariants(categories,
                brands, colors, sizes, from, to, q,
                pages, 6);
        System.out.println(list.size());
        request.setAttribute("list", list);

        int totalResult = pdao.calculateTotalProductVariants(categories,
                brands, colors, sizes, from, to, q);
        request.setAttribute("totalResult", totalResult);
        request.setAttribute("currentPage", pages);
        request.setAttribute("pageSize", 6);
        int totalPages = (int) Math.ceil((double) totalResult / 6);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("HomePage/ListProducts.jsp").forward(request, response);
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
