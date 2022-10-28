/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.action.Report;
import Model.auth.User;
import context.action.ReportDAO;
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
@WebServlet({"/Admin/Report"})
public class ReportController extends HttpServlet {

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
    ReportDAO rpDao = new ReportDAO();
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

        ArrayList<Report> listRead = rpDao.getAll();
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

        request.getRequestDispatcher("../manage/report.jsp").forward(request, response);
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
            Report rp = rpDao.getRP(Integer.parseInt(request.getParameter("id_pass")));
            rpDao.setStatus(rp.getId(), true);
            if (rp.getTypeID() == 3) {
                uDao.editRank(rp.getUid(), 1);
            }
            if (rp.getTypeID() == 4) {
                 User us = uDao.getUser(rp.getUid());
                uDao.editRank(rp.getUid(), (3-us.is_super()));
            }
        }
        if (request.getParameter("id_reject") != null) {
            Report rp = rpDao.getRP(Integer.parseInt(request.getParameter("id_pass")));
            rpDao.setStatus(rp.getId(), false);
        }

        response.sendRedirect("Report");
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
