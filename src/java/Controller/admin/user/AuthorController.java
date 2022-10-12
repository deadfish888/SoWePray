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
        ArrayList<Author> listAuthor = resize(author.getAllAuthor());
        ArrayList<Author> listUser = resize(author.getAllUser());

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
        if (request.getParameter("fullname")!=null) {
             int id = Integer.parseInt(request.getParameter("id_au"));
        String name = request.getParameter("fullname");
        author.updateAu(id, name);
        }
        
        ArrayList<Author> listAuthor = resize(author.getAllAuthor());
        ArrayList<Author> listUser = resize(author.getAllUser());
        if (request.getParameter("txt") != null) {
            listAuthor = resize(author.searchByUAname("%" + request.getParameter("txt") + "%")) ;
            request.setAttribute("txt", request.getParameter("txt"));
        }
        if (request.getParameter("stxt") != null) {
            listUser = resize(author.searchByUname("%" + request.getParameter("stxt") + "%")) ;
            request.setAttribute("stxt", request.getParameter("stxt"));
        }
        
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

    private ArrayList<Author> resize(ArrayList<Author> allAuthor) {
        ArrayList<Author> ret = new ArrayList<>();
        String xpage = null;
        int page;
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int size = allAuthor.size();
        int numPage = (size % 10 == 0) ? (size / 10) : (size / 10 + 1);
        int start = (page - 1) * 10;
        int end = Math.min(size, start + 10);
        return author.getByPage(allAuthor, start, end);
    }

}
