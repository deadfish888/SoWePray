/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin.book;

import context.BookDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/* @author ACER */
@WebServlet(name="ChangeStatusController", urlPatterns={"/Admin/ChangeStatus"})
public class ChangeStatusController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String xpage = request.getParameter("xpage");
        int page;
        if (xpage==null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            BookDAO bd = new BookDAO();
            bd.changeStatus(bookId);
            request.getRequestDispatcher("./Book?xpage="+page).forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ChangeStatusController.class.getName()).log(Level.SEVERE, null, ex);
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
