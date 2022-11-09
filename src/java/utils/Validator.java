/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import static java.lang.Double.NaN;
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
        return getString(phone) && !matcher.find() && !(phone.length() == 10);
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
    
//    public String getField(HttpServletRequest request, String fieldName, boolean required) throws Exception {
//        String value = null;
//        try {
//            value = new String(request.getParameter(fieldName).getBytes("iso-8859-1"), "utf-8");
//        } catch (Exception e) {
//            if (value == null || value.trim().isEmpty()) {
//                if (required) {
//                    String error = "Field "+fieldName+" is required";
//                    throw new Exception(error);
//                } else {
//                    value = null; // Make empty string null so that you don't need to hassle with equals("") afterwards.
//                }
//            }
//        }
//        return value;
//    }
//    
//    public int fieldInt(String value, String message) throws Exception {
//        int number = 0;
//        try {
//            number = Integer.parseInt(value);
//        } catch (NumberFormatException e) {
//            throw new Exception(message);
//        }
//        return number;
//    }
//
//    public float fieldFloat(String value, String message) throws Exception {
//        float number = 0;
//        try {
//            number = Float.parseFloat(value);
//        } catch (NumberFormatException e) {
//            throw new Exception(message);
//        }
//        return number;
//    }
//
//    public String fieldString(String value, String regex, String message) throws Exception {
//        if (!value.matches(regex)) {
//            throw new Exception(message);
//        }
//        return value;
//    }
//
//    public boolean fieldBoolean(String value, String message) throws Exception {
//        boolean bool = false;
//        try {
//            bool = Boolean.parseBoolean(value);
//        } catch (Exception e) {
//            throw new Exception(message);
//        }
//        return bool;
//    }
//
//    public Date fieldDate(String value, String message) throws Exception {
//        Date date = null;
//        try {
//            date = Date.valueOf(value);
//        } catch (Exception e) {
//            throw new Exception(message);
//        }
//        return date;
//    }
//
//    public Timestamp fieldTimestamp(String value, String message) throws Exception {
//        Timestamp timestamp = null;
//        try {
//            timestamp = new Timestamp(new java.util.Date(Long.parseLong(value)).getTime());
//        } catch (Exception e) {
//            throw new Exception(message);
//        }
//        return timestamp;
//    }
}
