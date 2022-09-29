/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Volume;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
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
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public ArrayList<Volume> getAllVolume(int bookId) {
        ArrayList<Volume> vols = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[volume]\n"
                    + "      ,[volumeName]\n"
                    + "      ,[summary]\n"
                    + "  FROM [dbo].[Volume]"
                    + " WHERE [bookId] = ? "
                    + " ORDER BY [volume] asc";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, bookId);
            rs=stm.executeQuery();
            while(rs.next()){
                int id = rs.getInt(1);
                int no = rs.getInt(2);
                String volumeName = rs.getString(3);
                String summary = rs.getString(4);
                
                Volume volume = new Volume();
                volume.setId(id);
                volume.setVolume(no);
                volume.setVolumeName(volumeName);
                volume.setSummary(summary);
                vols.add(volume);
            }
            return vols;
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Volume getVolume(int vid) {
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[bookId]\n"
                    + "      ,[volume]\n"
                    + "      ,[volumeName]\n"
                    + "      ,[summary]\n"
                    + "  FROM [dbo].[Volume]"
                    + " WHERE [id] = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, vid);
            rs=stm.executeQuery();
            while(rs.next()){
                int id = rs.getInt(1);
                int bookId = rs.getInt(2);
                int no = rs.getInt(3);
                String volumeName = rs.getString(4);
                String summary = rs.getString(5);
                
                Volume volume = new Volume();
                volume.setId(id);
                volume.setBookId(bookId);
                volume.setVolume(no);
                volume.setVolumeName(volumeName);
                volume.setSummary(summary);
                
                return volume;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VolumeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
