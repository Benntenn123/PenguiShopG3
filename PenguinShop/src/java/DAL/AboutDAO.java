package DAL;

import Models.AboutService;
import Models.AboutUs;
import Models.CompanyStat;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AboutDAO extends DBContext {
    
    /**
     * Lấy thông tin About Us hiện tại (chỉ lấy record active)
     * @return AboutUs object hoặc null nếu không có
     */
    public AboutUs getAboutInfo() {
        String sql = "SELECT * FROM tbAboutUs WHERE isActive = 1";
        AboutUs aboutUs = null;
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                aboutUs = new AboutUs();
                aboutUs.setAboutID(rs.getInt("aboutID"));
                aboutUs.setTitle(rs.getString("title"));
                aboutUs.setSubtitle(rs.getString("subtitle"));
                aboutUs.setMainImage(rs.getString("mainImage"));
                aboutUs.setContent(rs.getString("content"));
                aboutUs.setHighlightPoints(rs.getString("highlightPoints"));
                aboutUs.setVideoUrl(rs.getString("videoUrl"));
                aboutUs.setActive(rs.getBoolean("isActive"));
                aboutUs.setCreatedAt(rs.getTimestamp("createdAt"));
                aboutUs.setUpdatedAt(rs.getTimestamp("updatedAt"));
                
                Integer updatedBy = rs.getInt("updatedBy");
                if (rs.wasNull()) updatedBy = null;
                aboutUs.setUpdatedBy(updatedBy);
                
                // Chuyển highlightPoints thành list
                if (aboutUs.getHighlightPoints() != null) {
                    String[] points = aboutUs.getHighlightPoints().split("\\|");
                    aboutUs.setHighlightPointsList(Arrays.asList(points));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getAboutInfo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return aboutUs;
    }
    
    /**
     * Lấy danh sách các dịch vụ của công ty (chỉ lấy active)
     * @return List<AboutService>
     */
    public List<AboutService> getAboutServices() {
        String sql = "SELECT * FROM tbAboutServices WHERE isActive = 1 ORDER BY displayOrder ASC";
        List<AboutService> services = new ArrayList<>();
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                AboutService service = new AboutService();
                service.setServiceID(rs.getInt("serviceID"));
                service.setServiceName(rs.getString("serviceName"));
                service.setServiceDescription(rs.getString("serviceDescription"));
                service.setServiceIcon(rs.getString("serviceIcon"));
                service.setDisplayOrder(rs.getInt("displayOrder"));
                service.setActive(rs.getBoolean("isActive"));
                
                services.add(service);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAboutServices: " + e.getMessage());
            e.printStackTrace();
        }
        
        return services;
    }
    
    /**
     * Lấy danh sách thống kê công ty (chỉ lấy active)
     * @return List<CompanyStat>
     */
    public List<CompanyStat> getCompanyStats() {
        String sql = "SELECT * FROM tbCompanyStats WHERE isActive = 1 ORDER BY displayOrder ASC";
        List<CompanyStat> stats = new ArrayList<>();
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                CompanyStat stat = new CompanyStat();
                stat.setStatID(rs.getInt("statID"));
                stat.setStatName(rs.getString("statName"));
                stat.setStatValue(rs.getString("statValue"));
                stat.setStatIcon(rs.getString("statIcon"));
                stat.setDisplayOrder(rs.getInt("displayOrder"));
                stat.setActive(rs.getBoolean("isActive"));
                
                stats.add(stat);
            }
        } catch (SQLException e) {
            System.err.println("Error in getCompanyStats: " + e.getMessage());
            e.printStackTrace();
        }
        
        return stats;
    }
    
    /**
     * Cập nhật thông tin About Us
     * @param aboutUs AboutUs object cần cập nhật
     * @param updatedBy ID của user thực hiện cập nhật
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean updateAboutInfo(AboutUs aboutUs, int updatedBy) {
        String sql = "UPDATE tbAboutUs SET title = ?, subtitle = ?, mainImage = ?, " +
                    "content = ?, highlightPoints = ?, videoUrl = ?, isActive = ?, " +
                    "updatedAt = GETDATE(), updatedBy = ? WHERE aboutID = ?";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, aboutUs.getTitle());
            ps.setString(2, aboutUs.getSubtitle());
            ps.setString(3, aboutUs.getMainImage());
            ps.setString(4, aboutUs.getContent());
            ps.setString(5, aboutUs.getHighlightPoints());
            ps.setString(6, aboutUs.getVideoUrl());
            ps.setBoolean(7, aboutUs.isActive());
            ps.setInt(8, updatedBy);
            ps.setInt(9, aboutUs.getAboutID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in updateAboutInfo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Thêm thông tin About Us mới
     * @param aboutUs AboutUs object cần thêm
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean insertAboutInfo(AboutUs aboutUs) {
        String sql = "INSERT INTO tbAboutUs (title, subtitle, mainImage, content, " +
                    "highlightPoints, videoUrl, isActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, aboutUs.getTitle());
            ps.setString(2, aboutUs.getSubtitle());
            ps.setString(3, aboutUs.getMainImage());
            ps.setString(4, aboutUs.getContent());
            ps.setString(5, aboutUs.getHighlightPoints());
            ps.setString(6, aboutUs.getVideoUrl());
            ps.setBoolean(7, aboutUs.isActive());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in insertAboutInfo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    
    public boolean updateAboutService(AboutService service) {
        String sql = "UPDATE tbAboutServices SET serviceName = ?, serviceDescription = ?, " +
                    "serviceIcon = ?, displayOrder = ?, isActive = ? WHERE serviceID = ?";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setString(3, service.getServiceIcon());
            ps.setInt(4, service.getDisplayOrder());
            ps.setBoolean(5, service.isActive());
            ps.setInt(6, service.getServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in updateAboutService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Cập nhật thống kê công ty
     * @param stat CompanyStat object cần cập nhật
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean updateCompanyStat(CompanyStat stat) {
        String sql = "UPDATE tbCompanyStats SET statName = ?, statValue = ?, " +
                    "statIcon = ?, displayOrder = ?, isActive = ? WHERE statID = ?";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, stat.getStatName());
            ps.setString(2, stat.getStatValue());
            ps.setString(3, stat.getStatIcon());
            ps.setInt(4, stat.getDisplayOrder());
            ps.setBoolean(5, stat.isActive());
            ps.setInt(6, stat.getStatID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in updateCompanyStat: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Thêm dịch vụ About Us mới
     * @param service AboutService object cần thêm
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean addAboutService(AboutService service) {
        String sql = "INSERT INTO tbAboutServices (serviceName, serviceDescription, serviceIcon, displayOrder, isActive) VALUES (?, ?, ?, ?, ?)";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceDescription());
            ps.setString(3, service.getServiceIcon());
            ps.setInt(4, service.getDisplayOrder());
            ps.setBoolean(5, service.isActive());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in addAboutService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xóa dịch vụ About Us
     * @param serviceID ID của dịch vụ cần xóa
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean deleteAboutService(int serviceID) {
        String sql = "DELETE FROM tbAboutServices WHERE serviceID = ?";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, serviceID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in deleteAboutService: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Thêm thống kê công ty mới
     * @param stat CompanyStat object cần thêm
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean addCompanyStat(CompanyStat stat) {
        String sql = "INSERT INTO tbCompanyStats (statName, statValue, statIcon, displayOrder, isActive) VALUES (?, ?, ?, ?, ?)";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, stat.getStatName());
            ps.setString(2, stat.getStatValue());
            ps.setString(3, stat.getStatIcon());
            ps.setInt(4, stat.getDisplayOrder());
            ps.setBoolean(5, stat.isActive());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in addCompanyStat: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xóa thống kê công ty
     * @param statID ID của thống kê cần xóa
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean deleteCompanyStat(int statID) {
        String sql = "DELETE FROM tbCompanyStats WHERE statID = ?";
        
        try {
            Connection conn = connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, statID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in deleteCompanyStat: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Overload method for updateAboutInfo without updatedBy parameter
     * @param aboutUs AboutUs object cần cập nhật
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean updateAboutInfo(AboutUs aboutUs) {
        return updateAboutInfo(aboutUs, 1); // Default updatedBy = 1 (admin)
    }
}
