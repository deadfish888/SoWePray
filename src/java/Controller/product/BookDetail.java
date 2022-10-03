/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.Book;
import Model.Category;
import Model.User;
import context.BookDAO;
import context.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ttaad
 */
@WebServlet("/BookDetail")
public class BookDetail extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        BookDAO b = new BookDAO();
        CategoryDAO cd = new CategoryDAO();
        Book thisbook = b.getBookById(id);
        String category = cd.getCategory(thisbook.getCategoryid());
        request.setAttribute("category", category);
        ArrayList<Book> sames = b.getSimilarBooks(id, thisbook.getCategoryid());
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.setAttribute("own", user.isOwnBook(id));
        }
        request.setAttribute("sames", sames);
        request.setAttribute("book", thisbook);
        request.getRequestDispatcher("/views/book/book-details.jsp").forward(request, response);
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
