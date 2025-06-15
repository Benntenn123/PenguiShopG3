/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;


public class PaymentMethod {
    private int paymentMethodID;
    private String paymentMethodName;
    private String description;

    public PaymentMethod() {
    }

    public PaymentMethod(int paymentMethodID, String paymentMethodName, String description) {
        this.paymentMethodID = paymentMethodID;
        this.paymentMethodName = paymentMethodName;
        this.description = description;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }

    public String getPaymentMethodName() {
        return paymentMethodName;
    }

    public void setPaymentMethodName(String paymentMethodName) {
        this.paymentMethodName = paymentMethodName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
