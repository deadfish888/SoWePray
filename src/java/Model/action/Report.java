/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

import Model.auth.User;
import java.sql.Timestamp;

/**
 *
 * @author ttaad
 */
public class Report {
    private int id;
    private int reportType;
    private int userId;
    private User user;
    private int objectId;
    private String note;
    private Timestamp sent;

    public Report() {
    }

    public Report(int id, int reportType, int userId, User user, int objectId, String note, Timestamp sent) {
        this.id = id;
        this.reportType = reportType;
        this.userId = userId;
        this.user = user;
        this.objectId = objectId;
        this.note = note;
        this.sent = sent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getReportType() {
        return reportType;
    }

    public void setReportType(int reportType) {
        this.reportType = reportType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getObjectId() {
        return objectId;
    }

    public void setObjectId(int objectId) {
        this.objectId = objectId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getSent() {
        return sent;
    }

    public void setSent(Timestamp sent) {
        this.sent = sent;
    }
    
    

    
    
    
    
    
    
    
}
