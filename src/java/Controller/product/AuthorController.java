/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.auth.User;
import Model.product.Author;
import Model.product.Book;
import context.product.AuthorDAO;
import context.product.BookDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;


/* @author ACER */
@WebServlet("/Author")
public class AuthorController extends HttpServlet {

    // <editor-fold defaultstate="" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int aid = Integer.parseInt(request.getParameter("id"));
        BookDAO b = new BookDAO();
        AuthorDAO a = new AuthorDAO();
        Author thisauthor = a.getAuthorById(aid);
        ArrayList<Book> bookauthor = b.getAllBooksByAuthorId(aid);
        User au = a.getInformationByAuthorId(aid);
        int countbook = b.getAllBooksByAuthorId(aid).size();
        
        request.setAttribute("countbook",countbook);
        request.setAttribute("au", au);
        request.setAttribute("author", thisauthor);
        request.setAttribute("bookauthor", bookauthor);

        request.getRequestDispatcher("/views/book/book-author.jsp").forward(request, response);
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
