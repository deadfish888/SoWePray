/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin.transaction;

import Model.payment.PaymentAccount;
import Model.payment.Transaction;
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
        try {
            TransactionDAO transactionDAO = new TransactionDAO();
            PaymentAccountDAO payAccDAO = new PaymentAccountDAO();

            long transactionId = Long.parseLong(request.getParameter("transactionId"));
            Transaction transaction = new Transaction();
            transaction.setTransactionId(transactionId);
            transaction = transactionDAO.get(transaction);
            int status = Integer.parseInt(request.getParameter("upStatus"));

            PaymentAccount payAcc = transaction.getUser().getPaymentAccount();
            if (status == 3) {
                if (transaction.getType() == 1) {
                    payAcc.setBalance(payAcc.getBalance() + transaction.getAmount());
                } else {
                    //If amount in wallet is not enough to finish transaction, change to fail
                    if (transaction.getAmount() <= payAcc.getBalance()) {
                        payAcc.setBalance(payAcc.getBalance() - transaction.getAmount());
                    } else {
                        status = 1;
                        transaction.setDescription(transaction.getDescription() + "\nCause of failure: Balance in your wallet is not enough to finish this transaction.");
                        request.getSession().setAttribute("error", "Balance in wallet of user " + transaction.getUser().getId() + " is not enough.");
                    }
                }
                payAccDAO.update(payAcc);
            } else {
                transaction.setDescription(transaction.getDescription() + "\nCause of failure: " + request.getParameter("rejectReason"));
            }
            transaction.setBalanceAfter(payAcc.getBalance());
            transaction.setStatus(status);
            transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
            transactionDAO.update(transaction);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", e.getMessage());
        }
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
