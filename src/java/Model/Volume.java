/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author thanhienee
 */
public class Volume {
    private int id;
    private int bookId;
    private int volume;
    private String volumeName;

    public Volume() {
    }

    public Volume(int id, int bookId, int volume, String volumeName) {
        this.id = id;
        this.bookId = bookId;
        this.volume = volume;
        this.volumeName = volumeName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getVolume() {
        return volume;
    }

    public void setVolume(int volume) {
        this.volume = volume;
    }

    public String getVolumeName() {
        return volumeName;
    }

    public void setVolumeName(String volumeName) {
        this.volumeName = volumeName;
    }
    
    
}
