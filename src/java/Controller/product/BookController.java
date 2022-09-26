/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.Book;
import Model.Category;
import context.BookDAO;
import context.CategoryDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;


/* @author ACER */
@WebServlet("/Book")
public class BookController extends HttpServlet {

    // <editor-fold defaultstate="" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cid = request.getParameter("category");
        ArrayList<Book> books;
        BookDAO bd = new BookDAO();
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> category = cd.getAllCategories();
        request.setAttribute("category", category);
        if (cid != null) {
            if (!cid.equals("0")) {
                books = bd.getBooksByCid(cid);
                request.setAttribute("cate", cid);
            //    request.getRequestDispatcher("/views/book/bookshelf.jsp").forward(request, response);
            } else {
                books = bd.getBooks();
                request.setAttribute("cate", 0);
             //   request.getRequestDispatcher("/views/book/bookshelf.jsp").forward(request, response);
            }
            
            request.setAttribute("books", books);
            request.getRequestDispatcher("/views/book/library.jsp").forward(request, response);
            return;
        }
        
            books = bd.getBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/views/book/library.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }
}
