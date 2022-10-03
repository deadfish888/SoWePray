/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Rating;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ttaad
 */
public class RatingDAO {

    public RatingDAO() {
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

    public float getAverageStar(int bid) {

        try {
            String sql = "SELECT AVG([star]) "
                    + "     FROM [dbo].[Star] "
                    + "     WHERE [bid] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            rs = stm.executeQuery();
            if(rs.next()) return rs.getFloat(1);
        } catch (SQLException ex) {
            Logger.getLogger(RatingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void sendRatetoBook(int bid, float star) {
        try {
            String sql = "UPDATE [Book] SET [rating]=? WHERE id=?";
            stm = cnn.prepareStatement(sql);
            stm.setFloat(1, star);
            stm.setInt(2, bid);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateBook error:" + e.getMessage());
        }
    }

    public void addStar(int bid, int uid, int star) {
        try {
            String sql = "INSERT INTO [dbo].[Star]\n"
                    + "           ([bid]\n"
                    + "           ,[uid]\n"
                    + "           ,[star])\n"
                    + "     VALUES\n"
                    + "           ( ? "
                    + "           , ? "
                    + "           , ? )";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setInt(2, uid);
            stm.setInt(3, star);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("AddStar error:" + e.getMessage());
        }
    }

    public void updateStar(int bid, int uid, int star) {
        try {
            String sql = "UPDATE [dbo].[Star]\n"
                    + "   SET [star] = ? \n"
                    + " WHERE [bid] = ? "
                    + "     AND [uid] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, star);
            stm.setInt(2, bid);
            stm.setInt(3, uid);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateStar error:" + e.getMessage());
        }
    }

    public boolean checkExist(int bid, int uid) {
        try {
            String sql = "SELECT [bid]\n"
                    + "      ,[uid]\n"
                    + "      ,[star]\n"
                    + "  FROM [dbo].[Star]"
                    + "WHERE [bid] = ? "
                    + "  AND [uid] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setInt(2, uid);
            rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkExist error:" + e.getMessage());
        }
        return false;
    }

    public ArrayList<Rating> getStarList(int bid) {
        ArrayList<Rating> list_r = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Star] WHERE bid='" + bid + "'";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                int uid = rs.getInt(2);
                int star = rs.getInt(3);
                list_r.add(new Rating(bid, uid, star));
            }
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
        return list_r;
    }
}
