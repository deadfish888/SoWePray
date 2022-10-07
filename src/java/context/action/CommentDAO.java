/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Comment;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ttaad
 */
public class CommentDAO {

    public CommentDAO() {
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

    public void addComment(int bid, int uid, String comment) {
        try {
            String sql = "INSERT INTO [dbo].[Comment]\n"
                    + "           ([bookId]\n"
                    + "           ,[userId]\n"
                    + "           ,[comment])\n"
                    + "     VALUES\n"
                    + "           ( ?"
                    + "           , ?"
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setInt(2, uid);
            stm.setString(3, comment);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("add error:" + e.getMessage());
        }
    }

    public ArrayList<Comment> loadComment(int bid) {
        ArrayList<Comment> list = new ArrayList<>();
        try {
            String sql = "SELECT [bookId]\n"
                    + "      ,[userId]\n"
                    + "      ,[comment]\n"
                    + "  FROM [dbo].[Comment]"
                    + " WHERE [bookId]= ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int uid = rs.getInt(2);
                String cmt = rs.getString(3);
                list.add(0,new Comment(bid, uid, cmt));
            }
            return list;
        } catch (Exception e) {
            System.out.println("load error:" + e.getMessage());
        }
        return null;
    }

}
