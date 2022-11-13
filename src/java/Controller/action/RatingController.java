/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.action;

import Model.auth.User;
import context.action.RatingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Rating")
public class RatingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            RatingDAO rdao = new RatingDAO();
            int bid = Integer.parseInt(request.getParameter("bId"));
            if (request.getParameter("getRate") == null) {
                response.sendRedirect("./BookDetail?id=" + bid);
            }
            int rate = Integer.parseInt(request.getParameter("getRate"));
            User user = (User) request.getSession().getAttribute("user");
            int uid = user.getId();
            if (rdao.checkExist(bid, uid) == false) {
                rdao.addStar(bid, uid, rate);
            } else {
                rdao.updateStar(bid, uid, rate);
            }
            float aveRate = rdao.getAverageStar(bid);
            rdao.sendRatetoBook(bid, aveRate);
            response.sendRedirect("./BookDetail?id=" + bid);
        } catch (Exception e) {

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
