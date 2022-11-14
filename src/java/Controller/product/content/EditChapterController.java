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
import utils.Validator;

/* @author ACER */
public class EditChapterController extends HttpServlet {

    Validator mu = new Validator();
    BookDAO bd = new BookDAO();
    VolumeDAO vd = new VolumeDAO();
    ChapterDAO cd = new ChapterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        try {
            int chapterId = Integer.parseInt(request.getParameter("id"));

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
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int volId = Integer.parseInt(request.getParameter("volumeId"));
            boolean status = (request.getParameter("status").equals("finished"));
            String name = mu.fieldString(request.getParameter("title"), "Required Title!");
            String content = mu.fieldString(request.getParameter("content"), "Required Content!");

            Chapter chapter = new Chapter();
            chapter.setId(id);
            chapter.setVolumeId(volId);
            chapter.setTitle(name);
            chapter.setStatus(status);
            chapter.setContent(content);

            chapter.setNo(cd.getChapterNo(id));
            
            cd.editChapterNovel(chapter);
            response.sendRedirect("./TOC?id=" + bookId + "&cid=" + id);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");

        } catch (Exception e) {
            Chapter c = cd.getChapterById(id);
            request.setAttribute("book", bd.getBookById(c.getVolume().getBookId()));
            request.setAttribute("volumes", vd.getVolumesByBookId(c.getVolume().getBookId()));
            request.setAttribute("chapters", cd.getChaptersByBookId(c.getVolume().getBookId()));
            request.setAttribute("vol", vd.getVolumeById(c.getVolumeId()));
            request.setAttribute("chap", c);
            request.setAttribute("service", "Edit");
            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("../../views/user/toc/chapter-detail.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
