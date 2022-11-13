/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Comment;
import Model.auth.User;
import Model.payment.Transaction;
import Model.report.Report;
import Model.report.Violation;
import context.DBContext;
import context.payment.TransactionDAO;
import context.product.BookDAO;
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
            if (rs.next()) {
                ViolationDAO vd = new ViolationDAO();
                vd.addReportViolation(rs.getInt(1), rid);
            }
        } catch (Exception ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void addCommentReport(int[] rid, int cid, int uid, String note) {
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
            stm.setInt(1, 2);
            stm.setInt(2, uid);
            stm.setInt(3, cid);
            stm.setString(4, note);
            stm.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            rs = stm.executeQuery();
            if (rs.next()) {
                ViolationDAO vd = new ViolationDAO();
                vd.addReportViolation(rs.getInt(1), rid);
            }
        }catch (Exception ex) {
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
                ViolationDAO vd = new ViolationDAO();
                r.setViolates(vd.getReportViolations(rs.getInt(1)));
                listR.add(r);
            }
            return listR;
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Report> getReports(String reportType, String status) {
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
                    + " WHERE [reportType] like ? ";
            if (status.equals("")) {
                sql += "   AND r.[status] IS NULL ";
            } else {
                sql += " AND r.[status] = ? ";
            }
            sql += " ORDER BY [sent] DESC";
            stm = cnn.prepareStatement(sql);
            switch (reportType) {
                case "book":
                    reportType = "1";
                    break;
                case "comment":
                    reportType = "2";
                    break;
                case "transaction":
                    reportType="5";
                    break;
                default:
                    break;
            }
            stm.setString(1, "%" + reportType + "%");
            if (!status.equals("")) {
                stm.setString(2, status);
            }
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
                if (rs.getObject(9) != null) {
                    r.setStatus(rs.getBoolean(9));
                }
                ViolationDAO vd = new ViolationDAO();
                r.setViolates(vd.getReportViolations(rs.getInt(1)));
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

    public Report getReportById(int id) {
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
                    + "      ,r.[action]"
                    + "  FROM [Report] r "
                    + " INNER JOIN [User] u ON r.[userId] = u.[id]"
                    + " WHERE r.[id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
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

                r.setObjectId(rs.getInt(5));
                if (r.getReportType() == 1) {
                    BookDAO bd = new BookDAO();
                    r.setBookO(bd.getBookById(r.getObjectId()));
                }
                if (r.getReportType() == 2) {
                    CommentDAO cmt = new CommentDAO();
                    Comment cm = cmt.getCommentById(r.getObjectId());
                    r.setComO(cm);
                    BookDAO bd = new BookDAO();
                    r.setBookO(bd.getBookById(cm.getBookId()));
                }
                if(r.getReportType() == 5){
                    TransactionDAO trd = new TransactionDAO();
                    Transaction trs = new Transaction();
                    trs.setTransactionId(rs.getInt(5));
                    trs = trd.get(trs);
                    r.setTransO(trs);
                }
                r.setNote(rs.getString(6));
                r.setSent(rs.getTimestamp(7));
                r.setReceived(rs.getTimestamp(8));
                if (rs.getObject(9) != null) {
                    r.setStatus(rs.getBoolean(9));
                }
                r.setAction(rs.getString(10));
                ViolationDAO vd = new ViolationDAO();
                r.setViolates(vd.getReportViolations(rs.getInt(1)));
                return r;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void solveReport(Report r) {
        try {
            String sql = "UPDATE [dbo].[Report]\n"
                    + "   SET "
                    + "      [received] = ?\n"
                    + "      ,[status] = ?\n"
                    + "      ,[action] = ?\n"
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            stm.setBoolean(2, r.isStatus());
            stm.setString(3, r.getAction());
            stm.setInt(4, r.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addReport(int[] rid, int oId, int uid, String note, int type) {
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
            stm.setInt(1, type);
            stm.setInt(2, uid);
            stm.setInt(3, oId);
            stm.setString(4, note);
            stm.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            rs = stm.executeQuery();
            if (rs.next()) {
                ViolationDAO vd = new ViolationDAO();
                vd.addReportViolation(rs.getInt(1), rid);
            }
        }catch (Exception ex) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
