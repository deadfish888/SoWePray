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
import java.util.ArrayList;

/* @author ACER */
@WebServlet(name = "AdReportsController", urlPatterns = {"/Admin/Report"})
public class ReportsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String reportType = request.getParameter("type");
            String page = request.getParameter("page");
            String status = request.getParameter("status");

            if (page == null || page.trim().length() == 0) {
                page = "1";
            }
            int pageIndex = 0, pageSize = 12;
            try {
                pageIndex = Integer.parseInt(page);
                if (pageIndex <= 0) {
                    pageIndex = 1;
                }
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
            if (reportType == null || (!reportType.equals("book") && !reportType.equals("comment") && !reportType.equals("transaction"))) {
                reportType = "";
            }
            if (status == null || status.trim().length() == 0) {
                status = "";
            }

            ReportDAO rd = new ReportDAO();
            ArrayList<Report> reports = rd.getReports(reportType, status);

            int size = reports.size();
            int numPage = (int) Math.ceil((double) size / pageSize);
            int start = (pageIndex - 1) * pageSize;
            int end = Math.min(size, start + pageSize);

            reports = rd.getByPage(reports, start, end);
            request.setAttribute("page", pageIndex);
            request.setAttribute("numPage", numPage);

            request.setAttribute("listR", reports);
            request.getRequestDispatcher("../manage/report/reports.jsp").forward(request, response);
            return;
        } catch (Exception ex) {
            response.sendRedirect("../error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
