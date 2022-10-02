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

/* @author ACER */
@WebServlet(name = "ADBookController", urlPatterns = {"/Admin/Book"})
public class BooksController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("categories", cates);
        BookDAO bd = new BookDAO();
        ArrayList<Book> books = bd.getBooks();
        String xpage = request.getParameter("xpage");
        int page;
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int size = books.size();
        int numPage = (size % 10 == 0) ? (size / 10) : (size / 10 + 1);
        int start = (page - 1) * 10;
        int end = Math.min(size, start + 10);
        ArrayList<Book> listpage = bd.getByPage(books, start, end);
        request.setAttribute("xpage", page);
        request.setAttribute("numPage", numPage);
        request.setAttribute("books", listpage);
        request.getRequestDispatcher("/manage/book/view-books.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
