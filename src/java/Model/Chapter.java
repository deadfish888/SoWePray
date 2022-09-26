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
    private int volumeID;
    private int chapter;
    private String chapterName;

    public Chapter() {
    }

    public Chapter(int id, int volumeID, int chapter, String chapterName) {
        this.id = id;
        this.volumeID = volumeID;
        this.chapter = chapter;
        this.chapterName = chapterName;
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
