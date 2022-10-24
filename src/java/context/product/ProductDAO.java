/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Product;
import context.DBContext;
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
            System.out.println("Connect successfully CategoryDAO!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public Product get(Product product) {
        return null;
    }

    public int insert(Product product) {
        return 0;
    }

    public int update(Product product) {
        return 0;
    }

    public int delete(Product product) {
        return 0;
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
            while(rs.next()){
                chapIds.add(rs.getInt(1));
            }
            return chapIds;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
