/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.product.Book;
import Model.product.content.Chapter;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        int id = Integer.parseInt(request.getParameter("id"));
        String cid = request.getParameter("cid");
        BookDAO b = new BookDAO();
        ChapterDAO chd = new ChapterDAO();
        Book thisbook = b.getBookById(id);
        ArrayList<Chapter> listc = chd.getChaptersByBookId(id);
        Chapter chapter;
        if (cid == null) {
            chapter = chd.getFirstChapter(id);
        } else {
            chapter = chd.getChapterById(Integer.parseInt(cid));
        }
        String[] listr = chapter.getContent().split("\n");

//        ArrayList<Chapter> chap = chd.getChapterByVolumeIDandBookID(id, thisbook.getId());
        request.setAttribute("book", thisbook);
        request.setAttribute("listr", listr);
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
