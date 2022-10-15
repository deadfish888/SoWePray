/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

/**
 *
 * @author ttaad
 */
public class Favourite {
    private int uID;
    private int bID;

    public Favourite() {
    }

    public Favourite(int uID, int bID) {
        this.uID = uID;
        this.bID = bID;
    }

    public int getuID() {
        return uID;
    }

    public void setuID(int uID) {
        this.uID = uID;
    }

    public int getbID() {
        return bID;
    }

    public void setbID(int bID) {
        this.bID = bID;
    }
    
}
