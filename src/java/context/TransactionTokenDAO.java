/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Transaction;
import Model.TransactionToken;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TransactionTokenDAO {

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    public TransactionTokenDAO() {
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

    public TransactionToken get(Transaction trans) {
        TransactionToken transToken = new TransactionToken();
        try {
            String sql = "SELECT [transactionId]\n"
                    + "      ,[token]\n"
                    + "      ,[status]\n"
                    + "      ,[createdTime]\n"
                    + "  FROM [Transaction_Token]"
                    + "  WHERE [transationId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, trans.getTransactionId());
            rs = stm.executeQuery();
            if(rs.next()){
                transToken = new TransactionToken();
                transToken.setToken(rs.getString("token"));
                transToken.setTransaction(trans);
                transToken.setCreatedTime(rs.getTimestamp("createdTime"));
                transToken.setActive(rs.getBoolean("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TransactionTokenDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return transToken;
    }
}
