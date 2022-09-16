/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth;

import context.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import utils.EmailUtility;

/* @author ACER */
@WebServlet(name="ForgetPassword", urlPatterns={"/Forgot"})
public class ForgotController extends HttpServlet {

    private String host;
    private String port;
    private String user;
    private String pass;

    @Override
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = "smtp.gmail.com";
        port = "587";
        user = "anhktmhe163997@fpt.edu.vn";
        pass = "WhiteMoon";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getParameter("origin");
        request.setAttribute("origin", referer);
        forward(request, response, "/views/auth/forgot.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String recipient = request.getParameter("email");
        String subject = "New Pass";
        String Message = "";
        UserDAO ud = new UserDAO();

        try {
            if (ud.checkExistEmail(recipient)) {
                String generatedPass = ud.resetPassword(recipient);
                String content = "<i>Your brand new password:<i><br> "
                        + "<font color=red>" + generatedPass + "</font>";
                EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
                        content);
                Message = "New password was sent! Check your mail now.";
            } else {
                Message = "Email not match! Please try again!";
            }
        } catch (MessagingException ex) {
            Message = "There were an error! ";
        } finally {
            request.setAttribute("Message", Message);
            forward(request, response, "/views/auth/forgot.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }

}
