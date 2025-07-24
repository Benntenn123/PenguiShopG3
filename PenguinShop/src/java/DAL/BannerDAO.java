

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;
import Models.Banner;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BannerDAO extends DBContext{
    public List<Banner> getAllBanners() {
        List<Banner> banners = new ArrayList<>();
        String sql = "SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner where bannerStatus =1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }
        // Lấy tất cả banner có phân trang
    public List<Banner> getAllBannersPaging(int page, int pageSize) {
        List<Banner> banners = new ArrayList<>();
        String sql = "SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner ORDER BY createdAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }

    // Đếm tổng số banner
    public int countAllBanners() {
        String sql = "SELECT COUNT(*) FROM Banner";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tìm kiếm banner có phân trang
    public List<Banner> searchBannersPaging(String bannerName, String bannerHref, Integer bannerStatus, int page, int pageSize) {
        List<Banner> banners = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner WHERE 1=1");
        if (bannerName != null && !bannerName.trim().isEmpty()) {
            sql.append(" AND bannerName LIKE ?");
        }
        if (bannerHref != null && !bannerHref.trim().isEmpty()) {
            sql.append(" AND bannerHref LIKE ?");
        }
        if (bannerStatus != null) {
            sql.append(" AND bannerStatus = ?");
        }
        sql.append(" ORDER BY createdAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (bannerName != null && !bannerName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerName.trim() + "%");
            }
            if (bannerHref != null && !bannerHref.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerHref.trim() + "%");
            }
            if (bannerStatus != null) {
                ps.setInt(paramIndex++, bannerStatus);
            }
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }

    // Đếm tổng số banner theo điều kiện tìm kiếm
    public int countBannersSearch(String bannerName, String bannerHref, Integer bannerStatus) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Banner WHERE 1=1");
        if (bannerName != null && !bannerName.trim().isEmpty()) {
            sql.append(" AND bannerName LIKE ?");
        }
        if (bannerHref != null && !bannerHref.trim().isEmpty()) {
            sql.append(" AND bannerHref LIKE ?");
        }
        if (bannerStatus != null) {
            sql.append(" AND bannerStatus = ?");
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (bannerName != null && !bannerName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerName.trim() + "%");
            }
            if (bannerHref != null && !bannerHref.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerHref.trim() + "%");
            }
            if (bannerStatus != null) {
                ps.setInt(paramIndex++, bannerStatus);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Banner> getAllBannersList() {
        List<Banner> banners = new ArrayList<>();
        String sql = "SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }

    public boolean updateStatus(int bannerID, int status) {
        String sql = "UPDATE Banner SET bannerStatus = ? WHERE bannerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, bannerID);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addBanner(Banner banner) {
        String sql = "INSERT INTO Banner (bannerName, bannerHref, bannerLink, bannerStatus, createdAt) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, banner.getBannerName());
            ps.setString(2, banner.getBannerHref());
            ps.setString(3, banner.getBannerLink());
            ps.setInt(4, banner.getBannerStatus());
            ps.setTimestamp(5, new java.sql.Timestamp(banner.getCreatedAt().getTime()));
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBanner(int bannerID) {
        String sql = "DELETE FROM Banner WHERE bannerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, bannerID);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Banner getBannerById(int bannerID) {
        String sql = "SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner WHERE bannerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, bannerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                return banner;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBanner(Banner banner) {
        String sql = "UPDATE Banner SET bannerName = ?, bannerHref = ?, bannerLink = ?, bannerStatus = ? WHERE bannerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, banner.getBannerName());
            ps.setString(2, banner.getBannerHref());
            ps.setString(3, banner.getBannerLink());
            ps.setInt(4, banner.getBannerStatus());
            ps.setInt(5, banner.getBannerID());
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Banner> searchBanners(String bannerName, String bannerHref, Integer bannerStatus) {
        List<Banner> banners = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT bannerID, bannerName, bannerHref, bannerStatus, createdAt, bannerLink FROM Banner WHERE 1=1");
        
        if (bannerName != null && !bannerName.trim().isEmpty()) {
            sql.append(" AND bannerName LIKE ?");
        }
        if (bannerHref != null && !bannerHref.trim().isEmpty()) {
            sql.append(" AND bannerHref LIKE ?");
        }
        if (bannerStatus != null) {
            sql.append(" AND bannerStatus = ?");
        }
        sql.append(" ORDER BY createdAt DESC");
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (bannerName != null && !bannerName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerName.trim() + "%");
            }
            if (bannerHref != null && !bannerHref.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + bannerHref.trim() + "%");
            }
            if (bannerStatus != null) {
                ps.setInt(paramIndex++, bannerStatus);
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Banner banner = new Banner();
                banner.setBannerID(rs.getInt("bannerID"));
                banner.setBannerName(rs.getString("bannerName"));
                banner.setBannerHref(rs.getString("bannerHref"));
                banner.setBannerStatus(rs.getInt("bannerStatus"));
                banner.setCreatedAt(rs.getTimestamp("createdAt"));
                banner.setBannerLink(rs.getString("bannerLink"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return banners;
    }
}
