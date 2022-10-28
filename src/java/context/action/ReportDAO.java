/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Violation;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

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

    public int count() {
        int ret = 0;
        try {
            String sql = "SELECT COUNT([id])\n"
                    + "  FROM [dbo].[ReportDetail]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                ret = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("countIDfromReportDetail Error: ");
        }
        return ret;
    }
    
    public void addReportComment(int uid, int cid, String note) {
        try {
            String sql = "INSERT INTO [dbo].[Report]\n"
                    + "           ([reportTypeId]\n"
                    + "           ,[userId]\n"
                    + "           ,[objectId]\n"
                    + "           ,[note]\n"
                    + "           ,[sent])\n"
                    + "     VALUES\n"
                    + "           ( ?"
                    + "           , ?"
                    + "           , ?"
                    + "           , ?"
                    + "           , ?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, 2);
            stm.setInt(2, uid);
            stm.setInt(3, cid);
            stm.setString(4, note);
            stm.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("AddReportCommentError:" + e.getMessage());
        }
    }
    
    


}