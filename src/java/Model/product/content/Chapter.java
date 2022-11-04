/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.product.content;

/**
 *
 * @author thanhienee
 */
public class Chapter {
    private int id;
    private int volumeId;
    private Volume volume;
    private int no;
    private String title;
    private boolean status;
    private String content;
    private Chapter prev;
    private Chapter next;
    
    public Chapter() {
    }

    public Chapter(int id, int volumeId, int no, String title, boolean status, String content) {
        this.id = id;
        this.volumeId = volumeId;
        this.no = no;
        this.title = title;
        this.status = status;
        this.content = content;
    }

    public Volume getVolume() {
        return volume;
    }

    public void setVolume(Volume volume) {
        this.volume = volume;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVolumeId() {
        return volumeId;
    }

    public void setVolumeId(int volumeId) {
        this.volumeId = volumeId;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Chapter getPrev() {
        return prev;
    }

    public void setPrev(Chapter prev) {
        this.prev = prev;
    }

    public Chapter getNext() {
        return next;
    }

    public void setNext(Chapter next) {
        this.next = next;
    }

    
    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Chapter) {
            Chapter chapter = (Chapter) obj;
            return chapter.getId() == this.id;
        }
        return false;
    }

    
    
    }
