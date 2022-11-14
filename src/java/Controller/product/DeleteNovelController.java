/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.auth.User;
import Model.product.Book;
import context.product.BookDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "DeleteNovelController", urlPatterns = {"/User/Delete"})
public class DeleteNovelController extends HttpServlet {


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                    response.sendRedirect("./Novels");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));

            BookDAO bd = new BookDAO();
            Book book = bd.getBookById(bookId);
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath()+"/error.jsp");
                return;
            }

            bd.deleteBook(bookId);
            response.sendRedirect("./Novels");
        } catch (Exception ex) {
            Logger.getLogger(DeleteNovelController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath()+"/error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
