/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.action.Ticket;
import Model.auth.User;
import context.action.TicketDAO;
import context.auth.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author duypham0705
 */
@WebServlet({"/Admin/Ticket"})
public class TickController extends HttpServlet {

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
            out.println("<title>Servlet ReportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    TicketDAO rpDao = new TicketDAO();
    UserDAO uDao = new UserDAO();

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

        ArrayList<Ticket> listRead = rpDao.getAll();
        HttpSession session = request.getSession();
        User us = (User) session.getAttribute("admin");

        String xpage = request.getParameter("xpage");
        int page;
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int size = listRead.size();
        int numPage = (int) Math.ceil((double) size / 10);
        int start = (page - 1) * 10;
        int end = Math.min(size, start + 10);
        listRead = rpDao.getByPage(listRead, start, end);
        request.setAttribute("xpage", page);
        request.setAttribute("numPage", numPage);
        request.setAttribute("baocao", listRead);

        request.getRequestDispatcher("../manage/ticket.jsp").forward(request, response);
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

        if (request.getParameter("id_pass") != null) {
            int in_pass = Integer.parseInt(request.getParameter("id_pass"));
            if (in_pass > 0) {
                Ticket rp = rpDao.getRP(in_pass);
                rpDao.setStatus(rp.getId(), true);
                if (rp.getTypeID() == 3) {
                    uDao.editRank(rp.getUid(), 1);
                } else if (rp.getTypeID() == 4) {
                    User us = uDao.getUser(rp.getUid());
                    uDao.editRank(rp.getUid(), (3 - us.is_super()));
                }
            } else {
                ArrayList<Ticket> listRead = rpDao.getAll();
                for (Ticket ticket : listRead) {
                    rpDao.setStatus(ticket.getId(), true);
                    if (ticket.getTypeID() == 3) {
                        uDao.editRank(ticket.getUid(), 1);
                    } else if (ticket.getTypeID() == 4) {
                        User us = uDao.getUser(ticket.getUid());
                        uDao.editRank(ticket.getUid(), (3 - us.is_super()));
                    }
                }
            }
        }
        if (request.getParameter("id_reject") != null) {
            int id_reject = Integer.parseInt(request.getParameter("id_reject"));
            if (id_reject > 0) {
                rpDao.setStatus(id_reject, false);
            } else {
                ArrayList<Ticket> listRead = rpDao.getAll();
                for (Ticket ticket : listRead) {
                    rpDao.setStatus(ticket.getId(), false);
                }
            }
        }

        HttpSession session = request.getSession();

        if (rpDao.count() == 0) {
            session.removeAttribute("number");
        } else {
            session.setAttribute("number", rpDao.count());
        }
        response.sendRedirect("Ticket");
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
