/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.PaymentAccount;
import Model.PaymentMethod;
import Model.Transaction;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TransactionDAO {

    public TransactionDAO() {
        connectDB();
    }

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public void insert(Transaction transaction) {
        try {
            String sql = "INSERT INTO [Transaction]\n"
                    + "           ([userId]\n"
                    + "           ,[amount]\n"
                    + "           ,[balanceAfter]\n"
                    + "           ,[type]\n"
                    + "           ,[status]\n"
                    + "           ,[description]\n"
                    + "           ,[paymentId]\n"
                    + "           ,[transactionTime])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, transaction.getUser().getId());
            stm.setFloat(2, transaction.getAmount());
            stm.setFloat(3, transaction.getBalanceAfter());
            stm.setInt(4, transaction.getType());
            stm.setInt(5, transaction.getStatus());
            stm.setString(6, transaction.getDescription());
            stm.setInt(7, transaction.getPayment().getPaymentId());
            stm.setTimestamp(8, transaction.getTransactionTime());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Transaction> getTransactionList(User user) {
        ArrayList<Transaction> transactionList = new ArrayList<>();
        try {
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    + "      ,[paymentId]\n"
                    + "  FROM [Transaction]"
                    + "  WHERE userId = ?"
                    + "  ORDER BY transactionTime desc";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while(rs.next()){
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getLong("transactionId"));
                transaction.setUser(user);
                transaction.setAmount(rs.getFloat("amount"));
                transaction.setBalanceAfter(rs.getFloat("balanceAfter"));
                transaction.setTransactionTime(rs.getTimestamp("transactionTime"));
                transaction.setType(rs.getInt("type"));
                transaction.setStatus(rs.getInt("status"));
                transaction.setDescription(rs.getString("description"));
                PaymentMethodDAO paymentMethodDAO = new PaymentMethodDAO();
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setPaymentId(rs.getInt("paymentId"));
                paymentMethod = paymentMethodDAO.get(paymentMethod);
                transaction.setPayment(paymentMethod);
                transactionList.add(transaction);
            }
            return transactionList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

//    public void generateData() {
//        UserDAO userDAO = new UserDAO();
//        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
//        PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
//        ArrayList<User> userList = userDAO.getAllUsers();
//        for (User user : userList) {
//            Transaction transaction = new Transaction();
//            transaction.setUser(user);
//            transaction.setAmount(user.getPaymentAccount().getBalance());
//            transaction.setBalanceAfter(user.getPaymentAccount().getBalance());
//            transaction.setType(1);
//            transaction.setStatus(2);
//            transaction.setPayment(payMedDAO.getBankList(user).get(0));
//            transaction.setDescription("Recharge money from " + transaction.getPayment().getName());
//            transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
//            insert(transaction);
//        }
//    }
}

/**
 * SQL template:
 *
 *
 *
 */
/*

USE [BOOKIE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Transaction](
	[userId] [int] NOT NULL,
	[balanceBefore] [bigint] NOT NULL,
	[amount] [bigint] NOT NULL,
	[balanceAfter] [bigint] NOT NULL,
	[transactionTime] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[status] [int] NOT NULL
) ON [PRIMARY]
GO

 */
