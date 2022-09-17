/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.User;

import Model.User;
import Model.Validator;
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
@WebServlet(name = "Profile", urlPatterns = {"/User/Profile"})

public class ProfileController extends HttpServlet {

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
        request.getRequestDispatcher("../views/user/Profile.jsp").forward(request, response);
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
        if (request.getParameter("action").equals("edit")) {
            request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);

        } else if (request.getParameter("action").equals("save")) {
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phoneNumber = request.getParameter("phone");
            String address = request.getParameter("address");
            Validator validator = new Validator();
            boolean err = false;

            if (!validator.getString(name)) {
                err = true;
                request.setAttribute("nameMessage1", "Name can not be empty.");
//                request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);
            }
            if (!validator.getName(name)) {
                err = true;
                request.setAttribute("nameMessage2", "Name have to have less than 40 alphabetic characters or space characters.");
//                request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);
            }
            if (!validator.getString(phoneNumber)) {
                err = true;
                request.setAttribute("phoneMessage", "Phone number can not be empty.");
            }
            if (err) {
                request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);
            } else {
                User user = (User) request.getSession().getAttribute("user");
                user.setName(name);
                user.setDob(dob);
                user.setGender(gender);
                user.setPhone(phoneNumber);
                user.setAddress(address);
                UserDAO userDBC = new UserDAO();
                userDBC.updateUser(user);
                request.getRequestDispatcher("../views/user/Profile.jsp").forward(request, response);
            }

        } else if (request.getParameter("action").equals("clear")) {
            request.getRequestDispatcher("../views/user/Profile.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/User/Security");
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
