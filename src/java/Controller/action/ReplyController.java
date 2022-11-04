package Controller.action;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import context.action.CommentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author ttaad
 */
@WebServlet(name = "Reply", urlPatterns = {"/Reply"})
public class ReplyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bId"));
        if (request.getSession() == null || request.getSession().getAttribute("user") == null) {
            response.sendRedirect("./Login?origin=./BookDetail?id=" + bookId);
        } else {
            int userId = Integer.parseInt(request.getParameter("uId"));
            int sonOf = Integer.parseInt(request.getParameter("sId"));
            int replyTo = Integer.parseInt(request.getParameter("rId"));
            String reply = request.getParameter("reply");
            Timestamp time = new Timestamp(Calendar.getInstance().getTimeInMillis());
            CommentDAO cmtDAO = new CommentDAO();
            cmtDAO.replyComment(bookId, userId, reply, sonOf, replyTo, time);
            response.sendRedirect("./BookDetail?id=" + bookId);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
