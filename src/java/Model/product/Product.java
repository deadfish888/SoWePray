/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model.product;

import Model.product.content.Chapter;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class Product {
    String productId;
    Book book;
    Chapter chapter;
    float price;

    public Product() {
    }

    public Product(String productId, Book book, Chapter chapter, float price) {
        this.productId = productId;
        this.book = book;
        this.chapter = chapter;
        this.price = price;
    }

    public Product(String productId) {
        this.productId = productId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    
}
