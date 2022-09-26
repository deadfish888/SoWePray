/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin.product;

import Model.Category;
import context.BookDAO;
import context.CategoryDAO;
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
import utils.Validator;

/* @author ACER */
@WebServlet(name="EditBookController", urlPatterns={"/Admin/EditBook"})
public class EditBookController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int bookId = (new Validator()).fieldInt(request.getParameter("id"), "No Information");
            CategoryDAO cd = new CategoryDAO();
            ArrayList<Category> cates = cd.getAllCategory();
            request.setAttribute("cates", cates);
            request.setAttribute("service", "Update");
            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));
            request.getRequestDispatcher("/manage/book/add-book.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditBookController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
