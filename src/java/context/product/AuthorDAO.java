/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Author;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class AuthorDAO {

    public AuthorDAO() {
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

    public void add(Author author) {
        try {
            String sql = "INSERT INTO [dbo].[Author]\n"
                    + "           ([userId]\n"
                    + "           ,[authorName])\n"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, author.getUserId());
            stm.setString(2, author.getName());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Author get(Author author) {
        String sql = "SELECT [id]\n"
                + "      ,[userId]\n"
                + "      ,[name]\n"
                + "  FROM [Author]"
                + "  WHERE [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, author.getId());
            rs = stm.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return author;
    }

    public ArrayList<Author> getAllAuthor() {
        ArrayList<Author> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "  FROM [Author]"
                    + " WHERE [userId] IS NULL"
                    + " ORDER BY [name] ASC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Author author = new Author();
                author.setId(rs.getInt(1));
                author.setName(rs.getString(2));
                list.add(author);
            }
        } catch (Exception e) {
            System.out.println("getAuthor Error:" + e.getMessage());
        }
        return list;
    }
}
