/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TokenDAO extends DBContext {

    public boolean saveToken(int userID, String token, String create_date) {
        String sql = "INSERT INTO dbo.TokenUser\n"
                + "( userID,token, create_date_token)\n"
                + "VALUES(?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, token);
            ps.setString(3, create_date);
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String[] getTokenNewest(int userID) {
        String sql = "SELECT TOP 1 * FROM dbo.TokenUser WHERE userID = ?";
        String token = "";
        String created_date = "";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                token = rs.getString("token");
                created_date = rs.getString("create_date_token");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new String[]{token, created_date};
    }

    public boolean saveToken(int userID, String otpCode, String createdAt, int isUsed) {
        String sql = "INSERT INTO dbo.OTPCode\n"
                + "( userID, otpCode, createdAt,isUsed)\n"
                + "VALUES\n"
                + "(? , ? , ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, otpCode);
            ps.setString(3, createdAt);
            ps.setInt(4, isUsed);
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String[] loadNewestToken(int userID) {
        String sql = "SELECT TOP 1 otpCode, createdAt, isUsed\n"
                + "FROM OTPCode\n"
                + "WHERE userID = ?\n"
                + "ORDER BY createdAt DESC;";
        String otp = "";
        String createdAt = "";
        String isUsed = "";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                otp = rs.getString(1);
                createdAt = rs.getString(2);
                isUsed = String.valueOf(rs.getInt(3));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new String[] {otp, createdAt,isUsed};
    }

    public boolean markOTPAsUsed(int userID, String storedOtp) {
        String sql = "UPDATE dbo.OTPCode SET isUsed = 1 WHERE userID = ? AND otpCode = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, storedOtp);
            int result = ps.executeUpdate();
            if(result >0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
