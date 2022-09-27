/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import context.RatingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ttaad
 */
public class RatingController extends HttpServlet {
   

    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int bid=Integer.parseInt(request.getParameter("bId"));
        String rate=request.getParameter("rate");
        int star=0;
        if(rate=="star1"){
            star=1;
        }
        if(rate=="star2"){
            star=2;
        }
        if(rate=="star3"){
            star=3;
        }
        if(rate=="star4"){
            star=4;
        }
        if(rate=="star5"){
            star=5;
        }
        
        RatingDAO rdao=new RatingDAO();
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
