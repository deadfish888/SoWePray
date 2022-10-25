/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book.content;

import Model.product.content.Chapter;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "AdTOCController", urlPatterns = {"/Admin/Book/TOC"})
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

            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));

            String svolumeId = request.getParameter("vid");
            String schapterId = request.getParameter("cid");
            if (svolumeId != null) {
                int vid = Integer.parseInt(svolumeId);
                request.setAttribute("vol", vd.getVolumeById(vid));
            } else if (schapterId != null) {
                int cid = Integer.parseInt(schapterId);
                Chapter chapter = cd.getChapterById(cid);
                request.setAttribute("chap", chapter);
                String[] content = chapter.getContent().split("\n");
                
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
