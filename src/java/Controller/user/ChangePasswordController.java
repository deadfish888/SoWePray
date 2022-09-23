/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.user;

import Model.User;
import utils.Validator;
import context.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* @author ACER */
@WebServlet(name="ChangePassword", urlPatterns={"/User/ChangePassword"})
public class ChangePasswordController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("../views/user/Security.jsp").forward(request, response);
    }

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

}
