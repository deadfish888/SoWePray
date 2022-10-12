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

    public void delAuthor(int id) {
        try {
            String sql = "DELETE FROM [dbo].[Author]\n"
                    + "      WHERE [Author].[userId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addAuthor(int id, String name) {
        try {
            String sql = "INSERT INTO [dbo].[Author]\n"
                    + "           ([userId]\n"
                    + "           ,[name])\n"
                    + "     VALUES\n"
                    + "           (? \n"
                    + "           ,?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, name);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Author> getAllAuthor() {
        ArrayList<Author> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[userId]\n"
                    + "      ,[name]\n"
                    + "  FROM [dbo].[Author]\n"
                    + "  WHERE [userId] IS NULL";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(3);
                Author u = new Author();
                u.setId(id);
                u.setName(name);
                list.add(u);
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Author> getAllUser() {
        ArrayList<Author> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[userId]\n"
                    + "      ,[name]\n"
                    + "  FROM [dbo].[Author]\n"
                    + "  WHERE [userId] IS NOT NULL";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int userid = rs.getInt(2);
                String name = rs.getString(3);
                Author u = new Author(id, userid, name);
                list.add(u);
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public void updateAu(int id, String name) {
        try {
            String sql = "UPDATE [dbo].[Author]\n"
                    + "   SET       [name] = ?\n"
                    + " WHERE [Author].[id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(2, id);
            stm.setString(1, name);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Author> getByPage(ArrayList<Author> allAuthor, int start, int end) {
       ArrayList<Author> listpage = new ArrayList<>();
        if (allAuthor.size() < end) {
            end = allAuthor.size();
        }
        for (int i = start; i < end; i++) {
            listpage.add(allAuthor.get(i));
        }
        return listpage;
    }

    public ArrayList<Author> searchByUAname(String txt) {
        ArrayList<Author> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[userId]\n"
                    + "      ,[name]\n"
                    + "  FROM [dbo].[Author]\n"
                    + "  WHERE [name] LIKE ? \n"
                    + " AND [userId] IS NULL";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, txt);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int userid = rs.getInt(2);
                String name = rs.getString(3);
                Author u = new Author(id, userid, name);
                list.add(u);
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Author> searchByUname(String txt) {
        ArrayList<Author> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[userId]\n"
                    + "      ,[name]\n"
                    + "  FROM [dbo].[Author]\n"
                    + "  WHERE [name] LIKE ? \n"
                    + " AND [userId] IS NOT NULL";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, txt);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int userid = rs.getInt(2);
                String name = rs.getString(3);
                Author u = new Author(id, userid, name);
                list.add(u);
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

}
