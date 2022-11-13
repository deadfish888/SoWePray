/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;
import Model.report.Violation;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author duypham0705
 */
public class ViolationDAO {
    
    public ViolationDAO() {
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

    public ArrayList<Violation> getReportViolations(int reportId) {
        ArrayList<Violation> listV = new ArrayList<>();
        try {
            String sql = "SELECT v.[id]\n"
                    + "      ,v.[title]\n"
                    + "  FROM [Report_Violation] rv "
                    + " INNER JOIN [Violation] v ON rv.[violationId] = v.[id]"
                    + " WHERE [reportId] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, reportId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Violation v = new Violation();
                v.setId(rs.getInt(1));
                v.setTitle(rs.getString(2));
                listV.add(v);
            }
            return listV;
        } catch (SQLException ex) {
            Logger.getLogger(ViolationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public  void addReportViolation(int reportId, int[] rid) {
        try {
            String sql = "INSERT INTO [dbo].[Report_Violation]\n"
                    + "           ([reportId]\n"
                    + "           ,[violationId])\n"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , ? )";
            for (int i = 1; i < rid.length; i++) {
                sql += ", (?, ?)";
            }
            stm = cnn.prepareStatement(sql);
            for (int i = 0; i < rid.length; i++) {
                stm.setInt(2 * i + 1, reportId);
                stm.setInt(2 * i + 2, rid[i]);
            }
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ArrayList<Violation> getAllReportType(int rid) {
        ArrayList<Violation> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Violation] WHERE reportType = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, rid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int reportType = rs.getInt(2);
                String title = rs.getString(3);
                list.add(new Violation(id, reportType, title));
            }
        } catch (Exception e) {
            System.out.println("getAllReportType error:" + e.getMessage());
        }
        return list;
    }
}
