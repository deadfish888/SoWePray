/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book;

import Model.product.Book;
import Model.product.Category;
import context.product.BookDAO;
import context.product.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/* @author ACER */
@WebServlet(name = "AddBookController", urlPatterns = {"/Admin/AddBook"})
public class AddBookController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("cates", cates);
        request.setAttribute("service", "Add");
        BookDAO bd = new BookDAO();
        request.setAttribute("newId", bd.countBookNumber() + 1);
        request.getRequestDispatcher("/manage/book/book-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        float price = Float.parseFloat(request.getParameter("price"));
        boolean issale = (request.getParameter("issale") != null);
        String description = request.getParameter("description");
        String img = request.getParameter("image");

        Book book = new Book();
        book.setId(id);
        book.setTitle(title);
//        book.setAuthorId(author);
       // book.setCategoryId(categoryId);
        book.setPrice(price);
        book.setIssale(issale);
        book.setImage(img);
        book.setDescription(description);

        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("cates", cates);

        request.setAttribute("service", "Add");

        BookDAO bd = new BookDAO();
        if (bd.addBook(book) == 0) {
            request.setAttribute("message", "Add Failed! Please try again!");
            request.setAttribute("book", book);
        } else {
            request.setAttribute("message", "Add Successfully!");
        }
        request.setAttribute("newId", bd.countBookNumber() + 1);
        request.getRequestDispatcher("/manage/book/book-detail.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
