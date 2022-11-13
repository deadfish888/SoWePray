/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Book;
import Model.auth.User;
import Model.product.Author;
import Model.product.BookOwn;
import Model.product.content.Chapter;
import context.DBContext;
import context.product.content.ChapterDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class BookOwnDAO {

    public BookOwnDAO() {
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

    public ArrayList<Book> getOwnBooks(User user) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "  select bo.bookId"
                    + "      ,b.[title]\n"
                    + "      ,b.[authorId]\n"
                    + "      ,b.[rating]\n"
                    + "      ,b.[favourite]\n"
                    + "      ,b.[price]\n"
                    + "      ,b.[is_sale]\n"
                    + "      ,b.[image]\n"
                    + "      ,b.[description]\n"
                    + "      ,b.[views]\n"
                    + "      ,b.[status] "
                    + "  from [User] u \n"
                    + "  inner join [Book_Own] bo \n"
                    + "  on bo.userId = u.id\n"
                    + "  inner join Book b\n"
                    + "  on bo.bookId = b.id"
                    + "  where u.id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
//                int id = rs.getInt("bookId");
                Book book = new Book();
                Author author = new Author();
                author.setId(rs.getInt("authorId"));
                book.setAuthor(author);
                book.setId(rs.getInt("bookId"));
                book.setTitle(rs.getString("title"));
                book.setRating(rs.getFloat("rating"));
                book.setFavourite(rs.getInt("favourite"));
                book.setPrice(rs.getFloat("price"));
                book.setIssale(rs.getBoolean("is_sale"));
                book.setImage(rs.getString("image"));
                book.setDescription(rs.getString("description"));
                book.setViews(rs.getInt("views"));
                book.setStatus(rs.getBoolean("status"));
//                Book book = getBookById(id);
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getOwn Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Book> getOwnBooksPagging(User user, int pageSize, int pageIndex) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select bo.bookId      "
                    + ",b.[title]      "
                    + ",b.[authorId]      "
                    + ",b.[rating]\n"
                    + ",b.[favourite]\n"
                    + ",b.[price]\n"
                    + ",b.[is_sale]\n"
                    + ",b.[image]\n"
                    + ",b.[description]\n"
                    + ",b.[views]\n"
                    + ",b.[status]\n"
                    + "from [Book_Own] bo\n"
                    + "inner join Book b\n"
                    + "on bo.bookId = b.id\n"
                    + "where bo.userId = ?\n"
                    + " ORDER BY b.id ASC \n"
                    + "OFFSET ? * (?-1) ROWS  FETCH NEXT ?\n"
                    + "ROWS ONLY";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);
            rs = stm.executeQuery();
            while (rs.next()) {
//                int id = rs.getInt("bookId");
                Book book = new Book();
                Author author = new Author();
                author.setId(rs.getInt("authorId"));
                book.setAuthor(author);
                book.setId(rs.getInt("bookId"));
                book.setTitle(rs.getString("title"));
                book.setRating(rs.getFloat("rating"));
                book.setFavourite(rs.getInt("favourite"));
                book.setPrice(rs.getFloat("price"));
                book.setIssale(rs.getBoolean("is_sale"));
                book.setImage(rs.getString("image"));
                book.setDescription(rs.getString("description"));
                book.setViews(rs.getInt("views"));
                book.setStatus(rs.getBoolean("status"));
//                Book book = getBookById(id);
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getOwn Error:" + e.getMessage());
        }
        return list;
    }

    public void insert(Book book, User user) {
        try {
            String sql = "INSERT INTO [Book_Own]\n"
                    + "           ([userId]\n"
                    + "           ,[bookId])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setInt(2, book.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int count(User user) {
        try {
            String sql = "SELECT COUNT(*) as total FROM [Book_Own]"
                    + "  WHERE userId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;

    }

    public BookOwn get(User user, Book book) {
        BookOwn bookOwn = null;
        ChapterDAO chapterDAO = new ChapterDAO();
        try {
            String sql = "SELECT [userId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[recentTime]\n"
                    + "      ,[recentChapterId]\n"
                    + "  FROM [Book_Own]"
                    + "  WHERE [userId] = ?"
                    + "  AND [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setInt(2, book.getId());
            rs = stm.executeQuery();
            if (rs.next()) {
                bookOwn = new BookOwn();
                bookOwn.setBook(book);
                bookOwn.setUser(user);
                if (rs.getTimestamp("recentTime") != null && rs.getObject("recentChapterId") != null) {
                    bookOwn.setRecentTime(rs.getTimestamp("recentTime"));
                    bookOwn.setRecentChapter(chapterDAO.getChapterById(rs.getInt("recentChapterId")));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
            bookOwn = null;
        }
        return bookOwn;
    }

    public void updateReadingStatus(User user, Book book, Chapter chapter) {
        try {
            String sql = "UPDATE [Book_Own]\n"
                    + "      SET [recentTime] = ?\n"
                    + "      ,[recentChapterId] = ?\n"
                    + " WHERE [userId] = ?"
                    + " AND [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setTimestamp(1, new Timestamp(Calendar.getInstance().getTimeInMillis()));
            stm.setInt(2, chapter.getId());
            stm.setInt(3, user.getId());
            stm.setInt(4, book.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
