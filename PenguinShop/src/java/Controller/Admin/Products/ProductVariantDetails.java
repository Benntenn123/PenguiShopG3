/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products;

import DAL.CategoriesDAO;
import DAL.ProductDao;
import Models.Category;
import Models.ProductVariant;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductVariantDetails", urlPatterns = {"/admin/variant_details"})
public class ProductVariantDetails extends HttpServlet {

    ProductDao pdao = new ProductDao();
    CategoriesDAO cdao = new CategoriesDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductVariantDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductVariantDetails at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String variantID_raw = request.getParameter("variantID");
        if (StringConvert.isEmpty(variantID_raw)) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại!");
            response.sendRedirect("listProductAdmin");
            return;
        } else {
            try {
                int variantID = Integer.parseInt(variantID_raw);
                ProductVariant pv = pdao.getProductVariantWithID(variantID); // load details variant

                List<String> image = pdao.loadImageProductWithID(pv.getProduct().getProductId());// load ảnh galary

                List<Category> cate = cdao.getCategoryProduct(pv.getProduct().getProductId()); //load categories
                request.setAttribute("cate", cate);
                
                List<ProductVariant> list = pdao.getVariantProduct(pv.getProduct().getProductId());
                request.setAttribute("list", list);
                
                
                request.setAttribute("image", image);
                request.setAttribute("pv", pv);
            } catch (Exception e) {
            }
        }

        request.getRequestDispatcher("../Admin/ProductVariantDetails.jsp").forward(request, response);
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
