/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.product.content;

import Model.product.Book;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
public class Volume {
    private int id;
    private int bookId;
    private Book book;
    private int no;
    private String title;
    private String summary;
    private ArrayList<Chapter> chapters;

    public Volume() {
    }

    public Volume(int id, int bookId, int no, String title, String summary) {
        this.id = id;
        this.bookId = bookId;
        this.no = no;
        this.title = title;
        this.summary = summary;
    }

    public Volume(int id) {
        this.id = id;
    }

     public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
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
    
    
    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public ArrayList<Chapter> getChapters() {
        return chapters;
    }

    public void setChapters(ArrayList<Chapter> chapters) {
        this.chapters = chapters;
    }
    
}
