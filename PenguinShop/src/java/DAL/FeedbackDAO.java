
package DAL;

import Models.Feedback;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {
        // Thống kê số feedback theo tháng
    public List<Models.MonthValue> getMonthlyFeedbacks(int year) {
        List<Models.MonthValue> list = new ArrayList<>();
        String sql = "SELECT MONTH(feedbackDate) as month, COUNT(*) as count FROM tbFeedback WHERE YEAR(feedbackDate) = ? GROUP BY MONTH(feedbackDate) ORDER BY month";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Models.MonthValue(rs.getInt("month"), rs.getInt("count")));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO tbFeedback (productID, variantID, userID, rating, comment, feedbackDate) "
                + "VALUES (?, ?, ?, ?, ?, GETDATE())";
                
        try {
            // Bắt đầu transaction
            connection.setAutoCommit(false);
            
            // Insert feedback
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, feedback.getProductID());
            ps.setInt(2, feedback.getVariantID());
            ps.setInt(3, feedback.getUserID());
            ps.setInt(4, feedback.getRating());
            ps.setString(5, feedback.getComment());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                connection.rollback();
                return false;
            }
            
            // Lấy ID của feedback vừa thêm
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int feedbackID = rs.getInt(1);
                
                // Nếu có ảnh thì thêm ảnh
                if (feedback.getImages() != null && !feedback.getImages().isEmpty()) {
                    boolean imagesAdded = addFeedbackImages(feedbackID, feedback.getImages());
                    if (!imagesAdded) {
                        connection.rollback();
                        return false;
                    }
                }
            }
            
            // Commit transaction nếu mọi thứ OK
            connection.commit();
            return true;
            
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    private boolean addFeedbackImages(int feedbackID, List<String> imageUrls) throws SQLException {
        String sql = "INSERT INTO tbImages (feedbackID, imageURL) VALUES (?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (String imageUrl : imageUrls) {
                ps.setInt(1, feedbackID);
                ps.setString(2, imageUrl);
                ps.addBatch();
            }
            
            int[] results = ps.executeBatch();
            
            // Kiểm tra xem tất cả các ảnh đã được thêm thành công chưa
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            return true;
        }
    }
    
    public List<Feedback> getFeedbacksByVariantID(int variantID) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName, u.image_user "
                + "FROM tbFeedback f "
                + "INNER JOIN tbUsers u ON f.userID = u.userID "
                + "WHERE f.variantID = ? "
                + "ORDER BY f.feedbackDate DESC";
                
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackID(rs.getInt("feedbackID"));
                feedback.setProductID(rs.getInt("productID"));
                feedback.setVariantID(rs.getInt("variantID"));
                feedback.setUserID(rs.getInt("userID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setFeedbackDate(rs.getTimestamp("feedbackDate"));
                User u = new User();
                feedback.setUser(u);
                // Lấy thông tin user
                feedback.getUser().setFullName(rs.getString("fullName"));
                feedback.getUser().setImage_user(rs.getString("image_user"));
                
                // Lấy ảnh feedback
                List<String> images = getFeedbackImages(feedback.getFeedbackID());
                feedback.setImages(images);
                
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
    
    public List<Feedback> getFeedbacksByVariantIDPaginated(int variantID, int page, int pageSize) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName, u.image_user "
                + "FROM tbFeedback f "
                + "INNER JOIN tbUsers u ON f.userID = u.userID "
                + "WHERE f.variantID = ? "
                + "ORDER BY f.feedbackDate DESC "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
                
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackID(rs.getInt("feedbackID"));
                feedback.setProductID(rs.getInt("productID"));
                feedback.setVariantID(rs.getInt("variantID"));
                feedback.setUserID(rs.getInt("userID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setFeedbackDate(rs.getTimestamp("feedbackDate"));
                User u = new User();
                feedback.setUser(u);
                feedback.getUser().setFullName(rs.getString("fullName"));
                feedback.getUser().setImage_user(rs.getString("image_user"));
                
                List<String> images = getFeedbackImages(feedback.getFeedbackID());
                feedback.setImages(images);
                
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public List<String> getFeedbackImages(int feedbackID) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT imageURL FROM tbImages WHERE feedbackID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                images.add(rs.getString("imageURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }
    
    public double getAverageRating(int variantID) {
        String sql = "SELECT AVG(CAST(rating AS FLOAT)) as avgRating FROM tbFeedback WHERE variantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("avgRating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    public int getTotalFeedbacks(int variantID) {
        String sql = "SELECT COUNT(*) as total FROM tbFeedback WHERE variantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public boolean userHasFeedback(int userID, int variantID) {
        String sql = "SELECT COUNT(*) as count FROM tbFeedback WHERE userID = ? AND variantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, variantID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteFeedback(int feedbackID) {
        try {
            connection.setAutoCommit(false);
            
            // Xóa ảnh trước
            String deleteImagesSQL = "DELETE FROM tbImages WHERE feedbackID = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteImagesSQL)) {
                ps.setInt(1, feedbackID);
                ps.executeUpdate();
            }
            
            // Sau đó xóa feedback
            String deleteFeedbackSQL = "DELETE FROM tbFeedback WHERE feedbackID = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteFeedbackSQL)) {
                ps.setInt(1, feedbackID);
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    connection.commit();
                    return true;
                } else {
                    connection.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public int[] getRatingDistribution(int variantID) {
        int[] distribution = new int[5]; // Index 0 = 1 star, 4 = 5 stars
        String sql = "SELECT rating, COUNT(*) as count "
                + "FROM tbFeedback "
                + "WHERE variantID = ? "
                + "GROUP BY rating "
                + "ORDER BY rating";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int rating = rs.getInt("rating");
                int count = rs.getInt("count");
                if (rating >= 1 && rating <= 5) {
                    distribution[rating - 1] = count;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    public List<Feedback> getFeedbacksByRating(int variantID, int rating, int page, int pageSize) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName, u.image_user "
                + "FROM tbFeedback f "
                + "INNER JOIN tbUsers u ON f.userID = u.userID "
                + "WHERE f.variantID = ? "
                + (rating > 0 ? "AND f.rating = ? " : "")
                + "ORDER BY f.feedbackDate DESC "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
                
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, variantID);
            if (rating > 0) {
                ps.setInt(paramIndex++, rating);
            }
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackID(rs.getInt("feedbackID"));
                feedback.setProductID(rs.getInt("productID"));
                feedback.setVariantID(rs.getInt("variantID"));
                feedback.setUserID(rs.getInt("userID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setFeedbackDate(rs.getTimestamp("feedbackDate"));
                User u = new User();
                feedback.setUser(u);
                feedback.getUser().setFullName(rs.getString("fullName"));
                feedback.getUser().setImage_user(rs.getString("image_user"));
                
                List<String> images = getFeedbackImages(feedback.getFeedbackID());
                feedback.setImages(images);
                
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public int getTotalFeedbacksByRating(int variantID, int rating) {
        String sql = "SELECT COUNT(*) as total FROM tbFeedback WHERE variantID = ? "
                + (rating > 0 ? "AND rating = ? " : "");
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, variantID);
            if (rating > 0) {
                ps.setInt(2, rating);
            }
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
        // Lấy tất cả feedback kèm thông tin sản phẩm và user
    public List<Feedback> getAllFeedbacksWithProductAndUser() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, p.productName, u.fullName, u.image_user "
                + "FROM tbFeedback f "
                + "INNER JOIN tbProduct p ON f.productID = p.productID "
                + "INNER JOIN tbUsers u ON f.userID = u.userID "
                + "ORDER BY f.feedbackDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackID(rs.getInt("feedbackID"));
                feedback.setProductID(rs.getInt("productID"));
                feedback.setVariantID(rs.getInt("variantID"));
                feedback.setUserID(rs.getInt("userID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setFeedbackDate(rs.getTimestamp("feedbackDate"));
                // Set user
                Models.User u = new Models.User();
                u.setFullName(rs.getString("fullName"));
                u.setImage_user(rs.getString("image_user"));
                feedback.setUser(u);
                // Set product
                Models.Product p = new Models.Product();
                p.setProductName(rs.getString("productName"));
                feedback.setProduct(p);
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
        // Lấy chi tiết feedback theo ID (kèm user, product, images)
    public Feedback getFeedbackDetailById(int feedbackID) {
        String sql = "SELECT f.*,u.email, p.productName, u.fullName, u.image_user, i.imageURL "
                + "FROM tbFeedback f "
                + "INNER JOIN tbProduct p ON f.productID = p.productID "
                + "INNER JOIN tbUsers u ON f.userID = u.userID "
                + "LEFT JOIN tbImages i ON f.feedbackID = i.feedbackID "
                + "WHERE f.feedbackID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            Feedback feedback = null;
            List<String> images = new ArrayList<>();
            while (rs.next()) {
                if (feedback == null) {
                    feedback = new Feedback();
                    feedback.setFeedbackID(rs.getInt("feedbackID"));
                    feedback.setProductID(rs.getInt("productID"));
                    feedback.setVariantID(rs.getInt("variantID"));
                    feedback.setUserID(rs.getInt("userID"));
                    feedback.setRating(rs.getInt("rating"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setFeedbackDate(rs.getTimestamp("feedbackDate"));
                    // Set user
                    Models.User u = new Models.User();
                    u.setFullName(rs.getString("fullName"));
                    u.setImage_user(rs.getString("image_user"));
                    u.setEmail(rs.getString("email"));
                    feedback.setUser(u);
                    // Set product
                    Models.Product p = new Models.Product();
                    p.setProductName(rs.getString("productName"));
                    feedback.setProduct(p);
                }
                String imgUrl = rs.getString("imageURL");
                if (imgUrl != null && !imgUrl.isEmpty()) {
                    images.add(imgUrl);
                }
            }
            if (feedback != null) {
                feedback.setImages(images);
            }
            return feedback;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
