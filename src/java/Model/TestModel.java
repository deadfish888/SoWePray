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
        Transaction transaction = new Transaction();
        transaction.setTransactionId(300000);
        TransactionToken transToken = new TransactionToken(transaction);
        System.out.println(transToken.getToken());
        System.out.println(transToken.getToken().length());
    }
}
