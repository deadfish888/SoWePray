/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product.content;

import Model.product.Author;
import Model.product.Book;
import Model.product.Product;
import Model.product.content.Chapter;
import Model.product.content.Volume;
import context.DBContext;
import context.product.BookDAO;
import context.product.ProductDAO;
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
            
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public ArrayList<Chapter> getChaptersByBookId(int bookId) {
        ArrayList<Chapter> chaps = new ArrayList<>();
        try {
            String sql = "SELECT c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE [bookId] = ? "
                    + " ORDER BY v.[no], c.[no] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(6));
                volume.setTitle(rs.getString(7));
                volume.setBookId(bookId);

                Book book = new Book();
                book.setId(bookId);
                book.setTitle(rs.getString(8));

                Author author = new Author();
                author.setName(rs.getString(9));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);
                chaps.add(chap);
            }
            return chaps;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Chapter getChapterById(int chapterId) {
        try {
            String sql = "SELECT c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,c.[content]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[id] as [bookId]"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE c.[id] = ?"
                    + " ORDER BY v.[no], c.[no] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));
                chap.setContent(rs.getString(6));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(7));
                volume.setTitle(rs.getString(8));
                volume.setBookId(rs.getInt(9));

                Book book = new Book();
                book.setId(rs.getInt(9));
                book.setTitle(rs.getString(10));

                Author author = new Author();
                author.setName(rs.getString(11));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);
                
                chap.setPrev(getPreviousChapter(rs.getInt(9), chap.getVolume().getNo(),chap.getNo()));
                
                chap.setNext(getNextChapter(rs.getInt(9),chap.getVolume().getNo(),chap.getNo()));

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
                    + "           ([volumeId]"
                    + "           ,[no]\n"
                    + "           ,[title]\n"
                    + "           ,[status]\n"
                    + "           ,[content])\n"
                    + "     OUTPUT [Inserted].[id]"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , (SELECT COALESCE(MAX([no]), 0) FROM [dbo].[Chapter] WHERE [volumeId] = ?)+1 "
                    + "           , ? "
                    + "           , ? "
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter.getVolumeId());
            stm.setInt(2, chapter.getVolumeId());
            stm.setString(3, chapter.getTitle());
            stm.setBoolean(4, chapter.isStatus());
            stm.setString(5, chapter.getContent());
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int addChapterNovel(Chapter chapter) {
        try {
            String sql = "INSERT INTO [dbo].[Chapter]\n"
                    + "           ([volumeId]"
                    + "           ,[no]\n"
                    + "           ,[title]\n"
                    + "           ,[status]\n"
                    + "           ,[content])\n"
                    + "     OUTPUT [Inserted].[id]"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , (SELECT COALESCE(MAX([no]), 0) FROM [Chapter] WHERE [volumeId] = ?)+1 "
                    + "           , ? "
                    + "           , ? "
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter.getVolumeId());
            stm.setInt(2, chapter.getVolumeId());
            stm.setString(3, chapter.getTitle());
            stm.setBoolean(4, chapter.isStatus());
            stm.setString(5, chapter.getContent());
            rs = stm.executeQuery();
            if (rs.next()) {
                BookDAO bookDAO = new BookDAO();
                Book book = bookDAO.getByVolume(chapter.getVolumeId());

                ProductDAO productDAO = new ProductDAO();
                ChapterDAO cd = new ChapterDAO();
                Product product = new Product("B" + book.getId() + "-C" + cd.getChapterNo(rs.getInt(1)));
                product.setBook(book);
                chapter.setId(rs.getInt(1));
                product.setChapter(chapter);product.caculatePrice();
                productDAO.insert(product);
                productDAO.updateBookPrice(book);
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Chapter getLatestChapter(int bookId) {
        try {
            String sql = "SELECT TOP 1 c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,c.[content]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[id] as [bookId]"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE b.[id] = ?"
                    + " ORDER BY c.[id] DESC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));
                chap.setContent(rs.getString(6));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(7));
                volume.setTitle(rs.getString(8));
                volume.setBookId(rs.getInt(9));

                Book book = new Book();
                book.setId(rs.getInt(9));
                book.setTitle(rs.getString(10));

                Author author = new Author();
                author.setName(rs.getString(11));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);

                return chap;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int editChapter(Chapter chapter) {
        try {
            String sql = "UPDATE [dbo].[Chapter]\n"
                    + "   SET [title] = ? "
                    + "      ,[status] = ?"
                    + "      ,[content] = ? "
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, chapter.getTitle());
            stm.setBoolean(2, chapter.isStatus());
            stm.setString(3, chapter.getContent());
            stm.setInt(4, chapter.getId());
            int n = stm.executeUpdate();
            
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int editChapterNovel(Chapter chapter) {
        try {
            String sql = "UPDATE [dbo].[Chapter]\n"
                    + "   SET [title] = ? "
                    + "      ,[status] = ?"
                    + "      ,[content] = ? "
                    + " OUTPUT [deleted].[status]"
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, chapter.getTitle());
            stm.setBoolean(2, chapter.isStatus());
            stm.setString(3, chapter.getContent());
            stm.setInt(4, chapter.getId());
            rs = stm.executeQuery();
            if (rs.next() && !rs.getBoolean(1)) {
                BookDAO bookDAO = new BookDAO();
                Book book = bookDAO.getByVolume(chapter.getVolumeId());

                ProductDAO productDAO = new ProductDAO();
                Product product = new Product("B" + book.getId() + "-C" + chapter.getNo());
                product.setBook(book);
                product.setChapter(chapter);
                product.caculatePrice();
                productDAO.update(product);
                productDAO.updateBookPrice(book);
            }
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int deleteChapter(int chapterId) {
        try {
            String sql = "DELETE FROM [dbo].[Chapter]\n"
                    + "     OUTPUT [deleted].[volumeId], [deleted].[no] "
                    + "      WHERE [id] = ? ";
            ProductDAO productDAO = new ProductDAO();
            productDAO.deleteByChapter(chapterId);
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            rs = stm.executeQuery();
            if(rs.next()){
                sql = "UPDATE [Chapter]"
                        + "SET [no] = [no] -1 "
                        + "WHERE [volumeId] = "+rs.getInt(1)
                        +"   AND [no] > "+rs.getInt(2);
                stm.close();
                stm = cnn.prepareStatement(sql);
                stm.executeUpdate();
            }
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
            
        }
        return 0;
    }

    public Chapter getFirstChapter(int bookId) {
        try {
            String sql = "SELECT TOP 1 c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,[content]"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE [bookId] = ?"
                    + " ORDER BY v.[no], c.[no] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));
                chap.setContent(rs.getString(6));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(7));
                volume.setTitle(rs.getString(8));
                volume.setBookId(bookId);

                Book book = new Book();
                book.setId(bookId);
                book.setTitle(rs.getString(9));

                Author author = new Author();
                author.setName(rs.getString(10));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);
                   
                chap.setPrev(getPreviousChapter(bookId, chap.getVolume().getNo(),chap.getNo()));
                
                chap.setNext(getNextChapter(bookId,chap.getVolume().getNo(),chap.getNo()));
                return chap;
            }
        } catch (Exception e) {
            System.out.println("getFirstChapter " + e.getMessage());
        }
        return null;
    }

    public int getChapterNo(int id) {

        try {
            String sql = "SELECT [no]\n"
                    + "  FROM [Chapter]"
                    + "  WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if(rs.next()) {
                return rs.getInt("no");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Chapter> getChaptersByVolumeId(int volumeId) {
        ArrayList<Chapter> chaps = new ArrayList<>();
        try {
            String sql = "SELECT c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "      ,b.[id]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE [volumeId] = ?"
                    + " ORDER BY v.[no], c.[no] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, volumeId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(6));
                volume.setTitle(rs.getString(7));
                volume.setBookId(rs.getInt(10));

                Book book = new Book();
                book.setId(rs.getInt(10));
                book.setTitle(rs.getString(8));

                Author author = new Author();
                author.setName(rs.getString(9));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);
                chaps.add(chap);
            }
            return chaps;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    private Chapter getPreviousChapter(int bookId, int volNo, int chapNo) {
        if (volNo == 1 && chapNo == 1) return null;
        try {
            String sql = "SELECT TOP 1 c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,c.[content]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[id] as [bookId]"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE v.[no] = ? "
                    + "   AND b.[id] = ?";
            if(chapNo != 1){
                sql+= " AND c.[no] = ? ";
            }
                    sql+= " ORDER BY c.[no] DESC";
            stm = cnn.prepareStatement(sql);
            if (chapNo == 1){
                stm.setInt(1, volNo-1);
            }else{
                stm.setInt(1, volNo);
                stm.setInt(3, chapNo-1);
            }
            stm.setInt(2, bookId);
            ResultSet ss = stm.executeQuery();
            while (ss.next()) {
                Chapter chap = new Chapter();
                chap.setId(ss.getInt(1));
                chap.setVolumeId(ss.getInt(2));
                chap.setNo(ss.getInt(3));
                chap.setTitle(ss.getString(4));
                chap.setStatus(ss.getBoolean(5));
                chap.setContent(ss.getString(6));

                Volume volume = new Volume();
                volume.setId(ss.getInt(2));
                volume.setNo(ss.getInt(7));
                volume.setTitle(ss.getString(8));
                volume.setBookId(ss.getInt(9));

                Book book = new Book();
                book.setId(ss.getInt(9));
                book.setTitle(ss.getString(10));

                Author author = new Author();
                author.setName(ss.getString(11));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);

                return chap;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    private Chapter getNextChapter(int bookId, int volNo, int chapNo) {
        try {
            String sql = "SELECT TOP 1 c.[id]\n"
                    + "      ,[volumeId]\n"
                    + "      ,c.[no] as [chapterNo]\n"
                    + "      ,c.[title] as [chapterTitle]\n"
                    + "      ,c.[status]\n"
                    + "      ,c.[content]\n"
                    + "      ,v.[no] as [volumeNo]\n"
                    + "      ,v.[title] as [volumeTitle]\n"
                    + "      ,b.[id] as [bookId]"
                    + "      ,b.[title] as [bookTitle] "
                    + "      ,a.[name] as [author]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " INNER JOIN [Author] a ON b.[authorId] = a.[id] "
                    + " WHERE v.[no] = ? "
                    + " AND c.[no] = ? "
                    + " AND b.[id] =? "
                    + " ORDER BY c.[no] ASC";
            stm = cnn.prepareStatement(sql);
                stm.setInt(1, volNo);
                stm.setInt(2, chapNo+1);
                stm.setInt(3, bookId);
            rs = stm.executeQuery();
            boolean check =rs.next();
            if (!check) {
                rs.close();
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, volNo+1);
                stm.setInt(2, 1);
                stm.setInt(3, bookId);
                rs = stm.executeQuery();
                check = rs.next();
            }
            if(check){
                Chapter chap = new Chapter();
                chap.setId(rs.getInt(1));
                chap.setVolumeId(rs.getInt(2));
                chap.setNo(rs.getInt(3));
                chap.setTitle(rs.getString(4));
                chap.setStatus(rs.getBoolean(5));
                chap.setContent(rs.getString(6));

                Volume volume = new Volume();
                volume.setId(rs.getInt(2));
                volume.setNo(rs.getInt(7));
                volume.setTitle(rs.getString(8));
                volume.setBookId(rs.getInt(9));

                Book book = new Book();
                book.setId(rs.getInt(9));
                book.setTitle(rs.getString(10));

                Author author = new Author();
                author.setName(rs.getString(11));

                book.setAuthor(author);

                volume.setBook(book);

                chap.setVolume(volume);

                return chap;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
                    
        }
        return null;
    }

    public int countWordsByBookId(int bookId) {
        int total=0;
        try {
            String sql = "SELECT [content]"
                    + "  FROM [Chapter] c "
                    + " INNER JOIN [Volume] v ON c.[volumeId] = v.[id] "
                    + " INNER JOIN [Book] b ON v.[bookId] = b.[id]"
                    + " WHERE b.[id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                String content = rs.getString(1);
                int number = content.split("\\s+").length;
                total += number;
            }
            return total;
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    private boolean checkChapterNovelDone(Chapter chapter) {
        try {
            String sql ="SELECT [status]"
                    + "    FROM [Chapter]"
                    + "   WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter.getId());
            rs = stm.executeQuery();
            if (rs.next()) return rs.getBoolean(1);
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

}
