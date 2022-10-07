/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.auth;

import java.sql.Timestamp;

/* @author ACER */
public class Token {
    private int userId;
    private String token;
    private Timestamp expiredDate;

    public int getUserId() {
        return userId;
    }

    public String getToken() {
        return token;
    }

    public Timestamp getExpiredDate() {
        return expiredDate;
    }
    
}
