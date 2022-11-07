/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import context.payment.TransactionDAO;
import context.product.BookOwnDAO;
import context.product.BookDAO;
import Model.product.Book;
import Model.payment.PaymentAccount;
import Model.auth.User;
import Model.payment.Transaction;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TestDAO {

    public static void main(String[] args) {

//        TransactionDAO transactionDAO = new TransactionDAO();
//        User user = new User();
//        user.setId(109);
//        Transaction transaction = new Transaction(0, user, 0, 0, -1, -1, null, null);
//        System.out.println(transactionDAO.search(transaction).size());
System.out.println("UPDATE [Payment_Account]\n"
                    + "   SET [balance] = ?\n"
                    + " WHERE [accountNumber] = ?");
    }
}
