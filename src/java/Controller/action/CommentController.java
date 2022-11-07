/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.action;

import Model.action.Comment;
import Model.auth.User;
import context.action.CommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet("/Comment")
public class CommentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    int bId=Integer.parseInt(request.getParameter("bookId"));    
    if(request.getSession() == null || request.getSession().getAttribute("user") == null){
           response.sendRedirect("./Login?origin=./BookDetail?id="+bId);
    }else{ 
        User user=(User)request.getSession().getAttribute("user");
        int uId=user.getId();
        String comment=request.getParameter("comment");
        CommentDAO cdao=new CommentDAO();
        cdao.addComment(bId, uId, comment);
        response.sendRedirect("./BookDetail?id="+bId);
    }  
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int bId=Integer.parseInt(request.getParameter("bId"));
        CommentDAO cdao=new CommentDAO();
        ArrayList<Comment> list_c=cdao.loadComment(bId,"0");
        request.setAttribute("list", list_c);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
