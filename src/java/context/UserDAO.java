/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.IntStream;

/**
 *
 * @author ACER
 */
public class UserDAO {

    public UserDAO() {
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

    public User getUser(String key, String pass) {
        String sql = "Select * from [User] where (username=? OR email=?) AND password=?";
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                int userid = rs.getInt(1);
                String name = rs.getString(2);
                String gender = rs.getBoolean(3) ? "Male" : "Female";
                SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
                String dob = f.format(rs.getDate(4));
                String email = rs.getString(5);
                String phone = rs.getString(6);
                String address = rs.getString(7);
                String username = rs.getString(8);
                boolean is_super = rs.getBoolean(10);
                User u = new User(userid, name, gender, dob, email, phone, address, username, pass, is_super);
                return u;
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return null;
    }

    public String generatePass() {
        int data[] = IntStream.concat(IntStream.rangeClosed('0', '9'),
                IntStream.concat(IntStream.rangeClosed('A', 'Z'),
                        IntStream.rangeClosed('a', 'z'))).toArray();
        char index[] = new char[10];

        Random r = new Random();
        for (int i = 0; i < 10; i++) {
            index[i] = (char) data[r.nextInt(data.length)];
        }
        return new String(index);
    }

    public boolean checkDupEmail(String email) {
        try {
            String sql = "select * from [User] where email=?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                return false;
            }
        } catch (Exception e) {
            System.out.println("checkAccDOB Error:" + e.getMessage());
        }
        return true;
    }

    public boolean checkDupUsername(String key) {
        try {
            String sql = "select * from [User] where username=?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, key);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                return false;
            }
        } catch (Exception e) {
            System.out.println("checkAccDOB Error:" + e.getMessage());
        }
        return true;
    }

    public void createNewUser(String name, String gender, String dob, String email, String phone, String username, String password) {
        try {
            String sql = "insert [User] ([fullname],[gender] ,[dob] , [email], [phone],[username], [password])"
                    + "  values (?,"
                    + "?,"
                    + "CAST(? AS Date),"
                    + "?"
                    + "?"
                    + "?"
                    + "?')";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setBoolean(2, gender == "Male");
            stm.setString(3, dob);
            stm.setString(4, email);
            stm.setString(5, phone);
            stm.setString(6, username);
            stm.setString(7, password);
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("updatePass Error:" + e.getMessage());
        }
    }

    public void editProfile(int userid, String name, String gender, String dob, String phone, String address) {
        try {
            String sql = "update [User] set "
                    + "  [fullname] = ? AND"
                    + " [gender] = ? AND"
                    + " [dob] = ? AND"
                    + " [phone] = ? AND"
                    + " [address] = ?"
                    + "where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, gender);
            stm.setString(3, dob);
            stm.setString(4, phone);
            stm.setString(5, address);
            stm.setInt(6, userid);

            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public void changePassword(int userid, String newPassword) {
        try {
            String sql = "update [User] set "
                    + "  [password] = ?"
                    + "where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newPassword);
            stm.setInt(2, userid);
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("changePass Error:" + e.getMessage());
        }
    }

    public int getNumberUser() {
        return (getAllUsers().size());
    }

    public ArrayList<User> getAllUsers() {
        ArrayList<User> list = new ArrayList<>();
        try {
            String sql = "Select * from [User] where [is_super] = 0";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int userid = rs.getInt(1);
                String name = rs.getString(2);
                String gender = rs.getBoolean(3) ? "Male" : "Female";
                SimpleDateFormat f = new SimpleDateFormat("dd/mm/yyyy");
                String dob = f.format(rs.getDate(4));
                String email = rs.getString(5);
                String phone = rs.getString(6);
                String address = rs.getString(7);
                String username = rs.getString(8);
                list.add(new User(userid, name, username, gender, dob, email, phone, address));
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public String getUsername(int userid) {
        try {
            String sql = "select [username] from [User] where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, userid);
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberUser Error");
        }
        return null;
    }

    public void updateUser(int id, String name, String phone, String address) {
        try {

            String sql = "update [User] set "
                    + "  [fullname] = ?"
                    + ", [phone] = ?"
                    + ", [address] = ?"
                    + "where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, phone);
            stm.setString(3, address);
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("updateUser Error:" + e.getMessage());
        }
    }

    public boolean checkOldPass(int id, String oldpass) {
        try {
            String sql = "select * from [User] where [id] = ? AND [password]=? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, oldpass);
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("updateUser Error:" + e.getMessage());
        }
        return false;
    }

    public User getUser(int id) {
        try {
            String sql = "SELECT [fullname]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[email]\n"
                    + "      ,[phone]\n"
                    + "      ,[address]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[is_super]\n"
                    + "  FROM [User] "
                    + "where id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return new User(id, rs.getString(1), rs.getBoolean(2)?"Male" : "Female", 
                        rs.getString(3), rs.getString(4), rs.getString(5), 
                        rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
