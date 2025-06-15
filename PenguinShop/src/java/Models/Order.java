/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.List;

public class Order {

    private int orderID;
    private String orderDate;
    private double total;
    private User user;
    private int orderStatus;
    private String shippingAddress;
    private PaymentMethod paymentMethod;
    private boolean paymentStatus;
    private String emall_receiver;
    private String phone_receiver;
    private String name_receiver;
    private double shipFee;
    private List<OrderDetail> orderDetails;

    public Order() {
    }

    public Order(int orderID, String orderDate, double total, User user, int orderStatus, String shippingAddress, PaymentMethod paymentMethod, boolean paymentStatus, List<OrderDetail> orderDetails) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.user = user;
        this.orderStatus = orderStatus;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.orderDetails = orderDetails;
    }

    public Order(int orderID, String orderDate, double total, User user, int orderStatus) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.user = user;
        this.orderStatus = orderStatus;
    }

    public Order(int orderID, String orderDate, double total, User user, int orderStatus, String shippingAddress, PaymentMethod paymentMethod, boolean paymentStatus) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.user = user;
        this.orderStatus = orderStatus;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public double getShipFee() {
        return shipFee;
    }

    public void setShipFee(double shipFee) {
        this.shipFee = shipFee;
    }

    public String getEmall_receiver() {
        return emall_receiver;
    }

    public void setEmall_receiver(String emall_receiver) {
        this.emall_receiver = emall_receiver;
    }

    public String getPhone_receiver() {
        return phone_receiver;
    }

    public void setPhone_receiver(String phone_receiver) {
        this.phone_receiver = phone_receiver;
    }

    public String getName_receiver() {
        return name_receiver;
    }

    public void setName_receiver(String name_receiver) {
        this.name_receiver = name_receiver;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public boolean isPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getStringOrderStatus() {
        switch (orderStatus) {
            case 0:
                return "Đã hủy";
            case 2:
                return "Đang giao";
            case 1:
                return "Đã giao thành công";
            case 3:
                return "Hoàn Hàng";
            default:
                return "Lỗi";
        }
    }

}
