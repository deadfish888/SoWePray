/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.User;
import context.UserDAO;
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
@WebServlet("/UserManager")
public class UserManagement extends HttpServlet {

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
        HttpSession session = request.getSession();
        User us = (User) session.getAttribute("admin");
        UserDAO dao = new UserDAO();
        ArrayList<User> users = dao.getByAccess(us.is_super());

        request.setAttribute("users", users);
        request.getRequestDispatcher("./manage/UserList.jsp").forward(request, response);
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        User us = (User) session.getAttribute("admin");
        UserDAO dao = new UserDAO();
        if (request.getParameter("id_ban") != null) {
            dao.disableUser(Integer.parseInt(request.getParameter("id_ban")));
        }
        if (request.getParameter("id_up") != null) {
            dao.editRank(Integer.parseInt(request.getParameter("id_up")), 1);
        }
        if (request.getParameter("id_down") != null) {
            dao.editRank(Integer.parseInt(request.getParameter("id_down")), -1);
        }
        ArrayList<User> users = dao.getByAccess(us.is_super());

        if (request.getParameter("txt") != null) {
            users = dao.searchByUname(us.is_super(), "%" + request.getParameter("txt") + "%");
            request.setAttribute("txt", request.getParameter("txt"));
        }
        request.setAttribute("users", users);
        request.getRequestDispatcher("./manage/UserList.jsp").forward(request, response);
    }
}
