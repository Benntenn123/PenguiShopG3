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
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.List;
@MultipartConfig
@WebServlet(name="AddGroupProduct", urlPatterns={"/admin/addGroupProduct"})
public class AddGroupProduct extends HttpServlet {
    private final CloudinaryConfig cloudinaryService = new CloudinaryConfig();
    MeterialDAO mdao = new MeterialDAO();
    CategoriesDAO cdao = new CategoriesDAO();
    ProductDao pdao = new ProductDao();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddGroupProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddGroupProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    private String[] getData(HttpServletRequest request) throws IOException, ServletException {
        // Lấy dữ liệu từ request
        String productName = request.getParameter("productName");
        String sku = request.getParameter("sku");
        String productTypeID = request.getParameter("productTypeID");
        String brandID = request.getParameter("brandID");
        String description = request.getParameter("description");
        String[] categories = request.getParameterValues("categories");
        Part imageMainProduct = request.getPart("imageMainProduct");

        // Chuyển categories thành chuỗi phân tách bằng dấu phẩy
        String categoriesStr = categories != null ? String.join(",", categories) : "";

        // Upload ảnh lên Cloudinary và lấy public_id
        String imagePublicId = "";
        if (imageMainProduct != null && imageMainProduct.getSize() > 0) {
            String fileName = imageMainProduct.getSubmittedFileName();
            try {
                imagePublicId = cloudinaryService.uploadImage(imageMainProduct.getInputStream(), fileName);
                if (imagePublicId == null) {
                    imagePublicId = "";
                }
            } catch (Exception e) {
                System.out.println("Lỗi upload ảnh lên Cloudinary: " + e.getMessage());
            }
        }

        // Trả về mảng String chứa các trường bắt buộc
        return new String[] {
            productName,
            sku,
            productTypeID,
            brandID,
            description,
            categoriesStr,
            imagePublicId
        };
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Brand> brands = mdao.getAllBrand();
        List<Type> types = mdao.getAllProductType();
        List<Category> cates = cdao.getAllCategory();
        
        
        request.setAttribute("brands", brands);
        request.setAttribute("types", types);
        request.setAttribute("cates", cates);
        request.getRequestDispatcher("../Admin/AddGroupProduct.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String[] data = getData(request);
            // Kiểm tra các trường bắt buộc
            if (StringConvert.isAnyFieldEmpty(data)) {
                session.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc!");
                response.sendRedirect("addGroupProduct");
                return;
            }

            Product product = new Product();
            product.setProductName(data[0]);
            product.setSku(data[1]);
            
            int typeID = Integer.parseInt(data[2]);
            Type t = new Type();
            t.setTypeId(typeID);
            product.setType(t);
            
            Brand b = new Brand();
            int brID = Integer.parseInt(data[3]);
            b.setBrandID(brID);
            product.setBrand(b);
            
            product.setDescription(data[4]); // Lưu HTML
            
            String[] cate = request.getParameterValues("categories");
            List<Category> cateList = new ArrayList<>();
            for (String string : cate) {
                Category c = new Category();
                c.setCategoryId(Integer.parseInt(string));
                cateList.add(c);
            }
            product.setCategories(cateList);
            product.setImageMainProduct(data[6]);
            
            String importDate = request.getParameter("importDate");
            String weight = request.getParameter("weight");
            String fullDescription = request.getParameter("full_description"); // Lưu HTML
            product.setImportDate(importDate);
            product.setWeight(weight != null && !weight.isEmpty() ? Double.parseDouble(weight) : null);
            product.setFull_description(fullDescription);

            // Gọi DAO
            int productID = pdao.addProduct(product);
            boolean categoriesAdded = pdao.addProductCategories(productID, product.getCategories());

            if (productID != -1 && categoriesAdded) {
                session.setAttribute("ms", "Thêm sản phẩm thành công");
                session.setAttribute("product", product);
                session.setAttribute("imageUrl", cloudinaryService.getImageUrl(data[6]));
                response.sendRedirect("listGroupProduct");
            } else {
                session.setAttribute("error", "Thêm sản phẩm không thành công! Vui lòng thử lại");
                response.sendRedirect("addGroupProduct");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("addGroupProduct");
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
