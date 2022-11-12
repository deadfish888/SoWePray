/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.auth.User;
import Model.product.Book;
import Model.product.Category;
import context.product.BookDAO;
import context.product.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/* @author ACER */
@WebServlet(name = "NovelsController", urlPatterns = {"/User/Novels"})
public class NovelsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user.is_super() == 0) {
            response.sendRedirect("Support");
            return;
        }
        String page = request.getParameter("page");
        String search = request.getParameter("search");
        if (search == null || search.trim().length()==0) {
            search = "";
        }
        if (page == null || page.trim().length() == 0) {
            page = "1";
        }
        int pageIndex, pageSize = 5;
        try {
            pageIndex = Integer.parseInt(page);
            if (pageIndex <= 0) {
                pageIndex = 1;
            }
        } catch (NumberFormatException e) {
            pageIndex = 1;
        }
        CategoryDAO cd = new CategoryDAO();
        BookDAO bd = new BookDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        ArrayList<Book> books = bd.getUserNovels(user.getId(), search);

        int size = books.size();
        int numPage = (int) Math.ceil((double) size / pageSize);
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(size, start + pageSize);

        books = bd.getByPage(books, start, end);
        request.setAttribute("page", pageIndex);
        request.setAttribute("numPage", numPage);

        request.setAttribute("categories", cates);
        request.setAttribute("books", books);
        request.getRequestDispatcher("../views/user/Novels.jsp").forward(request, response);
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
