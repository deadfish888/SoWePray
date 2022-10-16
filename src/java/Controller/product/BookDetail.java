/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.product.Book;
import Model.product.content.Chapter;
import Model.action.Comment;
import Model.product.content.Volume;
import Model.auth.User;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
import context.action.CommentDAO;
import context.product.content.VolumeDAO;
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
        ChapterDAO chd = new ChapterDAO();
        VolumeDAO vd = new VolumeDAO();
        CommentDAO cmd = new CommentDAO();
        Book thisbook = b.getBookById(id);
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            request.setAttribute("own", user.isOwnBook(id));
        }
        ArrayList<Book> sames = b.getSimilarBooks(id, thisbook.getCategory());
        ArrayList<Volume> vols = vd.getVolumesByBookId(id);
        ArrayList<Chapter> chaps = chd.getChaptersByBookId(id);
        ArrayList<Comment> coms = cmd.loadComment(id);
        request.setAttribute("chaps", chaps);
        request.setAttribute("sames", sames);
        request.setAttribute("book", thisbook);
        request.setAttribute("vols", vols);
        request.setAttribute("comments", coms);
        request.setAttribute("aid", b.getAuthorIdByBookId(id));
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
