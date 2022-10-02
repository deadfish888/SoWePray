/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book.content;

import Model.Chapter;
import Model.Volume;
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
@WebServlet(name = "AddChapterController", urlPatterns = {"/Admin/Book/AddChapter"})
public class AddChapterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            int volId = Integer.parseInt(request.getParameter("vid"));

            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));

            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();

            request.setAttribute("vol", vd.getVolumeById(volId));
            request.setAttribute("volumes", vd.getAllVolume(bookId));
            request.setAttribute("chapters", cd.getAllChapter(bookId));
            request.setAttribute("service", "Add");

            request.getRequestDispatcher("/manage/book/toc/chapter-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddVolumeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int volId = Integer.parseInt(request.getParameter("volumeId"));
            boolean status = (request.getParameter("status").equals("finished"));
            String name = request.getParameter("chapterName");
            String content = request.getParameter("content");

            Chapter chapter = new Chapter();
            chapter.setBookID(bookId);
            chapter.setVolumeID(volId);
            chapter.setChapterName(name);
            chapter.setStatus(status);
            chapter.setContent(content);

            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));

            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();

            if (cd.addChapter(chapter) == 0) {
                request.setAttribute("vol", vd.getVolumeById(volId));
                request.setAttribute("volumes", vd.getAllVolume(bookId));
                request.setAttribute("chapters", cd.getAllChapter(bookId));
                request.setAttribute("message", "Add Failed! Please try again!");
                request.setAttribute("chap", chapter);
                request.setAttribute("service", "Add");

                request.getRequestDispatcher("/manage/book/toc/volume-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("./TOC?id=" + bookId + "&cid=" + cd.getNewChapter(bookId).getId());
            }
        } catch (Exception ex) {
            Logger.getLogger(AddVolumeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
