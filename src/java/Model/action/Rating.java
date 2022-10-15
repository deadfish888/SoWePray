/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.action;

/**
 *
 * @author ttaad
 */
public class Rating {
    private int bid;
    private int cid;
    private int star;

    public Rating() {
    }

    public Rating(int bid, int cid, int star) {
        this.bid = bid;
        this.cid = cid;
        this.star = star;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }
    
}
