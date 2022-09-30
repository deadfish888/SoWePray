/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Chapter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
public class ChapterDAO {
    
    public ChapterDAO(){
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
    
    public ArrayList<Chapter> getAllChapters(){
        ArrayList<Chapter> list = new ArrayList<>();
        try {
            String sql = "select * from [Chapter]";
            stm= cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int bookID = rs.getInt(2);
                int volumeID = rs.getInt(3);
                int chapter = rs.getInt(4);
                String chapterName = rs.getString(5);
                String status = "Done";
                if(rs.getBoolean(6)==false) status = "On-going";
                list.add(new Chapter(id, bookID, volumeID, chapter, chapterName, status));
                            }
        } catch (Exception e) {
            System.out.println("getAllChapter Error:" + e.getMessage());
        }
        return list;
    }
    
    public ArrayList<Chapter> getChapterByBookID(int bID){
        ArrayList<Chapter> list = new ArrayList<>();
        try {
            String sql = "select * from [Chapter] where [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int bookID = rs.getInt(2);
                int volumeID = rs.getInt(3);
                int chapter = rs.getInt(4);
                String chapterName = rs.getString(5);
                String status = "Done";
                if(rs.getBoolean(6)==false) status = "On-going";
                list.add(new Chapter(id, bookID, volumeID, chapter, chapterName, status));
            }
        } catch (Exception e) {
            System.out.println("getChapterByBookID Error:" + e.getMessage());
        }
        return list;
    }
    
    public ArrayList<Chapter> getChapterByVolumeIDandBookID(int volID, int bID){
        ArrayList<Chapter> list = new ArrayList<>();
        try {
            String sql = "select * from [Chapter] where [volumeId] = ? and [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, volID);
            stm.setInt(2, bID);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                int bookID = rs.getInt(2);
                int volumeID = rs.getInt(3);
                int chapter = rs.getInt(4);
                String chapterName = rs.getString(5);
                String status = "Done";
                if(rs.getBoolean(6)==false) status = "On-going";
                list.add(new Chapter(id, bookID, volumeID, chapter, chapterName, status));
            }
        } catch (Exception e) {
            System.out.println("getChapterByVolumeIDandBookID:" + e.getMessage());
        }
        return null;
    }
    
     public int getChapterIDbyChapterAndBookID(int chapter, int bid){
        try {
            String sql = "select c.id from Chapter c where chapter = ? and bookId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter);
            stm.setInt(2, bid);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                return id;
            }
        } catch (Exception e) {
            System.out.println("getChapterIDbyChapterAndBookID: " + e.getMessage());
        }
        return 0;
    
    }
    
    
    
   
    
}
