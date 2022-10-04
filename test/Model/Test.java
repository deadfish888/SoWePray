/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import context.*;
import java.util.ArrayList;


/* @author ACER */
public class Test {

    public static void main(String[] args) {
        BookDAO bd =new BookDAO();
        ArrayList<Book> books= bd.getAllBook();
        books.forEach((t) -> {
            System.out.println(t.getTitle());
        });
        AuthorDAO dao = new AuthorDAO();
        UserDAO ud = new UserDAO();
//        ArrayList<User> userList = ud.getAllUsers();
//        userList.forEach((t) -> {
//            Author author = new Author();
//            author.setUserId(t.getId());
//            author.setAuthorName(t.getName());
//            dao.add(author);
//        });
    }
}
