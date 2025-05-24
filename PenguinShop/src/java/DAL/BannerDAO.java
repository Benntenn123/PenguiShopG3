

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;
import Models.Banner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BannerDAO extends DBContext{
    public List<Banner> getAllBanners() {
        List<Banner> banners = new ArrayList<>();
        String sql = "SELECT bannerID, bannerLink FROM Banner";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }
}
