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

/**
 *
 * @author thanhienee
 */
@WebServlet("/BookPreread")
public class BookPreread extends HttpServlet {
   
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id=Integer.parseInt(request.getParameter("id"));
        BookDAO b = new BookDAO();
        ChapterDAO chd = new ChapterDAO();
        
        Book thisbook = b.getBookById(id);
        Chapter thischapter = chd.getFirstChapter(id);
        request.setAttribute("thischapter", thischapter);
        String[] list = thischapter.getContent().split("\n");
//      ArrayList<Chapter> chap = chd.getChapterByVolumeIDandBookID(id, thisbook.getId());
        request.setAttribute("content", list);
        request.setAttribute("book", thisbook);
        request.getRequestDispatcher("/views/book/book-preread.jsp").forward(request, response);
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
