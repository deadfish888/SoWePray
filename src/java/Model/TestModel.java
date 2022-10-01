/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class TestModel {

    public static void main(String[] args) {
//        Transaction transaction = new Transaction();
//        transaction.setTransactionId(300000);
//        TransactionToken transToken = new TransactionToken(transaction);
//        System.out.println(transToken.getToken());
//        System.out.println(transToken.getToken().length());
        User user = new User();
//        user.setId(1);
//        user.createWallet();
//        System.out.println(user.getPaymentAccount().getAccountNumber() + "      " + user.getPaymentAccount().getBalance());
System.out.println(user.getId());

String s = "\n" +
"                            <div class=\"modal-dialog modal-lg\">\n" +
"                                <div class=\"modal-content\">\n" +
"                                    <form action=\"/RemovePayment\" method=\"post\" id=\"removePaymentForm\">\n" +
"                                        <div class=\"modal-header\">\n" +
"                                            <h3 class=\"modal-title\">Remove payment method</h3>\n" +
"                                        </div>\n" +
"                                        <div class=\"modal-body\">\n" +
"                                            <!--<div class=\"wrapper row\">-->\n" +
"                                            <table>\n" +
"                                                <tr>\n" +
"                                                    <th>\n" +
"                                                        Password\n" +
"                                                    </th>\n" +
"                                                    <td>\n" +
"                                                        <input type=\"password\" name=\"password\"/>\n" +
"                                                        <div style=\"color: red\">${old_pass_noti}</div>\n" +
"                                                    </td>\n" +
"                                                </tr>\n" +
"                                            </table>\n" +
"                                            <!--</div>-->\n" +
"                                        </div>\n" +
"                                        <div class=\"modal-footer\" style=\"text-align: center\">\n" +
"                                            <button type=\"button\" data-dismiss=\"modal\">Cancel</button>\n" +
"                                            <input type=\"hidden\" id=\"pass\" value=\"${sessionScope.user.password}\"/>\n" +
"                                            <input type=\"hidden\" id=\"removedPaymentId\" name=\"removedPaymentId\"/>\n" +
"                                            <button type=\"button\" onclick=\"removePayment(${removedPaymentId})\">Confirm</button>\n" +
"                                        </div>\n" +
"                                    </form>\n" +
"                                </div>\n" +
"                            </div>";
    }
}
