/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.User;

import Model.action.Favourite;
import Model.auth.User;
import Model.product.Book;
import Model.product.Category;
import context.action.FavouriteDAO;
import context.product.BookDAO;
import context.product.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Silver_000
 */
@WebServlet(name="BookshelfController", urlPatterns={"/User/Bookshelf"})
public class BookshelfController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        FavouriteDAO favouriteDAO = new FavouriteDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        User user = (User) request.getSession().getAttribute("user");
        if(request.getParameter("categoryId") != null) {
            
        }
        ArrayList<Book> bookList = bookDAO.getOwnBooks(user);
        ArrayList<Book> novelList = bookDAO.getNovels(user);
        ArrayList<Favourite> favorList = favouriteDAO.getAllBook(user.getId());
        ArrayList<Category> categoryList = categoryDAO.getAllCategory();
//        bookList.size();
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("novelList", novelList);
        request.setAttribute("favorCount", favorList.size());
//        request.removeAttribute("");
        request.getRequestDispatcher("../views/book/Bookshelf.jsp").forward(request, response);
        bookDAO.close();
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
