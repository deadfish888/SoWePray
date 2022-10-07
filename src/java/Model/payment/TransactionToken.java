/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.payment;

import Model.payment.Transaction;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public final class TransactionToken {

    private Transaction transaction;
    private String token;
    private boolean active;
    private Timestamp createdTime;

    public TransactionToken() {
    }

    public TransactionToken(Transaction transaction) {
        this.transaction = transaction;
        createdTime = new Timestamp(Calendar.getInstance().getTime().getTime());
        active = false;
        token = generateToken();
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

    /**
     * Check if token is valid. The present time should be less than expire
     * time. Expire time is 5 minutes after create time.
     *
     */
    public boolean isValid() {
        Calendar created = Calendar.getInstance();
        created.setTimeInMillis(createdTime.getTime());
        Calendar expire = Calendar.getInstance();
        expire.setTimeInMillis(createdTime.getTime());
        expire.add(Calendar.MINUTE, 5);
        Calendar now = Calendar.getInstance();

        return new Timestamp(expire.getTime().getTime()).compareTo(
                new Timestamp(now.getTime().getTime())) > 0;
    }

    public String generateToken() {
        String finalToken = "";
        try {
            String transId = Long.toString(transaction.getTransactionId());
            String time = createdTime.toString();
            String rawToken = transId + time;
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(rawToken.getBytes());
            finalToken = new String(messageDigest.digest());
        } catch (NoSuchAlgorithmException ex) {
            System.err.println(ex.getMessage());
            Logger.getLogger(TransactionToken.class.getName()).log(Level.SEVERE, null, ex);
        }
        return finalToken;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof TransactionToken) {
            return ((TransactionToken) obj).getToken().equals(this.token)
                    && ((TransactionToken) obj).getTransaction()
                            .equals(this.transaction);
        }
        return false;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + Objects.hashCode(this.transaction);
        hash = 53 * hash + Objects.hashCode(this.createdTime);
        return hash;
    }

}
