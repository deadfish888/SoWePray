/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.auth.User;
import Model.product.Author;
import context.auth.UserDAO;
import context.product.AuthorDAO;
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
@WebServlet("/Admin/Users")
public class UsersController extends HttpServlet {

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
        String xpage = (String) session.getAttribute("whichpage");
        int page;
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int size = users.size();
        int numPage = (size % 10 == 0) ? (size / 10) : (size / 10 + 1);
        int start = (page - 1) * 10;
        int end = Math.min(size, start + 10);
        users = dao.getByPage(users, start, end);
        session.setAttribute("xpage3", page);
        request.setAttribute("numPage3", numPage);
        request.setAttribute("users", users);
        request.getRequestDispatcher("../manage/user/users.jsp").forward(request, response);
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
        AuthorDAO authorDao = new AuthorDAO();
        User searchUser = new User();
        if (request.getParameter("id_ban") != null) {
            searchUser = dao.getUser(Integer.parseInt(request.getParameter("id_ban")));
            dao.disableUser(searchUser.getId());
        }
        if (request.getParameter("id_up") != null) {
            searchUser = dao.getUser(Integer.parseInt(request.getParameter("id_up")));
            dao.editRank(searchUser.getId(), 1);
        }
        if (request.getParameter("id_down") != null) {
            searchUser = dao.getUser(Integer.parseInt(request.getParameter("id_down")));
            dao.editRank(searchUser.getId(), -1);
        }
        String xpage = (String) session.getAttribute("whichpage");
        int page;
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        ArrayList<User> users = dao.getByAccess(us.is_super());
        if (request.getParameter("txt") != null) {
            users = dao.searchByUname(us.is_super(), "%" + request.getParameter("txt") + "%");
            request.setAttribute("txt", request.getParameter("txt"));
            page = 1;
        }
        
        int size = users.size();
        int numPage = (size % 10 == 0) ? (size / 10) : (size / 10 + 1);
        int start = (page - 1) * 10;
        int end = Math.min(size, start + 10);
        users = dao.getByPage(users, start, end);
        session.setAttribute("xpage3", page);
        request.setAttribute("numPage3", numPage);
        request.setAttribute("users", users);
        request.getRequestDispatcher("../manage/user/users.jsp").forward(request, response);
    }
}
