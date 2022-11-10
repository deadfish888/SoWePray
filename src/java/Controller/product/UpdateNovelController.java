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
import context.product.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/* @author ACER */
@WebServlet(name = "UpdateNovelController", urlPatterns = {"/User/UpdateNovel"})
public class UpdateNovelController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        int bookId = Integer.parseInt(request.getParameter("id"));
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("categories", cates);
        BookDAO bd = new BookDAO();
        Book book = bd.getBookById(bookId);
        if (book.getAuthor().getUserId() != user.getId()) {
            response.sendRedirect("../Login");
            return;
        }
        ProductDAO pd = new ProductDAO();
        boolean issold = pd.countOwner(bookId)>0;
        request.setAttribute("issold", issold);
        request.setAttribute("book", book);
        request.setAttribute("service", "Update");
        request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String[] category = request.getParameterValues("categoryId");
        User user = (User) request.getSession().getAttribute("user");
        String description = request.getParameter("description");
        String img = request.getParameter("image");

        Book book = new Book();
        book.setId(id);
        book.setTitle(title);
        book.setCategory(category);
        book.setPrice(0);
        book.setIssale(false);
        book.setImage(img.trim().equals("") ? null : img);
        book.setDescription(description);
        if (user.is_super() >= 3) {
            float price = Float.parseFloat(request.getParameter("price"));
            boolean issale = (request.getParameter("issale") != null);
            book.setPrice(price);
            book.setIssale(issale);
        }

        BookDAO bd = new BookDAO();
        if (bd.editNovel(book) == 0) {
            CategoryDAO cd = new CategoryDAO();
            ArrayList<Category> cates = cd.getAllCategory();
            request.setAttribute("categories", cates);
            boolean issold = bd.checkNovelSold(id);
            request.setAttribute("issold", issold);
            request.setAttribute("service", "Update");
            request.setAttribute("message", "Failed successfully!");
            request.setAttribute("book", book);
            request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("./Novels");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
