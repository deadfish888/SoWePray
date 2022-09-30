/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package context;

import Model.Content;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class ContentDAO {

    public ContentDAO() {
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

    public ArrayList<Content> getContents(int cid) {
        ArrayList<Content> contents = new ArrayList<>();
        try {
            String sql = "SELECT [chapterId]\n" +
                    "      ,[paragraph]\n" +
                    "      ,[content]\n" +
                    "  FROM [dbo].[Content]"
                    + "WHERE [chapterId] = ? "
                    + "ORDER BY [paragraph] ASC";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, cid);
            rs = stm.executeQuery();
            while (rs.next()){
                int para = rs.getInt(2);
                String content = rs.getString(3);
                
                Content contento = new Content();
                contento.setParagraph(para);
                contento.setContent(content);
                
                contents.add(contento);
            }
            return contents;
        } catch (SQLException ex) {
            Logger.getLogger(ContentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
