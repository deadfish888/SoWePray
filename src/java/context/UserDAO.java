/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.MyUtil;
import utils.RandomEnglishNameGenerator;

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
            stm = cnn.prepareStatement(sql);
            stm.setString(1, key);
            stm.setString(2, key);
            stm.setString(3, pass);
            rs = stm.executeQuery();
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
                int is_super = rs.getInt(10);
                User u = new User(userid, name, gender, dob, email, phone, address, username, pass, is_super);
                return u;
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return null;
    }

    public void editProfile(User us) {
        String sql = "update[User] set\n"
                + "                [email] = ?,\n"
                + "                [fullname] = ?,\n"
                + "                [phone] = ?,\n"
                + "                [address] =  ? \n"
                + "                where [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, us.getEmail());
            stm.setString(2, us.getName());
            stm.setString(3, us.getPhone());
            stm.setString(4, us.getAddress());
            stm.setInt(5, us.getId());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public void disableUser(int id) {
        String sql = "update [User] set\n"
                + "	[is_super] = 0\n"
                + "	where [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public void editRank(int id, int set) {
        User us = getUser(id);
        String sql = "update [User] set\n"
                + "	[is_super] = ?\n"
                + "	where [id] = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, us.is_super() + set);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public ArrayList<User> getByAccess(int us) {
        ArrayList<User> list = new ArrayList<>();
        try {
            String sql = "Select * from [User] where [is_super] < ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, us);
            rs = stm.executeQuery();
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
                int is_super = rs.getInt(10);
                list.add(new User(userid, name, gender, dob, email, phone, address, username, is_super));
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<User> sortUser(int us, String att, int way) {
        String order = "";
        if (way == 0) {
            order = "ASC";
        } else {
            order = "DESC";
        }
        ArrayList<User> list = new ArrayList<>();
        try {
            String sql = "select * from [User]\n"
                    + "where is_super < ? \n"
                    + "order by " + att + " " + order + "";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, us);
            rs = stm.executeQuery();
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
                int is_super = rs.getInt(10);
                list.add(new User(userid, name, gender, dob, email, phone, address, username, is_super));
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<User> searchByUname(int us, String att) {
        ArrayList<User> list = new ArrayList<>();
        try {
            String sql = "select * from [User]\n"
                    + "where [is_super] <?\n"
                    + "and [fullname] like ?\n"
                    + "or [username] like ?\n"
                    + "or [email] like ?\n"
                    + "or [phone] like ?\n"
                    + "or [address] like ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, us);
            stm.setString(2, att);
            stm.setString(3, att);
            stm.setString(4, att);
            stm.setString(5, att);
            stm.setString(6, att);

            rs = stm.executeQuery();
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
                int is_super = rs.getInt(10);
                list.add(new User(userid, name, gender, dob, email, phone, address, username, is_super));
            }
        } catch (Exception e) {
            System.out.println("getUser Error:" + e.getMessage());
        }
        return list;
    }

    public String createResetToken(String recipient) {
        Timestamp expired_date = new Timestamp(System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(5));
        String token = MyUtil.randomString(20);
        String sql = "insert [ResetToken] "
                + "  values ( (select [id] from [User] where [email] = ?),"
                + "  ?, ?)";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, recipient);
            stm.setString(2, token);
            stm.setTimestamp(3, expired_date);
            stm.executeUpdate();
            return token;
        } catch (Exception e) {
            System.out.println("sendToken Error:" + e.getMessage());
        }
        return null;
    }

    public String resetPassword(String token) {
        if (checkToken(token)) {
            String newPassword = MyUtil.randomString(10);
            String sql = "update [User] set "
                    + "  [password] = ? "
                    + " where [id] = (select [uid] from [ResetToken] where [token] = ? )";
            try {
                stm = cnn.prepareStatement(sql);
                stm.setString(1, newPassword);
                stm.setString(2, token);
                stm.executeUpdate();
                return newPassword;
            } catch (Exception e) {
                System.out.println("resetPassword Error:" + e.getMessage());
            }
        }
        return null;
    }

    private boolean checkToken(String token) {
        String sql = "select * from [ResetToken] "
                + " where [token] = ? AND [expired_date] > ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, token);
            stm.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkToken Error:" + e.getMessage());
        }
        return false;
    }

    public int checkEmailExisted(String email) {
        String sql = "SELECT [id] FROM [User] "
                + "WHERE email= ? ";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("checkExistEmail Error:" + e.getMessage());
        }
        return 0;
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
            stm.setInt(9, user.is_super());
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

            stm.executeUpdate();
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
            String sql = "Select * from [User] where [is_super] < 5";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
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
            rs = stm.executeQuery();
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
            stm.executeUpdate();
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
            rs = stm.executeQuery();
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
                    + " where [id] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, user.getName());
            stm.setString(2, user.getPhone());
            stm.setString(3, user.getAddress());
            stm.setBoolean(4, user.getGender().equals("Male"));
            stm.setString(5, user.getDob());
            stm.setInt(6, user.getId());
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
            rs = stm.executeQuery();
            if (rs.next()) {
                return new User(id, rs.getString(1), rs.getBoolean(2) ? "Male" : "Female",
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    void generateData() {
        int[] roleSlots = {5, 15, 80, 500};
        User newUser;
        for (int i = 1; i <= 100; i++) {
            boolean isSuper = (int) (Math.random() * 20) == 0;
            String role = isSuper ? "Admin" : "User";
            String mail = "Bookie_" + role + i + "@qa.team";

            String password = "";
            //Loop until captcha have 5 character
            while (password.length() != 10) {
                int CharacterGroup = (int) (Math.random() * 3);
                //If group is 0, get a digit
                if (CharacterGroup == 0) {
                    char AsciiCharacter = (char) (Math.random() * 10 + 48);
                    password += Character.toString(AsciiCharacter);
                } //If group is 1, get a upcase letter
                else if (CharacterGroup == 1) {
                    char AsciiCharacter = (char) (Math.random() * 24 + 65);
                    password += Character.toString(AsciiCharacter);
                } //If group is 2, get a lowcase letter
                else {
                    char AsciiCharacter = (char) (Math.random() * 24 + 97);
                    password += Character.toString(AsciiCharacter);
                }
            }
            String username = "user_no" + i;
            String phone = "";
            while (phone.length() != 10) {
                char AsciiCharacter = (char) (Math.random() * 10 + 48);
                phone += Character.toString(AsciiCharacter);
            }

//            String name = "";
            RandomEnglishNameGenerator nameGenerator = new RandomEnglishNameGenerator();
            String name = nameGenerator.generateName();
            String gender = (int) (Math.random() * 2) == 0 ? "Male" : "Female";

            String address = "";
            address += Character.toString((char) (Math.random() * 6 + 65))
                    + String.format("%03d%s", (int) (Math.random() * 600 + 1), (int) (Math.random() * 2) == 0 ? "L" : "R");

            //Starting year of specified random date (including)
            int startYear = 1960;
            int endYear = 2004;
            long start = Timestamp.valueOf(startYear + 1 + "-1-1 0:0:0").getTime();
            long end = Timestamp.valueOf(endYear + "-1-1 0:0:0").getTime();
            //The qualified number of 13-bit milliseconds is obtained.
            long ms = (long) ((end - start) * Math.random() + start);
            Date tempDob = new Date(ms);

            DateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            String dob = f.format(tempDob);
//            System.out.println(dob);

            newUser = new User(i + 2, name, gender, dob, mail, phone, address, username, password, 1);
            addUser(newUser);
        }

    }

    public int checkUsernameExisted(String key) {
        try {
            String sql = "SELECT [id] FROM [User] "
                    + "             WHERE username = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, key);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("checkAccDOB Error:" + e.getMessage());
        }
        return 0;
    }

}
