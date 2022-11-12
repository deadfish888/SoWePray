/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.user;

import Model.product.Author;
import context.product.AuthorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author duypham0705
 */
@WebServlet(name = "Author", urlPatterns = {"/Admin/Author"})
public class AuthorController extends HttpServlet {

    AuthorDAO author = new AuthorDAO();

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ArrayList<Author> listAuthor = (author.getAllAuthor());
        ArrayList<Author> listUser = (author.getAllUser());

        String xpage1 = (String) session.getAttribute("whichpage1");
        int page1;
        if (xpage1 == null) {
            page1 = 1;
        } else {
            page1 = Integer.parseInt(xpage1);
        }
        int size1 = listAuthor.size();
        int numPage1 = (size1 % 10 == 0) ? (size1 / 10) : (size1 / 10 + 1);
        int start1 = (page1 - 1) * 10;
        int end1 = Math.min(size1, start1 + 10);

        String xpage2 = (String) session.getAttribute("whichpage2");
        int page2;
        if (xpage2 == null) {
            page2 = 1;
        } else {
            page2 = Integer.parseInt(xpage2);
        }
        int size2 = listUser.size();
        int numPage2 = (size2 % 10 == 0) ? (size2 / 10) : (size2 / 10 + 1);
        int start2 = (page2 - 1) * 10;
        int end2 = Math.min(size2, start2 + 10);

        listAuthor = author.getByPage(listAuthor, start1, end1);
        listUser = author.getByPage(listUser, start2, end2);

        session.setAttribute("xpage1", page1);
        request.setAttribute("numPage1", numPage1);
        session.setAttribute("xpage2", page2);
        request.setAttribute("numPage2", numPage2);
        request.setAttribute("listA", listAuthor);
        request.setAttribute("listU", listUser);
        request.getRequestDispatcher("../manage/user/author.jsp").forward(request, response);
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
        if (!request.getParameter("fullname").isEmpty()) {
            int id = Integer.parseInt(request.getParameter("id_au"));
            String name = request.getParameter("fullname");
            System.out.println(name);
            author.updateAu(id, name);
        }

        HttpSession session = request.getSession();
        ArrayList<Author> listAuthor = (author.getAllAuthor());
        ArrayList<Author> listUser = (author.getAllUser());

        String xpage1 = (String) session.getAttribute("whichpage1");
        int page1;
        if (xpage1 == null) {
            page1 = 1;
        } else {
            page1 = Integer.parseInt(xpage1);
        }

        String xpage2 = (String) session.getAttribute("whichpage2");
        int page2;
        if (xpage2 == null) {
            page2 = 1;
        } else {
            page2 = Integer.parseInt(xpage2);
        }

        if (request.getParameter("txt") != null) {
            listAuthor = (author.searchByUAname("%" + request.getParameter("txt") + "%"));
            request.setAttribute("txt", request.getParameter("txt"));
            page1 = 1;
            page2 = 1;
        }
        if (request.getParameter("stxt") != null) {
            listUser = (author.searchByUname("%" + request.getParameter("stxt") + "%"));
            request.setAttribute("stxt", request.getParameter("stxt"));
            page1 = 1;
            page2 = 1;
        }
        int size1 = listAuthor.size();
        int numPage1 = (size1 % 10 == 0) ? (size1 / 10) : (size1 / 10 + 1);
        int start1 = (page1 - 1) * 10;
        int end1 = Math.min(size1, start1 + 10);

        int size2 = listUser.size();
        int numPage2 = (size2 % 10 == 0) ? (size2 / 10) : (size2 / 10 + 1);
        int start2 = (page2 - 1) * 10;
        int end2 = Math.min(size2, start2 + 10);

        listAuthor = author.getByPage(listAuthor, start1, end1);
        listUser = author.getByPage(listUser, start2, end2);

        session.setAttribute("xpage1", page1);
        request.setAttribute("numPage1", numPage1);
        session.setAttribute("xpage2", page2);
        request.setAttribute("numPage2", numPage2);
        request.setAttribute("listA", listAuthor);
        request.setAttribute("listU", listUser);
        request.getRequestDispatcher("../manage/user/author.jsp").forward(request, response);
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
