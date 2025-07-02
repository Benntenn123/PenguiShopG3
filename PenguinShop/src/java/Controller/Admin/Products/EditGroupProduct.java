/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import APIKey.CloudinaryConfig;
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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.List;

@MultipartConfig
@WebServlet(name="EditGroupProduct", urlPatterns={"/admin/editGroupProduct"})
public class EditGroupProduct extends HttpServlet {
    private ProductDao productDAO = new ProductDao();
    private MeterialDAO mdao = new MeterialDAO();
    private CategoriesDAO cdao = new CategoriesDAO();
    private CloudinaryConfig clodinaryconfig = new CloudinaryConfig();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditGroupProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditGroupProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productID = Integer.parseInt(request.getParameter("productId"));
            
            Product product = productDAO.getProductFromID2(productID);
            if (product == null) {
                throw new IllegalArgumentException("Sản phẩm không tồn tại");
            }
            List<Type> types = mdao.getAllProductType();
            List<Brand> brands = mdao.getAllBrand();
            List<Category> cates = cdao.getAllCategory();

            request.setAttribute("product", product);
            request.setAttribute("types", types);
            request.setAttribute("brands", brands);
            request.setAttribute("cates", cates);
            request.getRequestDispatcher("../Admin/EditGroupProduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải sản phẩm: " + e.getMessage());
            response.sendRedirect("listGroupProduct");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String productName = request.getParameter("productName");
            int productTypeID = Integer.parseInt(request.getParameter("productTypeID"));
            int brandID = Integer.parseInt(request.getParameter("brandID"));
            String[] categoryIds = request.getParameterValues("categories");
            for (String categoryId : categoryIds) {
                System.out.println("Địt mẹ mày" +categoryId);
            }
            String description = request.getParameter("description");
            String fullDescription = request.getParameter("full_description");
            String existingImage = request.getParameter("existingImage");
            Part filePart = request.getPart("imageMainProduct");

            // Validate inputs
            if (productName == null || productName.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên sản phẩm không được để trống");
            }
            if (productTypeID <= 0) {
                throw new IllegalArgumentException("Loại sản phẩm không hợp lệ");
            }
            if (brandID <= 0) {
                throw new IllegalArgumentException("Thương hiệu không hợp lệ");
            }
            if (categoryIds == null || categoryIds.length == 0) {
                throw new IllegalArgumentException("Phải chọn ít nhất một danh mục");
            }
            if (description == null || description.trim().isEmpty()) {
                throw new IllegalArgumentException("Mô tả ngắn không được để trống");
            }
            if (description.length() > 500) {
                throw new IllegalArgumentException("Mô tả ngắn vượt quá 500 ký tự");
            }
            System.out.println("3");
            // Handle file upload to Cloudinary
            String imagePublicId = existingImage;
            if (filePart != null && filePart.getSize() > 0) {
                try (InputStream fileContent = filePart.getInputStream()) {
                    String fileName = filePart.getSubmittedFileName();
                    imagePublicId = clodinaryconfig.uploadImage(fileContent, fileName);
                    if (imagePublicId == null) {
                        throw new IllegalStateException("Lỗi khi upload ảnh lên Cloudinary");
                    }
                }
            }
            System.out.println("4");
            // Create Product object
            Type type = new Type();
            type.setTypeId(productTypeID);
            Brand brand = new Brand();
            brand.setBrandID(brandID);
            Product product = new Product();
            product.setProductId(productID);
            product.setProductName(productName);
            product.setType(type);
            product.setBrand(brand);
            product.setDescription(description);
            product.setFull_description(fullDescription);
            product.setImageMainProduct(imagePublicId);
            System.out.println("5");
            // Update product
            if(productDAO.updateProduct(product, categoryIds, imagePublicId)){
                request.getSession().setAttribute("ms", "Update thông tin sản phẩm thành công");
                response.sendRedirect("listGroupProduct");
            }
            else{
                request.getSession().setAttribute("error", "Update thông tin thất bại");
                response.sendRedirect("listGroupProduct");
            }

            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi "+ e.getMessage());
                response.sendRedirect("listGroupProduct");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
