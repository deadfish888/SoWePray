/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import Model.Book;
import Model.User;
import context.BookDAO;
import context.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ttaad
 */
@WebServlet(name="ReportController", urlPatterns={"/Report"})
public class ReportController extends HttpServlet { 
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user=(User)request.getSession().getAttribute("user");
        int uId=user.getId();
        int bid=Integer.parseInt(request.getParameter("bId"));
        String[] report=request.getParameterValues("report");
        int[] r_id=new int[report.length];
        int j=0;
        for(String s : report){
           if(s.trim().equals("1")) r_id[j++]=1;
           if(s.equals("2")) r_id[j++]=2;
           if(s.equals("3")) r_id[j++]=3;
           if(s.equals("4")) r_id[j++]=4;
           if(s.equals("5")) r_id[j++]=5;
           if(s.equals("6")) r_id[j++]=6;
           if(s.equals("7")) r_id[j++]=7;
           if(s.equals("8")) r_id[j++]=8;
           if(s.equals("9")) r_id[j++]=9;
           if(s.equals("10")) r_id[j++]=10;
        }
        String note=request.getParameter("note");
        ReportDAO redao=new ReportDAO();
        redao.addReport(bid, bid, uId, note);
        response.sendRedirect("./Home");
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int bid=Integer.parseInt(request.getParameter("bId"));
       if(request.getSession() == null || request.getSession().getAttribute("user") == null){
           response.sendRedirect("./Login");
       }else{
           request.setAttribute("bid", bid);
           BookDAO bdao= new  BookDAO();
           Book b=bdao.getBookById(bid);
           request.setAttribute("book", b);
           request.getRequestDispatcher("/views/book/report.jsp").forward(request, response);
       }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
