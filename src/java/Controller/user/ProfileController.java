/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.User;

import Model.auth.User;
import context.auth.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.Validator;

/* @author ACER */
@WebServlet(name="ProfileController", urlPatterns={"/User/Profile"})
public class ProfileController extends HttpServlet {
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
       switch (request.getParameter("action")) {
           case "edit":
               request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);
               break;
           case "save":
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
               }  if (!validator.getName(name)) {
                   err = true;
                   request.setAttribute("nameMessage2", "Name should have at least 1 character and less than 40 alphabetic characters or space characters.");
//                request.getRequestDispatcher("../views/user/EditProfile.jsp").forward(request, response);
               }  if (!validator.getString(phoneNumber)) {
                   err = true;
                   request.setAttribute("phoneMessage", "Phone number can not be empty.");
               }  if (err) {
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
               }  break;
           case "clear":
               request.getRequestDispatcher("../views/user/Profile.jsp").forward(request, response);
               break;
           default:
               response.sendRedirect(request.getContextPath() + "/User/Security");
               break;
       }
    }

}
