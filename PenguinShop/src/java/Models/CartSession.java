package Models;

public class CartSession {
    private int cartID;
    private int quantity;
    private double totalAmount;

    public CartSession(int cartID, int quantity, double totalAmount) {
        this.cartID = cartID;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
    }

    // Getters và Setters
    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
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