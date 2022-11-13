/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.payment;

//import Model.payment.PaymentMethod;
import Model.payment.Transaction;
import Model.auth.User;
import context.payment.PaymentAccountDAO;
//import context.payment.PaymentMethodDAO;
import context.payment.TransactionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Silver_000
 */
@WebServlet(name = "WithdrawController", urlPatterns = {"/User/Withdraw"})
public class WithdrawController extends HttpServlet {

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
        User user = (User) request.getSession().getAttribute("user");
        PaymentAccountDAO paymentAccountDAO = new PaymentAccountDAO();
        user.setPaymentAccount(paymentAccountDAO.get(user.getPaymentAccount()));
        request.getRequestDispatcher("../views/user/Withdraw.jsp").forward(request, response);
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
        try {
            String pass = request.getParameter("password");
            if (!((User) request.getSession().getAttribute("user")).getPassword().equals(pass)) {
                throw new Exception("Entered password is incorrect. Please try again.");
            } else {
                float amount = Float.parseFloat(request.getParameter("amount"));
                User user = (User) request.getSession().getAttribute("user");
                TransactionDAO transDAO = new TransactionDAO();

                Transaction transaction = new Transaction();
                transaction.setUser(user);
                transaction.setAmount(amount);
                transaction.setType(2);
                transaction.setStatus(2);
                transaction.setDescription("Withdraw to bank: " + request.getParameter("bank") + ", account number: " + request.getParameter("accountNumber"));
                transDAO.insert(transaction);

                response.sendRedirect(request.getContextPath() + "/User/Payment");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
            System.out.println(e.getCause());
            System.out.println(e.getLocalizedMessage());
            response.sendRedirect(request.getContextPath() + "/User/Withdraw");
        }
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
