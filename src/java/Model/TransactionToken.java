/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TransactionToken {
    Transaction transaction;
    String token;
    boolean active;
    Timestamp createdTime, expireTime;

    public TransactionToken() {
        createdTime = new Timestamp(Calendar.getInstance().getTime().getTime());
        int minutes = createdTime.getMinutes();
        expireTime = createdTime;
    }

    public TransactionToken(Transaction transaction, String token, boolean active, Timestamp createdTime) {
        this.transaction = transaction;
        this.token = token;
        this.active = active;
        this.createdTime = createdTime;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Timestamp getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Timestamp createdTime) {
        this.createdTime = createdTime;
    }
    
    public boolean isValid(){
        long crTime = createdTime.getTime();
        long nowTime = Calendar.getInstance().getTime().getTime();
        Timestamp check = new Timestamp(nowTime - crTime);
        return false;
    }
}
