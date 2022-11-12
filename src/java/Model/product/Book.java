/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.product;

import Model.product.content.Chapter;
import context.product.ProductDAO;
import context.product.content.ChapterDAO;
import java.util.ArrayList;

public class Book {

    private int id;
    private String title;
    private int authorId;
    private Author author;
    private ArrayList<Category> category;
    private float rating;
    private int favourite;
    private float price;
    private boolean issale;
    private String image;
    private String description;
    private int views;
    private boolean status;

    public Book() {
    }

    public boolean status() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Book(int id, String title, int authorId, float rating, int favourite, float price, boolean issale, String image, String description, int views, boolean status) {
        this.id = id;
        this.title = title;
        this.authorId = authorId;
        this.rating = rating;
        this.favourite = favourite;
        this.price = price;
        this.issale = issale;
        this.image = image;
        this.description = description;
        this.views = views;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getFavourite() {
        return favourite;
    }

    public void setFavourite(int favourite) {
        this.favourite = favourite;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public boolean issale() {
        return issale;
    }

    public void setIssale(boolean issale) {
        this.issale = issale;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;

    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public ArrayList<Category> getCategory() {
        return category;
    }

    public void setCategory(ArrayList<Category> category) {
        this.category = category;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Book) {
            Book book = (Book) obj;
            return book.getId() == this.id;
        }
        return false;
    }

    public void setCategory(String[] category) {
        this.category = new ArrayList<>();
        for (String category1 : category) {
            Category c = new Category();
            c.setId(Integer.parseInt(category1));
            this.category.add(c);
        }
    }

    public float calculatePrice() {
        ChapterDAO chapterDAO = new ChapterDAO();
        ArrayList<Chapter> chapterList = chapterDAO.getChaptersByBookId(id);
        if (author.getUserId() != 0) {
            ProductDAO productDAO = new ProductDAO();
            price = 0;
            for (Chapter chapter : chapterList) {
                System.out.println(chapter.getId());
                Product product = productDAO.getByChapter(chapter);
                price += product.getPrice();
            }
            productDAO.close();
        }
        return price;
    }

}
