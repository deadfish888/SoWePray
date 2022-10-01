/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book.content;

import Model.Chapter;
import context.BookDAO;
import context.ChapterDAO;
import context.VolumeDAO;
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
@WebServlet(name = "EditChapterController", urlPatterns = {"/Admin/Book/EditChapter"})
public class EditChapterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int chapterId = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            ChapterDAO cd = new ChapterDAO();
            VolumeDAO vd = new VolumeDAO();

            Chapter chapter = cd.getChapter(chapterId);
            int bookId = chapter.getBookID();

            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("volumes", vd.getAllVolume(bookId));
            request.setAttribute("chapters", cd.getAllChapter(bookId));

            request.setAttribute("vol", vd.getVolume(chapter.getVolumeID()));
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
        String name = request.getParameter("chapterName");
        String content = request.getParameter("content");

        Chapter chapter = new Chapter();
        chapter.setId(id);
        chapter.setChapterName(name);
        chapter.setStatus(status);
        chapter.setContent(content);

        ChapterDAO cd = new ChapterDAO();

        if (cd.editChapter(chapter) == 0) {
            BookDAO bd = new BookDAO();
            VolumeDAO vd = new VolumeDAO();

            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("volumes", vd.getAllVolume(bookId));
            request.setAttribute("chapters", cd.getAllChapter(bookId));
            request.setAttribute("message", "Edit Failed! Please try again!");
            request.setAttribute("vol", vd.getVolume(volId));
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
