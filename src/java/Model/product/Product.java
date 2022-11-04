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

    public float caculatePrice() {
        if (chapter != null) {
            if (chapter.isStatus()) {
                String chapterContent = chapter.getContent();
//                System.out.println(chapterContent.split("\\s+").length / 1000);
                this.price = (float) chapterContent.split("\\s+").length / 1000f * book.getPrice();
            } else {
                this.price = 0;
            }
        } else {
            this.price = book.calculatePrice();
        }
        return price;
    }

    @Override
    public String toString() {
        String name = "";
        name += "Book " + book.getTitle();
        if (chapter != null) {
            name += ", Chapter " + chapter.getNo();
        }
        return name;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Product) {
            Product product = (Product) obj;
            if(product.getChapter() != null) {
                return product.getChapter().equals(chapter);
            }
            return product.getProductId().equals(productId);
        }
        return false;
    }

    
}
