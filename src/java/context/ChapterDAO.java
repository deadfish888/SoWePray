/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Chapter;
import Model.Volume;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class ChapterDAO {

    public ChapterDAO() {
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

    public ArrayList<Chapter> getAllChapter(int bookId) {
        ArrayList<Chapter> chaps = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,[chapter]\n"
                    + "      ,[chapterName]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Chapter]"
                    + " WHERE [bookId] = ?"
                    + " ORDER BY [chapter] asc";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int volumeId = rs.getInt(2);
                int no = rs.getInt(3);
                String chapterName = rs.getString(4);
                boolean status = rs.getBoolean(5);

                Chapter chap = new Chapter();
                chap.setId(id);
                chap.setVolumeID(volumeId);
                chap.setChapter(no);
                chap.setChapterName(chapterName);
                chap.setStatus(status);
                chaps.add(chap);
            }
            return chaps;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Chapter getChapter(int chapterId) {
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[bookId]\n"
                    + "      ,[volumeId]\n"
                    + "      ,[chapter]\n"
                    + "      ,[chapterName]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Chapter]"
                    + " WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int bookId =rs.getInt(2);
                int volumeId = rs.getInt(3);
                int no = rs.getInt(4);
                String chapterName = rs.getString(5);
                boolean status = rs.getBoolean(6);

                Chapter chap = new Chapter();
                chap.setId(id);
                chap.setBookID(bookId);
                chap.setVolumeID(volumeId);
                chap.setChapter(no);
                chap.setChapterName(chapterName);
                chap.setStatus(status);
                
                return chap;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
