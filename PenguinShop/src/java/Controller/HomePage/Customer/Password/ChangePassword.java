/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Password;

import APIKey.Capcha;
import Utils.HashPassword;
import Controller.HomePage.Customer.Auth.Login;
import DAL.UserDAO;
import Models.User;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;

@WebServlet(name = "ChangePassword", urlPatterns = {"/changepassword"})
public class ChangePassword extends HttpServlet {

    UserDAO udao = new UserDAO();
    private static final Logger LOGGER = LogManager.getLogger(Login.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("HomePage/ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPass = request.getParameter("currentpass");
        String newPass = request.getParameter("pass");
        String rePass = request.getParameter("repass");
        System.out.println(currentPass);
        String recaptchaResponse = request.getParameter("g-recaptcha-response");
        LOGGER.info("Lấy thành công capcha{}", recaptchaResponse);
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            LOGGER.warn("User null");
            request.getSession().setAttribute("error", "Vui lòng đăng nhập.");
            response.sendRedirect("changepassword");
            return;
        }
        // Check rỗng các input
        if (currentPass == null || currentPass.isEmpty()
                || newPass == null || newPass.isEmpty()
                || rePass == null || rePass.isEmpty()) {
            request.getSession().setAttribute("error", "Vui lòng điền đủ các trường.");
            response.sendRedirect("changepassword");
            return;
        }

        // 1. Kiểm tra reCAPTCHA
        if (!verifyRecaptcha(recaptchaResponse)) {
            request.getSession().setAttribute("error", "Vui lòng xác nhận reCAPTCHA.");
            response.sendRedirect("changepassword");
            return;
        }

        // 2. Kiểm tra mật khẩu nhập lại
        if (!newPass.equals(rePass)) {
            request.getSession().setAttribute("error", "Mật khẩu không khớp.");
            response.sendRedirect("changepassword");
            return;
        }

        
        // 3. Xử lý đổi mật khẩu thật ở đây (ví dụ: kiểm tra currentPass và update DB)
        if (!udao.checkCorrectPassword(user.getUserID(), HashPassword.hashWithSHA256(currentPass))) {
            request.getSession().setAttribute("error", "Mật khẩu không đúng.");
            response.sendRedirect("changepassword");
            return;
        }
        
        if (!udao.updatePassword(user.getUserID(), HashPassword.hashWithSHA256(newPass))) {
            request.getSession().setAttribute("error", "Đổi mật khẩu không thành công!");
            response.sendRedirect("changepassword");
            return;
        }
        request.getSession().setAttribute("ms", "Đổi mật khẩu thành công!");
        response.sendRedirect("changepassword");

    }

    private boolean verifyRecaptcha(String recaptchaResponse) {
        try {

            String url = "https://www.google.com/recaptcha/api/siteverify";
            String postData = "secret=" + URLEncoder.encode(Capcha.SECRETKEY, "UTF-8")
                    + "&response=" + URLEncoder.encode(recaptchaResponse, "UTF-8");

            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            con.setRequestMethod("POST");
            con.setDoOutput(true);
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("Content-Length", String.valueOf(postData.length()));

            OutputStream os = con.getOutputStream();
            os.write(postData.getBytes());
            os.flush();
            os.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder responseText = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                responseText.append(inputLine);
            }
            in.close();

            JSONObject jsonObject = new JSONObject(responseText.toString());
            return jsonObject.getBoolean("success");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
