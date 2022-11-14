/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product.content;

import Model.product.Author;
import Model.product.Book;
import Model.product.content.Volume;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class VolumeDAO {

    public VolumeDAO() {
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

    public ArrayList<Volume> getVolumesByBookId(int bookId) {
        ArrayList<Volume> vols = new ArrayList<>();
        try {
            String sql = "SELECT v.[id]\n"
                    + "      ,[no]\n"
                    + "      , v.[title] as [volumeTitle]\n"
                    + "      ,[summary]\n"
                    + "      , b.[title] as [bookTitle] "
                    + "      , a.[name] as [author]"
                    + "      , b.[image]"
                    + "      , a.[id]"
                    + "  FROM [Volume] v "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id] "
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE [bookId] = ? "
                    + " ORDER BY [no] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int no = rs.getInt(2);
                String volumeTitle = rs.getString(3);
                String summary = rs.getString(4);
                Volume volume = new Volume();
                volume.setId(id);
                volume.setNo(no);
                volume.setTitle(volumeTitle);
                volume.setSummary(summary);
                volume.setBookId(bookId);
                Book book = new Book();
                book.setId(bookId);
                book.setTitle(rs.getString(5));
                book.setImage(rs.getString(7));
                Author author = new Author();
                author.setName(rs.getString(6));
                author.setId(rs.getInt(8));
                book.setAuthor(author);
                volume.setBook(book);
                ChapterDAO cd = new ChapterDAO();
                volume.setChapters(cd.getChaptersByVolumeId(id));
                vols.add(volume);
            }
            return vols;
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Volume getVolumeById(int vid) {
        try {
            String sql = "SELECT v.[id]\n"
                    +"       ,[bookId]"
                    + "      ,[no]\n"
                    + "      , v.[title] as [volumeTitle]\n"
                    + "      ,[summary]\n"
                    + "      , b.[title] as [bookTitle] "
                    + "      , a.[name] as [author]"
                    + "  FROM [Volume] v "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id] "
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE v.[id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, vid);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                int bookId = rs.getInt(2);
                int no = rs.getInt(3);
                String volumeTitle = rs.getString(4);
                String summary = rs.getString(5);

                Volume volume = new Volume();
                volume.setId(id);
                volume.setBookId(bookId);
                volume.setNo(no);
                volume.setTitle(volumeTitle);
                volume.setSummary(summary);

                Book book = new Book();
                book.setId(bookId);
                book.setTitle(rs.getString(6));
                Author author = new Author();
                author.setName(rs.getString(7));
                book.setAuthor(author);
                volume.setBook(book);
                
                return volume;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int addVolume(Volume volume) {
        try {
            String sql = "INSERT INTO [dbo].[Volume]\n"
                    + "           ([bookId]\n"
                    + "           ,[no]\n"
                    + "           ,[title]\n"
                    + "           ,[summary])\n"
                    + "     OUTPUT [inserted].[id]"
                    + "     VALUES ( ?"
                    + "             , (SELECT COALESCE(MAX([no]), 0) FROM [dbo].[Volume] WHERE [bookId] = ?)+1"
                    + "             , ?"
                    + "             , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, volume.getBookId());
            stm.setInt(2, volume.getBookId());
            stm.setString(3, volume.getTitle());
            if (!volume.getSummary().equals("")) {
                stm.setString(4, volume.getSummary());
            } else {
                stm.setNull(4, Types.NVARCHAR);
            }
            rs = stm.executeQuery();
            if(rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Volume getLatestVolume(int bookId) {
        try {
            String sql = "SELECT TOP 1 [id]\n"
                    + "      ,[bookId]\n"
                    + "      ,[no]\n"
                    + "      ,[title]\n"
                    + "      ,[summary]\n"
                    + "  FROM [Volume]"
                    + " WHERE [bookId] = ? "
                    + " ORDER BY [no] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int no = rs.getInt(3);
                String volumeName = rs.getString(4);
                String summary = rs.getString(5);

                Volume volume = new Volume();
                volume.setId(id);
                volume.setBookId(bookId);
                volume.setNo(no);
                volume.setTitle(volumeName);
                volume.setSummary(summary);

                return volume;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int editVolume(Volume volume) {
        try {
            String sql = "UPDATE [dbo].[Volume]\n"
                    + "   SET [title] = ? "
                    + "      ,[summary] = ? "
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, volume.getTitle());
            if (!volume.getSummary().equals("")) {
                stm.setString(2, volume.getSummary());
            } else {
                stm.setNull(2, Types.NVARCHAR);
            }
            stm.setInt(3, volume.getId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int deleteVolumeAndItsChapter(int volumeId) {
        try {
            String sql = "DELETE FROM [dbo].[Volume]\n"
                    + "      OUTPUT [deleted].[bookId], [deleted].[no]"
                    + "      WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, volumeId);
            rs = stm.executeQuery();
            if(rs.next()){
                sql = "UPDATE [Volume] "
                        + " SET [no] = [no]-1"
                        + " WHERE [bookId] = "+rs.getInt(1)
                        +"    AND [no] > "+rs.getInt(2);
                stm.close();
                stm = cnn.prepareStatement(sql);
                stm.executeUpdate();
            }
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
