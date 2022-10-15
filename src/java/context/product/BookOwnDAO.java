/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package context.product;

import Model.product.Book;
import Model.auth.User;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }
    
    public void insert(Book book, User user) {
        try {
            String sql = "INSERT INTO [Book_Own]\n" +
                    "           ([userId]\n" +
                    "           ,[bookId])\n" +
                    "     VALUES\n" +
                    "           (?\n" +
                    "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, user.getId());
            stm.setInt(2, book.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookOwnDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
