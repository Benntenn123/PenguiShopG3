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

            // Phân trang
            int page = 1;
            int pageSize = 9;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) { }
            }

            // Lấy danh sách brand và lọc search
            List<Brand> allBrands = brandDAO.getAllBrand();
            if (searchName != null && !searchName.trim().isEmpty()) {
                allBrands = allBrands.stream()
                    .filter(brand -> brand.getBrandName().toLowerCase()
                        .contains(searchName.toLowerCase().trim()))
                    .collect(java.util.stream.Collectors.toList());
            }
            int totalBrands = allBrands.size();
            int totalPages = (int) Math.ceil((double) totalBrands / pageSize);
            if (page > totalPages && totalPages > 0) page = totalPages;

            // Lấy danh sách brand cho trang hiện tại
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalBrands);
            List<Brand> brands = (fromIndex < toIndex) ? allBrands.subList(fromIndex, toIndex) : java.util.Collections.emptyList();

            // Set attributes cho JSP
            request.setAttribute("brands", brands);
            request.setAttribute("totalBrands", totalBrands);
            request.setAttribute("searchName", searchName);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

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
