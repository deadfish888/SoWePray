/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Book {
    private int id;
    private String title, author;
    private int categoryid;
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

    public Book(int id, String title, String author, int categoryid, float rating, 
            int favourite, float price, boolean issale, String image, String description, int views) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.categoryid = categoryid;
        this.rating = rating;
        this.favourite = favourite;
        this.price = price;
        this.issale = issale;
        this.image = image;
        this.description = description;
        this.views = views;
    }


    public Book(int id, String title, String author, int categoryid, int favourite, float price, boolean issale, String image) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.categoryid=categoryid;
        this.price = price;
        this.issale = issale;
        this.favourite = favourite;
        this.image = image;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
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

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Book) {
            Book book = (Book)obj;
            return book.getId() == this.id;
        }
        return false;
    }
    
    

}
