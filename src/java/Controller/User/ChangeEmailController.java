/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Model.auth.User;
import context.auth.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Silver_000
 */
@WebServlet(name = "ChangeEmailController", urlPatterns = {"/User/ChangeEmail"})
public class ChangeEmailController extends HttpServlet {

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
        UserDAO userDBC = new UserDAO();
        User user = (User) request.getSession().getAttribute("user");
        if (user.getPassword().equals(request.getParameter("password"))) {
            if (userDBC.checkEmailExisted(request.getParameter("newEmail")) == 0) {
                user.setEmail(request.getParameter("newEmail"));
                userDBC.changeEmail(user.getId(), request.getParameter("newEmail"));
                request.getSession().setAttribute("processMessage", "Your email is changed.");
            } else {
                request.getSession().setAttribute("error", "This email is duplicate.");
                request.getSession().setAttribute("processMessage", "Change email fail.");
            }
        } else {
            request.getSession().setAttribute("error", "Password is wrong.");
            request.getSession().setAttribute("processMessage", "Change email fail.");
        }
        response.sendRedirect(request.getContextPath() + "/User/Security");
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
