/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth;

import Model.auth.User;
import context.action.TicketDAO;
import context.auth.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* @author ACER */
@WebServlet("/Login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getParameter("origin");
        request.setAttribute("origin", referer);
        forward(request, response, "/views/auth/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String key = request.getParameter("username");
        String pass = request.getParameter("password");
        String origin = request.getParameter("origin");
        if (origin.equals("")) {
            origin = "./Home";
        }

        UserDAO ud = new UserDAO();
        User user = ud.getUser(key, pass);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.is_super() >= 4) {
                session.setAttribute("admin", user);
                TicketDAO rp = new TicketDAO();
                if (rp.count() > 0) {
                    session.setAttribute("number", rp.count());
                }
                response.sendRedirect("Admin/DashBoard");
                return;
            }
            Cookie name = new Cookie("name", key);
            Cookie password = new Cookie("pass", pass);
            name.setMaxAge(3600 * 24);
            password.setMaxAge(3600 * 24);
            response.addCookie(name);
            response.addCookie(password);
            response.sendRedirect(origin);
        } else {
            request.setAttribute("origin", request.getParameter("origin"));
            request.setAttribute("error", "Username or password wrong!");
            forward(request, response, "/views/auth/login.jsp");
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
