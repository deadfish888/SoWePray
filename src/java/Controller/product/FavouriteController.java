/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import Model.Book;
import Model.Category;
import context.BookDAO;
import context.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import javax.mail.Session;

/**
 *
 * @author ttaad
 */
public class FavouriteController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String cid=request.getParameter("category");
       ArrayList<Book> books;
        BookDAO bd = new BookDAO();
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> category = cd.getCategories();
        
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
