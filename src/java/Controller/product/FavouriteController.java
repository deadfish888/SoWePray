/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.product;

import Model.Book;
import Model.Category;
import Model.Favourite;
import Model.User;
import context.BookDAO;
import context.CategoryDAO;
import context.FavouriteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import javax.mail.Session;
@WebServlet("/Favourite")
public class FavouriteController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {   
       FavouriteDAO fdao=new FavouriteDAO();
       BookDAO bdao=new BookDAO();
       CategoryDAO cdao=new CategoryDAO();
       if(request.getSession() == null || request.getSession().getAttribute("user") == null){
           response.sendRedirect("./Login");
       }else{
           User user=(User)request.getSession().getAttribute("user");
           int uId=user.getId();
           
           ArrayList<Favourite> list_f= fdao.getAllBook(uId);
           ArrayList<Book> list_b=new ArrayList<>();
           ArrayList<Category> list_c=cdao.getAllCategories();
           for(int i=0;i<list_f.size();i++){
               int bID=list_f.get(i).getbID();
               Book b=bdao.getBookById(bID);
               list_b.add(b);
           }
           request.setAttribute("category", list_c);
           request.setAttribute("books", list_b);      
           request.getRequestDispatcher("/views/book/Favourite.jsp").forward(request, response);
       }        
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       int bId=Integer.parseInt(request.getParameter("bId"));
       FavouriteDAO fdao=new FavouriteDAO();
       if(request.getSession() == null || request.getSession().getAttribute("user") == null){
           response.sendRedirect("./Login");
       }else{
           User user=(User)request.getSession().getAttribute("user");
           int uId=user.getId();
            fdao.addFavourite(uId, bId);
            response.sendRedirect("./Favourite");
       }
       
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
