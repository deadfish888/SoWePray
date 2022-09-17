/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import static java.lang.Double.NaN;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Khuat Thi Minh Anh
 */
public class Validator {

    public boolean getString(String string) {
        if (string == null || string.trim().equals("")) {
            return false;
        }
        return true;
    }

    public boolean getName(String name) {
        String regex = "[^a-zA-Z ]";
        Pattern pattern = Pattern.compile(regex,
                Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(name);
        if (!getString(name) || matcher.find() || name.length() > 40) {
            return false;
        }
        return true;
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
}
