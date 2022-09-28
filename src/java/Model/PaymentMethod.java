/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class PaymentMethod {
    int payment_id;
    User user;
    PaymentAccount paymentAccount;
    String name;

    public PaymentMethod() {
    }

    public PaymentMethod(int payment_id, User user, PaymentAccount paymentAccount, String name) {
        this.payment_id = payment_id;
        this.user = user;
        this.paymentAccount = paymentAccount;
        this.name = name;
    }

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public PaymentAccount getPaymentAccount() {
        return paymentAccount;
    }

    public void setPaymentAccount(PaymentAccount paymentAccount) {
        this.paymentAccount = paymentAccount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
