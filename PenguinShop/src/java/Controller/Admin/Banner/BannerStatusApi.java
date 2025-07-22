package Controller.Admin.Banner;

import DAL.BannerDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "BannerStatusApi", urlPatterns = {"/admin/api/bannerStatus"})
public class BannerStatusApi extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        try {
            // Parse JSON
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            BannerStatusRequest req = gson.fromJson(sb.toString(), BannerStatusRequest.class);
            BannerDAO dao = new BannerDAO();
            boolean success = dao.updateStatus(req.id, req.status);
            out.print(gson.toJson(new BannerStatusResponse(success)));
        } catch (Exception e) {
            out.print(gson.toJson(new BannerStatusResponse(false)));
        } finally {
            out.close();
        }
    }

    private static class BannerStatusRequest {
        public int id;
        public int status;
    }
    private static class BannerStatusResponse {
        public boolean success;
        public BannerStatusResponse(boolean success) { this.success = success; }
    }
}
