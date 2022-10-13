/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.auth;

import Model.auth.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author SAP-LAP-FPT
 */

public abstract class BaseAuthController extends HttpServlet {
    
    protected abstract boolean isPermissionGet(HttpServletRequest request);
    protected abstract boolean isPermissionPost(HttpServletRequest request);

    private boolean isAuth(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return false;
        } else {
            return request.getMethod().equals("GET") ? isPermissionGet(request) : isPermissionPost(request);
        }
    }
    
    protected abstract void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    protected abstract void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isAuth(request)) {
            processGet(request, response);
        } else {
            request.getRequestDispatcher("/views/error/accessDenied.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isAuth(request)) {
            processPost(request, response);
        } else {
            request.getRequestDispatcher("/views/error/accessDenied.jsp").forward(request, response);
        }
    }

}
