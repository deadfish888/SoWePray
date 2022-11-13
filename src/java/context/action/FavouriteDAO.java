/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.product.Book;
import Model.action.Favourite;
import Model.auth.User;
import Model.product.Author;
import context.DBContext;
import context.product.AuthorDAO;
import context.product.CategoryDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ttaad
 */
public class FavouriteDAO {

    public FavouriteDAO() {
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

    public void addFavourite(int uID, int bID) {
        try {
            String sql = "INSERT INTO [Favourite]\n"
                    + "           ([uid]\n"
                    + "           ,[bid])\n"
                    + "     VALUES\n"
                    + "           (" + uID + ",\n"
                    + "           " + bID + ")";
            stm = cnn.prepareStatement(sql);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Add Error:" + e.getMessage());
        }
    }

    public ArrayList<Favourite> getAllBook(int uID) {
        ArrayList<Favourite> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Favourite] WHERE uid='" + uID + "'";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int uid = rs.getInt(1);
                int bid = rs.getInt(2);
                list.add(new Favourite(uid, bid));
            }
        } catch (Exception e) {
            System.out.println("Get Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Book> getFavoriteBook(User user) {
        ArrayList<Book> bookList = new ArrayList<>();
        try {
            String sql = "SELECT [Book].[id]\n"
                    + "      ,[title]\n"
                    + "      ,[authorId]\n"
                    + "      ,[rating]\n"
                    + "      ,[favourite]\n"
                    + "      ,[price]\n"
                    + "      ,[is_sale]\n"
                    + "      ,[image]\n"
                    + "      ,[description]\n"
                    + "      ,[views]\n"
                    + "      ,[status]\n"
                    +"       ,a.[name]"
                    + "  FROM [Book]"
                    + "  INNER JOIN [Favourite] ON [Favourite].uid = [id]"
                    + "  INNER JOIN [Author] a ON [Book].[authorId] = a.[id]"
                    + "  WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while(rs.next()){
                
                Book book = new Book();
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthorId(rs.getInt(3));
                AuthorDAO authorDAO = new AuthorDAO();
                Author author = new Author();
                author.setId(rs.getInt("authorId"));
                author.setName(rs.getString(12));
                book.setAuthor(author);

                CategoryDAO cd = new CategoryDAO();
                book.setCategory(cd.getCategoriesByBookId(rs.getInt(1)));

                book.setRating(rs.getFloat(4));
                book.setFavourite(rs.getInt(5));
                book.setPrice(rs.getFloat(6));
                book.setIssale(rs.getBoolean(7));
                book.setImage(rs.getString(8));
                book.setDescription(rs.getString(9));
                book.setViews(rs.getInt(10));
                book.setStatus(rs.getBoolean(11));
                bookList.add(book);
            }
        } catch (Exception e) {
            System.out.println("Get error:" + e.getMessage());
        }
        return bookList;
    }
    
    public ArrayList<Book> getFavorBooksPagging(User user, int pageSize, int pageIndex) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            String sql = "select b.id      "
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
                    + "from [Favourite] f\n"
                    + "inner join Book b\n"
                    + "on f.bid = b.id\n"
                    + "where f.uid = ?\n"
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
                book.setId(rs.getInt("id"));
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
            System.out.println("get favor Error:" + e.getMessage());
        }
        return list;
    }

    public int count(User user) {
        try {
            String sql = "SELECT COUNT(*) as total FROM [Favourite]"
                    + "  WHERE uid = " + user.getId();
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FavouriteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;

    }
    
    public void deleteFavourite(int uID, int bID) {
        try {
            String sql = "DELETE FROM [dbo].[Favourite]\n"
                    + " WHERE uid= ? and bid= ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, uID);
            stm.setInt(2, bID);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

    public boolean checkFavourite(int uID, int bID) {
        try {
            String sql = "SELECT [uid]\n"
                    + ",[bid]\n"
                    + " FROM [dbo].[Favourite] \n"
                    + " WHERE uid='" + uID + "' and bid='" + bID + "'";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return false;
    }
    
    public ArrayList<Favourite> getAllFav(int bID) {
        ArrayList<Favourite> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Favourite] WHERE bid='" + bID + "'";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int uid = rs.getInt(1);
                int bid = rs.getInt(2);
                list.add(new Favourite(uid, bid));
            }
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return list;
    }

    public void sendFavtoBook(int count,int bookId) {
        try {

            String sql = "UPDATE [dbo].[Book]\n"
                    + "      SET\n" 
                    + "           [favourite]=" + count + ""
                    + " WHERE [id] = ?";
            stm =cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }
}
