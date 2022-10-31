/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.payment;

import Model.auth.User;
import Model.product.Product;
import java.sql.Timestamp;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class Transaction {

    long transactionId;
    float amount;
    User user;
    float balanceAfter;
//    PaymentMethod payment;
    int type;
    Product product;
    //1. Recharge
    //2. Withdraw
    //3. Buy
    //4. Sell
    int status;
    //1. Fail
    //2. Pending
    //3. Successful
    Timestamp transactionTime;
    String description;

    public Transaction() {
    }

    public Transaction(long transactionId, User user, float balanceAfter, float amount, int type, int status, Timestamp transactionTime, String description) {
        this.transactionId = transactionId;
        this.user = user;
        this.balanceAfter = balanceAfter;
        this.amount = amount;
//        this.payment = payment;
        this.type = type;
        this.status = status;
        this.transactionTime = transactionTime;
        this.description = description;
    }

    public long getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(long transactionId) {
        this.transactionId = transactionId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public float getBalanceAfter() {
        return balanceAfter;
    }

    public void setBalanceAfter(float balanceAfter) {
        this.balanceAfter = balanceAfter;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

//    public PaymentMethod getPayment() {
//        return payment;
//    }
//
//    public void setPayment(PaymentMethod payment) {
//        this.payment = payment;
//    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
    }

    //0. Fail
    //1. Pending
    //2. Successful
    public String getSta() {
        String ret = "Fail";
        switch (this.status) {
            case 1:
                ret = "Pending";
                break;
            case 2:
                ret = "Successful";
                break;
            default:
                throw new AssertionError();
        }
        return ret;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getTransactionTime() {
        return transactionTime;
    }

    public void setTransactionTime(Timestamp transactionTime) {
        this.transactionTime = transactionTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return user.getId() + "\t" + amount;
    }

    
    /**
     * Compare if 2 transaction id is equal
     *
     */
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Transaction) {
            return this.transactionId == ((Transaction) obj).getTransactionId();
        }
        return false;
    }

}
