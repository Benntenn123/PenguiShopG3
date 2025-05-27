/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Brand;
import Models.Color;
import Models.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class MeterialDAO extends DBContext{
    public List<Size> getAllSize() {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.tbSize";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size s = new Size(rs.getInt(1),
                        rs.getString(2));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Color> getAllColor() {
        List<Color> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.tbColor";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Color c = new Color(rs.getInt(1),
                        rs.getString(2));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
