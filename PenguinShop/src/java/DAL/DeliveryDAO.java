/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.DeliveryInfo;
import Models.Size;
import Models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO extends DBContext {

    public List<DeliveryInfo> getAllDeliveryInfo(int userID) {
        List<DeliveryInfo> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.tbDeliveryInfo di \n"
                + "WHERE di.userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DeliveryInfo di = new DeliveryInfo(rs.getInt("deliveryInfoID"),
                        new User(rs.getInt("userID")),
                        rs.getString("fullname"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("addressDetail"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("postalCode"),
                        rs.getInt("isDefault"),
                        rs.getString("created_at"),
                        rs.getString("updated_at"));
                list.add(di);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAllDeliveryInfo(int userID, int deleveryID) {
        List<DeliveryInfo> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.tbDeliveryInfo di \n"
                + "WHERE di.userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DeliveryInfo di = new DeliveryInfo(rs.getInt("deliveryInfoID"),
                        new User(rs.getInt("userID")),
                        rs.getString("fullname"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("addressDetail"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("postalCode"),
                        rs.getInt("isDefault"),
                        rs.getString("created_at"),
                        rs.getString("updated_at"));
                list.add(di);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean insertDeliveryInfo(DeliveryInfo di) {
        List<DeliveryInfo> list = new ArrayList<>();
        String sql = "INSERT INTO dbo.tbDeliveryInfo\n"
                + "( userID, fullName, phone, email, addressDetail, city, created_at, updated_at)\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?,?)   ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, di.getUser().getUserID());
            ps.setString(2, di.getFullName());
            ps.setString(3, di.getPhone());
            ps.setString(4, di.getEmail());
            ps.setString(5, di.getAddessDetail());
            ps.setString(6, di.getCity());
            ps.setString(7, di.getCreated_at());
            ps.setString(8, di.getUpdated_at());
            int row = ps.executeUpdate();
            if(row >0){
                return true;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
