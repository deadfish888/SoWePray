/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.product;

import Model.product.Category;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class CategoryDAO {

    public CategoryDAO() {
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

    public int addCategory(String name) {
        int n = 0;
        try {
            String sql = "insert [Category] ([name]) values (?)";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            n = stm.executeUpdate();
            return n;
        } catch (Exception e) {
            System.out.println("add Error:" + e.getMessage());
        }
        return 0;
    }

    public int editCategory(int id, String editName) {
        int n = 0;
        try {
            String sql = "update [Category] set [name]= ? where [id]=?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, editName);
            stm.setInt(2, id);
            n = stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
        return 0;
    }

    public void delCategory(int id) {
        try {
            String sql = "delete from [Category] where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate(sql);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("del Error:" + e.getMessage());
        }
    }

    public ArrayList<Category> getAllCategory() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "  FROM [Category]"
                    + " ORDER BY [name] ASC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                list.add(new Category(id, name));
            }
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
        }
        return list;
    }

    public String getCategory(int id) {
        try {
            String sql = "select [name] from [Category] where [id] =? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
            return null;
        }
        return null;
    }

    public ArrayList<Category> getCategoriesByBookId(int bookId) {
        ArrayList<Category> cates = new ArrayList<>();
        try {
            String sql = "SELECT [categoryId]"
                    + "         ,[name]\n"
                    + "  FROM [CategoryBook] cb"
                    + " INNER JOIN [Category] c ON cb.[categoryId] = c.[id]"
                    + " WHERE [bookId] = ? "
                    + " ORDER BY [name] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));

                cates.add(category);
            }
            return cates;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}