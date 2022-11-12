/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import static java.lang.Double.NaN;
import java.sql.Timestamp;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class Validator {

    public boolean getString(String string) {
        return !(string == null || string.trim().equals(""));
    }
    
    public boolean getPhone(String phone) {
        String regex = "[^0-9]";
        Pattern pattern = Pattern.compile(regex,
                Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(phone);
        return getString(phone) && !matcher.find() && phone.length() == 10;
    }

    public boolean getName(String name) {
        String regex = "[^a-zA-Z ]";
        Pattern pattern = Pattern.compile(regex,
                Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(name);
        return !(!getString(name) || matcher.find() || name.length() > 40);
    }

    public int getInt(String input) {
        int integer;
        input = input.trim();
        try {
            integer = Integer.parseInt(input);
            return integer;
        } catch (Exception e) {
            return (int) NaN;
        }
    }

    public boolean getPassword(String input) {
        if (!getString(input)) {
            return false;
        }
        if (input.length() < 6 || input.length() > 32) {
            return false;
        }
        if (input.charAt(0) == ' ') {
            return false;
        }
        return true;
    }
 public int fieldInt(String value, String message) throws Exception {
        int number = 0;
        try {
            number = Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new Exception(message);
        }
        return number;
    }

    public double fieldDouble(String value, String message) throws Exception {
        double number = 0;
        try {
            number = Double.parseDouble(value);
        } catch (NumberFormatException e) {
            throw new Exception(message);
        }
        return number;
    }

    public String fieldString(String value, String message) throws Exception {
        if (value.isEmpty() || value.trim().equals("")) {
            throw new Exception(message);
        }
        return value;
    }

    public boolean fieldBoolean(String value, String message) throws Exception {
        boolean bool = false;
        try {
            bool = Boolean.parseBoolean(value);
        } catch (Exception e) {
            throw new Exception(message);
        }
        return bool;
    }

    public java.sql.Date fieldDate(String value, String message) throws Exception {
        java.sql.Date date = null;
        try {
            date = java.sql.Date.valueOf(value);
        } catch (Exception e) {
            throw new Exception(message);
        }
        return date;
    }

    public Timestamp fieldTimestamp(String value, String message) throws Exception {
        Timestamp timestamp = null;
        try {
            timestamp = new Timestamp(new java.util.Date(Long.parseLong(value)).getTime());
        } catch (Exception e) {
            throw new Exception(message);
        }
        return timestamp;
    }
}
