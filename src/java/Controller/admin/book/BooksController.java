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
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

/* @author ACER */
@WebServlet(name = "ADBookController", urlPatterns = {"/Admin/Book"})
public class BooksController extends HttpServlet {

    BookDAO bd = new BookDAO();
    CategoryDAO cd = new CategoryDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("categories", cates);
        
        int authorId = 0;
        String page = request.getParameter("page");
        String genre = request.getParameter("genreId");
        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String order = request.getParameter("order");

        if (page == null || page.trim().length() == 0) {
            page = "1";
        }
        int pageIndex = 0, pageSize = 10, genreId = 0;
        try {
            pageIndex = Integer.parseInt(page);
            if (pageIndex <= 0) {
                pageIndex = 1;
            }
        } catch (NumberFormatException e) {
            pageIndex = 1;
        }
        try {
            genreId = Integer.parseInt(genre);
            if (genreId <= 0) {
                genreId = 0;
            }
        } catch (NumberFormatException e) {
            genreId = 0;
        }
        if (search == null) {
            search = "";
        }
        HttpSession session = request.getSession();
        if (session.getAttribute("aid") != null) {
            authorId = Integer.parseInt(session.getAttribute("aid").toString());
            session.removeAttribute("aid");
        }
        if (order == null || order.length() == 0) {
            order = "latest";
        }

        if (type == null || (!type.equals("all") && !type.equals("book") && !type.equals("novel"))) {
            type = "book";
        }

        ArrayList<Book> books = bd.getBooks(type, search, authorId, genreId);

        switch (order) {
            case "fav":
                Collections.sort(books, (Book o1, Book o2) -> Integer.compare(o2.getFavourite(), o1.getFavourite()));
                break;
            case "view":
                Collections.sort(books, (Book o1, Book o2) -> Integer.compare(o2.getViews(), o1.getViews()));
                break;
            case "rate":
                Collections.sort(books, (Book o1, Book o2) -> Float.compare(o2.getRating(), o1.getRating()));
                break;
            case "price":
                Collections.sort(books, new Comparator<Book>() {
                    @Override
                    public int compare(Book o1, Book o2) {
                        return o2.getAuthor().getUserId()!=0? (!o2.issale()? -1 : Float.compare(o2.getPrice(), o1.getPrice())) : Float.compare(o2.getPrice(), o1.getPrice());
                    }
                });
                break;
            default:
                break;
        }
        int size = books.size();
        int numPage = (int) Math.ceil((double) size / pageSize);
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(size, start + pageSize);
        ArrayList<Book> listpage = bd.getByPage(books, start, end);
        request.setAttribute("page", pageIndex);
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
