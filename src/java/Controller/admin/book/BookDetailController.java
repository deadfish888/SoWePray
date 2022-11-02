/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book;

import Controller.product.BookDetail;
import Model.action.Comment;
import Model.auth.User;
import Model.product.Book;
import Model.product.Product;
import Model.product.content.Chapter;
import Model.product.content.Volume;
import context.action.CommentDAO;
import context.action.FavouriteDAO;
import context.product.BookDAO;
import context.product.ProductDAO;
import context.product.ProductOwnDAO;
import context.product.content.ChapterDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "AdBookDetailController", urlPatterns = {"/Admin/BookDetail"})
public class BookDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            FavouriteDAO fdao = new FavouriteDAO();
            BookDAO bd = new BookDAO();
            ChapterDAO chd = new ChapterDAO();
            VolumeDAO vd = new VolumeDAO();
            CommentDAO cmd = new CommentDAO();
            ProductDAO pd = new ProductDAO();

            Book thisbook = bd.getBookById(id);
            request.setAttribute("book", thisbook);
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
