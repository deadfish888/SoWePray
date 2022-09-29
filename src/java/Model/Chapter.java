/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author thanhienee
 */
public class Chapter {
    private int id;
    private int bookID;
    private int volumeID;
    private int chapter;
    private String chapterName;
    private boolean status;

    public Chapter() {
    }

    public Chapter(int id, int bookID, int volumeID, int chapter, String chapterName, boolean status) {
        this.id = id;
        this.bookID = bookID;
        this.volumeID = volumeID;
        this.chapter = chapter;
        this.chapterName = chapterName;
        this.status = status;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVolumeID() {
        return volumeID;
    }

    public void setVolumeID(int volumeID) {
        this.volumeID = volumeID;
    }

    public int getChapter() {
        return chapter;
    }

    public void setChapter(int chapter) {
        this.chapter = chapter;
    }

    public String getChapterName() {
        return chapterName;
    }

    public void setChapterName(String chapterName) {
        this.chapterName = chapterName;
    }

    
    
    }
