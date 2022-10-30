/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Ticket;
import context.DBContext;
import context.auth.UserDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ttaad
 */
public class TicketDAO {

    public TicketDAO() {
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

    public void passReport(int type, int uid, String txt, boolean status) {
        try {
            String sql = "INSERT INTO [dbo].[Report]\n"
                    + "           ([reportType]\n"
                    + "           ,[userId]\n"
                    + "           ,[objectId]\n"
                    + "           ,[note]\n"
                    + "           ,[sent]\n"
                    + "           ,[received]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,NULL\n"
                    + "           , ?\n"
                    + "           , ?\n"
                    + "           , NULL\n"
                    + "           ,? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, type);
            stm.setInt(2, uid);
            stm.setString(3, txt);
            SimpleDateFormat sdf = new SimpleDateFormat();
            stm.setString(4, sdf.format(new Date()));
            stm.setBoolean(5, status);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("add error:" + e.getMessage());
        }
    }

    public void senndReport(int type, int uid, String txt) {
        try {
            String sql = "INSERT INTO [dbo].[Report]\n"
                    + "           ([reportType]\n"
                    + "           ,[userId]\n"
                    + "           ,[objectId]\n"
                    + "           ,[note]\n"
                    + "           ,[sent]\n"
                    + "           ,[received]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,NULL\n"
                    + "           , ?\n"
                    + "           , ?\n"
                    + "           , NULL\n"
                    + "           , NULL )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, type);
            stm.setInt(2, uid);
            stm.setString(3, txt);
            SimpleDateFormat sdf = new SimpleDateFormat();
            stm.setString(4, sdf.format(new Date()));
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("add error:" + e.getMessage());
        }
    }

    public int count() {
        int ret = 0;
        try {
            String sql = "SELECT COUNT([id])\n"
                    + "  FROM [BOOKIE].[dbo].[Report]\n"
                    + "  WHERE [status] IS NULL "
                    + "  AND ([reportType] = 3 OR [reportType] =4)";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                ret = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("COUNT Error: ");
        }
        return ret;
    }

    public ArrayList<Ticket> getRead(int uid) {
        ArrayList<Ticket> list = new ArrayList<>();
        try {
            String sql = "SELECT TOP 5\n"
                    + "		[id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE [received] IS NOT NULL\n"
                    + "  AND userId = ?\n"
                    + "  ORDER BY [id] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int type = rs.getInt(2);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);
                String stage = "Passed";
                if (status == false) {
                    stage = "Reject";
                }
                Ticket rp = new Ticket(id, type, uid, objectId, note, sent, received, status, stage);
                list.add(rp);
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Ticket> getUnRead(int uid) {
        ArrayList<Ticket> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE [received] IS  NULL\n"
                    + "  AND userId = ?\n"
                    + "  AND [status] IS NOT NULL\n"
                    + "  ORDER BY [id] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int type = rs.getInt(2);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);
                String stage = "Passed";
                if (status == false) {
                    stage = "Reject";
                }

                Ticket rp = new Ticket(id, type, uid, objectId, note, sent, received, status, stage);

                list.add(rp);
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Ticket> getSent(int uid) {
        ArrayList<Ticket> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE  userId = ?\n"
                    + "  AND [status] IS NULL\n"
                    + "  ORDER BY [id] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int type = rs.getInt(2);
                String reportType = rs.getString(3);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);
                Ticket rp = new Ticket(id, type, uid, objectId, note, sent, received, status, "On Process");
                list.add(rp);
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Ticket> getAction(int uid) {
        ArrayList<Ticket> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE [userId] = ?\n"
                    + "  AND ([status] IS NULL OR [status] = 0 )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int type = rs.getInt(2);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);
                String stage = "Passed";
                if (status == false) {
                    stage = "Reject";
                }

                Ticket rp = new Ticket(id, type, uid, objectId, note, sent, received, status, stage);

                list.add(rp);
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Ticket> getAll() {
        ArrayList<Ticket> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE  [status] IS NULL\n"
                    + "  AND ([reportType] = 3 OR [reportType] =4)\n"
                    + "  ORDER BY [id] DESC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int type = rs.getInt(2);
                int uid = rs.getInt(3);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);

                Ticket rp = new Ticket(id, type, uid, objectId, note, sent, received, status, "On Process");
                list.add(rp);
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return list;
    }

    public boolean hasSent(int id) {
        int num = 0;
        try {
            String sql = "SELECT COUNT([id])\n"
                    + "  FROM [BOOKIE].[dbo].[Report]\n"
                    + "  WHERE [Report].[userId] = ? \n"
                    + "  AND [status] IS NULL\n"
                    + "  AND ([reportType] = 3 OR [reportType] =4)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                num = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (num > 0) {
            return true;
        }
        return false;
    }

    public void readAll(int id) {
        String sql = "UPDATE [dbo].[Report]\n"
                + "   SET [received] = ? \n"
                + " WHERE [userId] = ?"
                + " AND [status] IS NOT NULL";
        try {
            stm = cnn.prepareStatement(sql);
            SimpleDateFormat sdf = new SimpleDateFormat();
            stm.setString(1, sdf.format(new Date()));
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public void read(int id, int p) {
        String sql = "UPDATE [dbo].[Report]\n"
                + "   SET [received] = ? \n"
                + " WHERE [userId] = ?"
                + " AND [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            SimpleDateFormat sdf = new SimpleDateFormat();
            stm.setString(1, sdf.format(new Date()));
            stm.setInt(2, id);
            stm.setInt(3, p);

            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public Ticket getRP(int id) {
        Ticket rp = new Ticket();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[reportType]\n"
                    + "      ,[userId]\n"
                    + "      ,[objectId]\n"
                    + "      ,[note]\n"
                    + "      ,[sent]\n"
                    + "      ,[received]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Report]\n"
                    + "  WHERE  [Report].[id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                int type = rs.getInt(2);
                int uid = rs.getInt(3);
                int objectId = rs.getInt(4);
                String note = rs.getString(5);
                Date sent = rs.getDate(6);
                Date received = rs.getDate(7);
                boolean status = rs.getBoolean(8);

                rp = new Ticket(id, type, uid, objectId, note, sent, received, status, "On Process");
            }
        } catch (Exception e) {
            System.out.println("get rp Error:" + e.getMessage());
        }
        return rp;
    }

    public void setStatus(int id, boolean b) {
        String send = b ? "Your request has been apporved" : "Your request has been denied";
        String sql = "UPDATE [dbo].[Report]\n"
                + "   SET [status] = ?\n"
                + "   ,[note] = ?"
                + " WHERE [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setBoolean(1, b);
            stm.setString(2, send);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public ArrayList<Ticket> getByPage(ArrayList<Ticket> listRead, int start, int end) {
        ArrayList<Ticket> listpage = new ArrayList<>();
        if (listRead.size() < end) {
            end = listRead.size();
        }
        for (int i = start; i < end; i++) {
            listpage.add(listRead.get(i));
        }
        return listpage;
    }

}
