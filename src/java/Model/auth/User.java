/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model.auth;

import Model.payment.PaymentAccount;
//import Model.payment.PaymentMethod;
//import Model.product.Book;
import Model.product.Product;
//import context.payment.PaymentMethodDAO;
//import context.product.BookOwnDAO;
import context.product.ProductOwnDAO;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ACER
 */
public class User {

    private int id, is_super;
    private String name, gender, dob, email, phone, address, username, password;
    private PaymentAccount paymentAccount;

    public User() {
    }

    public User(String account, String password) {
        this.username = account;
        this.password = password;
    }

    public User(int id, String name, String gender, String dob, String email, String phone, String address, String username, String password, int is_super) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.username = username;
        this.password = password;
        this.is_super = is_super;
    }

    public User(String name, String gender, String dob, String email, String phone, String username, String password) {
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.email = email;
        this.phone = phone;
        this.username = username;
        this.password = password;
    }
    
    public User(int id, String name, String username, String gender, String dob, String email, String phone, String address) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.gender = gender;
        this.dob = dob;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public User(int id, String name, String gender, String dob, String email, String phone, String address, String username, String password, int is_super, PaymentAccount paymentAccount) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.username = username;
        this.password = password;
        this.is_super = is_super;
        this.paymentAccount = paymentAccount;
    }

    public int is_super() {
        return is_super;
    }

    public void setIs_super(int is_super) {
        this.is_super = is_super;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public int getPasswordLevel() {
        String numberRegex = "[0-9]";
        String characterRegex = "[a-zA-Z]";
        String otherRegex = "[^a-zA-Z0-9]";

        Pattern numberPattern = Pattern.compile(numberRegex,
                Pattern.CASE_INSENSITIVE);
        Matcher numberMatcher = numberPattern.matcher(password);

        Pattern alphaPattern = Pattern.compile(characterRegex,
                Pattern.CASE_INSENSITIVE);
        Matcher alphaMatcher = alphaPattern.matcher(password);

        Pattern specialPattern = Pattern.compile(otherRegex,
                Pattern.CASE_INSENSITIVE);
        Matcher specialMatcher = specialPattern.matcher(password);

        if (numberMatcher.find() && alphaMatcher.find() && specialMatcher.find()) {
            return 3;
        } else if (numberMatcher.find() && alphaMatcher.find()) {
            return 2;
        } else {
            return 1;
        }
    }

    public PaymentAccount getPaymentAccount() {
        return paymentAccount;
    }

    public void setPaymentAccount(PaymentAccount paymentAccount) {
        this.paymentAccount = paymentAccount;
    }

    public void createWallet(){
        paymentAccount = new PaymentAccount();
        paymentAccount.createWallet(this);
    }
    
    public boolean isOwnProduct(String productId) {
        ProductOwnDAO productOwnDAO = new ProductOwnDAO();
        Product product = new Product(productId);
        return productOwnDAO.get(this, product) != null;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof User) {
            User user = (User) obj;
            return user.getId() == this.id;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + this.id;
        hash = 31 * hash + Objects.hashCode(this.name);
        hash = 31 * hash + Objects.hashCode(this.email);
        hash = 31 * hash + Objects.hashCode(this.phone);
        hash = 31 * hash + Objects.hashCode(this.username);
        return hash;
    }
    
}
