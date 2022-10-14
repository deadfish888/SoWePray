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
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
public class TOCController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../Login");
            return;
        }
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            Book book = bd.getBookById(bookId);
            if (book.getAuthor().getUserId() != user.getId()) {
                response.sendRedirect("../Login");
                return;
            }

            VolumeDAO vd = new VolumeDAO();
            ChapterDAO cd = new ChapterDAO();

            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("book", book);
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));

            String schapterId = request.getParameter("cid");
            if (schapterId != null) {
                int cid = Integer.parseInt(schapterId);
                Chapter chapter = cd.getChapterById(cid);
                request.setAttribute("chap", chapter);
                String[] content = chapter.getContent().split("\n") ;
                request.setAttribute("content", content);
                boolean issold = bd.checkNovelSold(bookId);
                request.setAttribute("issold", issold);
            }
            request.getRequestDispatcher("../../views/user/toc/view-toc.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(Controller.product.content.TOCController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
