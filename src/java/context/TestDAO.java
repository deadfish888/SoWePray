/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package context;

import Model.PaymentAccount;
import Model.User;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TestDAO {
    public static void main(String[] args) {
    UserDAO userDBC = new UserDAO();
    PaymentAccountDAO payAccDBC = new PaymentAccountDAO();
    PaymentMethodDAO payMedDBC = new PaymentMethodDAO();
    TransactionDAO transactionDAO = new TransactionDAO();
    transactionDAO.generateData();
//    payAccDBC.generateData();
//    payMedDBC.generateData();
//    User user = new User();
//    user.setId(1);
//    user.createWallet();
//    PaymentAccount paymentAccount = user.getPaymentAccount();
//    payAccDBC.insert(paymentAccount);
//    userDBC.setWalletNumber(user.getPaymentAccount(), user);
//    userDBC.changePassword(1, "admin1");
//    userDBC.generateData();
//    userDBC.updateUser(new User(1, "MrA", "Male", "2000-01-01", "abc@def", "0000000000", "asdfghj", "zxcvbnm", "123456", false));
        
    }
}
