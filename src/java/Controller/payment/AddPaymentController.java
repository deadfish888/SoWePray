///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package Controller.payment;
//
//import Model.payment.PaymentAccount;
//import Model.payment.PaymentMethod;
//import Model.auth.User;
//import context.auth.UserDAO;
//import context.payment.PaymentAccountDAO;
////import context.payment.PaymentMethodDAO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
///**
// *
// * @author Silver_000
// */
//@WebServlet(name = "AddPaymentController", urlPatterns = {"/User/AddPayment"})
//public class AddPaymentController extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        PaymentAccountDAO payAccDAO = new PaymentAccountDAO();
//        long acccountNumer = Long.parseLong(request.getParameter("accountNumber"));
//        PaymentAccount paymentAccount = payAccDAO.get(new PaymentAccount(acccountNumer));
//        if (paymentAccount == null) {
//            request.setAttribute("addErrorNoti", "Payment account is invalid");
//
//        request.getRequestDispatcher("/User/Payment").forward(request, response);
////            response.sendRedirect(request.getContextPath() + "/User/Payment");
//        } else {
//            PaymentMethodDAO payMedDAO = new PaymentMethodDAO();
//            PaymentMethod paymentMethod = new PaymentMethod();
//            User user = (User) request.getSession().getAttribute("user");
//            paymentMethod.setUser(user);
//            paymentMethod.setPaymentAccount(paymentAccount);
//            paymentMethod.setName(request.getParameter("paymentName"));
//            paymentMethod.setActive(true);
//            payMedDAO.insert(paymentMethod);
//            response.sendRedirect(request.getContextPath() + "/User/Payment");
//            if(user.is_super() == 1) {
//                user.setIs_super(2);
//                UserDAO userDAO = new UserDAO();
//                userDAO.editRank(user.getId(), 1);
//            }
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
