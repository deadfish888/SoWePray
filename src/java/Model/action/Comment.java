/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

import java.sql.Timestamp;

/**
 *
 * @author ttaad
 */
public class Comment {
    private int id;
    private int bookId;
    private int userId;
    private String comment;
    private int sonOf;
    private int replyTo;
    private Timestamp createdAt;

    public Comment() {
    }

    public Comment(int id, int bookId, int userId, String comment, int sonOf, int replyTo, Timestamp createdAt) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.sonOf = sonOf;
        this.replyTo = replyTo;
        this.createdAt = createdAt;
    }
    
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSonOf() {
        return sonOf;
    }

    public void setSonOf(int sonOf) {
        this.sonOf = sonOf;
    }

    public int getReplyTo() {
        return replyTo;
    }

    public void setReplyTo(int replyTo) {
        this.replyTo = replyTo;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
}
