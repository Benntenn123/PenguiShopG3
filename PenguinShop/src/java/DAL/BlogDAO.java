package DAL;

import Models.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    // Lấy tất cả blog (super admin thấy hết, user thường chỉ thấy blog của mình)
    public List<Blog> getAllBlogs(int roleId, int authorId) {
        List<Blog> list = new ArrayList<>();
        String sql = (roleId == 1)
                ? "SELECT * FROM tbBlog ORDER BY created_at DESC"
                : "SELECT * FROM tbBlog WHERE authorID = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (roleId != 1) {
                ps.setInt(1, authorId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy blog phân trang, có filter search (title, status, date)
    public List<Blog> getBlogsByPage(int page, int pageSize, int roleId, int authorId, String title, Integer status, java.util.Date fromDate, java.util.Date toDate) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tbBlog WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (roleId != 1) {
            sql.append(" AND authorID = ?");
            params.add(authorId);
        }
        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        if (fromDate != null) {
            sql.append(" AND created_at >= ?");
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        }
        if (toDate != null) {
            sql.append(" AND created_at <= ?");
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }
        sql.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy tổng số blog, có filter search (title, status, date)
    public int getTotalBlogCount(int roleId, int authorId, String title, Integer status, java.util.Date fromDate, java.util.Date toDate) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbBlog WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (roleId != 1) {
            sql.append(" AND authorID = ?");
            params.add(authorId);
        }
        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        if (fromDate != null) {
            sql.append(" AND created_at >= ?");
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        }
        if (toDate != null) {
            sql.append(" AND created_at <= ?");
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    // Lấy chi tiết blog theo ID
    public Blog getBlogById(int blogID) {
        String sql = "SELECT * FROM tbBlog WHERE blogID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToBlog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm blog mới
    public boolean insertBlog(Blog blog) {
        String sql = "INSERT INTO tbBlog (title, content, image, created_at, updated_at, authorID, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImage());
            ps.setTimestamp(4, new java.sql.Timestamp(blog.getCreated_at().getTime()));
            ps.setTimestamp(5, blog.getUpdated_at() != null ? new java.sql.Timestamp(blog.getUpdated_at().getTime()) : null);
            ps.setInt(6, blog.getAuthorID());
            ps.setInt(7, blog.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Sửa blog
    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE tbBlog SET title=?, content=?, image=?, updated_at=?, authorID=?, status=? WHERE blogID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImage());
            ps.setTimestamp(4, blog.getUpdated_at() != null ? new java.sql.Timestamp(blog.getUpdated_at().getTime()) : null);
            ps.setInt(5, blog.getAuthorID());
            ps.setInt(6, blog.getStatus());
            ps.setInt(7, blog.getBlogID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật trạng thái blog
    public boolean updateBlogStatus(int blogID, int status) {
        String sql = "UPDATE tbBlog SET status=? WHERE blogID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, blogID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa blog
    public boolean deleteBlog(int blogID) {
        String sql = "DELETE FROM tbBlog WHERE blogID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thống kê cơ bản (super admin thấy hết, user thường chỉ thấy blog của mình)
    public int countBlogByStatus(int status, int roleId, int authorId) {
        String sql = (roleId == 1)
                ? "SELECT COUNT(*) FROM tbBlog WHERE status=?"
                : "SELECT COUNT(*) FROM tbBlog WHERE status=? AND authorID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, status);
            if (roleId != 1) {
                ps.setInt(2, authorId);
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

    // Map ResultSet sang Blog
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setBlogID(rs.getInt("blogID"));
        blog.setTitle(rs.getString("title"));
        blog.setContent(rs.getString("content"));
        blog.setImage(rs.getString("image"));
        blog.setCreated_at(rs.getTimestamp("created_at"));
        blog.setUpdated_at(rs.getTimestamp("updated_at"));
        blog.setAuthorID(rs.getInt("authorID"));
        blog.setStatus(rs.getInt("status"));
        return blog;
    }

    // Search blogs with filters (for all users or super admin)
    public List<Blog> searchBlogs(String title, String status, String date, int offset, int limit) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tbBlog WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Integer.parseInt(status));
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) = ?");
            params.add(date);
        }

        sql.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Search blogs by author with filters
    public List<Blog> searchBlogsByAuthor(int authorID, String title, String status, String date, int offset, int limit) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tbBlog WHERE authorID = ?");
        List<Object> params = new ArrayList<>();
        params.add(authorID);

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Integer.parseInt(status));
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) = ?");
            params.add(date);
        }

        sql.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get total blogs count with filters (for all users or super admin)
    public int getTotalBlogsCount(String title, String status, String date) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbBlog WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Integer.parseInt(status));
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) = ?");
            params.add(date);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    // Get total blogs count by author with filters
    public int getTotalBlogsByAuthorCount(int authorID, String title, String status, String date) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbBlog WHERE authorID = ?");
        List<Object> params = new ArrayList<>();
        params.add(authorID);

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Integer.parseInt(status));
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) = ?");
            params.add(date);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    // Get blogs with author info for homepage
    public List<Blog> getBlogsWithAuthor(String title, String date, int offset, int limit) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.*, u.fullName as authorName, u.image_user as authorImage "
                + "FROM tbBlog b INNER JOIN tbUsers u ON b.authorID = u.userID "
                + "WHERE b.status = 1"
        );
        List<Object> params = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND b.title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(b.created_at AS DATE) = ?");
            params.add(date);
        }

        sql.append(" ORDER BY b.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blog.setAuthorName(rs.getString("authorName"));
                blog.setAuthorImage(rs.getString("authorImage"));
                list.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get recent blogs (for sidebar)
    public List<Blog> getRecentBlogs(int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) b.*, u.fullName as authorName, u.image_user as authorImage "
                + "FROM tbBlog b INNER JOIN tbUsers u ON b.authorID = u.userID "
                + "WHERE b.status = 1 ORDER BY b.created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blog.setAuthorName(rs.getString("authorName"));
                blog.setAuthorImage(rs.getString("authorImage"));
                list.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Count blogs with filters (for homepage pagination)
    public int countBlogsWithFilters(String title, String date) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbBlog WHERE status = 1");
        List<Object> params = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title.trim() + "%");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND CAST(created_at AS DATE) = ?");
            params.add(date);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    // Get related blogs based on title similarity
    public List<Blog> getRelatedBlogs(int currentBlogId, String currentTitle, int limit) {
        List<Blog> list = new ArrayList<>();

        // Step 1: Try to find blogs with similar title keywords
        String[] keywords = currentTitle.toLowerCase().split("\\s+");

        if (keywords.length > 0) {
            StringBuilder sql = new StringBuilder(
                    "SELECT TOP (?) b.*, u.fullName as authorName, u.image_user as authorImage "
                    + "FROM tbBlog b INNER JOIN tbUsers u ON b.authorID = u.userID "
                    + "WHERE b.status = 1 AND b.blogID != ? AND ("
            );

            // Build OR conditions for each keyword
            for (int i = 0; i < keywords.length; i++) {
                if (i > 0) {
                    sql.append(" OR ");
                }
                sql.append("LOWER(b.title) LIKE ?");
            }
            sql.append(") ORDER BY b.created_at DESC");

            try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
                ps.setInt(1, limit * 2); // Get more to have options
                ps.setInt(2, currentBlogId);

                // Set keyword parameters
                for (int i = 0; i < keywords.length; i++) {
                    ps.setString(3 + i, "%" + keywords[i] + "%");
                }

                ResultSet rs = ps.executeQuery();
                while (rs.next() && list.size() < limit) {
                    Blog blog = mapResultSetToBlog(rs);
                    blog.setAuthorName(rs.getString("authorName"));
                    blog.setAuthorImage(rs.getString("authorImage"));
                    list.add(blog);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Step 2: If we don't have enough related blogs, fill with recent ones
        if (list.size() < limit) {
            List<Blog> recentBlogs = getRecentBlogsExcluding(currentBlogId, limit);
            for (Blog recentBlog : recentBlogs) {
                // Avoid duplicates
                boolean exists = list.stream().anyMatch(b -> b.getBlogID() == recentBlog.getBlogID());
                if (!exists) {
                    list.add(recentBlog);
                }
                if (list.size() >= limit) {
                    break;
                }
            }
        }

        // Step 3: If still not enough, get ANY published blogs (fallback)
        if (list.size() < limit) {
            List<Blog> allBlogs = getAllPublishedBlogsExcluding(currentBlogId, limit);
            for (Blog blog : allBlogs) {
                // Avoid duplicates
                boolean exists = list.stream().anyMatch(b -> b.getBlogID() == blog.getBlogID());
                if (!exists) {
                    list.add(blog);
                }
                if (list.size() >= limit) {
                    break;
                }
            }
        }

        return list;
    }

    // Helper method to get recent blogs excluding current blog
    private List<Blog> getRecentBlogsExcluding(int excludeId, int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) b.*, u.fullName as authorName, u.image_user as authorImage "
                + "FROM tbBlog b INNER JOIN tbUsers u ON b.authorID = u.userID "
                + "WHERE b.status = 1 AND b.blogID != ? ORDER BY b.created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit * 2); // Get more than needed
            ps.setInt(2, excludeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blog.setAuthorName(rs.getString("authorName"));
                blog.setAuthorImage(rs.getString("authorImage"));
                list.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method to get all published blogs excluding current (final fallback)
    private List<Blog> getAllPublishedBlogsExcluding(int excludeId, int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) b.*, u.fullName as authorName, u.image_user as authorImage "
                + "FROM tbBlog b INNER JOIN tbUsers u ON b.authorID = u.userID "
                + "WHERE b.status = 1 AND b.blogID != ? ORDER BY NEWID()"; // Random order
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit * 3); // Get plenty
            ps.setInt(2, excludeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blog.setAuthorName(rs.getString("authorName"));
                blog.setAuthorImage(rs.getString("authorImage"));
                list.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Blog> getTop3BlogNewest() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM dbo.tbBlog"; // Random order
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
