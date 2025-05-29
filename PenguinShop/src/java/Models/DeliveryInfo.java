/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;


public class DeliveryInfo {
    private int deliveryInfoID;
    private User user;
    private String fullName;
    private String phone;
    private String email;
    private String addessDetail;
    private String city;
    private String country;
    private String postalCode;
    private int isDefault;
    private String created_at;
    private String updated_at;

    public DeliveryInfo(int deliveryInfoID, User user, String fullName, String phone, String email, String addessDetail, String city, String country, String postalCode, int isDefault, String created_at, String updated_at) {
        this.deliveryInfoID = deliveryInfoID;
        this.user = user;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.addessDetail = addessDetail;
        this.city = city;
        this.country = country;
        this.postalCode = postalCode;
        this.isDefault = isDefault;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public DeliveryInfo() {
    }

    public int getDeliveryInfoID() {
        return deliveryInfoID;
    }

    public void setDeliveryInfoID(int deliveryInfoID) {
        this.deliveryInfoID = deliveryInfoID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddessDetail() {
        return addessDetail;
    }

    public void setAddessDetail(String addessDetail) {
        this.addessDetail = addessDetail;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public int getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(int isDefault) {
        this.isDefault = isDefault;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }
    
}
