/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.Request;
import Utils.GetDateTime;
import java.sql.PreparedStatement;

public class RequestDAO extends DBContext {

    public boolean addRequestSupport(String[] data) {
        String sql = "INSERT INTO dbo.tbRequests\n"
                + "(email_request, phone_request, name_request, requestType, description, requestStatus, requestDate)\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, data[0]);
            ps.setString(2, data[1]);
            ps.setString(3, data[2]);
            ps.setString(4, data[3]);
            ps.setString(5, data[4]);
            ps.setInt(6, Request.CHUA_PHAN_HOI);
            ps.setString(7, GetDateTime.getCurrentTime());
            int result = ps.executeUpdate();
            if(result >0){
                return true;
            }
        } catch (Exception e) {
        }

        return false;
    }
}
