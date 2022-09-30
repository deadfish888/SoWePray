/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Book;
import Model.Content;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
public class ContentDAO {

    public ContentDAO() {
        connectDB();
    }

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully Content!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public ArrayList<Content> getContentByChapterID(int bid) {
        ArrayList<Content> list = new ArrayList<>();
        try {
            String sql = "select * from Content where chapterId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int chapterID = rs.getInt(1);
                int paragraph = rs.getInt(2);
                String content = rs.getString(3);
                list.add(new Content(chapterID, paragraph, content));
            }
        } catch (Exception e) {
            System.out.println("getContentByChapterID Error:" + e.getMessage());
        }
        return list;
    }

    public String getContentByChapterIdAndParagraph(int chapterId, int para) {
        try {
            String sql = "select content from [Content] where [chapterId] = ? and [paragraph] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            stm.setInt(2, para);
            rs = stm.executeQuery();
            if (rs.next()) {
                String content = rs.getString(3);
                return content;
            }
        } catch (Exception e) {
            System.out.println("getContentByChapterIdAndParagraphError" + e.getMessage());
        }
        return null;
    }
    
    public ArrayList<Content> getFirstChapterofBook(int bid) {
        ArrayList<Content> list = new ArrayList<>();
        try {
            String sql = "select c.* from Content c, chapter v where v.chapter = 1 and v.bookId = ? and v.id = c.chapterId";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int chapterID = rs.getInt(1);
                int paragraph = rs.getInt(2);
                String content = rs.getString(3);
                list.add(new Content(chapterID, paragraph, content));
            }
        } catch (Exception e) {
            System.out.println("getFirstChapterofBook Error:" + e.getMessage());
        }
        return list;
    }
    

    
    
    
}
