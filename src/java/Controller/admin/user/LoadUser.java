/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.auth.User;
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
@WebServlet("/Admin/LoadUser")

public class LoadUser extends HttpServlet {

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
        HttpSession session = request.getSession();
        String xpage = request.getParameter("xpage3");
        session.setAttribute("whichpage", xpage);
        response.sendRedirect("Users");
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
        String order = (String) session.getAttribute("order");
        String txtSearch = request.getParameter("type");
        UserDAO dao = new UserDAO();
        ArrayList<User> users = new ArrayList<>();
        if (order == null) {
            order = "0";
        }
        int run_way = Integer.parseInt(order);
        if (txtSearch.equals("1")) {
            users = dao.sortUser(us.is_super(), "fullname", Integer.parseInt(order));
        }
        if (txtSearch.equals("2")) {
            users = dao.sortUser(us.is_super(), "username", Integer.parseInt(order));

        }
        if (txtSearch.equals("3")) {
            users = dao.sortUser(us.is_super(), "email", Integer.parseInt(order));

        }
        if (txtSearch.equals("4")) {
            users = dao.sortUser(us.is_super(), "phone", Integer.parseInt(order));

        }
        if (txtSearch.equals("5")) {
            users = dao.sortUser(us.is_super(), "address", Integer.parseInt(order));

        }
        if (txtSearch.equals("6")) {
            users = dao.sortUser(us.is_super(), "is_super", Integer.parseInt(order));

        }
        run_way = (run_way + 1) % 2;

        session.setAttribute("order", Integer.toString(run_way));
        users = dao.getByPage(users, 0, 10);
        PrintWriter out = response.getWriter();
        int i = 0;
        for (User u : users) {
            out.println("<form action=\"UserManager\" method=\"Post\">\n"
                    + "                                                    <tr>\n"
                    + "                                                        <td>" + (++i) + "</td>\n"
                    + "                                                        <td width=\"15%\">" + u.getName() + "</td>\n"
                    + "                                                        <td style=\"width: 200px;\">" + u.getUsername() + "</td>\n"
                    + "                                                        <td>" + u.getEmail() + "</td>\n"
                    + "                                                        <td>" + u.getPhone() + "</td>\n"
                    + "                                                        <td width=\"200px\">" + u.getAddress() + "</td>\n"
                    + "                                                        <td>" + u.is_super() + "</td>\n"
                    + "\n");
            if (u.is_super() == 0) {
                out.println("<td><button class=\"btn btn-primary\" name=\"id_up\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-up-long\"></i></button></td>\n");
            } else if (u.is_super() + 1 == us.is_super()) {
                out.println("<td></td>\n"
                        + "                                                                <td><button class=\"btn btn-primary\" name=\"id_down\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-down-long\"></i></button></td>\n"
                        + "                                                                <td><button class=\"btn btn-primary\" name=\"id_ban\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-user-slash\"></i></button></td>");
            } else {
                out.println("<td><button class=\"btn btn-primary\" name=\"id_up\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-up-long\"></i></button></td>\n"
                        + "                                                                <td><button class=\"btn btn-primary\" name=\"id_down\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-down-long\"></i></button></td>\n"
                        + "                                                                <td><button class=\"btn btn-primary\" name=\"id_ban\" value=\"${s.getId()}\" type=\"submit\"><i class=\"fa-solid fa-user-slash\"></i></button></td>");
            }
            out.println("                                                    </tr>\n"
                    + "                                                </form>");
        }
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
