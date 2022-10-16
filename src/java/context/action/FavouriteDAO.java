/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.product.Book;
import Model.action.Favourite;
import context.DBContext;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ttaad
 */
public class FavouriteDAO {

    public FavouriteDAO() {
        connectDB();
    }
    Connection cnn; // ket noi db
    Statement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public void addFavourite(int uID, int bID) {
        try {
            String sql = "INSERT INTO [Favourite]\n"
                    + "           ([uid]\n"
                    + "           ,[bid])\n"
                    + "     VALUES\n"
                    + "           (" + uID + ",\n"
                    + "           " + bID + ")";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

    public void deleteFavourite(int uID, int bID) {
        try {
            String sql = "DELETE FROM [dbo].[Favourite]\n"
                    + " WHERE uid='" + uID + "' and bid='" + bID + "'";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

    public boolean checkFavourite(int uID, int bID) {
        try {
            String sql = "SELECT [uid]\n"
                    + ",[bid]\n"
                    + " FROM [dbo].[Favourite] \n"
                    + " WHERE uid='" + uID + "' and bid='" + bID + "'";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return false;
    }

    public ArrayList<Favourite> getAllBook(int uID) {
        ArrayList<Favourite> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Favourite] WHERE uid='" + uID + "'";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int uid = rs.getInt(1);
                int bid = rs.getInt(2);
                list.add(new Favourite(uid, bid));
            }
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Favourite> getAllFav(int bID) {
        ArrayList<Favourite> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Favourite] WHERE bid='" + bID + "'";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int uid = rs.getInt(1);
                int bid = rs.getInt(2);
                list.add(new Favourite(uid, bid));
            }
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return list;
    }

    public void sendFavtoBook(int count) {
        try {

            String sql = "INSERT INTO [dbo].[Book]\n"
                    + "           (\n"
                    + "           [favourite])\n"
                    + "     VALUES\n"
                    + "           ('" + count + "'"
                    + "           )";
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stm.execute(sql);
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

}
