/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth;

import context.auth.TokenDAO;
import context.auth.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.mail.MessagingException;
import utils.MyUtil;

/* @author ACER */
@WebServlet("/Forgot")
public class ForgotController extends HttpServlet {

    private String user;
    private String pass;
    
    @Override
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getParameter("origin");
        request.setAttribute("origin", referer);
        String token = request.getParameter("token");
        request.setAttribute("token", token);
        if (token != null) {
            UserDAO ud = new UserDAO();
            String generatedPass = ud.resetPassword(token);
            if (generatedPass == null) {
                request.setAttribute("Message", "Link expired!");
            }else request.setAttribute("newpassword", generatedPass);
        }
        forward(request, response, "/views/auth/forgot.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String recipient = request.getParameter("email");
        String subject = "Password Reset request for your Bookie account";
        String Message = "";
        UserDAO ud = new UserDAO();
        TokenDAO td = new TokenDAO();
        try {
            int userId = ud.checkEmailExisted(recipient);
            if (userId != 0) {
                String token = td.createResetToken(userId);
                String content = "Hi there,<br>"
                        + "<br>"
                        + "There was a request to change your password!<br>"
                        + "<br>"
                        + "If you did not make this request then please ignore this email.<br>"
                        + "<br>" 
                        + "Otherwise, please click this link to change your password: "
                        + "<a href=\"http://localhost:8080/Bookie/Forgot?token="+token+"\"><i>It's me, DIO!<i></a>";
                MyUtil.sendEmail(user, pass, recipient, subject, content);
                Message = "Instruction mail has been sent to your email!";
            } else {
                Message = "Email is not registered! Please try again!";
            }
        } catch (MessagingException ex) {
            Message = "Connection error! ";
        } finally {
            request.setAttribute("Message", Message);
            forward(request, response, "/views/auth/forgot.jsp");
        }
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }

}
