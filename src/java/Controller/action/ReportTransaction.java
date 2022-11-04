/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.action;

import Model.auth.User;
import context.action.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author ttaad
 */
@WebServlet(name = "ReportTrans", urlPatterns = {"/User/ReportTrans"})
public class ReportTransaction extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int uId = user.getId();
        String[] report = request.getParameterValues("report");
        int transactionId = Integer.parseInt(request.getParameter("transId"));
        int[] vioId = new int[report.length];
        int j = 0;
        for (String s : report) {
            vioId[j++] = Integer.parseInt(s);
        }
        String note = request.getParameter("note");
        ReportDAO redao = new ReportDAO();
        redao.addReport(vioId, transactionId, uId, note, 5);
        response.sendRedirect("./Payment");
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
