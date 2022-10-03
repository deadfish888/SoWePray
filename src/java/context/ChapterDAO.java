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
import java.sql.Types;
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
                chap.setBookID(bookId);
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
                    + "      ,[content]\n"
                    + "  FROM [dbo].[Chapter]"
                    + " WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int bookId = rs.getInt(2);
                int volumeId = rs.getInt(3);
                int no = rs.getInt(4);
                String chapterName = rs.getString(5);
                boolean status = rs.getBoolean(6);
                String content = rs.getString(7);

                Chapter chap = new Chapter();
                chap.setId(id);
                chap.setBookID(bookId);
                chap.setVolumeID(volumeId);
                chap.setChapter(no);
                chap.setChapterName(chapterName);
                chap.setStatus(status);
                chap.setContent(content);
                return chap;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int addChapter(Chapter chapter) {
        try {
            String sql = "INSERT INTO [dbo].[Chapter]\n"
                    + "           ([bookId]\n"
                    + "           ,[volumeId]\n"
                    + "           ,[chapter]\n"
                    + "           ,[chapterName]\n"
                    + "           ,[status]\n"
                    + "           ,[content])\n"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , ? "
                    + "           , (SELECT COUNT([chapter]) FROM [dbo].[Chapter] WHERE [volumeId] = ?)+1 "
                    + "           , ? "
                    + "           , ? "
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter.getBookID());
            stm.setInt(2, chapter.getVolumeID());
            stm.setInt(3, chapter.getVolumeID());
            stm.setString(4, chapter.getChapterName());
            stm.setBoolean(5, chapter.isStatus());
            stm.setString(6, chapter.getContent());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Chapter getNewChapter(int bookId) {
        try {
            String sql = "SELECT TOP 1 [id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,[chapter]\n"
                    + "      ,[chapterName]\n"
                    + "      ,[status]\n"
                    + "      ,[content]\n"
                    + "  FROM [dbo].[Chapter]"
                    + "WHERE [bookId] = ? "
                    + "ORDER BY [chapter] DESC ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                int no = rs.getInt(3);
                String chapterName = rs.getString(4);
                boolean status = rs.getBoolean(5);
                String content = rs.getString(6);

                Chapter chapter = new Chapter();
                chapter.setId(id);
                chapter.setBookID(bookId);
                chapter.setChapterName(chapterName);
                chapter.setChapter(no);
                chapter.setStatus(status);
                chapter.setContent(content);
                return chapter;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int editChapter(Chapter chapter) {
        try {
            String sql = "UPDATE [dbo].[Chapter]\n"
                    + "   SET [chapterName] = ? "
                    + "      ,[status] = ?"
                    + "      ,[content] = ? "
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, chapter.getChapterName());
            stm.setBoolean(2, chapter.isStatus());
            if (!chapter.getContent().equals("")) {
                stm.setString(3, chapter.getContent());
            } else {
                stm.setNull(3, Types.NVARCHAR);
            }
            stm.setInt(4, chapter.getId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int deleteChapter(int chapterId) {
        try {
            String sql = "DELETE FROM [dbo].[Chapter]\n"
                    + "      WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Chapter getFirstChapterId(int bookId) {
        try {
            String sql = "SELECT TOP 1 [id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,[chapter]\n"
                    + "      ,[chapterName]\n"
                    + "      ,[status]\n"
                    + "      ,[content]\n"
                    + "  FROM [dbo].[Chapter]"
                    + "WHERE [bookId] = ? "
                    + "ORDER BY [chapter] ASC ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                int no = rs.getInt(3);
                String chapterName = rs.getString(4);
                boolean status = rs.getBoolean(5);
                String content = rs.getString(6);

                Chapter chapter = new Chapter();
                chapter.setId(id);
                chapter.setBookID(bookId);
                chapter.setChapterName(chapterName);
                chapter.setChapter(no);
                chapter.setStatus(status);
                chapter.setContent(content);
                return chapter;
            }
        } catch (Exception e) {
            System.out.println("getChapterIDbyChapterAndBookID: " + e.getMessage());
        }
        return null;
    }

}
