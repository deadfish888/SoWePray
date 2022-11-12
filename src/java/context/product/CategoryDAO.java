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
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public int addCategory(String name) {
        int n = 0;
        try {
            String sql = "INSERT INTO [Category]\n"
                    + "           ([name]\n"
                    + "           ,[active])\n"
                    + "     VALUES\n"
                    + "           (?,?)";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setBoolean(2, true);
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
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("del Error:" + e.getMessage());
        }
    }

    public void delBookCategory(int id) {
        try {
            String sql = "DELETE FROM [CategoryBook]\n"
                    + "      WHERE [categoryId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
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
                    + "      ,[active]\n"
                    + "  FROM [Category]"
                    + " ORDER BY [name] ASC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                Category cat = new Category(id, name);
                cat.setActive(rs.getBoolean("active"));
                list.add(cat);
            }
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Category> getAllActiveCategory() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "      ,[active]\n"
                    + "  FROM [Category]"
                    + "  WHERE [active] = 1"
                    + " ORDER BY [name] ASC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                Category cat = new Category(id, name);
                cat.setActive(rs.getBoolean("active"));
                list.add(cat);
            }
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Category> getAllCategory_SortById() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "      ,[active]\n"
                    + "  FROM [Category]"
                    + " ORDER BY [id] ASC";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                Category cat = new Category(id, name);
                cat.setActive(rs.getBoolean("active"));
                list.add(cat);
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

    public int addCategoryBook(int bookId, ArrayList<Category> category) {
        try {
            String sql = "INSERT INTO [CategoryBook] ([bookId], [CategoryId])"
                    + " VALUES ( ? ,? ) ";
            for (int i = 1; i < category.size(); i++) {
                sql += ", (?, ?)";
            }
            stm = cnn.prepareStatement(sql);
            for (int i = 0; i < category.size(); i++) {
                stm.setInt(2 * i + 1, bookId);
                stm.setInt(2 * i + 2, category.get(i).getId());
            }
            return stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("addCategoryBook Error:" + e.getMessage());
        }
        return 0;
    }

    public int editCategoryBook(int bookId, ArrayList<Category> category) {
        try {
            deleteCategoryBook(bookId);
            String sql = "INSERT INTO [CategoryBook] ([bookId], [CategoryId])"
                    + " VALUES ( ? ,? ) ";
            for (int i = 1; i < category.size(); i++) {
                sql += ", (?, ?)";
            }
            stm = cnn.prepareStatement(sql);
            for (int i = 0; i < category.size(); i++) {
                stm.setInt(2 * i + 1, bookId);
                stm.setInt(2 * i + 2, category.get(i).getId());
            }
            return stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("addCategoryBook Error:" + e.getMessage());
        }
        return 0;
    }

    private void deleteCategoryBook(int bookId) {
        try {
            String sql = "DELETE FROM [CategoryBook]"
                    + " WHERE [bookId] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("addCategoryBook Error:" + e.getMessage());
        }
    }

    public void updateActiveCategory(Category category, boolean active) {
        try {
            String sql = "UPDATE [Category]\n"
                    + "   SET [active] = ?\n"
                    + " WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setBoolean(1, active);
            stm.setInt(2, category.getId());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("addCategoryBook Error:" + e.getMessage());
        }

    }

    public int countBook(Category category) {
        try {
            String sql = "  select COUNT (*) as total from Category c\n"
                    + "  INNER JOIN CategoryBook cb \n"
                    + "  ON c.id = cb.categoryId\n"
                    + "  where c.id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, category.getId());
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
