/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product.content;

import Model.auth.User;
import Model.product.Book;
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
@WebServlet(name="AddChapterController", urlPatterns={"/User/Novels/AddChapter"})
public class AddChapterController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
             int volId = Integer.parseInt(request.getParameter("vid"));
             
            BookDAO bd = new BookDAO();
            Book book = bd.getBookById(bookId);
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }
            request.setAttribute("book", book);
            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();

            request.setAttribute("vol", vd.getVolumeById(volId));
            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
            request.setAttribute("service", "Add");

            request.getRequestDispatcher("../../views/user/toc/chapter-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddChapterController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int volId = Integer.parseInt(request.getParameter("volumeId"));
            boolean status = (request.getParameter("status").equals("finished"));
            String name = request.getParameter("title");
            String content = request.getParameter("content");

            Chapter chapter = new Chapter();
            chapter.setVolumeId(volId);
            chapter.setTitle(name);
            chapter.setStatus(status);
            chapter.setContent(content);

            BookDAO bd = new BookDAO();
            request.setAttribute("book", bd.getBookById(bookId));

            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();
            
            int newChapterId = cd.addChapter(chapter);
            if (newChapterId == 0) {
                request.setAttribute("vol", vd.getVolumeById(volId));
                request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
                request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
                request.setAttribute("message", "Add Failed! Please try again!");
                request.setAttribute("chap", chapter);
                request.setAttribute("service", "Add");

                request.getRequestDispatcher("/manage/book/toc/volume-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("./TOC?id=" + bookId + "&cid=" + newChapterId);
            }
        } catch (Exception ex) {
            Logger.getLogger(AddChapterController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
