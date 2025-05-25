/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.Account;
import Utils.HashPassword;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
        String sql = "SELECT * FROM tbUsers WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getInt("roleID"));
                user.setAddress(rs.getString("address"));
                user.setBirthday(rs.getDate("birthday"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setImage_user(rs.getString("image_user"));
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

    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        String[] info = new String[]{"Lương", "Nguyễn", "nguyenluongk2k4@gmail.com", "0936971273", "50f890eed24bfcd3ec4f2de7743fad1f8fadb9fc17665fada25f33a2c90acaee",
            Account.AVATAR_DEFAULT_USER};

        System.out.println(udao.addUser(info));
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
        String sql = "UPDATE tbUsers SET fullName = ?, address = ?, birthday = ?, phone = ?, email = ?, image_user = ? WHERE userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getAddress());
            ps.setDate(3, new java.sql.Date(user.getBirthday().getTime()));
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getImage_user());
            ps.setInt(7, user.getUserID());
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

    public boolean updateStatusAccount(int userID) {
        String sql = "UPDATE dbo.tbUsers SET status_account = ? WHERE userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, Account.ACTIVE_ACCOUNT);
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
}
