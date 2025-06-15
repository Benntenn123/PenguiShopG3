/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class OrderDetail {
    private int detailID, quantity_product;
    private double price;
    private Order order;
    private ProductVariant variant;

    public OrderDetail(int detailID, int quantity, double price, Order order, ProductVariant variant) {
        this.detailID = detailID;
        this.quantity_product = quantity;
        this.price = price;
        this.order = order;
        this.variant = variant;
    }

    public OrderDetail() {
    }

    public OrderDetail(int detailID, double aDouble, int aInt, ProductVariant variant) {
        this.detailID = detailID;
        this.price = aDouble;
        this.quantity_product = aInt;
        this.variant = variant;
        
    }

    public int getDetailID() {
        return detailID;
    }

    public void setDetailID(int detailID) {
        this.detailID = detailID;
    }

    public int getQuantity_product() {
        return quantity_product;
    }

    public void setQuantity_product(int quantity_product) {
        this.quantity_product = quantity_product;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }
    
          
}
