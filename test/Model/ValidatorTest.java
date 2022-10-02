package Model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */

import Model.Validator;
import static java.lang.Double.NaN;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import static org.junit.jupiter.api.Assertions.*;
import org.testng.annotations.Test;

/**
 *
 * @author fpt
 */
public class ValidatorTest {

    public ValidatorTest() {
    }

    @BeforeAll
    public static void setUpClass() {
    }

    @AfterAll
    public static void tearDownClass() {
    }

    @BeforeEach
    public void setUp() {
    }

    @AfterEach
    public void tearDown() {
    }

    @Test
    public void testGetName_1() {
        String input = "Alpha 17";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_2() {
        String input = "Alpha 17";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_3() {
        String input = "Alpha 17";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_4() {
        String input = "Alpha 17";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_5() {
        String input = "Alpha asdfg";
        Validator validator = new Validator();
        assertTrue(validator.getName(input));
    }

    @Test
    public void testGetName_6() {
        String input = "    ";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_7() {
        String input = "Alpha 17   asd";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }

    @Test
    public void testGetName_8() {
        String input = "Alpha p;l.";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }
    
    @Test
    public void testGetName_9() {
        String input = "Khuat Thi Minh Anh";
        Validator validator = new Validator();
        assertTrue(validator.getName(input));
    }
    
    @Test
    public void testGetName_10() {
        String input = "";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }
    
    @Test
    public void testGetName_11() {
        String input = "Khuat Thi Minh Anh aaaaaaaaaaaaaaaaaaa  aaaaaaaaaaaaa     aaaaaaaaaaaaaaa  aaaaaaaaaaaaaaaaaaaaaaaa  aaaa aaa aaaaaaaaaaaa";
        Validator validator = new Validator();
        assertFalse(validator.getName(input));
    }
    
    @Test
    public void testGetName_12() {
        String input = "Khuat Thi      Minh Anh";
        Validator validator = new Validator();
        assertTrue(validator.getName(input));
    }
    
    @Test
    public void testGetInt_1(){
        String input = "";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), (int) NaN);
    }
    
    @Test
    public void testGetInt_2(){
        String input = "afd";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), (int) NaN);
    }
    
    @Test
    public void testGetInt_3(){
        String input = "   ";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), (int) NaN);
    }
    
    @Test
    public void testGetInt_4(){
        String input = "14 ";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), 14);
    }
    
    @Test
    public void testGetInt_5(){
        String input = "14,7";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), (int) NaN);
    }
    
    @Test
    public void testGetInt_6(){
        String input = "-5";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), -5);
    }
    
    @Test
    public void testGetInt_7(){
        String input = "a9";
        Validator validator = new Validator();
        assertEquals(validator.getInt(input), (int) NaN);
    }
    
    @Test
    public void testPass1(){
        String input = "";
        Validator validator = new Validator();
        assertFalse(validator.getPassword(input));
    }
    @Test
    public void testPass2(){
        String input = " dfefevd";
        Validator validator = new Validator();
        assertFalse(validator.getPassword(input));
    }
    @Test
    public void testPass3(){
        String input = "234rfcaer";
        Validator validator = new Validator();
        assertTrue(validator.getPassword(input));
    }
    @Test
    public void testPass4(){
        String input = "3wsxdcfvgy6t5fgbhnju87ytgvbhnju7y6tgvbnjuy6t5r4esxdcfvgbhnjmnbvfcdxsw3e4r5t6y789ioiuytreswasxd";
        Validator validator = new Validator();
        assertFalse(validator.getPassword(input));
    }
    @Test
    public void testPass5(){
        String input = "         ";
        Validator validator = new Validator();
        assertFalse(validator.getPassword(input));
    }
    @Test
    public void testPass6(){
        String input = "23refvfvgdz";
        Validator validator = new Validator();
        assertTrue(validator.getPassword(input));
    }
    @Test
    public void testPass7(){
        String input = "a0";
        Validator validator = new Validator();
        assertFalse(validator.getPassword(input));
    }
    
}
