/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.action.Comment;
import Model.report.Violation;
import Model.product.Book;
import Model.auth.User;
import context.action.CommentDAO;
import context.product.BookDAO;
import context.action.ReportDAO;
import context.action.ViolationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author thanhienee
 */
@WebServlet(name = "ReportCommentController", urlPatterns = {"/ReportComment"})
public class ReportCommentController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("bId"));
        int cid = Integer.parseInt(request.getParameter("cId"));
        if (request.getSession() == null || request.getSession().getAttribute("user") == null) {
            response.sendRedirect("./Login?origin=./BookDetail?id="+bid);
        } else {
            request.setAttribute("bid", bid);
            request.setAttribute("cid", cid);
            BookDAO bdao = new BookDAO();
            Book b = bdao.getBookById(bid);
            request.setAttribute("book", b);
            CommentDAO cdao = new CommentDAO();
            Comment comment = cdao.getCommentById(cid);
            ViolationDAO vd = new ViolationDAO();
            ArrayList<Violation> list = vd.getAllReportType(2);
            request.setAttribute("list", list);
            request.setAttribute("comment", comment);
            request.getRequestDispatcher("/views/book/report-comment.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int uId = user.getId();
        int bid = Integer.parseInt(request.getParameter("bId"));
        int cid = Integer.parseInt(request.getParameter("cId"));
        String[] report = request.getParameterValues("report");
        int[] violate_ids = new int[report.length];
        int j = 0;
        for (String s : report) {
            violate_ids[j++] = Integer.parseInt(s);
        }
        String note = request.getParameter("note");
        ReportDAO redao = new ReportDAO();
        redao.addCommentReport(violate_ids, cid, uId, note);
        request.setAttribute("confirm","Report Successfully!");

        response.sendRedirect("./BookDetail?id="+bid);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
