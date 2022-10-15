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

    public void addAuthor(int userid, String name) {
        try {
            String sql = "INSERT INTO [dbo].[Author]\n"
                    + "           (\n"
                    + "           [name]\n"
                    + "           ,[date])\n"
                    + "     VALUES\n"
                    + "           (  \n"
                    + "            ? \n"
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, java.time.LocalDate.now().toString());
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
            System.out.println("search Error:" + e.getMessage());
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
            System.out.println("search Error:" + e.getMessage());
        }
        return list;
    }

    public int getPercent() {
        ArrayList<Author> listAuthor = getAllAuthor();
        ArrayList<Author> listUser = getAllUser();
        int a = listAuthor.size();
        int b = listUser.size();
        double ret = (double) a / (a + b);
        ret *= 100;
        return (int) ret;
    }

    public void addSignup(int id, String name) {
        try {
            String sql = "INSERT INTO [dbo].[Author]\n"
                    + "           ([userId]\n"
                    + "           ,[name]\n"
                    + "           ,[date])\n"
                    + "     VALUES\n"
                    + "           ( ? \n"
                    + "           , ? \n"
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, name);
            stm.setString(3, java.time.LocalDate.now().toString());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    public ArrayList<Integer> getNumQuater(int now, int before) {
        ArrayList<Integer> list = new ArrayList<>();
        try {
            String sql = "(SELECT COUNT([Author].[date])\n"
                    + "                    FROM[dbo].[Author]\n"
                    + "                    WHERE[date] <= '" + before + "-1-1')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                    FROM[dbo].[Author]\n"
                    + "                    WHERE[date] BETWEEN '" + before + "-1-1' AND '" + before + "-3-31')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + before + "-4-1' AND '" + before + "-6-30')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + before + "-7-1' AND '" + before + "-9-30')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + before + "-10-1' AND '" + before + "-12-31')\n"
                    + "                                           UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + now + "-1-1' AND '" + now + "-3-31')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + now + "-4-1' AND '" + now + "-6-30')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + now + "-7-1' AND '" + now + "-9-30')\n"
                    + "                                          UNION ALL\n"
                    + "    (SELECT COUNT([Author].[date])\n"
                    + "                                          FROM[dbo].[Author]\n"
                    + "                                          WHERE[date] BETWEEN '" + now + "-10-1' AND '" + now + "-12-31')";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int userid = rs.getInt(1);
                list.add(userid);
            }
        } catch (Exception e) {
            System.out.println("count Error:" + e.getMessage());
        }
        return list;
    }

    public Integer getNumYear(int month, int year) {
        int ret = 0;
        try {
            String sql = "(SELECT COUNT([Author].[id])\n"
                    + "  FROM [dbo].[Author]\n"
                    + "  WHERE YEAR([date]) = ? AND MONTH([date]) = ?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, year);
            stm.setInt(2, month);
            rs = stm.executeQuery();
            while (rs.next()) {
                ret = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("count Error:" + e.getMessage());
        }
        return ret;
    }
}
