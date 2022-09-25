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
    int user_id;
    long balance_before, balance_after, amount, transaction_id;
    int type; 
        //1. Recharge
        //2. Withdraw
        //3. Buy
        //4. Sell
    int status;
    Timestamp transaction_time;

    public Transaction() {
    }

    public Transaction(long transaction_id) {
        this.transaction_id = transaction_id;
    }

    public Transaction(int user_id, long balance_before, long balance_after, long amount, long transaction_id, int type, int status, Timestamp transaction_time) {
        this.user_id = user_id;
        this.balance_before = balance_before;
        this.balance_after = balance_after;
        this.amount = amount;
        this.transaction_id = transaction_id;
        this.type = type;
        this.status = status;
        this.transaction_time = transaction_time;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public long getBalance_before() {
        return balance_before;
    }

    public void setBalance_before(long balance_before) {
        this.balance_before = balance_before;
    }

    public long getBalance_after() {
        return balance_after;
    }

    public void setBalance_after(long balance_after) {
        this.balance_after = balance_after;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
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

    public Timestamp getTransaction_time() {
        return transaction_time;
    }

    public void setTransaction_time(Timestamp transaction_time) {
        this.transaction_time = transaction_time;
    }

    public long getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(long transaction_id) {
        this.transaction_id = transaction_id;
    }
    
}
