/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.PaymentAccount;
import Model.PaymentMethod;
import Model.User;
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
public class PaymentMethodDAO {

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    public PaymentMethodDAO() {
        connectDB();
    }

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public PaymentMethod get(PaymentMethod paymentMethod) {
        try {
            String sql = "SELECT [paymentId]\n"
                    + "      ,[userId]\n"
                    + "      ,[accountNumber]\n"
                    + "      ,[name]\n"
                    + "  FROM [Payment_Method]";
            if (paymentMethod.getPaymentId() == 0) {
                sql += "  WHERE [userId] = ?"
                        + " and accountNumber = ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, paymentMethod.getUser().getId());
                stm.setLong(2, paymentMethod.getPaymentAccount().getAccountNumber());
            } else {
                sql += "  WHERE [paymentId] = ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, paymentMethod.getPaymentId());
            }
            rs = stm.executeQuery();
            if (rs.next()) {
                paymentMethod.setPaymentId(rs.getInt("paymentId"));
                UserDAO userDAO = new UserDAO();
                paymentMethod.setUser(userDAO.getUser(rs.getInt("userId")));

                PaymentAccountDAO paymentAccountDAO = new PaymentAccountDAO();
                paymentMethod.setPaymentAccount(paymentAccountDAO.get(new PaymentAccount(rs.getLong("accountNumber"))));
                paymentMethod.setName(rs.getString("name"));
                return paymentMethod;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insert(PaymentMethod paymentMethod) {
        try {
            String sql = "INSERT INTO [Payment_Method]\n"
                    + "           ([userId]\n"
                    + "           ,[accountNumber]\n"
                    + "           ,[name])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, paymentMethod.getUser().getId());
            stm.setLong(2, paymentMethod.getPaymentAccount().getAccountNumber());
            stm.setString(3, paymentMethod.getName());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delete(PaymentMethod paymentMethod) {
        try {
            String sql = "DELETE FROM [Payment_Method]\n"
                    + "      WHERE paymentId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, paymentMethod.getPaymentId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void generateData() {
        UserDAO userDAO = new UserDAO();
        ArrayList<User> userList = userDAO.getAll();
        PaymentAccountDAO paymentAccountDAO = new PaymentAccountDAO();
        for (User user : userList) {
            PaymentAccount paymentAccount;
            long accountNumber;
            do {
                accountNumber = Long.parseLong(MyUtil.randomNumberString(10));
                paymentAccount = new PaymentAccount(accountNumber);

            } while (paymentAccountDAO.get(paymentAccount) != null);
            float balance = (float) Math.random() * 5000 + 100;
            paymentAccount.setAccountNumber(accountNumber);
            paymentAccount.setBalance(balance);

            PaymentMethod paymentMethod = new PaymentMethod();
            paymentMethod.setUser(user);
            paymentMethod.setPaymentAccount(user.getPaymentAccount());
            paymentMethod.setName("Wallet of " + user.getUsername());
            insert(paymentMethod);

            paymentAccountDAO.insert(paymentAccount);
            paymentMethod = new PaymentMethod();
            paymentMethod.setPaymentAccount(paymentAccount);
            paymentMethod.setUser(user);
            paymentMethod.setName("Linked Bank");
            insert(paymentMethod);
        }

    }
}
