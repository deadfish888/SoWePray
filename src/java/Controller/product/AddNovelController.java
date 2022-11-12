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
import utils.Validator;

/* @author ACER */
@WebServlet(name = "CreateNovelController", urlPatterns = {"/User/CreateNovel"})
public class AddNovelController extends HttpServlet {

    Validator mu = new Validator();
    BookDAO bd = new BookDAO();
    CategoryDAO cd = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Category> cates = cd.getAllActiveCategory();
        request.setAttribute("categories", cates);
        request.setAttribute("service", "Create");
        request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        try {
            String title = mu.fieldString(request.getParameter("title"), "Required Title!");
            String[] category = request.getParameterValues("categoryId");
            if (category == null) {
                throw new Exception("Genre required!");
            }
            String description = mu.fieldString(request.getParameter("description"), "Required Description!");
            String img = request.getParameter("image");

            Book book = new Book();
            book.setTitle(title);
            Author author = new Author();
            author.setUserId(user.getId());
            book.setAuthor(author);
            book.setCategory(category);
            book.setPrice((float) 0.1);
            book.setIssale(false);
            book.setImage(img.trim().equals("") ? null : img);
            book.setDescription(description);
            if (user.is_super() >= 3) {
                float price = (float) mu.fieldDouble(request.getParameter("price"),"Wrong format price!");
                boolean issale = (request.getParameter("issale") != null);
                book.setPrice(price);
                book.setIssale(issale);
            }

            bd.addNovel(book);
            response.sendRedirect("./Novels");
        } catch (Exception e) {
            ArrayList<Category> cates = cd.getAllActiveCategory();
            request.setAttribute("categories", cates);
            request.setAttribute("service", "Create");
            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
