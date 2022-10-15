/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package Model;

import Model.auth.User;
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
public class UserTest {
    
    public UserTest() {
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
    public void testPassLv1(){
        String input = "a0cad2";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 2);
    }
    
    @Test
    public void testPassLv2(){
        String input = "a0cad2['/.";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 3);
    }
    
    @Test
    public void testPassLv3(){
        String input = "asdfgh";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 1);
    }
    
    @Test
    public void testPassLv4(){
        String input = "9467456";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 1);
    }
    
    @Test
    public void testPassLv5(){
        String input = "[;'./";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 1);
    }
    
    @Test
    public void testPassLv6(){
        String input = "7u6yhbgfgr4t64";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 2);
    }
    
    @Test
    public void testPassLv7(){
        String input = "WhiteMoon983/";
        User user = new User("", input);
        assertEquals(user.getPasswordLevel(), 3);
    }
}
