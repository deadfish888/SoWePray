/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.transaction;

import Model.auth.User;
import Model.payment.Transaction;
import Model.product.Product;
import context.payment.TransactionDAO;
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
 * @author Silver_000
 */
@WebServlet(name = "AdminTransactionController", urlPatterns = {"/Admin/Transaction"})
public class AdminTransactionController extends HttpServlet {

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
        request.getRequestDispatcher("../views/admin/Transaction.jsp").forward(request, response);
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
        TransactionDAO transactionDAO = new TransactionDAO();
        ArrayList<Transaction> transactionList = transactionDAO.getAll();
        request.setAttribute("transactionList", transactionList);
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
        Transaction tempTrans = new Transaction();
        String userId = request.getParameter("userId");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String productId = request.getParameter("productId");
            if (userId != null && !userId.equals("")) {
                User user = new User();
                user.setId(Integer.parseInt(userId));
                tempTrans.setUser(user);
            }
            if (type != null && !type.equals("")) {
                tempTrans.setType(Integer.parseInt(type));
            }
            if (status != null && !status.equals("")) {
                tempTrans.setStatus(Integer.parseInt(status));
            }
            if (productId != null && !productId.equals("")) {
                tempTrans.setProduct(new Product(productId));
            }
            TransactionDAO transactionDAO = new TransactionDAO();
            ArrayList<Transaction> transactionList = transactionDAO.search(tempTrans);
            request.setAttribute("transactionList", transactionList);
            request.setAttribute("tempTrans", tempTrans);
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

}