/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ttaad
 */
public class ReportDAO {

    public ReportDAO() {
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

    public void addReport(int rid, int bid, int uid, String note) {
        try {
            String sql = "INSERT INTO [dbo].[ReportDetail]\n"
                    + "           ([reportId]\n"
                    + "           ,[bookId]\n"
                    + "           ,[userId]\n"
                    + "           ,[note])\n"
                    + "     VALUES\n"
                    + "           ( ?"
                    + "           , ?"
                    + "           , ?"
                    + "           , ? ) ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, rid);
            stm.setInt(2, bid);
            stm.setInt(3, uid);
            stm.setString(4, note);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("add error:" + e.getMessage());
        }
    }

}
