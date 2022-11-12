/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book;

import Controller.product.BookDetail;
import Model.product.Book;
import context.action.CommentDAO;
import context.action.RatingDAO;
import context.product.BookDAO;
import context.product.ProductDAO;
import context.product.content.ChapterDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "AdBookDetailController", urlPatterns = {"/Admin/BookDetail"})
public class BookDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            ChapterDAO chd = new ChapterDAO();
            CommentDAO cmd = new CommentDAO();
            ProductDAO pd = new ProductDAO();
            RatingDAO rd =new RatingDAO();
            
            Book thisbook = bd.getBookById(id);
            int words = chd.countWordsByBookId(id);
            int comments = cmd.countByBook(id);
            int users = pd.countOwner(id);
           
            request.setAttribute("words", words);
            request.setAttribute("comments", comments);
            request.setAttribute("users", users);
            request.setAttribute("book", thisbook);
            request.setAttribute("votes", rd.countBook(id));
            request.getRequestDispatcher("../manage/book/book-details.jsp").forward(request, response);

        } catch (Exception e) {

            Logger.getLogger(BookDetail.class.getName()).log(Level.SEVERE, null, e);
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
