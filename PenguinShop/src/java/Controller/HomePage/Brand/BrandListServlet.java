package Controller.HomePage.Brand;

import DAL.BrandDAO;
import Models.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BrandListServlet", urlPatterns = {"/brands"})
public class BrandListServlet extends HttpServlet {

    private final BrandDAO brandDAO = new BrandDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get search parameters
            String searchName = request.getParameter("searchName");
            
            // For now, we'll get all brands and implement basic filtering
            List<Brand> brands = brandDAO.getAllBrand();
            
            // Filter brands if search name is provided
            if (searchName != null && !searchName.trim().isEmpty()) {
                brands = brands.stream()
                    .filter(brand -> brand.getBrandName().toLowerCase()
                        .contains(searchName.toLowerCase().trim()))
                    .collect(java.util.stream.Collectors.toList());
            }

            // Set attributes for JSP
            request.setAttribute("brands", brands);
            request.setAttribute("totalBrands", brands.size());
            request.setAttribute("searchName", searchName);

            // Forward to JSP page
            request.getRequestDispatcher("HomePage/BrandList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tải danh sách thương hiệu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
