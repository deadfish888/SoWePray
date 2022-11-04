/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.product.Book;
import Model.auth.User;
import context.product.BookDAO;
import context.action.ReportDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ttaad
 */
@WebServlet(name = "ReportController", urlPatterns = {"/Report"})
public class ReportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int uId = user.getId();
        int bid = Integer.parseInt(request.getParameter("bookId"));
        String[] report = request.getParameterValues("report");
        int[] r_id = new int[report.length];
        int j = 0;
        for (String s : report) {
            r_id[j++] = Integer.parseInt(s);
        }
        String note = request.getParameter("note");
        ReportDAO redao = new ReportDAO();
        redao.addBookReport(r_id, bid, uId, note);
        response.sendRedirect("./BookDetail?id="+bid);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("bId"));
        if (request.getSession() == null || request.getSession().getAttribute("user") == null) {
            response.sendRedirect("./Login?origin=./BookDetail?id="+bid);
        } else {
            request.setAttribute("bid", bid);
            BookDAO bdao = new BookDAO();
            Book b = bdao.getBookById(bid);
            request.setAttribute("book", b);
            request.getRequestDispatcher("/views/book/report.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
