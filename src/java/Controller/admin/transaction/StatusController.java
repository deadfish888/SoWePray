/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.transaction;

import Model.auth.User;
import Model.payment.Transaction;
import context.auth.UserDAO;
import context.payment.PaymentAccountDAO;
import context.payment.TransactionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author Silver_000
 */
@WebServlet(name = "StatusController", urlPatterns = {"/Admin/Status"})
public class StatusController extends HttpServlet {

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
        TransactionDAO transactionDAO = new TransactionDAO();
//        UserDAO userDAO = new UserDAO();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();

        long transactionId = Long.parseLong(request.getParameter("transactionId"));
        Transaction transaction = new Transaction();
        transaction.setTransactionId(transactionId);
        transaction = transactionDAO.get(transaction);
        int status = Integer.parseInt(request.getParameter("upStatus"));
        transaction.setStatus(status);

        User transUser = transaction.getUser();
        if (status == 1) {
            transaction.setBalanceAfter(transUser.getPaymentAccount().getBalance());
        } else if (status == 3) {
            if (transaction.getType() == 1) {
                transUser.getPaymentAccount().setBalance(transUser.getPaymentAccount().getBalance() + transaction.getAmount());
                transaction.setBalanceAfter(transUser.getPaymentAccount().getBalance());
            } else {
                transUser.getPaymentAccount().setBalance(transUser.getPaymentAccount().getBalance() - transaction.getAmount());
                transaction.setBalanceAfter(transUser.getPaymentAccount().getBalance());
            }
            payAccDAO.update(transUser.getPaymentAccount());
        }
        transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
        transactionDAO.update(transaction);
        response.sendRedirect(request.getContextPath() + "/Admin/Transaction");
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

}
