/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.payment;

import Model.payment.PaymentMethod;
import Model.payment.Transaction;
import Model.auth.User;
import context.payment.PaymentAccountDAO;
import context.payment.PaymentMethodDAO;
import context.payment.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Calendar;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

/**
 *
 * @author Silver_000
 */
@WebServlet(name = "RechargeController", urlPatterns = {"/User/Deposit"})
public class RechargeController extends HttpServlet {

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
        request.getRequestDispatcher("../views/user/Recharge.jsp").forward(request, response);
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
//        try {
                //Tao transaction gui cho admin
                TransactionDAO transDAO = new TransactionDAO();
                User user = (User) request.getSession().getAttribute("user");
                float amount = Float.parseFloat(request.getParameter("amount"));
//                float walletBalance = user.getPaymentAccount().getBalance() + amount;

                Transaction transaction = new Transaction();
                transaction.setUser(user);
                transaction.setAmount(amount);
//                transaction.setBalanceAfter(walletBalance);
                transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
                transaction.setType(1);
                transaction.setStatus(1);
                transaction.setDescription("Deposit into wallet.");
//                System.out.println(transaction);
//                transaction.setPayment(paymentMethod);
//                payAccDAO.update(paymentMethod.getPaymentAccount());
//                payAccDAO.update(user.getPaymentAccount());
                transDAO.insert(transaction);

                response.sendRedirect(request.getContextPath() + "/User/Payment");
//        } catch (Exception e) {
//            response.sendRedirect(request.getContextPath() + "/User/Payment");
//        }
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
