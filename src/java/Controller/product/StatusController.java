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
@WebServlet(name = "sStatusController", urlPatterns = {"/User/Status"})
public class StatusController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        String page = request.getParameter("page");
        if (page == null || page.trim().length() == 0) {
            page = "1";
        }
        int pageIndex;
        try {
            pageIndex = Integer.parseInt(page);
            if (pageIndex <= 0) {
                pageIndex = 1;
            }
        } catch (NumberFormatException e) {
            pageIndex = 1;
        }
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            String service = request.getParameter("service");

            BookDAO bd = new BookDAO();
            Book book = bd.getBookById(bookId);
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }

            if (service != null && service.equals("Delete")) {
                bd.deleteBook(bookId);
                response.sendRedirect("./Novels");
                return;
            }
            bd.changeStatus(bookId);
            response.sendRedirect("./Novels?page=" + pageIndex);
        } catch (Exception ex) {
            Logger.getLogger(Controller.admin.book.ChangeStatusController.class.getName()).log(Level.SEVERE, null, ex);
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
