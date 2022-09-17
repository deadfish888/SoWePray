/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Model.User;
import Model.Validator;
import context.DBContext;
import context.UserDAO;
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
@WebServlet(name = "ChangePassword", urlPatterns = {"/User/ChangePassword"})
public class ChangePasswordController extends HttpServlet {

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
        request.getRequestDispatcher("../views/user/Security.jsp").forward(request, response);
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
//        String old_password = request.getParameter("oldPassword");
//        String new_password = request.getParameter("newPassword");
//        String confirm_password = request.getParameter("confirmPassword");

        UserDAO userDBC = new UserDAO();
        User user = (User) request.getSession().getAttribute("user");
        if (user.getPassword().equals(request.getParameter("currentPassword"))) {
            Validator validator = new Validator();
            if (validator.getPassword(request.getParameter("newPassword"))) {
                if (request.getParameter("newPassword").equals(request.getParameter("confirmPassword"))) {
                    user.setPassword(request.getParameter("newPassword"));
                    userDBC.changePassword(user.getId(), request.getParameter("newPassword"));
            request.setAttribute("processMessage", "Change password successfully.");
                } else {
                    request.setAttribute("confirm_pass_noti", "Confirm password is not match with new password.");
                    request.setAttribute("processMessage", "Change password fail.");
                }
            } else {
                request.setAttribute("new_pass_noti", "New password is invalid.");
                request.setAttribute("processMessage", "Change password fail.");
            }
        } else {
            request.setAttribute("old_pass_noti", "Old password is wrong.");
            request.setAttribute("processMessage", "Change password fail.");
        }
        request.getRequestDispatcher("../views/user/Security.jsp").forward(request, response);
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
