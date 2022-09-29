/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

    public void insert() {
        String sql = "INSERT INTO [dbo].[Transaction]\n"
                + "           ([userId]\n"
                + "           ,[amount]\n"
                + "           ,[balanceAfter]\n"
                + "           ,[type]\n"
                + "           ,[status]\n"
                + "           ,[description]\n"
                + "           ,[paymentId])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,<status, int,>\n"
                + "           ,?\n"
                + "           ,?)";
    }
}

/**
 * SQL template:
 
 
 **/
