/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Product;

import Controller.HomePage.Customer.Auth.Login;
import DAL.CategoriesDAO;
import DAL.ProductDao;
import Models.Category;
import Models.Color;
import Models.ProductVariant;
import Models.Size;
import Models.Tag;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


@WebServlet(name="ProductDetails", urlPatterns={"/productdetail"})
public class ProductDetails extends HttpServlet {
    ProductDao pdao = new ProductDao();
    CategoriesDAO cdao = new CategoriesDAO();
    private static final Logger LOGGER = LogManager.getLogger(Login.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetails</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetails at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {        
        String variantID = request.getParameter("id");
        if(variantID == null){
            request.getSession().setAttribute("error", "Vui lòng chọn sản phẩm!");
            response.sendRedirect("trangchu");
            return;
        }
        try {
            int variant = Integer.parseInt(variantID);
            ProductVariant pv = pdao.loadProductWithID(variant); // load detail sp
            request.setAttribute("pv", pv);
            
            List<String> image = pdao.loadImageProductWithID(pv.getProduct().getProductId()); // load ảnh sản phẩm
            request.setAttribute("image", image);
            
            List<Category> cate = cdao.getCategoryProduct(pv.getProduct().getProductId()); //load categories
            request.setAttribute("cate", cate);
            
            List<Tag> tag = pdao.loadTagProduct(pv.getProduct().getProductId());
            request.setAttribute("tag", tag);
            
            List<Integer> catego = new ArrayList<>();    //load sản phẩm sát với các categories mà product detail này đang đứng
            
            for (Category ca : cate) {
                System.out.println(ca.getCategoryId());
                catego.add(ca.getCategoryId());
            }
            List<ProductVariant> relatedProduct = pdao.getRelatedProduct(catego);          
            request.setAttribute("relatedProduct", relatedProduct);
            
            List<Size> sizePro = pdao.loadSizeProduct(pv.getProduct().getProductId());
            request.setAttribute("sizePro", sizePro);
            
            List<Color> colorPro = pdao.loadColorProduct(pv.getProduct().getProductId());
            request.setAttribute("colorPro", colorPro);
            
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Link không đúng vui lòng thử lại");
            response.sendRedirect("trangchu");
            return;
        }
        
        
        
        request.getRequestDispatcher("HomePage/ProductDetail.jsp").forward(request, response);
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
