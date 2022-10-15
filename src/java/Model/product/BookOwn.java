/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.product;

import Model.auth.User;
import Model.product.content.Chapter;
import java.sql.Timestamp;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class BookOwn {
    User user;
    Book book;
    Timestamp recentTime;
    Chapter recentChapter;

    public BookOwn() {
    }

    public BookOwn(User user, Book book, Timestamp recentTime, Chapter recentChapter) {
        this.user = user;
        this.book = book;
        this.recentTime = recentTime;
        this.recentChapter = recentChapter;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Timestamp getRecentTime() {
        return recentTime;
    }

    public void setRecentTime(Timestamp recentTime) {
        this.recentTime = recentTime;
    }

    public Chapter getRecentChapter() {
        return recentChapter;
    }

    public void setRecentChapter(Chapter recentChapter) {
        this.recentChapter = recentChapter;
    }
    
    
}
