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
import Const.ProductConst;
import DAL.CategoriesDAO;
import DAL.MeterialDAO;
import Models.Brand;
import Models.Category;
import Models.Color;
import Models.Material;
import Models.Size;
import Models.Type;

@WebServlet(name = "ListProduct", urlPatterns = {"/admin/listProductAdmin"})
public class ListProduct extends HttpServlet {

    MeterialDAO mdao = new MeterialDAO();
    ProductDao pd = new ProductDao();
    CategoriesDAO cdao = new CategoriesDAO();

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
            out.println("<h1>Servlet ListProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int batch = 10;
        String[] data = getData(request); // getData từ thanh request lưu vào mảng
        String page_raw = request.getParameter("page");
        int page = 1;
        try {
            if(page_raw != null){
                page = Integer.parseInt(page_raw);
            }
            
            List<ProductVariant> list = pd.getProductVariants(data, page, batch);  // load ra list sản phẩm

            int totalReCord = pd.getTotalRecords(data); // load ra tổng sản phẩm

            String[] activeProduct = {"", "", "", ProductConst.ON_STOCK, "", "", "", ""};  // load tổng số sp đang bán
            int activePro = pd.getTotalRecords(activeProduct);

            String[] notactiveProduct = {"", "", "", ProductConst.NOT_STOCK, "", "", "", ""}; // load tổng số sp đã dừng bán
            int notactivePro = pd.getTotalRecords(notactiveProduct);

            List<Color> colorList = mdao.getAllColor();  // 3 hàm load cỡ, màu nhãn hàng
            List<Size> sizeList = mdao.getAllSize();
            List<Brand> brandList = mdao.getAllBrand();
            List<Type> typeList = mdao.getAllProductType();
            List<Category> categoryList = cdao.getAllCategory();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("typeList", typeList);
            request.setAttribute("brandList", brandList);
            request.setAttribute("colorList", colorList);
            request.setAttribute("sizeList", sizeList);
            request.setAttribute("totalProduct", activePro + notactivePro);
            request.setAttribute("activePro", activePro);
            request.setAttribute("notactivePro", notactivePro);
            request.setAttribute("listP", list);
            request.setAttribute("startRecord", (page - 1)*batch +1);
            request.setAttribute("endRecord", Math.min(page * batch, totalReCord));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", (int) (totalReCord / batch) +1);
            request.setAttribute("totalRecords", totalReCord);
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra!");
        }

        request.getRequestDispatcher("../Admin/ListProductAdmin.jsp").forward(request, response);
    }

    private String[] getData(HttpServletRequest request) {
        String search = request.getParameter("productName");
        String color = request.getParameter("color");
        String size = request.getParameter("size");
        String status = request.getParameter("status");
        String quantity = request.getParameter("quantity");
        String type = request.getParameter("type");
        String brand = request.getParameter("brand");
        String categories = request.getParameter("cate");
        return new String[]{search, color, size, status,
            quantity, type, brand, categories};
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
