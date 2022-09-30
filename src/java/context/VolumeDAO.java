/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Volume;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
public class VolumeDAO {

    public VolumeDAO() {
        connectDB();
    }
    Connection cnn; // ket noi db
    PreparedStatement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully VolumeDAO!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public ArrayList<Volume> getVolumeByBookID(int bID) {
        ArrayList<Volume> list = new ArrayList<>();
        try {
            String sql = "select * from [Volume] where [bookId] = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int bookID = rs.getInt(2);
                int volume = rs.getInt(3);
                String volumeName = rs.getString(4);
                list.add(new Volume(id, bookID, volume, volumeName));
            }
        } catch (Exception e) {
            System.out.println("getVolumeByBookID Error:" + e.getMessage());
        }
        return list;
    }
    
    
}
