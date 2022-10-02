/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Comment;
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
    
    public void addComment(int bid, int uid, String comment){
        try {
            String sql ="INSERT [Comment] VALUES ([bid]='"+bid+"',[uid]='"+uid+"',[comment]='"+comment+"');";
            stm=cnn.prepareStatement(sql);
            rs=stm.executeQuery();
            
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }
    
    public ArrayList<Comment> loadComment(int bid){
        ArrayList<Comment> list=new ArrayList<>();
        try {
            String sql ="SELECT * FROM [Comment] WHERE [bid]='"+bid+"'";
            stm=cnn.prepareStatement(sql);
            rs=stm.executeQuery();
            if(rs.next()){
                int uid=rs.getInt(2);
                String cmt=rs.getString(3);
                list.add(new Comment(bid,uid,cmt));
            }
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
        return list;
    }
    
}
