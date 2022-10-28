/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.auth.User;
import Model.report.Report;
import Model.report.Violation;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    public void addBookReport(int[] rid, int bid, int uid, String note) {
        try {
            String sql = "INSERT INTO [dbo].[Report]\n"
                    + "           ([reportType]\n"
                    + "           ,[userId]\n"
                    + "           ,[objectId]\n"
                    + "           ,[note]\n"
                    + "           ,[sent])\n"
                    + "     OUTPUT [inserted].[id]"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , ? "
                    + "           , ? "
                    + "           , ? "
                    + "           , ? )";

            stm = cnn.prepareStatement(sql);
            stm.setInt(1, 1);
            stm.setInt(2, uid);
            stm.setInt(3, bid);
            stm.setString(4, note);
            stm.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            rs = stm.executeQuery();
//            if (rs.next()) {
//                ViolationDAO vd = new ViolationDAO();
//                vd.addReportViolation(rs.getInt(1), rid);
//            }
        } catch (Exception ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println("getAuthorIdByBookId Error: ");
        }
        return ret;
    }

    public ArrayList<Report> getAllReports() {
        ArrayList<Report> listR = new ArrayList<>();
        try {
            String sql = "SELECT r.[id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,u.[username]"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,r.[status]\n"
                    + "  FROM [Report] r "
                    + " INNER JOIN [User] u ON r.[userId] = u.[id]"
                    + " ORDER BY [sent] DESC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Report r = new Report();
                r.setId(rs.getInt(1));
                r.setReportType(rs.getInt(2));
                r.setUserId(rs.getInt(3));

                User userR = new User();
                userR.setId(rs.getInt(3));
                userR.setUsername(rs.getString(4));

                r.setUserR(userR);

                r.setNote(rs.getString(6));
                r.setSent(rs.getTimestamp(7));
                r.setReceived(rs.getTimestamp(8));
                r.setStatus(rs.getBoolean(9));
//                ViolationDAO vd = new ViolationDAO();
//                r.setViolates(vd.getReportViolations(rs.getInt(1)));
                listR.add(r);
            }
            return listR;
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Report> getReports(String reportType, boolean status) {
        ArrayList<Report> list = new ArrayList<>();
        try {
            String sql = "SELECT r.[id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,u.[username]"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,r.[status]\n"
                    + "  FROM [Report] r "
                    + " INNER JOIN [User] u ON r.[userId] = u.[id]"
                    + " WHERE [reportType] like ? "
                    + "   AND r.[status] = ? "
                    + " ORDER BY [sent] DESC";
            stm = cnn.prepareStatement(sql);
            if (reportType.equals("book")) {
                reportType = "1";
            } else if (reportType.equals("comment")) {
                reportType = "2";
            }
            stm.setString(1, "%" + reportType + "%");
            stm.setBoolean(2, status);
            rs = stm.executeQuery();
            while (rs.next()) {
                Report r = new Report();
                r.setId(rs.getInt(1));
                r.setReportType(rs.getInt(2));
                r.setUserId(rs.getInt(3));

                User userR = new User();
                userR.setId(rs.getInt(3));
                userR.setUsername(rs.getString(4));

                r.setUserR(userR);

                r.setNote(rs.getString(6));
                r.setSent(rs.getTimestamp(7));
                r.setReceived(rs.getTimestamp(8));
                r.setStatus(rs.getBoolean(9));
//                ViolationDAO vd = new ViolationDAO();
//                r.setViolates(vd.getReportViolations(rs.getInt(1)));
                list.add(r);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Report> getByPage(ArrayList<Report> reports, int start, int end) {
        ArrayList<Report> listpage = new ArrayList<>();

        for (int i = start; i < end; i++) {
            listpage.add(reports.get(i));
        }
        return listpage;
    }
}
