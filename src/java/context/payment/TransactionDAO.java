/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.payment;

//import Model.payment.PaymentMethod;
import Model.payment.Transaction;
import Model.auth.User;
import Model.product.Product;
import context.DBContext;
import context.auth.UserDAO;
import context.product.ProductDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
            
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public int insert(Transaction transaction) {
        try {
            String sql = "INSERT INTO [Transaction]\n"
                    + "           ([userId]\n"
                    + "           ,[amount]\n"
                    + "           ,[balanceAfter]\n"
                    + "           ,[type]\n"
                    + "           ,[status]\n"
                    + "           ,[description]\n"
                    + "           ,[transactionTime]\n"
                    + "           ,[productId])\n"
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
            stm.setTimestamp(7, transaction.getTransactionTime());
            stm.setString(8, transaction.getProduct() == null ? null : transaction.getProduct().getProductId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public ArrayList<Transaction> getTransactionList(User user) {
        ArrayList<Transaction> transactionList = new ArrayList<>();
        try {
            ProductDAO productDAO = new ProductDAO();
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    //                    + "      ,[paymentId]\n"
                    + "      ,[productId]\n"
                    + "  FROM [Transaction]"
                    + "  WHERE userId = ?"
                    + "  ORDER BY transactionTime desc";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getLong("transactionId"));
                transaction.setUser(user);
                transaction.setAmount(rs.getFloat("amount"));
                transaction.setBalanceAfter(rs.getFloat("balanceAfter"));
                transaction.setTransactionTime(rs.getTimestamp("transactionTime"));
                transaction.setType(rs.getInt("type"));
                transaction.setStatus(rs.getInt("status"));
                transaction.setDescription(rs.getString("description"));
                transaction.setProduct(productDAO.get(new Product(rs.getString("productId"))));
//                PaymentMethodDAO paymentMethodDAO = new PaymentMethodDAO();
//                PaymentMethod paymentMethod = new PaymentMethod();
//                paymentMethod.setPaymentId(rs.getInt("paymentId"));
//                paymentMethod = paymentMethodDAO.get(paymentMethod);
//                transaction.setPayment(paymentMethod);
                transactionList.add(transaction);
            }
            return transactionList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Transaction> getAll() {
        UserDAO userDAO = new UserDAO();
        ArrayList<Transaction> transactionList = new ArrayList<>();
        try {
            ProductDAO productDAO = new ProductDAO();
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    + "      ,[productId]\n"
                    + "  FROM [Transaction]"
                    + "  ORDER BY transactionTime desc";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getLong("transactionId"));
                transaction.setUser(userDAO.getUser(rs.getInt("userId")));
                transaction.setAmount(rs.getFloat("amount"));
                transaction.setBalanceAfter(rs.getFloat("balanceAfter"));
                transaction.setTransactionTime(rs.getTimestamp("transactionTime"));
                transaction.setType(rs.getInt("type"));
                transaction.setStatus(rs.getInt("status"));
                transaction.setDescription(rs.getString("description"));
                transaction.setProduct(productDAO.get(new Product(rs.getString("productId"))));
//                PaymentMethodDAO paymentMethodDAO = new PaymentMethodDAO();
//                PaymentMethod paymentMethod = new PaymentMethod();
//                paymentMethod.setPaymentId(rs.getInt("paymentId"));
//                paymentMethod = paymentMethodDAO.get(paymentMethod);
//                transaction.setPayment(paymentMethod);
                transactionList.add(transaction);
            }
            return transactionList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<Transaction> getPending() {
        UserDAO userDAO = new UserDAO();
        ArrayList<Transaction> transactionList = new ArrayList<>();
        try {
            ProductDAO productDAO = new ProductDAO();
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    + "      ,[productId]\n"
                    + "  FROM [Transaction]"
                    + "  WHERE [status] = 2"
                    + "  ORDER BY transactionTime desc";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getLong("transactionId"));
                transaction.setUser(userDAO.getUser(rs.getInt("userId")));
                transaction.setAmount(rs.getFloat("amount"));
                transaction.setBalanceAfter(rs.getFloat("balanceAfter"));
                transaction.setTransactionTime(rs.getTimestamp("transactionTime"));
                transaction.setType(rs.getInt("type"));
                transaction.setStatus(rs.getInt("status"));
                transaction.setDescription(rs.getString("description"));
                transaction.setProduct(productDAO.get(new Product(rs.getString("productId"))));
                transactionList.add(transaction);
            }
            return transactionList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Transaction get(Transaction transaction) {
        UserDAO userDAO = new UserDAO();
        try {
            ProductDAO productDAO = new ProductDAO();
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    + "      ,[productId]\n"
                    + "  FROM [Transaction]"
                    + "  WHERE [transactionId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, transaction.getTransactionId());
            rs = stm.executeQuery();
            if (rs.next()) {
                transaction.setTransactionId(rs.getLong("transactionId"));
                transaction.setUser(userDAO.getUser(rs.getInt("userId")));
                transaction.setAmount(rs.getFloat("amount"));
                transaction.setBalanceAfter(rs.getFloat("balanceAfter"));
                transaction.setTransactionTime(rs.getTimestamp("transactionTime"));
                transaction.setType(rs.getInt("type"));
                transaction.setStatus(rs.getInt("status"));
                transaction.setDescription(rs.getString("description"));
                transaction.setProduct(productDAO.get(new Product(rs.getString("productId"))));
            }
            return transaction;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int update(Transaction transaction) {
        try {
            String sql = "UPDATE [Transaction]\n"
                    + "   SET [amount] = ?\n"
                    + "      ,[balanceAfter] = ?\n"
                    + "      ,[status] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[transactionTime] = ?\n"
                    + " WHERE [transactionId] = ?\n";
            stm = cnn.prepareStatement(sql);
            stm.setFloat(1, transaction.getAmount());
            stm.setFloat(2, transaction.getBalanceAfter());
            stm.setInt(3, transaction.getStatus());
            stm.setString(4, transaction.getDescription());
            stm.setTimestamp(5, transaction.getTransactionTime());
            stm.setLong(6, transaction.getTransactionId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public ArrayList<Transaction> search(Transaction transaction) {
        ArrayList<Transaction> transactionList = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        UserDAO userDAO = new UserDAO();
        try {
            String sql = "SELECT [transactionId]\n"
                    + "      ,[userId]\n"
                    + "      ,[amount]\n"
                    + "      ,[balanceAfter]\n"
                    + "      ,[transactionTime]\n"
                    + "      ,[type]\n"
                    + "      ,[status]\n"
                    + "      ,[description]\n"
                    + "      ,[productID]\n"
                    + "  FROM [Transaction]"
                    + "  WHERE 1 = 1";
            if(transaction.getTransactionId() !=0){
                sql += "\n  AND [transactionId] = " + transaction.getTransactionId();
            }
            if (transaction.getUser() != null) {
                sql += "\n  AND [userId] = " + transaction.getUser().getId();
            }
            if (transaction.getType() > 0) {
                sql += "\n  AND [type] = " + transaction.getType();
            }
            if (transaction.getStatus() > 0) {
                sql += "\n  AND [status] = " + transaction.getStatus();
            }
            if (transaction.getProduct() != null) {
                sql += "\n  AND [productId] LIKE '%" + transaction.getProduct().getProductId() + "%'";
            }
            System.out.println(sql);
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Transaction trans = new Transaction();
                trans.setTransactionId(rs.getLong("transactionId"));
                trans.setUser(userDAO.getUser(rs.getInt("userId")));
                trans.setAmount(rs.getFloat("amount"));
                trans.setBalanceAfter(rs.getFloat("balanceAfter"));
                trans.setTransactionTime(rs.getTimestamp("transactionTime"));
                trans.setType(rs.getInt("type"));
                trans.setStatus(rs.getInt("status"));
                trans.setDescription(rs.getString("description"));
                trans.setProduct(productDAO.get(new Product(rs.getString("productId"))));
//                PaymentMethodDAO paymentMethodDAO = new PaymentMethodDAO();
//                PaymentMethod paymentMethod = new PaymentMethod();
//                paymentMethod.setPaymentId(rs.getInt("paymentId"));
//                paymentMethod = paymentMethodDAO.get(paymentMethod);
//                transaction.setPayment(paymentMethod);
                transactionList.add(trans);

            }
            return transactionList;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ArrayList<Transaction> getByPage(ArrayList<Transaction> listT, int start, int end) {

        ArrayList<Transaction> listpage = new ArrayList<>();
        if (listT.size() < end) {
            end = listT.size();
        }
        for (int i = start; i < end; i++) {
            listpage.add(listT.get(i));
        }
        return listpage;
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
