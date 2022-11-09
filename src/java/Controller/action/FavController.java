/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.action.Favourite;
import Model.auth.User;
import context.action.FavouriteDAO;
import java.io.IOException  ;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ttaad
 */
@WebServlet(name = "FavController", urlPatterns = {"/Fav"})
public class FavController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bId = Integer.parseInt(request.getParameter("bId"));
        FavouriteDAO fdao = new FavouriteDAO();
        boolean check = false;
        if (request.getSession() != null || request.getSession().getAttribute("user") != null) {
            User user = (User) request.getSession().getAttribute("user");
            int uId = user.getId();
            if (fdao.checkFavourite(uId, bId) == true) {
                check = true;
            } else {
                check = false;
            }
        }
        request.setAttribute("check", check);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bId = Integer.parseInt(request.getParameter("bId"));
        FavouriteDAO fdao = new FavouriteDAO();
        User user = (User) request.getSession().getAttribute("user");
        int uId = user.getId();
        fdao.deleteFavourite(uId, bId);
        ArrayList<Favourite> list=fdao.getAllFav(bId);
        int count=list.size();
        fdao.sendFavtoBook(count,bId);
        response.sendRedirect("./BookDetail?id="+bId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
