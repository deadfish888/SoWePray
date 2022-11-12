/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin.report;

import Model.report.Report;
import context.action.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* @author ACER */
@WebServlet(name="AdReportDetail", urlPatterns={"/Admin/ReportDetail"})
public class ReportDetailController extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ReportDAO rd = new ReportDAO();
        Report r = rd.getReportById(id);
        request.setAttribute("report", r);
        request.getRequestDispatcher("../manage/report/report-detail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");
        String service = request.getParameter("service");
        
        Boolean status = null;
        if (service.equals("close")) status = true;
        if (service.equals("reject")) status = false;
        
        ReportDAO rd = new ReportDAO();
        Report r = new Report();
        r.setId(id);
        r.setAction(action);
        r.setStatus(status);
        
        rd.solveReport(r);
        response.sendRedirect("./ReportDetail?id="+id);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
