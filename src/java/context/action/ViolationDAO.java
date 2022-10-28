/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context.action;

import Model.action.Violation;
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
public class ViolationDAO {
    public ViolationDAO() {
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
    
    public ArrayList<Violation> getAllReportType(int rid) {
        ArrayList<Violation> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Violation] WHERE reportType = ? ";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, rid);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int reportType = rs.getInt(2);
                String title = rs.getString(3);
                list.add(new Violation(id, reportType, title));
            }
        } catch (Exception e) {
            System.out.println("getAllReportType error:" + e.getMessage());
        }
        return list;
    }
    
}
