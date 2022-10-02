/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Rating;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ttaad
 */
public class RatingDAO {
    public RatingDAO() {
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
    
    public float getAverageStar(int bid){
        
        ArrayList<Rating> list = getStarList(bid);
        int sum=0;
        for(int i=0;i<list.size();i++){
            sum+=list.get(i).getStar();
        }
        float star=sum/list.size();       
        return star;
    }
    
    public void sendRatetoBook(int bid, float star){
        try {
            String sql = "UPDATE [Book] SET [rate]='"+star+"' WHERE [bid]='"+bid+"'";           
            stm= cnn.prepareStatement(sql);
            stm.executeUpdate(sql);
        } catch (Exception e) {
           System.out.println("Connect error:" + e.getMessage());
        }
    }
    
    public void addStar(int bid,int uid, int star){
        try {
            String sql = "INSERT INTO [Star] VALUES ([bid]='"+bid+"',[uid]='"+uid+"',[star]='"+star+"')";
            stm= cnn.prepareStatement(sql);
            stm.executeUpdate(sql);
            System.out.println("Add Success!!");
        } catch (Exception e) {
           System.out.println("Connect error:" + e.getMessage());
        }
    }
    
    public void updateStar(int bid, int uid, int star){
        try {
            String sql = "UPDATE [Star] SET [star]='"+star+"' WHERE [bid]='"+bid+"' and [uid]='"+uid+"'";
            stm= cnn.prepareStatement(sql);
            stm.executeUpdate(sql);
        } catch (Exception e) {
           System.out.println("Connect error:" + e.getMessage());
        }
    }
    
    public boolean checkExist(int bid,int uid){
        try {
            String sql = "SELECT * FROM [Star] WHERE [bid]='"+bid+"',uid='"+uid+"'";
            stm= cnn.prepareStatement(sql);
             rs = stm.executeQuery();
             if(rs.next()){
                 return true;
             }    
        } catch (Exception e) {
           System.out.println("Connect error:" + e.getMessage());
        }
        return false;
    }
    
    
    public ArrayList<Rating> getStarList(int bid){
        ArrayList<Rating> list_r=new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Star] WHERE [bid]='"+bid+"'";
            stm= cnn.prepareStatement(sql);
             rs = stm.executeQuery();
             if(rs.next()){
                 int uid=rs.getInt(2);
                 int star=rs.getInt(3);
                 list_r.add(new Rating(bid, uid, star));
             }    
        } catch (Exception e) {
           System.out.println("Connect error:" + e.getMessage());
        }
        return list_r;
    }
}
