/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model;

import java.sql.Timestamp;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class Transaction {
    long transactionId;
    User user;
    int balanceAfter, amount;
    PaymentMethod payment;
    int type; 
        //1. Recharge
        //2. Withdraw
        //3. Buy
        //4. Sell
    int status;
        //0. Fail
        //1. Pending
        //2. Successful
    Timestamp transactionTime;
    String description;

    public Transaction() {
    }

    public Transaction(long transactionId, User user, int balanceAfter, int amount, PaymentMethod payment, int type, int status, Timestamp transactionTime, String description) {
        this.transactionId = transactionId;
        this.user = user;
        this.balanceAfter = balanceAfter;
        this.amount = amount;
        this.payment = payment;
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

    public int getBalanceAfter() {
        return balanceAfter;
    }

    public void setBalanceAfter(int balanceAfter) {
        this.balanceAfter = balanceAfter;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public PaymentMethod getPayment() {
        return payment;
    }

    public void setPayment(PaymentMethod payment) {
        this.payment = payment;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
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

}
