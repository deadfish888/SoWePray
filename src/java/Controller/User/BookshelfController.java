/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Model.action.Favourite;
import Model.auth.User;
import Model.product.Book;
import Model.product.BookOwn;
import Model.product.Category;
import context.action.FavouriteDAO;
import context.product.BookDAO;
import context.product.BookOwnDAO;
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
@WebServlet(name = "BookshelfController", urlPatterns = {"/User/Bookshelf"})
public class BookshelfController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        BookOwnDAO bookOwnDAO = new BookOwnDAO();
        FavouriteDAO favouriteDAO = new FavouriteDAO();
//        CategoryDAO categoryDAO = new CategoryDAO();
        User user = (User) request.getSession().getAttribute("user");
//        if (request.getParameter("categoryId") != null) {
//
//        }
//        ArrayList<Book> novelList = bookDAO.getNovels(user);
//        ArrayList<Category> categoryList = categoryDAO.getAllCategory();
//        bookList.size();

        int pageSize = 12;
        
        
        String bookPage = request.getParameter("bookPage");
        if (bookPage == null) {
            bookPage = "1";
        }
        int bookPageIndex = Integer.parseInt(bookPage);
        System.out.println(bookPageIndex);
        
        String favorPage = request.getParameter("favorPage");
        if (favorPage == null) {
            favorPage = "1";
        }
        int favorPageIndex = Integer.parseInt(favorPage);
        System.out.println(favorPageIndex);
        
        String novelPage = request.getParameter("novelPage");
        if (novelPage == null) {
            novelPage = "1";
        }
        int novelPageIndex = Integer.parseInt(novelPage);
        System.out.println(novelPageIndex);
        
        ArrayList<Book> bookList = bookOwnDAO.getOwnBooksPagging(user, pageSize, bookPageIndex);
//        ArrayList<BookOwn> bookOwnList = new ArrayList<>();
//        for (Book book : bookList) {
//            bookOwnList.add(bookOwnDAO.get(user, book));
//        }
        int bookCount = bookOwnDAO.count(user);
        int bookTotalPage = (bookCount % pageSize == 0) ? (bookCount / pageSize) : (bookCount / pageSize) + 1;
        System.out.println("TotalPage: " + bookTotalPage);
        
        ArrayList<Book> favorList = favouriteDAO.getFavorBooksPagging(user, pageSize, favorPageIndex);
        int favorCount = favouriteDAO.count(user);
        int favorTotalPage = (favorCount % pageSize == 0) ? (favorCount / pageSize) : (favorCount / pageSize) + 1;
        
        ArrayList<Book> novelList = bookDAO.getNovelsPagging(user, pageSize, novelPageIndex);
        int novelCount = bookDAO.countNovel(user);
        int novelTotalPage = (novelCount % pageSize == 0) ? (novelCount / pageSize) : (novelCount / pageSize) + 1;
        
//        request.setAttribute("categoryList", categoryList);
        request.setAttribute("bookTotalPage", bookTotalPage);
        request.setAttribute("favorTotalPage", favorTotalPage);
        request.setAttribute("novelTotalPage", novelTotalPage);

        request.setAttribute("bookCount", bookCount);
        request.setAttribute("favorCount", favorCount);
        request.setAttribute("novelCount", novelCount);
        
        request.setAttribute("bookList", bookList);
        request.setAttribute("favorList", favorList);
        request.setAttribute("novelList", novelList);
        
//        request.removeAttribute("");

        if(request.getParameter("novelPage") != null) {
            request.setAttribute("tab", "novels");
        } else if(request.getParameter("favorPage") != null) {
            request.setAttribute("tab", "favorites");
        } else {
            request.setAttribute("tab", "books");
        }

        request.setAttribute("bookPageIndex", bookPageIndex);
        request.setAttribute("favorPageIndex", favorPageIndex);
        request.setAttribute("novelPageIndex", novelPageIndex);
        request.getRequestDispatcher("../views/book/Bookshelf.jsp").forward(request, response);
        bookDAO.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
