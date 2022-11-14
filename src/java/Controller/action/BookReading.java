/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.auth.User;
import Model.product.Book;
import Model.product.BookOwn;
import Model.product.Product;
import Model.product.content.Chapter;
import Model.product.content.Volume;
import context.product.BookDAO;
import context.product.ProductDAO;
import context.product.BookOwnDAO;
import context.product.content.ChapterDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet("/BookReading")
public class BookReading extends HttpServlet {

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
            User user = (User) request.getSession().getAttribute("user");

            int bookId = Integer.parseInt(request.getParameter("id"));
            String cid = request.getParameter("cid");
            BookDAO b = new BookDAO();
            VolumeDAO vd = new VolumeDAO();
            ChapterDAO chd = new ChapterDAO();
            Book thisbook = b.getBookById(bookId);
            ArrayList<Volume> listV = vd.getVolumesByBookId(bookId);
            Product product = new Product("B" + bookId);

            ProductDAO productDAO = new ProductDAO();
            Chapter chapter;

            if (user == null) {
                response.sendRedirect("./Login?origin=./BookDetail?id=" + request.getParameter("id"));
                return;
            }

            BookOwnDAO bookOwnDAO = new BookOwnDAO();
            BookOwn bookOwn = bookOwnDAO.get(user, thisbook);
            if (cid == null) {
                if (bookOwn != null && bookOwn.getRecentChapter() != null) {
                    chapter = bookOwn.getRecentChapter();
                    if (thisbook.getAuthor().getUser() != null) {
                        product = productDAO.getByChapter(bookOwn.getRecentChapter());
                    } else {
                        product = productDAO.get(product);
                    }
                } else {
                    chapter = chd.getFirstChapter(bookId);
                    if (thisbook.getAuthor().getUser() != null) {
                        product.setProductId(product.getProductId() + "-C1");
                        product = productDAO.get(product);
                    }
                }
            } else {
                chapter = chd.getChapterById(Integer.parseInt(cid));
                if (thisbook.getAuthor().getUser() != null) {
                    product.setProductId(product.getProductId() + "-C" + chapter.getNo());
                }
                product = productDAO.get(product);
            }

            if (!(user.isOwnProduct("B" + bookId)
                    || user.isOwnProduct(product.getProductId())
                    || ((thisbook.getAuthor().getUser() != null
                    && !thisbook.issale())
                    || (thisbook.getAuthor().getUser() != null
                    && thisbook.getAuthor().getUser().equals(user))))
                    && request.getSession().getAttribute("admin") == null) {
                request.getSession().setAttribute("error", "Please buy this book to continue reading.");
                response.sendRedirect(request.getContextPath() + "/BookDetail?id=" + request.getParameter("id"));
                return;
            }
            Cookie cookie = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie1 : cookies) {
                    if (cookie1.getName().equals("cid")) {
                        cookie = cookie1;
                        break;
                    }
                }
            }
            if (cookie == null || (!cookie.getValue().equals(cid))) {
                cookie = new Cookie("cid", cid);
                cookie.setMaxAge(5 * 60);
                response.addCookie(cookie);
                b.updateView(bookId);
            }
            bookOwnDAO.updateReadingStatus(user, thisbook, chapter);
//        ArrayList<Chapter> chap = chd.getChapterByVolumeIDandBookID(id, thisbook.getId());
//            request.setAttribute("bookProductId", "B" + bookId);
            request.setAttribute("listV", listV);
            request.setAttribute("words", chapter.getContent().split("\\s+").length);
            request.setAttribute("chapter", chapter);
            request.getRequestDispatcher("/views/book/book-reading.jsp").forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage() + "\n" + e.getLocalizedMessage());
            response.sendRedirect(request.getContextPath() + "/BookDetail?id=" + request.getParameter("id"));
        }
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
