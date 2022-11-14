/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book.content;

import Model.product.content.Chapter;
import Model.product.content.Volume;
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
import utils.Validator;

/* @author ACER */
@WebServlet(name = "AdAddChapterController", urlPatterns = {"/Admin/Book/AddChapter"})
public class AddChapterController extends HttpServlet {

    Validator mu = new Validator();
    BookDAO bd = new BookDAO();
    VolumeDAO vd = new VolumeDAO();
    ChapterDAO cd = new ChapterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            int volId = Integer.parseInt(request.getParameter("vid"));

            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("vol", vd.getVolumeById(volId));
            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
            request.setAttribute("service", "Add");

            request.getRequestDispatcher("/manage/book/toc/chapter-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddChapterController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int volId = 0;
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            volId = Integer.parseInt(request.getParameter("volumeId"));
            boolean status = (request.getParameter("status").equals("finished"));
            String name = mu.fieldString(request.getParameter("title"), "Required Title!");
            String content = mu.fieldString(request.getParameter("content"), "Required Content!");

            Chapter chapter = new Chapter();
            chapter.setVolumeId(volId);
            chapter.setTitle(name);
            chapter.setStatus(status);
            chapter.setContent(content);

            int newID = cd.addChapter(chapter);
            response.sendRedirect("./TOC?id=" + bookId + "&cid=" + newID);
        } catch (NumberFormatException ex) {
            Logger.getLogger(AddChapterController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } catch (Exception e) {
            Volume vol = vd.getVolumeById(volId);
            request.setAttribute("vol", vol);
            request.setAttribute("book", bd.getBookById(vol.getBookId()));
            request.setAttribute("volumes", vd.getVolumesByBookId(vol.getBookId()));
            request.setAttribute("chapters", cd.getChaptersByBookId(vol.getBookId()));
            request.setAttribute("message", e.getMessage());
            request.setAttribute("service", "Add");

            request.getRequestDispatcher("/manage/book/toc/chapter-detail.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
