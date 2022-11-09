/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

import java.util.Date;

/**
 *
 * @author ttaad
 */
public class Ticket {

    private int id;
    private int typeID;
    private int uid;
    private int objectId;
    private String note;
    private Date sent;
    private Date received;
    private boolean status;
    private String stage;

    public Ticket() {
    }

    public Ticket(int id, int typeID, int uid, int objectId, String note, Date sent, Date received, boolean status, String stage) {
        this.id = id;
        this.typeID = typeID;
        this.uid = uid;
        this.objectId = objectId;
        this.note = note;
        this.sent = sent;
        this.received = received;
        this.status = status;
        this.stage = stage;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTypeID() {
        return typeID;
    }

    public String getTypeName() {
        String ret = "";
        switch (this.typeID) {
            case 1:
                ret = "Report Book";
                break;
            case 2:
                ret = "Report Comment";
                break;
            case 3:
                ret = "Enable Account";
                break;
            case 4:
                ret = "Enable Monetization ";
                break;
            case 5:
                ret = "Report Transaction ";
                break;
            default:
                throw new AssertionError();
        }
        return ret;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
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

    public Date getSent() {
        return sent;
    }

    public void setSent(Date sent) {
        this.sent = sent;
    }

    public Date getReceived() {
        return received;
    }

    public void setReceived(Date received) {
        this.received = received;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

}
