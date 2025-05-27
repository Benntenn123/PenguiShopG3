
package Controller.HomePage.Customer.Auth;

import DAL.TokenDAO;
import DAL.UserDAO;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(name="Verify", urlPatterns={"/verify"})
public class Verify extends HttpServlet {
    
    TokenDAO tdao = new TokenDAO();
    UserDAO udao = new UserDAO();
    private static final Logger LOGGER = LogManager.getLogger(Login.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Verify</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Verify at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String token = request.getParameter("token");
        String[] verify = StringConvert.splitUserIdAndUUID(token);        
        try {
            int userID = Integer.parseInt(verify[0]);
            String[] oldTokenRaw = tdao.getTokenNewest(userID);
            String[] old_token = StringConvert.splitUserIdAndUUID(oldTokenRaw[0]);
            
            if(verify[0].equals(old_token[0]) && token.equals(oldTokenRaw[0])){
                if(udao.updateStatusAccount(userID)){
                    request.getSession().setAttribute("ms", "Xác minh tài khoản thành công!");
                    response.sendRedirect("trangchu");
                }
            }
            else{
                request.getSession().setAttribute("error", "Token không chính xác! Vui Lòng Thử Lại sau");
                response.sendRedirect("trangchu");
            }
        } catch (Exception e) {
        }
        
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
