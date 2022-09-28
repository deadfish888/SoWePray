/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.RandomEnglishNameGenerator;
import Model.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
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
                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
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

    public String generateNewPass() {
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

    public boolean checkExistEmail(String email) {
        String sql = "select * from [User] where email= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkExistEmail Error:" + e.getMessage());
        }
        return false;
    }

    public String resetPassword(String email) {
        String newPassword = generateNewPass();
        String sql = "update [User] set "
                + "  [password] = ? "
                + " where [email] = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("resetPassword Error:" + e.getMessage());
        }
        return newPassword;
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
                    + "?, "
                    + "?, "
                    + "?, "
                    + "?)";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setBoolean(2, gender.equals("Male"));
            stm.setString(3, dob);
            stm.setString(4, email);
            stm.setString(5, phone);
            stm.setString(6, username);
            stm.setString(7, password);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updatePass Error:" + e.getMessage());
        }
    }

    public void addUser(User user) {
        try {
            String sql = "INSERT INTO [dbo].[User]\n"
                    + "           ([fullname]\n"
                    + "           ,[gender]\n"
                    + "           ,[dob]\n"
                    + "           ,[email]\n"
                    + "           ,[phone]\n"
                    + "           ,[address]\n"
                    + "           ,[username]\n"
                    + "           ,[password]\n"
                    + "           ,[is_super])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";

            stm = cnn.prepareStatement(sql);
            stm.setString(1, user.getName());
            stm.setBoolean(2, user.getGender().equals("Male"));
            stm.setString(3, user.getDob());
            stm.setString(4, user.getEmail());
            stm.setString(5, user.getPhone());
            stm.setString(6, user.getAddress());
            stm.setString(7, user.getUsername());
            stm.setString(8, user.getPassword());
            stm.setBoolean(9, user.is_super());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editProfile(int userid, String name, String gender, String dob, String phone, String address) {
        try {
            String sql = "update [User] set "
                    + "  [fullname] = ? AND"
                    + " [gender] = ? AND"
                    + " [dob] = ? AND"
                    + " [phone] = ? AND"
                    + " [address] = ? "
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
                    + "  [password] = ? "
                    + "where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newPassword);
            stm.setInt(2, userid);
            stm.executeUpdate();
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
                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                String dob = f.format(rs.getDate(4));
                String email = rs.getString(5);
                String phone = rs.getString(6);
                String address = rs.getString(7);
                String username = rs.getString(8);
                float balance = rs.getFloat("balance");
                list.add(new User(userid, name, username, gender, dob, email, phone, address, balance));
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<User> getAll() {
        ArrayList<User> list = new ArrayList<>();
        try {
            String sql = "Select * from [User]";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int userid = rs.getInt(1);
                String name = rs.getString(2);
                String gender = rs.getBoolean(3) ? "Male" : "Female";
                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                String dob = f.format(rs.getDate(4));
                String email = rs.getString(5);
                String phone = rs.getString(6);
                String address = rs.getString(7);
                String username = rs.getString(8);
                float balance = rs.getFloat("balance");
                list.add(new User(userid, name, username, gender, dob, email, phone, address, balance));
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
                    + ", [address] = ? "
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

    public void updateUser(User user) {
        try {

            String sql = "update [User] set "
                    + "  [fullname] = ?"
                    + ", [phone] = ?"
                    + ", [address] = ?"
                    + ", [gender] = ?"
                    + ", [dob] = ? "
                    + ", [email] = ? "
                    + " where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, user.getName());
            stm.setString(2, user.getPhone());
            stm.setString(3, user.getAddress());
            stm.setBoolean(4, user.getGender().equals("Male"));
            stm.setString(5, user.getDob());
            stm.setString(6, user.getEmail());
            stm.setInt(7, user.getId());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateUser Error:" + e.getMessage());
        }

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
                return new User(id, rs.getString(1), rs.getBoolean(2) ? "Male" : "Female",
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    void generateData() {
//        int[] roleSlots = {5, 15, 80, 500};
//        User newUser;
//        for (int i = 1; i <= 100; i++) {
//            boolean isSuper = (int) (Math.random() * 30) == 0;
//            String role = isSuper? "Admin" : "User";
//            String mail = "Bookie_" + role + i + "@qa.team";
//
//            String password = "";
//            //Loop until captcha have 5 character
//            while (password.length() != 10) {
//                int CharacterGroup = (int) (Math.random() * 3);
//                //If group is 0, get a digit
//                if (CharacterGroup == 0) {
//                    char AsciiCharacter = (char) (Math.random() * 10 + 48);
//                    password += Character.toString(AsciiCharacter);
//                } //If group is 1, get a upcase letter
//                else if (CharacterGroup == 1) {
//                    char AsciiCharacter = (char) (Math.random() * 24 + 65);
//                    password += Character.toString(AsciiCharacter);
//                } //If group is 2, get a lowcase letter
//                else {
//                    char AsciiCharacter = (char) (Math.random() * 24 + 97);
//                    password += Character.toString(AsciiCharacter);
//                }
//            }
//            String username = "user_no" + i;
//            String phone = "";
//            while (phone.length() != 10) {
//                char AsciiCharacter = (char) (Math.random() * 10 + 48);
//                phone += Character.toString(AsciiCharacter);
//            }
//
////            String name = "";
//            RandomEnglishNameGenerator nameGenerator = new RandomEnglishNameGenerator();
//            String name = nameGenerator.generateName();
//            String gender = (int) (Math.random() * 2) == 0 ? "Male" : "Female";
//
//            String address = "";
//            address += Character.toString((char) (Math.random() * 6 + 65))
//                    + String.format("%03d%s", (int) (Math.random() * 600 + 1), (int) (Math.random() * 2) == 0 ? "L" : "R");
//
//            //Starting year of specified random date (including)
//            int startYear = 1960;
//            int endYear = 2004;
//            long start = Timestamp.valueOf(startYear + 1 + "-1-1 0:0:0").getTime();
//            long end = Timestamp.valueOf(endYear + "-1-1 0:0:0").getTime();
//            //The qualified number of 13-bit milliseconds is obtained.
//            long ms = (long) ((end - start) * Math.random() + start);
//            Date tempDob = new Date(ms);
//
//            DateFormat f = new SimpleDateFormat("yyyy-MM-dd");
//            String dob = f.format(tempDob);
////            System.out.println(dob);
//
//            newUser = new User(i + 2, name, gender, dob, mail, phone, address, username, password, isSuper);
//            addUser(newUser);
        for (User user : getAll()) {
            float balance = (float) (Math.random() * 30);
            
        }
    }

}
