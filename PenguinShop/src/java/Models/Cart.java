/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class Cart {

    private int cartID;
    private User user;
    private ProductVariant variant;
    private int quantity;
    private Product product;

    public Cart(int cartID, ProductVariant variant) {
        this.cartID = cartID;
        this.variant = variant;
    }

    public Cart() {
    }

    public Cart(int cartID, User user, ProductVariant variant, int quantity, Product product) {
        this.cartID = cartID;
        this.user = user;
        this.variant = variant;
        this.quantity = quantity;
        this.product = product;
    }

    public Cart(int cartID) {
        this.cartID = cartID;
    }

    public Cart(int cartID, ProductVariant variant, int quantity, Product product) {
        this.cartID = cartID;
        this.variant = variant;
        this.quantity = quantity;
        this.product = product;
    }

    public Cart(User user, ProductVariant variant, int quantity, Product product) {
        this.user = user;
        this.variant = variant;
        this.quantity = quantity;
        this.product = product;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

}
