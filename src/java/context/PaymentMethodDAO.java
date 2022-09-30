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

    public PaymentMethod checkDuplicate(PaymentMethod paymentMethod) {
        try {
            String sql = "SELECT [paymentId]\n"
                    + "      ,[userId]\n"
                    + "      ,[accountNumber]\n"
                    + "      ,[name]\n"
                    + "  FROM [Payment_Method]";
            if(paymentMethod.getPayment_id() == 0) {
                sql += "  WHERE [userId] = ?"
                        + " and accountNumber = ?";
                stm.setInt(1, paymentMethod.getUser().getId());
                stm.setLong(2, paymentMethod.getPaymentAccount().getAccountNumber());
            }else {
                sql += "  WHERE [paymentId] = ?";
                stm.setInt(1, paymentMethod.getPayment_id());
            }
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                paymentMethod.setPayment_id(rs.getInt("paymentId"));
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
    
    public void insert(PaymentMethod paymentMethod){
        
    }

    public void generateData(){
        UserDAO userDAO = new UserDAO();
        ArrayList<User> userList = userDAO.getAllUsers();
        for(User user : userList){
            long accountNumber = Long.parseLong(MyUtil.randomNumberString(10));
            float balance = (float) Math.random() * 8888;
            PaymentAccount paymentAccount = new PaymentAccount(accountNumber, balance);
            PaymentMethod paymentMethod = new PaymentMethod();
            paymentMethod.setUser(user);
            paymentMethod.setPaymentAccount(paymentAccount);
        }
        
    }
}
