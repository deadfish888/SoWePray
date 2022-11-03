/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.auth.User;
import Model.product.Book;
import Model.product.Product;
import Model.product.content.Chapter;
import Model.product.content.Volume;
import context.product.BookDAO;
import context.product.ProductDAO;
import context.product.content.ChapterDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
        int id = Integer.parseInt(request.getParameter("id"));
        String cid = request.getParameter("cid");
        BookDAO b = new BookDAO();
        VolumeDAO vd = new VolumeDAO();
        ChapterDAO chd = new ChapterDAO();
        Book thisbook = b.getBookById(id);
        ArrayList<Volume> listV = vd.getVolumesByBookId(id);
        Product product = new Product("B" + id);
        ProductDAO productDAO = new ProductDAO();
        Chapter chapter;
        if (cid == null) {
            if (thisbook.getAuthor().getUser() != null) {
                product.setProductId(product.getProductId() + "-C1");
            }
            product = productDAO.get(product);
            chapter = chd.getFirstChapter(id);
        } else {
            chapter = chd.getChapterById(Integer.parseInt(cid));
            if (thisbook.getAuthor().getUser() != null) {
                product.setProductId(product.getProductId() + "-C" + chapter.getNo());
            }
            product = productDAO.get(product);
        }
        String[] listr = chapter.getContent().split("\n");
        request.setAttribute("product", product);

//        ArrayList<Chapter> chap = chd.getChapterByVolumeIDandBookID(id, thisbook.getId());
//        request.setAttribute("book", thisbook);
        request.setAttribute("listr", listr);
        request.setAttribute("listV", listV);
        request.setAttribute("words", chapter.getContent().split("\\s+").length);
        request.setAttribute("chapter", chapter);
        request.getRequestDispatcher("/views/book/book-reading.jsp").forward(request, response);
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
