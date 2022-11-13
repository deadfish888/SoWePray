/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Model.action.Ticket;
import Model.auth.User;
import Model.product.Author;
import context.action.TicketDAO;
import context.auth.UserDAO;
import context.product.AuthorDAO;
import java.io.IOException;
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
@WebServlet(name = "SupportController", urlPatterns = {"/User/Support"})
public class SupportController extends HttpServlet {

    TicketDAO rpDao = new TicketDAO();
    AuthorDAO auDao = new AuthorDAO();
    UserDAO uDao = new UserDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        try {
            User user = (User) request.getSession().getAttribute("user");

            ArrayList<Ticket> listRead = new ArrayList<Ticket>();
            String type = (String) request.getParameter("type");
            int p;
            if (type == null) {
                p = 0;
            } else {
                p = Integer.parseInt(type);
            }
            if (p == 0) {
                listRead = rpDao.getRead(user.getId());
            }
            if (p == 1) {
                listRead = rpDao.getUnRead(user.getId());
                if (listRead.size() > 0) {
                    request.setAttribute("okok", "yes");
                }
            }
            if (p == 2) {
                listRead = rpDao.getSent(user.getId());
            }
            for (Ticket ticket : listRead) {
                System.out.println(ticket.getNote());
            }
            Author check = auDao.getAuthorByUserId(user.getId());
            boolean valid = rpDao.hasSent(user.getId());
            if (user.is_super() == 0 && !valid || auDao.getViews(check.getId()) >= 5000 && !valid && user.is_super() < 3) {

                request.setAttribute("forTick", "oke");
            }
            request.setAttribute("reads", listRead);
            request.getRequestDispatcher("../views/user/Support.jsp").forward(request, response);
        } catch (Exception e) {
        }
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
        response.setContentType("text/html;charset=UTF-8");

        request.removeAttribute("forTick");
        User user = (User) request.getSession().getAttribute("user");
        String txt = request.getParameter("txt").toString();

        if (user.is_super() == 0) {
            if (uDao.isVIP(user.getId())) {
                rpDao.passReport(3, user.getId(), "Your request has been apporved", true);
                uDao.editRank(user.getId(), 1);
                response.sendRedirect("../Logout");
                return;
            } else {
                rpDao.senndReport(3, user.getId(), txt);
            }
            response.sendRedirect("Support");

            return;
        }
        if (uDao.isVIP(user.getId())) {
            rpDao.passReport(4, user.getId(), "Your request has been apporved", true);
            uDao.editRank(user.getId(), (3 - user.is_super()));
            response.sendRedirect("../Logout");
            return;
        } else {
            rpDao.senndReport(4, user.getId(), txt);
        }
        response.sendRedirect("Support");
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
