/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Const.Request;
import Models.CustomerRequest;
import Utils.GetDateTime;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
            if (result > 0) {
                return true;
            }
        } catch (Exception e) {
        }

        return false;
    }

    public List<CustomerRequest> getCustomerRequests(String email, String requestType, String phone, String status, String startDate, String endDate, int page, int pageSize) throws SQLException {
        List<CustomerRequest> requestList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT requestID, requestDate, email_request, phone_request, requestType, requestStatus "
                + "FROM tbRequests WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search conditions
        if (email != null && !email.isEmpty()) {
            sql.append(" AND email_request LIKE ?");
            params.add("%" + email + "%");
        }
        if (phone != null && !phone.isEmpty()) {
            sql.append(" AND phone_request LIKE ?");
            params.add("%" + phone + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND requestStatus = ?");
            params.add(status);
        }
        if (requestType != null && !requestType.isEmpty()) {
            sql.append(" AND requestType = ?");
            params.add(requestType);
        }
        if (startDate != null && !startDate.isEmpty()) {
            sql.append(" AND requestDate >= ?");
            params.add(startDate);
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append(" AND requestDate <= ?");
            params.add(endDate);
        }

        // Add pagination
        sql.append(" ORDER BY requestDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerRequest request = new CustomerRequest();
                    request.setRequestID(rs.getInt("requestID"));
                    request.setRequestDate(rs.getString("requestDate"));
                    request.setEmail_request(rs.getString("email_request"));
                    request.setPhone_request(rs.getString("phone_request"));
                    request.setRequestType(rs.getString("requestType"));
                    request.setRequestStatus(rs.getInt("requestStatus"));
                    requestList.add(request);
                }
            }
        }
        return requestList;
    }

    public int getTotalRequests(String email, String phone, String status, String startDate, String endDate) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbRequests WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search conditions
        if (email != null && !email.isEmpty()) {
            sql.append(" AND email_request LIKE ?");
            params.add("%" + email + "%");
        }
        if (phone != null && !phone.isEmpty()) {
            sql.append(" AND phone_request LIKE ?");
            params.add("%" + phone + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND requestStatus = ?");
            params.add(status);
        }
        if (startDate != null && !startDate.isEmpty()) {
            sql.append(" AND requestDate >= ?");
            params.add(startDate);
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append(" AND requestDate <= ?");
            params.add(endDate);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int getPendingRequests() throws SQLException {
        String sql = "SELECT COUNT(*) FROM tbRequests WHERE requestStatus = 0";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getProcessedRequests() throws SQLException {
        String sql = "SELECT COUNT(*) FROM tbRequests WHERE requestStatus = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public CustomerRequest getCustomerRequestById(int requestID) throws SQLException {
        CustomerRequest request = null;
        String sql = "SELECT requestID, requestDate, email_request, name_request, "
                + "phone_request, requestType, requestStatus,requestDate, response,responseDate,description "
                + "FROM dbo.tbRequests WHERE requestID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, requestID);
            System.out.println(sql);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    request = new CustomerRequest();
                    request.setRequestID(rs.getInt("requestID"));
                    request.setRequestDate(rs.getString("requestDate"));
                    request.setEmail_request(rs.getString("email_request"));
                    request.setPhone_request(rs.getString("phone_request"));
                    request.setRequestType(rs.getString("requestType"));
                    request.setRequestStatus(rs.getInt("requestStatus"));
                    request.setDescription(rs.getString("description"));
                    request.setName_request(rs.getString("name_request"));
                    request.setResponse(rs.getString("response"));
                    request.setResponseDate(rs.getString("responseDate"));
                }
            }
        }
        return request;
    }

    public boolean updateRequest(String htmlContent, int requestID) {
        String sql = "UPDATE dbo.tbRequests SET requestStatus = ?, response = ?, responseDate = ?\n"
                + "WHERE requestID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) { 
            ps.setInt(1, Request.DA_PHAN_HOI);
            ps.setString(2, htmlContent);
            ps.setString(3, GetDateTime.getCurrentTime());
            ps.setInt(4, requestID);
            int result = ps.executeUpdate();
            if(result >0){
                return true;
            }
        } catch (Exception e) {

        }
        return false;
    }

    public static void main(String[] args) {
        RequestDAO rdao = new RequestDAO();
        try {

            System.out.println(rdao.getCustomerRequestById(1).getDescription());

        } catch (Exception e) {
        }
    }
}
