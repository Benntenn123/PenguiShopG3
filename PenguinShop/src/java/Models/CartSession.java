package Models;

public class CartSession {
    private Cart cart;
    private int quantity;
    private double totalAmount;

    public CartSession(Cart cart, int quantity, double totalAmount) {
        this.cart = cart;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
    }

    // Getters và Setters

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
    

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}