/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Book;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ttaad */
public class BookDAO {

    public BookDAO() {
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

    public ArrayList<Book> getBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[title]\n"
                    + "      ,[author]\n"
                    + "      ,[categoryid]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Book]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int category = rs.getInt(4);
                float rating = rs.getFloat(5);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                int view = rs.getInt(11);
                Book book = new Book(id, title, author, category, rating, favourite, price, issale, image, description, view);
                book.setStatus(rs.getBoolean(12));
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }

    public int editBook(Book book) {
        String sql = "UPDATE [Book] "
                + "SET [title]= ?"
                + ", [author] = ? "
                + ", [categoryid] = ?"
                + ", [price] = ?"
                + ", [is_sale] = ?"
                + ", [image] = ?"
                + ", [description] = ?"
                + " WHERE [id] = ? ";
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, book.getTitle());
            pre.setString(2, book.getAuthor());
            if(book.getCategoryid()!=0){
                pre.setInt(3, book.getCategoryid());
            }else pre.setNull(3, Types.INTEGER);
            pre.setFloat(4, book.getPrice());
            pre.setBoolean(5, book.issale());
            pre.setString(6, book.getImage());
            pre.setString(7, book.getDescription());
            pre.setInt(8, book.getId());
            return pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return 0;
    }

    public int addBook(Book book) {
        String sql = "INSERT INTO [dbo].[Book]\n"
                + "           ([title]\n"
                + "           ,[author]\n"
                + "           ,[categoryid]\n"
                + "           ,[price]\n"
                + "           ,[is_sale]\n"
                + "           ,[image]\n"
                + "           ,[description])\n"
                + "     VALUES ( ? "
                + "             , ? "
                + "             , ? "
                + "             , ? "
                + "             , ? "
                + "             , ? "
                + "             , ? )";
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, book.getTitle());
            pre.setString(2, book.getAuthor());
            if(book.getCategoryid()!=0){
                pre.setInt(3, book.getCategoryid());
            }else pre.setNull(3, Types.INTEGER);
            pre.setFloat(4, book.getPrice());
            pre.setBoolean(5, book.issale());
            pre.setString(6, book.getImage());
            pre.setString(7, book.getDescription());
            return pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("addBook Error:" + e.getMessage());
        }
        return 0;
    }

    public Book getBookById(int bookId) {
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[title]\n"
                    + "      ,[author]\n"
                    + "      ,[categoryid]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Book]"
                    + "WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int category = rs.getInt(4);
                float rating = rs.getFloat(5);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                int view = rs.getInt(11);
                Book book = new Book(id, title, author, category, rating, favourite, price, issale, image, description, view);
                book.setStatus(rs.getBoolean(12));
                return book;
            }
        } catch (Exception e) {
            System.out.println("getBookbyID Error:" + e.getMessage());
        }
        return null;
    }

    public ArrayList<Book> getSimilarBooks(int bookid, int categoryid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select top 3 * from [Book] "
                    + "where [categoryid] = ? "
                    + "AND [id] != ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, categoryid);
            stm.setInt(2, bookid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int category = rs.getInt(4);
                float rating = rs.getFloat(5);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                int view = rs.getInt(11);
                list.add(new Book(id, title, author, category, rating, favourite, price, issale, image, description, view));
            }
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
        return list;
    }

    public int countBookNumber() {
        try {
            String sql = "select count([id]) from [Book]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberBook Error");
        }
        return -1;
    }

    public ArrayList<Book> getFeaturedBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select * from [Book]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                list.add(new Book(id, title, author, type, favourite, price, issale, image));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        ArrayList<Book> lists = new ArrayList<>();
        Random r = new Random();
        int index[] = new int[15];
        int i = 0, temp;

        while (i < 15) {
            boolean is = true;
            temp = r.nextInt(list.size());
            for (int j = 0; j < i; j++) {
                if (index[j] == temp) {
                    is = false;
                }
            }
            if (is) {
                index[i] = temp;
                lists.add(list.get(temp));
                i++;
            }
        }
        return lists;
    }

    public ArrayList<Book> getByPage(ArrayList<Book> list, int start, int end) {
        ArrayList<Book> listpage = new ArrayList<>();

        for (int i = start; i < end; i++) {
            listpage.add(list.get(i));
        }
        return listpage;
    }

    public ArrayList<Book> getBooksByCid(String cid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Book] "
                                + "WHERE [categoryid] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, Integer.parseInt(cid));
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int category = rs.getInt(4);
                float rating = rs.getFloat(5);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                int view = rs.getInt(11);
                list.add(new Book(id, title, author, category, rating, favourite, price, issale, image, description, view));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }
    
    public ArrayList<Book> getWeeklySaleBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select * from [Book] where [is_sale] = 1";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                list.add(new Book(id, title, author, type, favourite, price, issale, image));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        ArrayList<Book> lists = new ArrayList<>();
        Random r = new Random();
        int index[] = new int[4];
        int i = 0, temp;

        while (i < 4) {
            boolean is = true;
            temp = r.nextInt(list.size());
            for (int j = 0; j < i; j++) {
                if (index[j] == temp) {
                    is = false;
                }
            }
            if (is) {
                index[i] = temp;
                lists.add(list.get(temp));
                i++;
            }
        }
        return lists;
    }

    public ArrayList<Book> getFavouriteBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select top(3)* from BOOK order by favourite desc";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int favourite = rs.getInt(6);
                float price = rs.getFloat(7);
                boolean issale = rs.getBoolean(8);
                String image = rs.getString(9);
                list.add(new Book(id, title, author, type, favourite, price, issale, image));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }

    public void changeStatus(int bookId) {
        try {
            String sql = "UPDATE [Book]"
                    + "      SET [status] = 1 ^ [status] "
                    + "    WHERE [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Book> getOwnBooks(User user) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "  select bo.bookId from [User] u \n"
                    + "  inner join [Book_Own] bo \n"
                    + "  on bo.userId = u.id\n"
                    + "  inner join Book b\n"
                    + "  on bo.bookId = b.id"
                    + "  where u.id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("bookId");
                Book book = getBookById(id);
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getOwn Error:" + e.getMessage());
        }
        return list;
    }
    
    public boolean isOwn(User user, Book book) {
        return getOwnBooks(user).contains(book);
    }
}
