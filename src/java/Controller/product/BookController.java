/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.product.Book;
import Model.product.Category;
import context.product.BookDAO;
import context.product.CategoryDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;


/* @author ACER */
@WebServlet("/Book")
public class BookController extends HttpServlet {

    // <editor-fold defaultstate="" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");
        String[] category = request.getParameterValues("categoryId");
        String search = request.getParameter("search");
        String author = request.getParameter("author");
        String type = request.getParameter("type");
        String order = request.getParameter("order");

        int[] idCategory = new int[category == null ? 1 : category.length];
        if (category == null || category.length == 0 || category[0].equals("")) {
            idCategory[0] = -1;
        } else {
            for (int i = 0; i < category.length; i++) {
                idCategory[i] = Integer.parseInt(category[i]);
            }
        }
        if (page == null || page.trim().length() == 0) {
            page = "1";
        }
        Cookie cookie =null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("pageSize")) {
                    cookie = cookies[i];
                    break;
                }
            }
        }
        int pageIndex = 0, pageSize = (cookie==null? 12 : Integer.parseInt(cookie.getValue()));
        try {
            pageIndex = Integer.parseInt(page);
            if (pageIndex <= 0) {
                pageIndex = 1;
            }
        } catch (NumberFormatException e) {
            pageIndex = 1;
        }
        if (search == null) {
            search = "";
        }
        if (author == null) {
            author = "";
        }
        if (order == null || order.length() == 0) {
            order = "latest";
        }

        if (type == null || (!type.equals("all") && !type.equals("book") && !type.equals("novel"))) {
            type = "book";
        }

        BookDAO bd = new BookDAO();
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Book> books = bd.getBooks(type, search, author, idCategory);

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

        books = bd.getByPage(books, start, end);
        request.setAttribute("page", pageIndex);
        request.setAttribute("numPage", numPage);

        ArrayList<Category> categories = cd.getAllCategory();
        request.setAttribute("categories", categories);
        request.setAttribute("books", books);
        request.getRequestDispatcher("/views/book/library.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }
}
