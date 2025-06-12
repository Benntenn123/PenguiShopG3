/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.Account;
import Models.DeliveryInfo;
import Models.GoogleAccount;
import Models.Logs;
import Models.Order;
import Models.Role;
import Utils.HashPassword;
import Models.User;
import Utils.GetDateTime;
import Utils.StringConvert;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public boolean authenticateUser(String email, String password) {
        String sql = "SELECT * FROM tbUsers WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User loadUserInfoByEmail(String email) {
        String sql = "SELECT u.userID,u.fullName,u.roleID,d.addressDetail AS address, u.birthday,u.phone, u.email, u.image_user,u.created_at,u.status_account FROM tbUsers u \n"
                + "LEFT JOIN dbo.tbDeliveryInfo d ON d.userID = u.userID\n"
                + "WHERE u.email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            System.out.println(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setRoleID(rs.getInt("roleID"));
                user.setAddress(rs.getString("address"));
                user.setBirthday(rs.getDate("birthday"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setImage_user(rs.getString("image_user"));
                user.setStatus_account(rs.getInt("status_account"));   
                user.setCreated_at(rs.getString("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkCorrectPassword(int userID, String password) {
        String sql = "SELECT count(*) FROM tbUsers WHERE userID = ? and password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int result = rs.getInt(1);
                if (result > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updatePassword(int userID, String newPassword) {
        String sql = "UPDATE tbUsers SET password = ? WHERE userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserProfile(User user) {

        String sql = "UPDATE tbUsers SET fullName = ?, birthday = ?, phone = ?, email = ?, image_user = ? WHERE userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullName());

            ps.setDate(2, new java.sql.Date(user.getBirthday().getTime()));
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getImage_user());
            ps.setInt(6, user.getUserID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkExistPhoneUser(String phone) {
        String sql = "Select count(*) from tbUsers where phone = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int row = rs.getInt(1);
                if (row > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkExistEmail(String email) {
        String sql = "Select count(*) from tbUsers where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int row = rs.getInt(1);
                if (row > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int addUser(String[] info) {
        String insertSql = "INSERT INTO dbo.tbUsers(fullName, password, roleID, phone, email, image_user, status_account) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String selectSql = "SELECT userID FROM dbo.tbUsers WHERE email = ?";

        int userId = -1;

        try {
            connection.setAutoCommit(false);

            PreparedStatement insertPs = connection.prepareStatement(insertSql);
            String fullName = info[0] + " " + info[1];

            insertPs.setString(1, fullName);
            insertPs.setString(2, info[4]);
            insertPs.setInt(3, Account.ROLE_CUSTOMER);
            insertPs.setString(4, info[3]);
            insertPs.setString(5, info[2]); // email
            insertPs.setString(6, info[5]);
            insertPs.setInt(7, Account.INACTIVE_ACCOUNT);

            int result = insertPs.executeUpdate();

            if (result > 0) {
                PreparedStatement selectPs = connection.prepareStatement(selectSql);
                selectPs.setString(1, info[2]); // email

                ResultSet rs = selectPs.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt("userID");
                }

                rs.close();
                selectPs.close();
            }

            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userId;
    }

    public boolean updateStatusAccount(int userID, int status) {
        String sql = "UPDATE dbo.tbUsers SET status_account = ? WHERE userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, userID);
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getEmailAndPhone(String email_raw) {
        String sql = "SELECT userID ,email,phone,fullName FROM dbo.tbUsers\n"
                + "WHERE email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email_raw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt(1),
                        rs.getString(4),
                        rs.getString(3),
                        rs.getString(2));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public List<Logs> getLogsByTimeRange(int userID, String from, String to, int page, int pageSize) {
        List<Logs> logs = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT logID, userID, action, description, logDate FROM tbLogs WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();

        sql.append(" AND userID = ?");
        params.add(userID);

        if (from != null && !from.isEmpty()) {
            sql.append(" AND logDate >= CAST(? AS DATE)");
            params.add(from);
        }

        if (to != null && !to.isEmpty()) {
            sql.append(" AND logDate < DATEADD(DAY, 1, CAST(? AS DATE))");
            params.add(to);
        }

        sql.append(" ORDER BY logDate DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        int offset = (page - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Logs log = new Logs(
                            rs.getInt(1),
                            new User(rs.getInt(2)),
                            rs.getString(3),
                            rs.getString(5) // rs.getString(5) sửa lại thành 4 cho đúng column
                    );
                    logs.add(log);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return logs;
    }

    public int countLogsByTimeRange(int userID, String from, String to) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbLogs WHERE 1=1");
        List<Object> params = new ArrayList<>();

        sql.append(" AND userID = ?");
        params.add(userID);

        if (from != null && !from.isEmpty()) {
            sql.append(" AND logDate >= CAST(? AS DATE)");
            params.add(from);
        }

        if (to != null && !to.isEmpty()) {
            sql.append(" AND logDate < DATEADD(DAY, 1, CAST(? AS DATE))");
            params.add(to);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean CheckExistGGAccount(GoogleAccount gg) {
        String sql = "Select count(*) from tbUsers where email = ? and google_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, gg.getEmail());
            st.setString(2, gg.getId());

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int arrow = rs.getInt(1);
                if (arrow > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isertAccountGoogle(GoogleAccount gg) {
        String sql = "INSERT INTO dbo.tbUsers\n"
                + "(fullName,password,roleID,email,image_user,status_account,google_id,created_at)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?, ?, ?, ?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, gg.getName());
            ps.setString(2, HashPassword.hashWithSHA256(StringConvert.generateRandomString()));
            ps.setInt(3, Account.ROLE_CUSTOMER);
            ps.setString(4, gg.getEmail());
            ps.setString(5, Account.AVATAR_DEFAULT_USER);
            ps.setInt(6, Account.ACTIVE_ACCOUNT);
            ps.setString(7, gg.getId());
            ps.setString(8, GetDateTime.getCurrentTime());
            System.out.println(sql);
            int row = ps.executeUpdate();
            if (row > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getAllUser(int page, int pageSize, String fullName, String email, String phone, int roleID) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT u.userID, u.fullName, u.birthday, u.phone, u.email, u.image_user, r.roleName "
                + "FROM dbo.tbUsers u "
                + "INNER JOIN dbo.tbRoles r ON u.roleID = r.roleID "
                + "WHERE u.roleID = ?"
        );

        // Add search conditions dynamically
        List<String> searchParams = new ArrayList<>();
        if (fullName != null && !fullName.trim().isEmpty()) {
            sql.append(" AND u.fullName LIKE ?");
            searchParams.add("%" + fullName.trim() + "%");
        }
        if (email != null && !email.trim().isEmpty()) {
            sql.append(" AND u.email LIKE ?");
            searchParams.add("%" + email.trim() + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND u.phone LIKE ?");
            searchParams.add("%" + phone.trim() + "%");
        }

        // Add pagination
        sql.append(" ORDER BY u.userID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            // Set roleID parameter
            ps.setInt(paramIndex++, roleID);

            // Set search parameters
            for (String param : searchParams) {
                ps.setString(paramIndex++, param);
            }

            // Set pagination parameters
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);
            System.out.println("Load User"+sql);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User(
                            rs.getInt("userID"),
                            rs.getString("fullName"),
                            rs.getDate("birthday"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("image_user"),
                            new Role(0, rs.getString("roleName"))
                    );
                    list.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public int getTotalUserRecords(int roleID, String fullName, String email, String phone) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total " +
                "FROM dbo.tbUsers u " +
                "INNER JOIN dbo.tbRoles r ON u.roleID = r.roleID " +
                "WHERE u.roleID = ?"
        );

        List<String> searchParams = new ArrayList<>();
        if (fullName != null && !fullName.trim().isEmpty()) {
            sql.append(" AND u.fullName LIKE ?");
            searchParams.add("%" + fullName.trim() + "%");
        }
        if (email != null && !email.trim().isEmpty()) {
            sql.append(" AND u.email LIKE ?");
            searchParams.add("%" + email.trim() + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND u.phone LIKE ?");
            searchParams.add("%" + phone.trim() + "%");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, roleID);

            for (String param : searchParams) {
                ps.setString(paramIndex++, param);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public User getUserById(int userID) {
        String sql = "SELECT u.userID, u.fullName, u.birthday, u.phone, u.email,"+
                     " u.image_user, r.roleName ,u.status_account, u.created_at " +
                     "FROM dbo.tbUsers u " +
                     "INNER JOIN dbo.tbRoles r ON u.roleID = r.roleID " +
                     "WHERE u.userID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            System.out.println(sql);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("userID"),
                        rs.getString("fullName"),
                        rs.getDate("birthday"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("image_user"),
                        new Role(0, rs.getString("roleName")),
                        rs.getInt("status_account"),
                        rs.getString("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public List<Logs> getLatestLogByUserId(int userID) {
        String sql = "SELECT TOP 5 logID, userID, action, logDate " +
                     "FROM dbo.tbLogs " +
                     "WHERE userID = ? " +
                     "ORDER BY logDate DESC";
        List<Logs> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Logs l = new Logs(
                        rs.getInt("logID"),
                        new User(rs.getInt("userID")),
                        rs.getString("action"),
                        rs.getString("logDate")
                    );
                    list.add(l);
                }
                return list;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Order> getRecentOrdersByUserId(int userID) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT TOP 5 orderID, orderDate, total, orderStatus, userID " +
                     "FROM dbo.tbOrder " +
                     "WHERE userID = ? " +
                     "ORDER BY orderDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User(rs.getInt("userID"));
                    Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getString("orderDate"), // Chuyển DATETIME thành String
                        rs.getDouble("total"),
                        user,
                        rs.getInt("orderStatus")
                    );
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<DeliveryInfo> getDeliveryAddressesByUserId(int userID) {
        List<DeliveryInfo> list = new ArrayList<>();
        String sql = "SELECT deliveryInfoID, userID, addressDetail, city, fullName, phone, isDefault " +
                     "FROM dbo.tbDeliveryInfo " +
                     "WHERE userID = ? " +
                     "ORDER BY isDefault DESC, deliveryInfoID ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DeliveryInfo address = new DeliveryInfo(
                        rs.getInt("deliveryInfoID"),
                        new User(rs.getInt("userID")),
                        rs.getString("fullName"),
                        rs.getString("phone"),
                        rs.getString("addressDetail"),
                        rs.getString("city"),
                        rs.getInt("isDefault")
                    );
                    list.add(address);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        System.out.println(udao.getDeliveryAddressesByUserId(1).size());
    }

}
