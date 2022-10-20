/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth;

import Model.auth.User;
import Model.product.Author;
import context.auth.UserDAO;
import context.product.AuthorDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/* @author ACER */
@WebServlet("/Signup")
public class SignupController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getParameter("origin");
        request.setAttribute("origin", referer);
        forward(request, response, "/views/auth/signup.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String key = request.getParameter("username");
        String pass = request.getParameter("password");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("birthday");
        String gender = request.getParameter("gender");

        UserDAO ud = new UserDAO();
        User user = new User(name, gender, dob, email, phone, key, pass);
        if (ud.checkEmailExisted(email) != 0) {
            request.setAttribute("in4", user);
            request.setAttribute("error", "The email had already been registered!");
            request.setAttribute("origin", request.getParameter("origin"));
            forward(request, response, "/views/auth/signup.jsp");
            return;
        }
        if (ud.checkUsernameExisted(key) != 0) {
            request.setAttribute("in4", user);
            request.setAttribute("error", "Existed username!");
            request.setAttribute("origin", request.getParameter("origin"));
            forward(request, response, "/views/auth/signup.jsp");
        } else {
            HttpSession session = request.getSession();
            String origin = request.getParameter("origin");
            if (origin.equals("")) {
                origin = "./Home";
            }

//            ud.createNewUser(name, gender, dob, email, phone ,key, pass);
            user.setIs_super(1);
            ud.addUser(user);

            user = ud.getByUsername(key);
            user.createWallet();
            ud.setWalletNumber(user.getPaymentAccount(), user);
            AuthorDAO au = new AuthorDAO();
            au.addSignup(user.getId(),user.getName());
            session.setAttribute("user", user);

            request.setAttribute("error", "Sign up successfully!");
            request.setAttribute("origin", request.getParameter("origin"));
            response.sendRedirect(origin);
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
