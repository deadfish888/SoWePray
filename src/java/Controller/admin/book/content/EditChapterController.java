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
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name = "AdEditChapterController", urlPatterns = {"/Admin/Book/EditChapter"})
public class EditChapterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int chapterId = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            ChapterDAO cd = new ChapterDAO();
            VolumeDAO vd = new VolumeDAO();

            Chapter chapter = cd.getChapterById(chapterId);

            request.setAttribute("book", bd.getBookById(1));
            request.setAttribute("volumes", vd.getVolumesByBookId(1));
            request.setAttribute("chapters", cd.getChaptersByBookId(1));

            request.setAttribute("vol", vd.getVolumeById(chapter.getVolumeId()));
            request.setAttribute("chap", chapter);
            request.setAttribute("service", "Edit");

            request.getRequestDispatcher("/manage/book/toc/chapter-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddVolumeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int volId = Integer.parseInt(request.getParameter("volumeId"));
        boolean status = (request.getParameter("status").equals("finished"));
        String name = request.getParameter("title");
        String content = request.getParameter("content");

        Chapter chapter = new Chapter();
        chapter.setId(id);
        chapter.setTitle(name);
        chapter.setStatus(status);
        chapter.setContent(content);

        ChapterDAO cd = new ChapterDAO();

        if (cd.editChapter(chapter) == 0) {
            BookDAO bd = new BookDAO();
            VolumeDAO vd = new VolumeDAO();

            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
            request.setAttribute("message", "Edit Failed! Please try again!");
            request.setAttribute("vol", vd.getVolumeById(volId));
            request.setAttribute("chap", chapter);
            request.setAttribute("service", "Edit");

            request.getRequestDispatcher("/manage/book/toc/volume-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("./TOC?id=" + bookId + "&cid=" + id);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
