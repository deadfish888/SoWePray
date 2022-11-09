/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Comment;
import Model.auth.User;
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

    public ArrayList<Comment> loadComment(int bid, String cmtId) {
        ArrayList<Comment> list = new ArrayList<>();
        int cmtID ;
        try{
            cmtID = Integer.parseInt(cmtId);
        }catch (Exception e){
            cmtID = 0;
        }
        Comment cmt = getCommentById(cmtID);
        try {
            String sql = "SELECT c.[id]"
                    + "      ,[bookId]\n"
                    + "      ,c.[userId]\n"
                    + "      ,u.[fullname]\n"
                    + "      ,[comment]\n"
                    + "      ,[createdAt]\n"
                    + "      ,[status]\n"
                    + "      ,[sonOf]"
                    + "      ,[editedAt]"
                    + "  FROM [Comment] c"
                    + " INNER JOIN [User] u ON c.[userId] = u.[id]"
                    + " WHERE [bookId]= ? "
                    + " ORDER BY CASE WHEN c.[id] = ? THEN 1 ELSE 2 END"
                    + ",[createdAt] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            if(cmt ==null || cmt.getSonOf() == 0){
                stm.setInt(2, cmtID);
            }else {
                stm.setInt(2, cmt.getSonOf());
            }
            
            rs = stm.executeQuery();
            while (rs.next()) {
                Comment cm = new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3),
                         rs.getString(5), rs.getTimestamp(6), rs.getBoolean(7));
                cm.setSonOf(rs.getInt(8));
                cm.setEditedAt(rs.getTimestamp(9));
                User user = new User();
                user.setName(rs.getString(4));
                cm.setUser(user);
                cm.setReplies(getCommentReplies(rs.getInt(1)));
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

    public Comment getCommentById(int objectId) {
        try {
            String sql = "SELECT c.[id]"
                    + "      ,[bookId]\n"
                    + "      ,c.[userId]\n"
                    + "      ,u.[fullname]\n"
                    + "      ,[comment]\n"
                    + "      ,sonOf"
                    + "      ,replyTo"
                    + "      ,[createdAt]\n"
                    + "      ,[editedAt]\n"
                    + "      ,[status]"
                    + "  FROM [Comment] c"
                    + " INNER JOIN [User] u ON c.[userId] = u.[id]"
                    + " WHERE c.[id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, objectId);
            rs = stm.executeQuery();
            if (rs.next()) {
                Comment cm = new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3),
                         rs.getString(5), rs.getTimestamp(8), rs.getBoolean(10));
                cm.setSonOf(rs.getInt(6));
                cm.setReplyTo(rs.getInt(7));
                cm.setEditedAt(rs.getTimestamp(9));
                User user = new User();
                user.setId(rs.getInt(3));
                user.setName(rs.getString(4));
                cm.setUser(user);
                return cm;
            }

        } catch (Exception e) {
            System.out.println("load error:" + e.getMessage());
        }
        return null;
    }

    public void banComment(int commentId) {
        try {
            String sql = "UPDATE [Comment]"
                    + "      SET [status] = 0"
                    + "    WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, commentId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteComment(int bId, int uId, int cmtId) {
        try {
            String sql = "DELETE FROM [dbo].[Comment]\n"
                    + "      WHERE id='" + cmtId + "' and bookId='" + bId + "' and  userId='" + uId + "' ";
            stm = cnn.prepareStatement(sql);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete Comment Error: ");
        }
    }

    public void editComment(int bookId, int userId, int cmtId, String newComment, Timestamp updateTime) {
        try {
            String sql = "UPDATE [dbo].[Comment]\n"
                    + "   SET [comment] ='" + newComment + "',"
                    + "       [editedAt] ='" + updateTime + "' "
                    + "   WHERE id='" + cmtId + "' " //                    + " and bookId='"+bookId+"' and userId='"+userId+"'";
                    ;
            stm = cnn.prepareStatement(sql);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Edit Comment Error: ");
        }
    }

    public int findMotherComment(int cmtId) {
        int motherId = 0;
        try {

        } catch (Exception e) {
            System.out.println("Find Mother Comment Error: ");
        }
        return motherId;
    }

    public void replyComment(int bookId, int userId, String reply, int sonOf, int replyTo, Timestamp time) {
        try {
            String sql = "INSERT INTO [dbo].[Comment]\n"
                    + "           ([bookId]\n"
                    + "           ,[userId]\n"
                    + "           ,[comment]\n"
                    + "           ,[sonOf]\n"
                    + "           ,[replyTo]\n"
                    + "           ,[createdAt])\n"
                    + " VALUES\n"
                    + "           ('" + bookId + "'\n"
                    + "           ,'" + userId + "'\n"
                    + "           ,'" + reply + "'\n"
                    + "           ,'" + sonOf + "'\n"
                    + "           ,'" + replyTo + "'\n"
                    + "           ,'" + time + "')\n";
            stm = cnn.prepareStatement(sql);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Add Reply Error: ");
        }
    }

    private ArrayList<Comment> getCommentReplies(int cId) {
        ArrayList<Comment> list = new ArrayList<>();
        try {
            String sql = "SELECT c.[id]"
                    + "      ,c.[bookId]\n"
                    + "      ,c.[userId]\n"
                    + "      ,u.[fullname]\n"
                    + "      ,c.[comment]\n"
                    + "      ,c.[createdAt]\n"
                    + "      ,c.[status]\n"
                    + "      ,c.[sonOf]"
                    + "      ,c.[replyTo]"
                    + "      ,c.[editedAt]"
                    + "      ,uu.[fullname]"
                    + "  FROM [Comment] c"
                    + " INNER JOIN [User] u ON c.[userId] = u.[id]"
                    + " INNER JOIN [Comment] cc ON c.[replyTo] = cc.[id]"
                    + " INNER JOIN [User] uu ON cc.[userId] = uu.[id]"
                    + " WHERE c.[sonOf] = ? "
                    + " ORDER BY [createdAt]";
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setInt(1, cId);
            ResultSet re = pre.executeQuery();
            while (re.next()) {
                Comment cm = new Comment(re.getInt(1), re.getInt(2), re.getInt(3),
                         re.getString(5), re.getTimestamp(6), re.getBoolean(7));
                cm.setSonOf(re.getInt(8));
                cm.setReplyTo(re.getInt(9));
                cm.setEditedAt(re.getTimestamp(10));
                User user = new User();
                user.setName(re.getString(4));
                cm.setUser(user);
                cm.setReplyName(re.getString(11));
                list.add(cm);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int countByBook(int bookId) {
        try {
            String sql = "SELECT COUNT( [id])\n"
                    + "  FROM [dbo].[Comment]\n"
                    + "  WHERE bookId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
