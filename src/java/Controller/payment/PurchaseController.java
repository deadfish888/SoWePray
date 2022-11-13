/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.payment;

import Model.product.Book;
//import Model.payment.PaymentMethod;
import Model.payment.Transaction;
import Model.auth.User;
import Model.product.Product;
import context.product.BookOwnDAO;
import context.payment.PaymentAccountDAO;
//import context.payment.PaymentMethodDAO;
import context.payment.TransactionDAO;
import context.product.ProductDAO;
import context.product.ProductOwnDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.ArrayList;
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
        try {
            User user = (User) request.getSession().getAttribute("user");
            String bookId = request.getParameter("bookId");

            if (request.getParameter("password").equals(user.getPassword())) {
                PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
                user.setPaymentAccount(payAccDAO.get(user.getPaymentAccount()));
                TransactionDAO transDAO = new TransactionDAO();

                float amount = Float.parseFloat(request.getParameter("amount"));

                if (amount > user.getPaymentAccount().getBalance()) {
                    request.getSession().setAttribute("error", "Your wallet have not enough coin to buy this book. Please deposit into wallet and try again.");
                } else {
                    ProductDAO productDAO = new ProductDAO();
                    Product product = new Product("B" + bookId);
                    product = productDAO.get(product);
                    User author = product.getBook().getAuthor().getUser();

                    if (amount > 0) {
                        float walletBalance = user.getPaymentAccount().getBalance() - amount;
                        user.getPaymentAccount().setBalance(walletBalance);

                        Transaction transaction = new Transaction();
                        transaction.setUser(user);
                        transaction.setAmount(amount);
                        transaction.setBalanceAfter(walletBalance);
                        transaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
                        transaction.setType(3);
                        transaction.setStatus(3);

                        transaction.setProduct(product);
                        transaction.setDescription("Buy " + product.toString() + ".");
                        transDAO.insert(transaction);

                        payAccDAO.update(user.getPaymentAccount());
                        if (author != null) {
                            Transaction auTransaction = new Transaction();
                            auTransaction.setUser(author);
                            auTransaction.setAmount(amount);
                            auTransaction.setBalanceAfter(author.getPaymentAccount().getBalance() + amount);
                            auTransaction.setTransactionTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
                            auTransaction.setType(4);
                            auTransaction.setStatus(3);
                            auTransaction.setProduct(product);
                            auTransaction.setDescription("Sell " + product.toString() + ".");
                            transDAO.insert(auTransaction);

                            author.getPaymentAccount().setBalance(author.getPaymentAccount().getBalance() + amount);
                            payAccDAO.update(author.getPaymentAccount());
                        }
                    }

                    BookOwnDAO bookOwnDAO = new BookOwnDAO();
                    Book book = new Book();
                    book.setId(Integer.parseInt(bookId));
                    bookOwnDAO.insert(book, user);

                    ProductOwnDAO productOwnDAO = new ProductOwnDAO();
                    if (author != null) {
                        ArrayList<Product> chapterProducts = productDAO.getChapterByBook(book);
                        for (Product p : chapterProducts) {
                            if (!user.isOwnProduct(p.getProductId())) {
                                productOwnDAO.insert(p, user);
                            }
                        }
                    } else {
                        productOwnDAO.insert(product, user);
                    }
                }
            } else {
                request.getSession().setAttribute("error", "Wrong password.");
            }
            response.sendRedirect(request.getContextPath() + "/BookDetail?id=" + bookId);
        } catch (IOException | NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Home");
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
