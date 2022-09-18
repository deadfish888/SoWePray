/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.stream.IntStream;
import utils.MyUtil;

/**
 *
 * @author ACER
 */
public class UserDAO {

    public UserDAO() {
        connectDB();
    }

    Connection cnn; // ket noi db
    Statement stm; // thuc thi cac cau lenh sql
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
    public void editProfile(User us) {
        String sql = "update[User] set\n"
                + "                [email] = ?,\n"
                + "                [fullname] = ?,\n"
                + "                [phone] = ?,\n"
                + "                [address] =  ? \n"
                + "                where [id] = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ps.setString(1, us.getEmail());
            ps.setString(2, us.getName());
            ps.setString(3, us.getPhone());
            ps.setString(4, us.getAddress());
            ps.setInt(5, us.getId());
            rs = ps.executeQuery();
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public String randomPassword() {
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

    public String randomToken() {
        int data[] = IntStream.concat(IntStream.rangeClosed('0', '9'),
                IntStream.concat(IntStream.rangeClosed('A', 'Z'),
                        IntStream.rangeClosed('a', 'z'))).toArray();
        char index[] = new char[20];

        Random r = new Random();
        for (int i = 0; i < 20; i++) {
            index[i] = (char) data[r.nextInt(data.length)];
        }
        return new String(index);
    }

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String createResetToken(String recipient) {
        Timestamp expired_date = new Timestamp(System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(5));
        String token = MyUtil.randomString(20);
        String sql = "insert [ResetToken] "
                + "  values ( (select [id] from [User] where [email] = ?),"
                + "  ?, ?)";
        try {
            PreparedStatement ps = cnn.prepareStatement(sql);
            ps.setString(1, recipient);
            ps.setString(2, token);
            ps.setTimestamp(3, expired_date);
            ps.executeUpdate();
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
                PreparedStatement ps = cnn.prepareStatement(sql);
                ps.setString(1, newPassword);
                ps.setString(2, token);
                ps.executeUpdate();
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
                PreparedStatement ps = cnn.prepareStatement(sql);
                ps.setString(1, token);
                ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                rs=ps.executeQuery();
                if(rs.next()) return true;
            } catch (Exception e) {
                System.out.println("checkToken Error:" + e.getMessage());
            }
        return false;
    }

    public boolean checkEmailExisted(String email) {
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
    
    public boolean checkDupUsername(String key) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [User] where username='" + key + "'";
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
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "insert [User] ([fullname],[gender] ,[dob] , [email], [phone],[username], [password])"
                    + "  values (N'" + name + "',"
                    + "N'" + (gender.equals("Male") ? 1 : 0) + "',"
                    + "CAST(N'" + dob + "' AS Date),"
                    + "N'" + email + "',"
                    + "N'" + phone + "',"
                    + "N'" + username + "',"
                    + "N'" + password + "')";
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("updatePass Error:" + e.getMessage());
        }
    }

    public void editProfile(int userid, String name, String gender, String dob, String email, String phone, String address) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [User] set "
                    + "  [fullname] = N'" + name + "' AND"
                    + " [gender] = " + (gender.equals("male") ? 1 : 0) + " AND"
                    + " [dob] = N'" + dob + "' AND"
                    + " [phone] = N'" + phone + "' AND"
                    + " [address] = N'" + address + "'"
                    + "where [id] = " + userid;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("editProfile Error:" + e.getMessage());
        }
    }

    public void changePassword(int userid, String newPassword) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [User] set "
                    + "  [password] = N'" + newPassword + "'"
                    + "where [id] = " + userid;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("changePass Error:" + e.getMessage());
        }
    }

    public Object getNumberUser() {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select count([id]) from [User] where [is_super] = 'False'";
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberUser Error");
        }
        return -1;
    }

    public ArrayList<User> getAllUsers() {
        ArrayList<User> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "Select * from [User] where [is_super] = 0";
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
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select [username] from [User] where [id] = " + userid;
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
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [User] set "
                    + "  [fullname] = N'" + name + "'"
                    + ", [phone] = N'" + phone + "'"
                    + ", [address] = N'" + address + "'"
                    + "where [id] = " + id;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("updateUser Error:" + e.getMessage());
        }
    }

    public boolean checkOldPass(int id, String oldpass) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [User] where [id] = " + id + " AND [password]=N'" + oldpass + "'";
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("updateUser Error:" + e.getMessage());
        }
        return false;
    }

}
