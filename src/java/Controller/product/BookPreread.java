/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import Model.Book;
import Model.Category;
import Model.Chapter;
import Model.Content;
import Model.Volume;
import context.BookDAO;
import context.CategoryDAO;
import context.ChapterDAO;
import context.ContentDAO;
import context.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

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
        ContentDAO cd = new ContentDAO();
        ChapterDAO chd = new ChapterDAO();
        Book thisbook = b.getBookById(id);
        int thischapter = chd.getChapterIDbyChapterAndBookID(1, id);
        request.setAttribute("thischapter", thischapter);
        ArrayList<Content> list = cd.getContentByChapterID(thischapter);
//      ArrayList<Chapter> chap = chd.getChapterByVolumeIDandBookID(id, thisbook.getId());
        request.setAttribute("list", list);
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
