/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Author;
import Model.product.Book;
import Model.product.Category;
import Model.auth.User;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    public ArrayList<Book> getAllBook() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);
                
                CategoryDAO cd = new CategoryDAO();
                book.setCategory(cd.getCategoriesByBookId(rs.getInt(1)));

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
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
                + ", [authorId] = ? "
                + ", [price] = ?"
                + ", [is_sale] = ?"
                + ", [image] = ?"
                + ", [description] = ?"
                + " WHERE [id] = ? ";
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, book.getTitle());
            pre.setInt(2, book.getAuthorId());
//            if(book.getCategoryId()!=0){
//                pre.setInt(3, book.getCategoryId());
//            }else pre.setNull(3, Types.INTEGER);
            pre.setFloat(3, book.getPrice());
            pre.setBoolean(4, book.issale());
            pre.setString(5, book.getImage());
            pre.setString(6, book.getDescription());
            pre.setInt(7, book.getId());
            return pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return 0;
    }

    public int addBook(Book book) {
        String sql = "INSERT INTO [dbo].[Book]\n"
                + "           ([title]\n"
                + "           ,[authorId]\n"
                + "           ,[price]\n"
                + "           ,[is_sale]\n"
                + "           ,[image]\n"
                + "           ,[description])\n"
                + "     VALUES ( ? "
                + "             , ? "
                + "             , ? "
                + "             , ? "
                + "             , ? "
                + "             , ? )";
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, book.getTitle());
            pre.setInt(2, book.getAuthorId());
            pre.setFloat(3, book.getPrice());
            pre.setBoolean(4, book.issale());
            pre.setString(5, book.getImage());
            pre.setString(6, book.getDescription());
            return pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("addBook Error:" + e.getMessage());
        }
        return 0;
    }

    public Book getBookById(int bookId) {
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [Book].[id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                CategoryDAO cd = new CategoryDAO();
                ArrayList<Category> cates = cd.getCategoriesByBookId(rs.getInt(1));
                book.setCategory(cates);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
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
            String sql = "SELECT TOP 4 [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [categoryId] = ?\n"
                    + "   AND [Book].[id] != ?"
                    + "   AND [status] != 0 ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, categoryid);
            stm.setInt(2, bookid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));

                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
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

    public ArrayList<Book> getBooksByNewest() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [status] != 0"
                    + " ORDER BY [Book].[id] DESC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        ArrayList<Book> lists = new ArrayList<>();

        int i = 0;

        while (i < 15) {
            lists.add(list.get(i));
            i++;
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

    public ArrayList<Book> getBooksByCategoryId(String cid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " INNER JOIN [CategoryBook] cb ON [Book].[id] = cb.[bookId] "
                    + " WHERE cb.[categoryId] = ?"
                    + "   AND [status] != 0 ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, Integer.parseInt(cid));
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
            }
            return list;
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return null;
    }

    public ArrayList<Book> getWeeklySaleBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [is_sale] = 1 AND [Author].[userId] is NULL"
                                        + "   AND [status] != 0 ";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
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
            String sql = "SELECT TOP 3 [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [status] != 0 "
                    + " ORDER BY [favourite] DESC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
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
            CategoryDAO categoryDAO = new CategoryDAO();
            while (rs.next()) {
                int id = rs.getInt("bookId");
                Book book = new Book();
                Author author = new Author();
                author.setId(rs.getInt("authorId"));
                book.setAuthor(author);
                book.setId(rs.getInt("bookId"));
                book.setTitle(rs.getString("title"));
                book.setRating(rs.getFloat("rating"));
                book.setFavourite(rs.getInt("favourite"));
                book.setPrice( rs.getFloat("price"));
                book.setIssale(rs.getBoolean("is_sale"));
                book.setImage( rs.getString("image"));
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

    public boolean isOwn(User user, Book book) {
        return getOwnBooks(user).contains(book);
    }

    public ArrayList<Book> getBooks(String search, String authorname, int[] idCategory) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id] as [bookId]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name] as [authorName]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " INNER JOIN [CategoryBook] cb ON [Book].[id] = cb.[bookId]"
                    + " WHERE [Book].[title] LIKE ? "
                    + "   AND [Author].[name] LIKE ? "
                    + "   AND [status] != 0 ";
            int idCateLength = idCategory.length;
            if (idCategory[0] != -1) {
                sql += "AND cb.[categoryId] in (? ";
                for (int i = 1; i < idCateLength; i++) {
                    sql += ",? ";
                }
                sql += ") GROUP BY [Book].[id]\n"
                        + "      ,[title]\n"
                        + "      ,[authorId]\n"
                        + "      ,[Author].[name]\n"
                        + "      ,[rating]\n"
                        + "      ,[favourite]\n"
                        + "      ,[price]\n"
                        + "      ,[is_sale]\n"
                        + "      ,[image]\n"
                        + "      ,[description]\n"
                        + "      ,[views]\n"
                        + "      ,[status]\n"
                        + "having count(distinct cb.[categoryId]) = ? ";
            } else {
                sql += " GROUP BY [Book].[id]\n"
                        + "      ,[title]\n"
                        + "      ,[authorId]\n"
                        + "      ,[Author].[name]\n"
                        + "      ,[rating]\n"
                        + "      ,[favourite]\n"
                        + "      ,[price]\n"
                        + "      ,[is_sale]\n"
                        + "      ,[image]\n"
                        + "      ,[description]\n"
                        + "      ,[views]\n"
                        + "      ,[status]\n";
            }

            stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            stm.setString(2, "%" + authorname + "%");
            if (idCategory[0] != -1) {
                for (int i = 0; i < idCateLength; i++) {
                    stm.setInt(i + 3, idCategory[i]);
                }
                stm.setInt(idCateLength + 3, idCateLength);
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Book> getUsersOW(int userId) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[Author].[name]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    + "  FROM [Book]"
                    + " INNER JOIN [Author] ON [Book].[authorId] = [Author].[id]"
                    + " WHERE [Author].[userId] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                Author author = new Author();
                author.setId(rs.getInt(3));
                author.setName(rs.getString(4));
                book.setAuthor(author);
                
                CategoryDAO cd = new CategoryDAO();
                book.setCategory(cd.getCategoriesByBookId(rs.getInt(1)));

                book.setRating(rs.getFloat(5));
                book.setFavourite(rs.getInt(6));
                book.setPrice(rs.getFloat(7));
                book.setIssale(rs.getBoolean(8));
                book.setImage(rs.getString(9));
                book.setDescription(rs.getString(10));
                book.setViews(rs.getInt(11));
                book.setStatus(rs.getBoolean(12));
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }
}
