/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

import Model.auth.User;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author ttaad
 */
public class Comment {
    private int id;
    private int bookId;
    private int userId;
    private User user;
    private String comment;
    private int sonOf;
    private int replyTo;
    private String replyName;
    private ArrayList<Comment> replies;
    private Timestamp createdAt;
    private Timestamp editedAt;
    private Boolean status;

    public Comment() {
    }

    public Comment(int id, int bookId, int userId, String comment, Timestamp createdAt, boolean status) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.comment = comment;
        this.createdAt = createdAt;
        this.status = status;
    }

    public String getReplyName() {
        return replyName;
    }

    public void setReplyName(String replyName) {
        this.replyName = replyName;
    }
    
    public int getBookId() {
        return bookId;
    }

    public String getEditedAt() {
        return editedAt ==null? null: new SimpleDateFormat("HH:mm a MM/dd/yyyy").format(editedAt);
    }

    public void setEditedAt(Timestamp editedAt) {
        this.editedAt = editedAt;
    }


    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public ArrayList<Comment> getReplies() {
        return replies;
    }

    public void setReplies(ArrayList<Comment> replies) {
        this.replies = replies;
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getCreatedAt() {
        return createdAt ==null? null: new SimpleDateFormat("HH:mm a MM/dd/yyyy").format(createdAt);
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Boolean isStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    
    
}
