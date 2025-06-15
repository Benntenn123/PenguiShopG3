/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class CustomerRequest {
    private int requestID;
    private String email_request;
    private String phone_request;
    private String name_request;
    private String requestType;
    private String description;
    private int requestStatus;
    private String requestDate;
    private String response;
    private String responseDate;

    public CustomerRequest() {
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public String getEmail_request() {
        return email_request;
    }

    public void setEmail_request(String email_request) {
        this.email_request = email_request;
    }

    public String getPhone_request() {
        return phone_request;
    }

    public void setPhone_request(String phone_request) {
        this.phone_request = phone_request;
    }

    public String getName_request() {
        return name_request;
    }

    public void setName_request(String name_request) {
        this.name_request = name_request;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(int requestStatus) {
        this.requestStatus = requestStatus;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public String getResponseDate() {
        return responseDate;
    }

    public void setResponseDate(String responseDate) {
        this.responseDate = responseDate;
    }
    
}
