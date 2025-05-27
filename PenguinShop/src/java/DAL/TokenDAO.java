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

public class TokenDAO extends DBContext{

    

    public boolean saveToken(int userID, String token , String create_date) {
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
    
    public boolean saveToken(){
        return false;
    }
    
}
