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

    public ArrayList<PaymentMethod> getBankList(User user) {
        ArrayList<PaymentMethod> bankList = new ArrayList<>();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
        PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
        try {
            String sql = "select pa.accountNumber, balance, paymentId, userId, pm.[name] from Payment_Account pa\n"
                    + "  inner join Payment_Method pm\n"
                    + "  on pa.accountNumber = pm.accountNumber\n"
                    + "  where pa.accountNumber not in \n"
                    + "  (\n"
                    + "  select walletNumber from [User]\n"
                    + "  inner join Payment_Account\n"
                    + "  on [User].walletNumber = Payment_Account.accountNumber\n"
                    + "  ) and userId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setPaymentId(rs.getInt("paymentId"));
                bankList.add(payMedDAO.get(paymentMethod));
            }
            return bankList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void generateData() {
        UserDAO userDAO = new UserDAO();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
        ArrayList<User> userList = userDAO.getAll();
        for (User user : userList) {
            Transaction transaction = new Transaction();
            transaction.setUser(user);
            transaction.setAmount(user.getPaymentAccount().getBalance());
            transaction.setBalanceAfter(user.getPaymentAccount().getBalance());
            transaction.setType(1);
            transaction.setStatus(2);
            transaction.setPayment(getBankList(user).get(0));
            transaction.setDescription("Recharge money from " + transaction.getPayment().getName());
            transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
            insert(transaction);
        }
    }
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
