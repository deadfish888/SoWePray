/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Book;
import Model.product.Product;
import Model.product.content.Chapter;
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
public class ProductDAO {

    public ProductDAO() {
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

    public Product get(Product product) {
        try {
            String sql = "SELECT [productId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[chapterId]\n"
                    + "      ,[price]\n"
                    + "  FROM [Product]\n"
                    + "  WHERE [productId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, product.getProductId());
            rs = stm.executeQuery();
            if (rs.next()) {
                BookDAO bookDAO = new BookDAO();
                ChapterDAO chapterDAO = new ChapterDAO();
                product.setBook(bookDAO.getBookById(rs.getInt("bookId")));
                product.setChapter(chapterDAO.getChapterById(rs.getInt("chapterId")));
                product.setPrice(rs.getFloat("price"));
                return product;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int insert(Product product) {
        try {
            String sql = "INSERT INTO [Product]\n"
                    + "           ([productId]\n"
                    + "           ,[bookId]\n"
                    + "           ,[chapterId]\n"
                    + "           ,[price])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, product.getProductId());
            stm.setInt(2, product.getBook().getId());
            if (product.getChapter() != null) {
                stm.setInt(3, product.getChapter().getId());
            } else {
                stm.setObject(3, null);
            }
            stm.setFloat(4, product.caculatePrice());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public int update(Product product) {
        try {
            String sql = "UPDATE [Product]\n"
                    + "   SET [price] = ?\n"
                    + " WHERE [productId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setFloat(1, product.getPrice());
            stm.setString(2, product.getProductId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public int deleteByChapter(int chapterId) {
        try {
            String sql = "DELETE FROM [Product]\n"
                    + "      [chapterId] = ?\n";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapterId);
            stm.execute();
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public ArrayList<Integer> getChaptersOwn(int userId, int bookId) {
        ArrayList<Integer> chapIds = new ArrayList<>();
        try {
            String sql = "SELECT p.[chapterId]\n"
                    + "  FROM [Product_Own] po "
                    + " INNER JOIN [Product] p ON p.[productId] = po.[productId]"
                    + " WHERE p.[chapterId] IS NOT NULL "
                    + "   AND po.[userId] = ? "
                    + "   AND p.[bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                chapIds.add(rs.getInt(1));
            }
            return chapIds;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Product getByChapter(Chapter chapter) {
        try {
            String sql = "SELECT [productId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[chapterId]\n"
                    + "      ,[price]\n"
                    + "  FROM [Product]\n"
                    + "  WHERE [chapterId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, chapter.getId());
            rs = stm.executeQuery();
            if (rs.next()) {
                BookDAO bookDAO = new BookDAO();
                Product product = new Product();
                product.setProductId(rs.getString("productId"));
                product.setBook(bookDAO.getBookById(rs.getInt("bookId")));
                product.setChapter(chapter);
                product.setPrice(rs.getFloat("price"));
                return product;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Product> getChapterByBook(Book book) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT [productId]\n"
                    + "      ,[bookId]\n"
                    + "      ,[chapterId]\n"
                    + "      ,[price]\n"
                    + "  FROM [Product]\n"
                    + "  WHERE [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, book.getId());
            rs = stm.executeQuery();
            if (rs.next()) {
                ChapterDAO chapterDAO = new ChapterDAO();
                Product product = new Product();
                product.setProductId(rs.getString("productId"));
                product.setBook(book);
                product.setChapter(chapterDAO.getChapterById(rs.getInt("chapterId")));
                product.setPrice(rs.getFloat("price"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //Use to add price to product Book when edit price of each chapter
    public int updateBookPrice(Book book) {
        try {
            String sql = "UPDATE [Product]\n"
                    + "   SET [price] = ?\n"
                    + " WHERE productId = ?";

            book.calculatePrice();
            stm = cnn.prepareStatement(sql);
            stm.setFloat(1, book.getPrice());
            stm.setString(2, "B" + book.getId());
            return stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public void close() {
        try {
            cnn.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int countOwner(int bookId) {
        try {
            String sql = "SELECT COUNT(*) "
                    + "FROM (SELECT DISTINCT po.[userId]"
                    + "  FROM [Product_Own] po\n"
                    +" INNER JOIN [Product] p ON po.productId = p.[productId]"
                    +" WHERE p.bookId = ? ) p";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
