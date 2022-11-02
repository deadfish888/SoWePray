/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.action.Ticket;
import Model.auth.User;
import Model.payment.Transaction;
import context.action.TicketDAO;
import context.auth.UserDAO;
import context.payment.TransactionDAO;
import context.product.BookDAO;
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
 * @author duypham0705
 */
@WebServlet(name = "UserActionController", urlPatterns = {"/Admin/Activities"})
public class UserActionController extends HttpServlet {

    UserDAO uDao = new UserDAO();
    TransactionDAO tranDao = new TransactionDAO();
    TicketDAO ticDao = new TicketDAO();
    BookDAO bDao = new BookDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserActionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserActionController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = uDao.getUser(id);
        ArrayList<Transaction> listT = tranDao.getTransactionList(user);
        ArrayList<Ticket> listR = ticDao.getAction(id);

        String xpage1 = request.getParameter("xpage10");
        int page1;
        if (xpage1 == null) {
            page1 = 1;
        } else {
            page1 = Integer.parseInt(xpage1);
        }
        int size1 = listT.size();
        int numPage1 = (size1 % 10 == 0) ? (size1 / 10) : (size1 / 10 + 1);
        int start1 = (page1 - 1) * 10;
        int end1 = Math.min(size1, start1 + 10);

        String xpage2 = request.getParameter("xpage20");
        int page2;
        if (xpage2 == null) {
            page2 = 1;
        } else {
            page2 = Integer.parseInt(xpage2);
        }
        int size2 = listR.size();
        int numPage2 = (size2 % 10 == 0) ? (size2 / 10) : (size2 / 10 + 1);
        int start2 = (page2 - 1) * 10;
        int end2 = Math.min(size2, start2 + 10);

        listT = tranDao.getByPage(listT, start1, end1);
        listR = ticDao.getByPage(listR, start2, end2);
        request.setAttribute("xpage10", page1);
        request.setAttribute("numPage10", numPage1);
        request.setAttribute("xpage20", page2);
        request.setAttribute("numPage20", numPage2);
        request.setAttribute("userA", user);
        request.setAttribute("numberNovel", bDao.countNovel(user));
        request.setAttribute("numberBook", bDao.getOwnBooks(user).size());

        request.setAttribute("listA", listT);
        request.setAttribute("listU", listR);
        request.getRequestDispatcher("../manage/user/activities.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
