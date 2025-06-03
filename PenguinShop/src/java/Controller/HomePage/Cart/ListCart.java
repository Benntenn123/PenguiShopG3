

package Controller.HomePage.Cart;

import DAL.CartDAO;
import Models.Cart;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name="ListCart", urlPatterns={"/listCart"})
public class ListCart extends HttpServlet {
   
    CartDAO cdao = new CartDAO();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCart</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCart at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null){
            request.getSession().setAttribute("ms", "Vui lòng login ! ");
            response.sendRedirect("login");
        }
        
        List<Cart> cart = cdao.getCartUser(user.getUserID());
        request.setAttribute("cart", cart);       
        request.getRequestDispatcher("HomePage/ListCart.jsp").forward(request, response);
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
