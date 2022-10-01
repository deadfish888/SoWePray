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
                    + "      ,[active]\n"
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
                paymentMethod.setPaymentAccount(paymentAccountDAO.get(
                        new PaymentAccount(rs.getLong("accountNumber"))));
                paymentMethod.setName(rs.getString("name"));
                paymentMethod.setActive(rs.getBoolean("active"));
                return paymentMethod;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insert(PaymentMethod paymentMethod) {
        if (get(paymentMethod) != null) {
            active(paymentMethod);
        } else {
            try {
                String sql = "INSERT INTO [Payment_Method]\n"
                        + "           ([userId]\n"
                        + "           ,[accountNumber]\n"
                        + "           ,[name]\n"
                        + "           ,[active])\n"
                        + "     VALUES\n"
                        + "           (?, ?, ?, ?)";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, paymentMethod.getUser().getId());
                stm.setLong(2, paymentMethod.getPaymentAccount().getAccountNumber());
                stm.setString(3, paymentMethod.getName());
                stm.setBoolean(4, paymentMethod.isActive());
                stm.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

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

    public void deactive(PaymentMethod paymentMethod) {
        try {
            String sql = "UPDATE [dbo].[Payment_Method]\n"
                    + "   SET [active] = 0"
                    + "   WHERE paymentId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, paymentMethod.getPaymentId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void active(PaymentMethod paymentMethod) {
        try {
            String sql = "UPDATE [dbo].[Payment_Method]\n"
                    + "   SET [active] = 1"
                    + "   WHERE paymentId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, paymentMethod.getPaymentId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentMethodDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public ArrayList<PaymentMethod> getActivePayment(User user) {
        ArrayList<PaymentMethod> bankList = new ArrayList<>();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
        PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
        try {
            String sql = "SELECT paymentId, userId, pm.accountNumber, [name], [balance], [active]\n"
                    + "  FROM Payment_Method pm inner join Payment_Account pa\n"
                    + "  ON pm.accountNumber = pa.accountNumber\n"
                    + "  WHERE userId = ?"
                    + "  AND [active] = 1";
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

    public ArrayList<PaymentMethod> getUserPayment(User user) {
        ArrayList<PaymentMethod> bankList = new ArrayList<>();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
        PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
        try {
            String sql = "SELECT paymentId, userId, pm.accountNumber, [name], [balance], [active]\n"
                    + "  FROM Payment_Method pm inner join Payment_Account pa\n"
                    + "  ON pm.accountNumber = pa.accountNumber\n"
                    + "  WHERE userId = ?";
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
//
//    public void generateData() {
//        UserDAO userDAO = new UserDAO();
//        ArrayList<User> userList = userDAO.getAll();
//        PaymentAccountDAO paymentAccountDAO = new PaymentAccountDAO();
//        for (User user : userList) {
//            PaymentAccount paymentAccount;
//            long accountNumber;
//            do {
//                accountNumber = Long.parseLong(MyUtil.randomNumberString(10));
//                paymentAccount = new PaymentAccount(accountNumber);
//
//            } while (paymentAccountDAO.get(paymentAccount) != null);
//            float balance = (float) Math.random() * 5000 + 100;
//            paymentAccount.setAccountNumber(accountNumber);
//            paymentAccount.setBalance(balance);
//
//            PaymentMethod paymentMethod = new PaymentMethod();
//            paymentMethod.setUser(user);
//            paymentMethod.setPaymentAccount(user.getPaymentAccount());
//            paymentMethod.setName("Wallet of " + user.getUsername());
//            insert(paymentMethod);
//
//            paymentAccountDAO.insert(paymentAccount);
//            paymentMethod = new PaymentMethod();
//            paymentMethod.setPaymentAccount(paymentAccount);
//            paymentMethod.setUser(user);
//            paymentMethod.setName("Linked Bank");
//            insert(paymentMethod);
//        }
//
//    }
}
