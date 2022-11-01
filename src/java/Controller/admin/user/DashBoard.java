/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.product.Author;
import Model.auth.User;
import context.action.CommentDAO;
import context.product.BookDAO;
import context.auth.UserDAO;
import context.product.AuthorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author duypham0705
 */
@WebServlet("/Admin/DashBoard")
public class DashBoard extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    AuthorDAO aDao = new AuthorDAO();
    UserDAO uDao = new UserDAO();
    BookDAO bDao = new BookDAO();
    CommentDAO cDao = new CommentDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Author> listAuthor = aDao.getAllAuthor();
        ArrayList<Author> listUserAu = aDao.getAllUser();
        int a = listAuthor.size();
        int b = listUserAu.size();
        double ret = (double) a / (a + b) * 100;
        int per = (int) ret;

        Date date = new Date();
        ArrayList<User> listUser = uDao.getAllUsers();
        ArrayList<Integer> listQuater = aDao.getNumQuater(date.getYear() + 1900, date.getYear() + 1899);
        ArrayList<Integer> listYear = new ArrayList<>();
        for (int i = 0; i < date.getMonth(); i++) {
            listYear.add(aDao.getNumYear(i + 1, date.getYear() + 1900));
        }
        for (int i = date.getMonth(); i < 12; i++) {
            listYear.add(0);
        }
        int sum = 0;
        for (int i = 0; i < 12; i++) {
            request.setAttribute("m" + i, listYear.get(i));
            sum += listYear.get(i);
        }
        request.setAttribute("sum", sum);
        request.setAttribute("thisYear", date.getYear() + 1900);
        request.setAttribute("forYear", date.getYear() + 1899);

        request.setAttribute("books", bDao.countBookNumber());
        request.setAttribute("cmt", cDao.count());

        request.setAttribute("listQuater", listQuater);
        request.setAttribute("max", getMax(listQuater));
        request.setAttribute("totalU", listUser.size());

        request.setAttribute("totalA", a + b);
        request.setAttribute("per1", per);
        request.setAttribute("per2", 100 - per);
        request.getRequestDispatcher("../manage/dashboard.jsp").forward(request, response);
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
        processRequest(request, response);
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

    private int getMax(ArrayList<Integer> listQuater) {
        int max = 0;
        for (Integer item : listQuater) {
            if (item > max) {
                max = item;
            }
        }
        return max;
    }

}
