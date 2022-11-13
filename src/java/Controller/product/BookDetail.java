/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.product;

import Model.product.Book;
import Model.product.content.Chapter;
import Model.action.Comment;
import Model.product.content.Volume;
import Model.auth.User;
import Model.product.Product;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
import context.action.CommentDAO;
import context.action.FavouriteDAO;
import context.action.RatingDAO;
import context.product.ProductDAO;
import context.product.ProductOwnDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ttaad
 */
@WebServlet("/BookDetail")
public class BookDetail extends HttpServlet {

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
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String cmtId = request.getParameter("cmtId");
            FavouriteDAO fdao = new FavouriteDAO();
            boolean check = false;
            BookDAO b = new BookDAO();
            ChapterDAO chd = new ChapterDAO();
            VolumeDAO vd = new VolumeDAO();
            CommentDAO cmd = new CommentDAO();
            ProductDAO productDAO = new ProductDAO();
            RatingDAO ratingdao = new RatingDAO();
            int num_rate = ratingdao.countBook(id);
            int numfav=fdao.getAllFav(id).size();
            
            Book thisbook = b.getBookById(id);
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                request.setAttribute("own", user.isOwnProduct("B" + id));
                int uId = user.getId();
                check = fdao.checkFavourite(uId, id) == true;
            }
            ArrayList<Book> sames = b.getSimilarBooks(id, thisbook.getCategory());
            ArrayList<Volume> vols = vd.getVolumesByBookId(id);
            ArrayList<Chapter> chaps = chd.getChaptersByBookId(id);
            ArrayList<Comment> coms = cmd.loadComment(id,cmtId);
            request.setAttribute("chaps", chaps);
            request.setAttribute("sames", sames);
            request.setAttribute("book", thisbook);
            request.setAttribute("vols", vols);
            request.setAttribute("comments", coms);
            request.setAttribute("check", check);
            request.setAttribute("numrate", num_rate);
            request.setAttribute("numfav", numfav);
            
            if (thisbook.getAuthor().getUserId() == 0) {
                request.getRequestDispatcher("/views/book/book-details.jsp").forward(request, response);
            } else {
                Product bookProduct = new Product("B" + id);
                bookProduct = productDAO.get(bookProduct);
                
                ProductOwnDAO productOwnDAO = new ProductOwnDAO();
                ArrayList<Product> productOwnList = user!=null?productOwnDAO.getOwnChapterOfBook(user, thisbook): null;
                
                ArrayList<Product> chapterProductList = new ArrayList<>();
                for (Chapter chapter : chaps) {
                    Product product = productDAO.getByChapter(chapter);
                    chapterProductList.add(product);
                    if(productOwnList!=null && productOwnList.contains(product)) {
                        bookProduct.setPrice(bookProduct.getPrice() - product.getPrice());
                    }
                }
                bookProduct.setPrice(Math.round(bookProduct.getPrice() * 100) / 100f);

                request.setAttribute("productOwnList", productOwnList);
                request.setAttribute("chapterProductList", chapterProductList);
                request.setAttribute("bookProduct", bookProduct);
                request.getRequestDispatcher("/views/book/novel-details.jsp").forward(request, response);
            }
        } catch (Exception e) {
            
            Logger.getLogger(BookDetail.class.getName()).log(Level.SEVERE, null, e);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
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
