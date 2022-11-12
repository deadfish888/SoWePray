/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.report;

import Model.action.Comment;
import Model.auth.User;
import Model.payment.Transaction;
import Model.product.Book;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/* @author ACER */
public class Report {

    private int id, reportType, userId, objectId;
    private String note,action;
    private Timestamp sent, received;
    private Boolean status;
    // ReportType :
    // 1. Book
    // 2. Comment
    // 3. Ticket
    // 5. Transaction
    private String reportTypeName;
    private User userR,userO;
    private Book bookO;
    private Comment comO;
    private Transaction transO;
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
        switch (reportType) {
            case 1:
                this.reportTypeName = "Book";
                break;
            case 2:
                this.reportTypeName = "Comment";
                break;
            case 5:
                this.reportTypeName = "Transaction";
                break;
            default:
                break;
        }
    }

    public Transaction getTransO() {
        return transO;
    }

    public void setTransO(Transaction transO) {
        this.transO = transO;
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

    public String getSent() {
        return new SimpleDateFormat("HH:mm a MM/dd/yyyy").format(sent);
    }

    public void setSent(Timestamp sent) {
        this.sent = sent;
    }

    public String getReceived() {
        return received ==null? null: new SimpleDateFormat("HH:mm a MM/dd/yyyy").format(received);
    }

    public void setReceived(Timestamp received) {
        this.received = received;
    }

    public Boolean isStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
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

    public ArrayList<Violation> getViolates() {
        return violates;
    }

    public void setViolates(ArrayList<Violation> violates) {
        this.violates = violates;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
    
    
}
