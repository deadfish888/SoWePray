/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product.content;

import Model.auth.User;
import Model.product.Book;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class DeleteChapterController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        try {
            int bookId =  Integer.parseInt(request.getParameter("id"));
            int chapterId = Integer.parseInt(request.getParameter("cid"));
            BookDAO bd = new BookDAO();
            ChapterDAO cd = new ChapterDAO();
            Book book = bd.getBookById(bookId);
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }
            cd.deleteChapter(chapterId);
            response.sendRedirect("./TOC?id="+bookId) ;
        } catch (Exception ex) {
            Logger.getLogger(DeleteChapterController.class.getName()).log(Level.SEVERE, null, ex);
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
