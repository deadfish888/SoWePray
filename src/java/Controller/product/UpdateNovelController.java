/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.auth.User;
import Model.product.Book;
import Model.product.Category;
import context.product.AuthorDAO;
import context.product.BookDAO;
import context.product.CategoryDAO;
import context.product.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import utils.Validator;

/* @author ACER */
@WebServlet(name = "UpdateNovelController", urlPatterns = {"/User/UpdateNovel"})
public class UpdateNovelController extends HttpServlet {

    Validator mu = new Validator();
    BookDAO bd = new BookDAO();
    CategoryDAO cd = new CategoryDAO();
    AuthorDAO ad = new AuthorDAO();
        ProductDAO pd = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("id"));
        ArrayList<Category> cates = cd.getAllActiveCategory();
        request.setAttribute("categories", cates);
        Book book = bd.getBookById(bookId);
        if (book.getAuthor().getUserId() != user.getId()) {
            response.sendRedirect("../Login");
            return;
        }
        boolean issold = pd.countOwner(bookId) > 0;
        request.setAttribute("issold", issold);
        request.setAttribute("book", book);
        request.setAttribute("service", "Update");
        request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            Book old = bd.getBookById(id);
            if (old.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }
            String title = mu.fieldString(request.getParameter("title"), "Required Title!");
            String[] category = request.getParameterValues("categoryId");
            if (category == null) {
                throw new Exception("Genre required!");
            }
            String description = mu.fieldString(request.getParameter("description"), "Required Description!");
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
                float price = (float) ( mu.fieldDouble(request.getParameter("price"), "Wrong format price!")>0.1?0.1:mu.fieldDouble(request.getParameter("price"), "Wrong format price!"));
                boolean issale = (request.getParameter("issale") != null);
                book.setPrice(price);
                book.setIssale(issale);
            }

            bd.editNovel(book);
            response.sendRedirect("./Novels");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } catch (Exception e) {
            ArrayList<Category> cates = cd.getAllActiveCategory();
            request.setAttribute("categories", cates);
            boolean issold = pd.countOwner(id)>0;
            request.setAttribute("issold", issold);
            request.setAttribute("service", "Update");
            request.setAttribute("message", e.getMessage());
            request.setAttribute("book", bd.getBookById(id));
            request.getRequestDispatcher("../views/user/NovelDetail.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
