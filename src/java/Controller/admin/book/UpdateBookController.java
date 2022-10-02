/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin.book;

import Model.Book;
import Model.Category;
import context.BookDAO;
import context.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.Validator;

/* @author ACER */
@WebServlet(name="UpdateBookController", urlPatterns={"/Admin/UpdateBook"})
public class UpdateBookController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int bookId = (new Validator()).fieldInt(request.getParameter("id"), "No Information");
            CategoryDAO cd = new CategoryDAO();
            ArrayList<Category> cates = cd.getAllCategory();
            request.setAttribute("cates", cates);
            request.setAttribute("service", "Update");
            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));
            request.getRequestDispatcher("/manage/book/book-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateBookController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        book.setAuthor(author);
        book.setCategoryid(categoryId);
        book.setPrice(price);
        book.setIssale(issale);
        book.setImage(img);
        book.setDescription(description);
        
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("cates", cates);

        request.setAttribute("service", "Update");

        BookDAO bd = new BookDAO();
        if (bd.editBook(book) == 0) {
            request.setAttribute("message", "Update Failed! Please try again!");
        } else {
            request.setAttribute("message", "Update Successfully!");
        }
        request.setAttribute("book", book);
        request.getRequestDispatcher("/manage/book/book-detail.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
