/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

/**
 *
 * @author ttaad
 */
public class Comment {
    private int bid;
    private int uid;
    private  String comment;

    public Comment() {
    }

    public Comment(int bid, int uid, String comment) {
        this.bid = bid;
        this.uid = uid;
        this.comment = comment;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
}
