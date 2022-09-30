/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import Model.User;
import context.RatingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ttaad
 */
@WebServlet("/Rating")
public class RatingController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { 
        RatingDAO rdao=new RatingDAO();
        int bid=Integer.parseInt(request.getParameter("bId"));
        String getRate=request.getParameter("getRate");
        int rate=0;
        if(getRate.equalsIgnoreCase("1")) rate=1;      
        if(getRate.equalsIgnoreCase("2")) rate=2;        
        if(getRate.equalsIgnoreCase("3")) rate=3;
        if(getRate.equalsIgnoreCase("4")) rate=4;
        if(getRate.equalsIgnoreCase("5")) rate=5;
        User user=(User)request.getSession().getAttribute("user");
        int uid=user.getId();
        if(request.getParameter("gRate")!=null){
            if(rdao.checkExist(bid, uid)==false)rdao.addStar(bid, uid, rate);
            if(rdao.checkExist(bid, uid)==true)rdao.updateStar(bid, uid, rate);
            response.sendRedirect("/book-details.jsp");
            response.setHeader("REFRESH", "0");
        }
        float aveRate=rdao.getAverageStar(bid);
        rdao.sendRatetoBook(bid, aveRate);
        request.setAttribute("star", aveRate);   
         
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
