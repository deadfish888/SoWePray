/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.payment;

import Model.auth.User;
import context.payment.PaymentAccountDAO;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class PaymentAccount {
    private long accountNumber;
    private float balance;

    public PaymentAccount() {
    }

    public PaymentAccount(long accountNumber) {
        this.accountNumber = accountNumber;
    }
    
    public PaymentAccount(long accountNumber, float balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public long getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(long accountNumber) {
        this.accountNumber = accountNumber;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public PaymentAccount createWallet(User user){
        long tempNumber = user.getId();
        PaymentAccountDAO paymentAccDAO = new PaymentAccountDAO();
        while(paymentAccDAO.get(new PaymentAccount(tempNumber)) != null){
            tempNumber++;
        }
        accountNumber = tempNumber;
        balance = 0f;
        paymentAccDAO.insert(this);
        return this;
    }   
    
    @Override
    public boolean equals(Object obj) {
        if(obj instanceof PaymentAccount){
            PaymentAccount paymentAccount = (PaymentAccount) obj;
            return this.accountNumber == paymentAccount.getAccountNumber();
        }
        return false;
    }
    
}
