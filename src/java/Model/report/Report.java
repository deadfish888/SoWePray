/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.report;

import Model.action.Comment;
import Model.auth.User;
import Model.product.Book;
import java.sql.Timestamp;
import java.util.ArrayList;

/* @author ACER */
public class Report {

    private int id, reportType, userId, objectId;
    private String note;
    private Timestamp sent, received;
    private boolean status;
    // ReportType :
    // 1. Book
    // 2. Comment
    private String reportTypeName;
    private User userR,userO;
    private Book bookO;
    private Comment comO;
    private ArrayList<Violation> violates;

    public Report() {
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

    public Timestamp getReceived() {
        return received;
    }

    public void setReceived(Timestamp received) {
        this.received = received;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getReportTypeName() {
        return reportTypeName;
    }

    public void setReportTypeName(String reportTypeName) {
        this.reportTypeName = reportTypeName;
    }

    public User getUserR() {
        return userR;
    }

    public void setUserR(User userR) {
        this.userR = userR;
    }

    public User getUserO() {
        return userO;
    }

    public void setUserO(User userO) {
        this.userO = userO;
    }

    public Book getBookO() {
        return bookO;
    }

    public void setBookO(Book bookO) {
        this.bookO = bookO;
    }

    public Comment getComO() {
        return comO;
    }

    public void setComO(Comment comO) {
        this.comO = comO;
    }
    
    
}
