/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Comment;
import Model.auth.User;
import context.DBContext;
import context.auth.UserDAO;
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
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public void addComment(int bid, int uid, String comment) {
        try {
            String sql = "INSERT INTO [dbo].[Comment]\n"
                    + "           ([bookId]\n"
                    + "           ,[userId]\n"
                    + "           ,[comment]\n"
                    + "           ,[createdAt])\n"
                    + "     VALUES\n"
                    + "           ( ?"
                    + "           , ?"
                    + "           , ?"
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setInt(2, uid);
            stm.setString(3, comment);
            stm.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("add error:" + e.getMessage());
        }
    }

    public ArrayList<Comment> loadComment(int bid) {
        ArrayList<Comment> list = new ArrayList<>();
        try {
            String sql = "SELECT c.[id]"
                    + "      ,[bookId]\n"
                    + "      ,c.[userId]\n"
                    + "      ,u.[fullname]\n"
                    + "      ,u.[username]\n"
                    + "      ,u.[gender]\n"
                    + "      ,[comment]\n"
                    + "      ,[createdAt]\n"
                    + "      ,[status]\n"
                    + "  FROM [Comment] c"
                    + " INNER JOIN [User] u ON c.[userId] = u.[id]"
                    + " WHERE [bookId]= ? "
                    + " ORDER BY [createdAt] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Comment cm = new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3)
                        , rs.getString(7), rs.getTimestamp(8), rs.getBoolean(9));
                User user = new User();
                user.setName(rs.getString(4));
                user.setUsername(rs.getString(5));
                user.setGender(rs.getBoolean(6)?"Male":"Female");
                cm.setUser(user);
                list.add(cm);
            }
            return list;
        } catch (Exception e) {
            System.out.println("load error:" + e.getMessage());
        }
        return null;
    }

    public int count() {
        int ret = 0;
        try {
            String sql = "SELECT COUNT([id])\n"
                    + "  FROM [dbo].[Comment]";
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

    public Comment getCommentById(int cid) {
        try {
            String sql = "SELECT c.[id]"
                    + "      ,[bookId]\n"
                    + "      ,c.[userId]\n"
                    + "      ,u.[fullname]\n"
                    + "      ,u.[username]\n"
                    + "      ,u.[gender]\n"
                    + "      ,[comment]\n"
                    + "      ,[createdAt]\n"
                    + "      ,[status]\n"
                    + "  FROM [Comment] c"
                    + " INNER JOIN [User] u ON c.[userId] = u.[id]"
                    + " WHERE c.[id]= ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, cid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Comment cm = new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3)
                        , rs.getString(7), rs.getTimestamp(8), rs.getBoolean(9));
                User user = new User();
                user.setName(rs.getString(4));
                user.setUsername(rs.getString(5));
                user.setGender(rs.getBoolean(6)?"Male":"Female");
                
                cm.setUser(user);
                return cm;
            }
        } catch (Exception e) {
            System.out.println("getCommentById:" + e.getMessage());
        }
        return null;
    }
    
    public void deleteComment(int cId) {
        try {
            String sql = "UPDATE [Comment]"
                    + "      SET [status] = 0"
                    + "    WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, cId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    
}
