/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.book.content;

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
@WebServlet(name = "AdAddVolumeController", urlPatterns = {"/Admin/Book/AddVolume"})
public class AddVolumeController extends HttpServlet {

    Validator mu = new Validator();
    BookDAO bd = new BookDAO();
    VolumeDAO vd = new VolumeDAO();
    ChapterDAO cd = new ChapterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
            request.setAttribute("service", "Add");

            request.getRequestDispatcher("/manage/book/toc/volume-detail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AddVolumeController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/error.jsp");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = 0;
        try {
            bookId = Integer.parseInt(request.getParameter("bookId"));
            String name = mu.fieldString(request.getParameter("volumeTitle"), "Required Title!");
            String summary = request.getParameter("summary");

            Volume volume = new Volume();
            volume.setBookId(bookId);
            volume.setTitle(name);
            volume.setSummary(summary);

            int newID = vd.addVolume(volume);
            response.sendRedirect("./TOC?id=" + bookId + "&vid=" + newID);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } catch (Exception e){
            request.setAttribute("book", bd.getBookById(bookId));
            request.setAttribute("volumes", vd.getVolumesByBookId(bookId));
            request.setAttribute("chapters", cd.getChaptersByBookId(bookId));
            request.setAttribute("service", "Add");
            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/manage/book/toc/volume-detail.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
