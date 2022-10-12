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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;


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
        int pageIndex = 0, pageSize = 12;
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
        
        BookDAO bd = new BookDAO();
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Book> books = bd.getBooks(search, author, idCategory);
        
        int size = books.size();
        int numPage = (int) Math.ceil((double)size / pageSize);
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
