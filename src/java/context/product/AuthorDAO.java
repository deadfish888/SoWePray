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
     public Author getAuthorById(int aid) {
        try {
            String sql = "SELECT * from Author where aid = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, aid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Author author = new Author();
                author.setId(rs.getInt(1));
                author.setUserId(rs.getInt(2));
                author.setName(rs.getString(3));
                return author;
            }
        } catch (Exception e) {
            System.out.println("getAuthorById Error:" + e.getMessage());
        }
        return null;
    }

    public int getAuthorByBookId(int bid) {
        try {
            String sql = "select authorId from dbo.Book where id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getAuthorByBookId Error:" + e.getMessage());
        }
        return -1;
    }
}
