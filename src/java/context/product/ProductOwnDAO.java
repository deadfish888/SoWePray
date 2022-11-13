/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.auth.User;
import Model.product.Book;
import Model.product.Product;
import Model.product.ProductOwn;
import context.DBContext;
import context.product.content.ChapterDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class ProductOwnDAO {

    public ProductOwnDAO() {
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

    public ArrayList<Product> getOwnProducts(User user) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT p.[productId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[chapterId]\n"
                    + "      ,[price]\n"
                    + "  FROM [Product] p"
                    + "  INNER JOIN [Product_Own] po\n"
                    + "  on po.productId = p.productId\n"
                    + "  INNER JOIN [User] u \n"
                    + "  on po.userId = u.id\n"
                    + "  where u.id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
                BookDAO bookDAO = new BookDAO();
                ChapterDAO chapterDAO = new ChapterDAO();
                Product product = new Product();
                product.setProductId(rs.getString("productId"));
                product.setBook(bookDAO.getBookById(rs.getInt("bookId")));
                product.setChapter(chapterDAO.getChapterById(rs.getInt("chapterId")));
                product.setPrice(rs.getFloat("price"));
                list.add(product);
            }
        } catch (Exception e) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("getProductOwn Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Product> getOwnChapterOfBook(User user, Book book) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT p.[productId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[chapterId]\n"
                    + "      ,[price]\n"
                    + "  FROM [Product] p"
                    + "  INNER JOIN [Product_Own] po\n"
                    + "  on po.productId = p.productId\n"
                    + "  INNER JOIN [User] u \n"
                    + "  on po.userId = u.id\n"
                    + "  where u.id = ?"
                    + "  and bookId = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setInt(2, book.getId());
            rs = stm.executeQuery();
            while (rs.next()) {
                BookDAO bookDAO = new BookDAO();
                ChapterDAO chapterDAO = new ChapterDAO();
                Product product = new Product();
                product.setProductId(rs.getString("productId"));
                product.setBook(bookDAO.getBookById(rs.getInt("bookId")));
                product.setChapter(chapterDAO.getChapterById(rs.getInt("chapterId")));
                product.setPrice(rs.getFloat("price"));
                list.add(product);
            }
        } catch (Exception e) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("getProductOwn Error:" + e.getMessage());
        }
        return list;
    }

    public void insert(Product product, User user) {
        try {
            String sql = "INSERT INTO [Product_Own]\n"
                    + "           ([userId]\n"
                    + "           ,[productId])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setString(2, product.getProductId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int count(User user) {
        try {
            String sql = "SELECT COUNT(*) as total FROM [Product_Own]"
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

    public ProductOwn get(User user, Product product) {
        ProductOwn productOwn = new ProductOwn();
        try {
            String sql = "SELECT [userId]\n"
                    + "      ,[productId]\n"
                    + "  FROM [Product_Own]"
                    + "  WHERE [userId] = ?"
                    + "  AND [productId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setString(2, product.getProductId());
            rs = stm.executeQuery();
            if (rs.next()) {
                productOwn.setProduct(product);
                productOwn.setUser(user);
                return productOwn;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
