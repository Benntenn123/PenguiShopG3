/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products;

import DAL.MeterialDAO;
import DAL.ProductDao;
import Models.Color;
import Models.Product;
import Models.ProductVariant;
import Models.Size;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AddAttributeProduct", urlPatterns = {"/admin/addAttributeProduct"})
public class AddAttributeProduct extends HttpServlet {

    ProductDao pdao = new ProductDao();
    MeterialDAO mdao = new MeterialDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAttributeProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAttributeProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("productID");
        if (StringConvert.isEmpty(productID)) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra");
            response.sendRedirect("listGroupProduct");
            return;
        }
        try {
            int pID = Integer.parseInt(productID);
            Product p = pdao.getProductFromID(pID);
            List<Color> colors = mdao.getAllColor();
            List<Size> sizes = mdao.getAllSize();

            request.setAttribute("colors", colors);
            request.setAttribute("sizes", sizes);
            request.setAttribute("pv", p);
        } catch (Exception e) {
        }

        request.getRequestDispatcher("../Admin/AddProductAttribute.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String groupProductID = request.getParameter("groupProductID");
            String colorID = request.getParameter("colorID");
            String sizeID = request.getParameter("sizeID");
            String price = request.getParameter("price");
            String stock = request.getParameter("stock");
            String status = request.getParameter("status");
            String[] data = new String[]{groupProductID, colorID, sizeID, price, stock, status};
            // Validate
            if (StringConvert.isAnyFieldEmpty(data)) {
                session.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc!");
                response.sendRedirect("addProductAttribute?groupProductID=" + groupProductID);
                return;
            }

            ProductVariant attribute = new ProductVariant();

            Product p = new Product();
            p.setProductId(Integer.parseInt(groupProductID));
            attribute.setProduct(p);

            Color c = new Color();
            c.setColorID(Integer.parseInt(colorID));
            attribute.setColor(c);

            Size s = new Size();
            s.setSizeID(Integer.parseInt(sizeID));
            attribute.setSize(s);

            attribute.setPrice(Double.parseDouble(price));

            attribute.setQuantity(Integer.parseInt(stock));

            attribute.setStockSta(Integer.parseInt(status));
            if (!pdao.checkVariantExists(attribute.getProduct().getProductId(), attribute.getColor().getColorID(),
                    attribute.getSize().getSizeID())) {
                boolean success = pdao.addProductAttribute(attribute);
                if (success) {
                    session.setAttribute("ms", "Thêm thuộc tính thành công");
                    response.sendRedirect("listGroupProduct");
                } else {
                    session.setAttribute("error", "Thêm thuộc tính không thành công! Vui lòng thử lại");
                    response.sendRedirect("addAttributeProduct?productID=" + groupProductID);
                }
            }
            else{
                session.setAttribute("error", "Sản phẩm với thuộc tính này đã tồn tại");
                response.sendRedirect("addAttributeProduct?productID=" + groupProductID);
            }

        } catch (Exception e) {
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("listGroupProduct");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
