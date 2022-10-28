/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.product;

import Model.auth.User;
import java.sql.Date;

/* @author ACER */
public class Author {
    private int id, userId;
    private String name;
    private Date date;
    private User user;
    public Author() {
    }

    public Author(int id, int userId, String name) {
        this.id = id;
        this.userId = userId;
        this.name = name;
    }

    public Author(int id, int userId, String name, Date date) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.date = date;
    }

    public Date getDate() {
        return date;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
