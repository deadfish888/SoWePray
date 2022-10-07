/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.payment;

import Model.payment.PaymentAccount;
import Model.auth.User;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class PaymentMethod {
    private int paymentId;
    private User user;
    private PaymentAccount paymentAccount;
    private String name;
    private boolean active;

    public PaymentMethod() {
    }

    public PaymentMethod(int paymentId, User user, PaymentAccount paymentAccount, String name, boolean active) {
        this.paymentId = paymentId;
        this.user = user;
        this.paymentAccount = paymentAccount;
        this.name = name;
        this.active = active;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
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

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof PaymentMethod) {
            PaymentMethod paymentMethod = (PaymentMethod) obj;
            return (paymentMethod.getPaymentId() == paymentId) 
                    || (paymentMethod.getPaymentAccount().equals(paymentAccount) 
                    && paymentMethod.getUser().equals(user));
        }
        return false;
    }
    
    

}
