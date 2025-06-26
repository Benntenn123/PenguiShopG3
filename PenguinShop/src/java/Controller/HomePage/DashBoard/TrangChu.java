/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.DashBoard;

import DAL.BannerDAO;
import DAL.BrandDAO;
import DAL.CartDAO;
import DAL.CategoriesDAO;
import DAL.ProductDao;
import Models.Banner;
import Models.Brand;
import Models.Category;
import Models.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import DAL.ProductDao;
import DAL.PromotionDAO;
import Models.Promotion;
import Models.User;

@WebServlet(name = "TrangChu", urlPatterns = {"/trangchu"})
public class TrangChu extends HttpServlet {

    BannerDAO bdao = new BannerDAO();
    CategoriesDAO cdao = new CategoriesDAO();
    BrandDAO brdao = new BrandDAO();
    ProductDao pdao = new ProductDao();
    CartDAO cadao = new CartDAO();
    PromotionDAO promotionDAO = new PromotionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Banner> banner = bdao.getAllBanners();
            request.setAttribute("banner", banner);

            List<Category> cate = cdao.getAllCategory();
            request.setAttribute("cate", cate);

            List<Brand> br = brdao.getAllBrand();
            request.setAttribute("brand", br);

            List<Brand> sixbr = brdao.gettop6BrandHighestOrder();
            request.setAttribute("sixbr", sixbr);

            List<ProductVariant> newArrival = pdao.getNewArrival();
            request.setAttribute("newArrival", newArrival);

            List<ProductVariant> top4Week = pdao.loadTop4ProductHotWeek();
            request.setAttribute("top4Week", top4Week);

            List<ProductVariant> hot = pdao.getHotProduct();
            request.setAttribute("hot", hot);

            Promotion flashSale = promotionDAO.getSoonExpiringPromotionWithProducts(); // load flash sales
            request.setAttribute("flashSale", flashSale);

            User user = (User) request.getSession().getAttribute("user");
            int totalCart = 0;
            if (user != null) {
                totalCart = cadao.getCartUser(user.getUserID()).size();
            }
            request.getSession().setAttribute("totalCart", totalCart);
            request.getSession().setAttribute("cateMenu", cate);
            request.getSession().setAttribute("brandMenu", br);
        } catch (Exception e) {
        }

        request.getRequestDispatcher("HomePage/TrangChu.jsp").forward(request, response);
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
