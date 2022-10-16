/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.auth.User;
import Model.product.Author;
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
@WebServlet(name = "CreateNovelController", urlPatterns = {"/User/CreateNovel"})
public class AddNovelController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        CategoryDAO cd = new CategoryDAO();
        ArrayList<Category> cates = cd.getAllCategory();
        request.setAttribute("categories", cates);
        request.setAttribute("service", "Create");
        request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String[] category = request.getParameterValues("categoryId");
        User user = (User) request.getSession().getAttribute("user");
        
        String description = request.getParameter("description");
        String img = request.getParameter("image");
        
        Book book = new Book();
        book.setTitle(title);
        Author author = new Author();
        author.setUserId(user.getId());
        book.setAuthor(author);
        book.setCategory(category);
        book.setPrice(0);
        book.setIssale(false);
        book.setImage(img.trim().equals("")? null : img);
        book.setDescription(description);
        if (user.is_super() >= 3) {
            float price = Float.parseFloat(request.getParameter("price"));
            boolean issale = (request.getParameter("issale") != null);
            book.setPrice(price);
            book.setIssale(issale);
        }
        
        BookDAO bd = new BookDAO();
        if (bd.addNovel(book) == 0) {
            CategoryDAO cd = new CategoryDAO();
            ArrayList<Category> cates = cd.getAllCategory();
            request.setAttribute("categories", cates);
            request.setAttribute("service", "Create");
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
