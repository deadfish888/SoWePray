/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.payment;

import Model.product.Book;
import Model.payment.PaymentAccount;
import Model.payment.PaymentMethod;
import Model.payment.Transaction;
import Model.auth.User;
import context.product.BookOwnDAO;
import context.payment.PaymentAccountDAO;
import context.payment.PaymentMethodDAO;
import context.payment.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author Silver_000
 */
@WebServlet(name = "PurchaseController", urlPatterns = {"/User/Purchase"})
public class PurchaseController extends HttpServlet {

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
        PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
        TransactionDAO transDAO = new TransactionDAO();

        float amount = Float.parseFloat(request.getParameter("amount"));

        User user = (User) request.getSession().getAttribute("user");
        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setUser(user);
        paymentMethod.setPaymentAccount(user.getPaymentAccount());

        if (amount > user.getPaymentAccount().getBalance()) {
//            request.setAttribute("walletNoti", "Balance in wallet is not enough to purchase this book.");
//            request.getRequestDispatcher("/BookDetail?id=" + request.getParameter("bookId")).forward(request, response);
            response.sendRedirect(request.getContextPath() + "/BookDetail?id=" + request.getParameter("bookId"));
        } else {
            float walletBalance = user.getPaymentAccount().getBalance() - amount;
            user.getPaymentAccount().setBalance(walletBalance);

            Transaction transaction = new Transaction();
            transaction.setUser(user);
            transaction.setAmount(amount);
            transaction.setBalanceAfter(walletBalance);
            transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
            transaction.setType(3);
            transaction.setStatus(2);
            transaction.setDescription("Buy " + request.getParameter("bookTitle") + ".");
//            transaction.setPayment(payMedDAO.get(paymentMethod));
            transDAO.insert(transaction);

            payAccDAO.update(paymentMethod.getPaymentAccount());
            payAccDAO.update(user.getPaymentAccount());

            BookOwnDAO bookOwnDAO = new BookOwnDAO();
            Book book = new Book();
            book.setId(Integer.parseInt(request.getParameter("bookId")));
            bookOwnDAO.insert(book, user);
            System.out.println(book.getId());
            System.out.println(user.getId());
            
            response.sendRedirect(request.getContextPath() + "/BookDetail?id=" + request.getParameter("bookId"));
        }
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
