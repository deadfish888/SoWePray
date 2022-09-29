/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.product.content;

import Controller.admin.product.UpdateBookController;
import Model.Content;
import context.BookDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "TOCController", urlPatterns = {"/Admin/Book/TOC"})
public class TOCController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));

            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();

            request.setAttribute("volumes", vd.getAllVolume(bookId));
            request.setAttribute("chapters", cd.getAllChapter(bookId));

            String svolumeId = request.getParameter("vid");
            String schapterId = request.getParameter("cid");
            if (svolumeId != null) {
                int vid = Integer.parseInt(svolumeId);
                request.setAttribute("vol", vd.getVolume(vid));
            } else if (schapterId != null) {
                int cid = Integer.parseInt(schapterId);
                request.setAttribute("chap", cd.getChapter(cid));

                ContentDAO pd = new ContentDAO();
                ArrayList<Content> content = pd.getContents(cid);
                request.setAttribute("content", content);
            }

            request.getRequestDispatcher("/manage/book/toc/view-toc.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(TOCController.class.getName()).log(Level.SEVERE, null, ex);
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
