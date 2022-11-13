/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.payment;

import Model.payment.PaymentAccount;
import Model.auth.User;
import context.DBContext;
import context.auth.UserDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.MyUtil;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class PaymentAccountDAO {

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    public PaymentAccountDAO() {
        connectDB();
    }

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public PaymentAccount get(PaymentAccount paymentAccount) {
        try {
            String sql = "SELECT [accountNumber]\n"
                    + "      ,[balance]\n"
                    + "  FROM [Payment_Account]"
                    + "  WHERE [accountNumber] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, paymentAccount.getAccountNumber());
            rs = stm.executeQuery();
            if (rs.next()) {
                paymentAccount.setBalance(rs.getFloat("balance"));
            } else {
                paymentAccount = null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return paymentAccount;
    }

    public PaymentAccount getWallet(User user) {
        return get(user.getPaymentAccount());
    }

    public void insert(PaymentAccount paymentAccount) {
        try {
            String sql = "INSERT INTO [Payment_Account]\n"
                    + "           ([accountNumber]\n"
                    + "           ,[balance])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, paymentAccount.getAccountNumber());
            stm.setFloat(2, paymentAccount.getBalance());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void update(PaymentAccount paymentAccount) {
        try {
            String sql = "UPDATE [Payment_Account]\n"
                    + "   SET [balance] = ?\n"
                    + " WHERE [accountNumber] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setFloat(1, paymentAccount.getBalance());
            stm.setLong(2, paymentAccount.getAccountNumber());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void generateData() {
        UserDAO userDAO = new UserDAO();
        ArrayList<User> userList = userDAO.getAllUsers();
        System.out.println(userList.size());

        for (User user : userList) {
            if (user.getPaymentAccount() == null) {
                user.createWallet();
                System.out.println("null");
            }
            PaymentAccount paymentAccount = user.getPaymentAccount();
            float balance = (float) Math.random() * 888;
            paymentAccount.setBalance(balance);
//            System.out.println(paymentAccount.getAccountNumber() + "   " + paymentAccount.getBalance());
            update(paymentAccount);
//            userDAO.setWalletNumber(paymentAccount, user);
        }
//        for (int i = 0; i < 100; i++) {
//            PaymentAccount paymentAccount = new PaymentAccount();
//            paymentAccount.setAccountNumber(Long.parseLong(MyUtil.randomNumberString(12)));
//            paymentAccount.setBalance((float) Math.random() * 4000);
//            insert(paymentAccount);
//        }
    }
}

/**
 * SQL template
 *
 * try { String sql = ""; stm = cnn.prepareStatement(sql); rs =
 * stm.executeQuery(); } catch (SQLException ex) {
 * Logger.getLogger(PaymentAccountDAO.class.getName()).log(Level.SEVERE, null,
 * ex); }
 *
 */
