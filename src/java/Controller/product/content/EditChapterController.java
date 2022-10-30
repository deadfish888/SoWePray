/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product.content;

import Model.auth.User;
import Model.product.Book;
import Model.product.content.Chapter;
import Model.product.content.Volume;
import context.product.BookDAO;
import context.product.content.ChapterDAO;
import context.product.content.VolumeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class EditChapterController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        try {
            int chapterId = Integer.parseInt(request.getParameter("id"));
             
            BookDAO bd = new BookDAO();
            ChapterDAO cd = new ChapterDAO();
            VolumeDAO vd = new VolumeDAO();

            Chapter chapter = cd.getChapterById(chapterId);
            Book book = bd.getBookById(chapter.getVolume().getBookId());
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }
            
            request.setAttribute("book", book);
            request.setAttribute("volumes", vd.getVolumesByBookId(chapter.getVolume().getBookId()));
            request.setAttribute("chapters", cd.getChaptersByBookId(chapter.getVolume().getBookId()));

            request.setAttribute("vol", vd.getVolumeById(chapter.getVolumeId()));
            request.setAttribute("chap", chapter);
            request.setAttribute("service", "Edit");

            request.getRequestDispatcher("../../views/user/toc/chapter-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditChapterController.class.getName()).log(Level.SEVERE, null, ex);
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
        chapter.setVolumeId(volId);
        chapter.setTitle(name);
        chapter.setStatus(status);
        chapter.setContent(content);

        ChapterDAO cd = new ChapterDAO();
        chapter.setNo(cd.getChapterNo(id));

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

            request.getRequestDispatcher("../../views/user/toc/chapter-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("./TOC?id=" + bookId + "&cid=" + id);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
