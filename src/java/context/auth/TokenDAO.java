/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.auth;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;
import utils.MyUtil;

/* @author ACER */
public class TokenDAO {

    public TokenDAO() {
        connectDB();
    }

    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect Token successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public int checkTokenExpired(String token) {
        String sql = "SELECT [userId] FROM [Token] "
                + "               WHERE [token] = ? "
                + "                 AND [expiredDate] > ?";
            try {
                stm = cnn.prepareStatement(sql);
                stm.setString(1, token);
                stm.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                rs=stm.executeQuery();
                if(rs.next()) return rs.getInt(1);
            } catch (Exception e) {
                System.out.println("checkToken Error:" + e.getMessage());
            }
        return 0;
    }
    
    public String createResetToken(int userId) {
        Timestamp expiredDate = new Timestamp(System.currentTimeMillis() + TimeUnit.MINUTES.toMillis(5));
        String token = MyUtil.randomString(20);
        String sql = "INSERT INTO [dbo].[Token]\n" +
                                    "           ([userId]\n" +
                                    "           ,[token]\n" +
                                    "           ,[expiredDate])\n" +
                                    "     VALUES\n" +
                                    "           ( ? \n" +
                                    "           , ? \n" +
                                    "           , ? )";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setString(2, token);
            stm.setTimestamp(3, expiredDate);
            stm.executeUpdate();
            return token;
        } catch (Exception e) {
            System.out.println("createToken Error:" + e.getMessage());
        }
        return null;
    }
}
