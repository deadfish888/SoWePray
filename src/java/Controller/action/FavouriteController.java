/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.action;

import Model.product.Book;
import Model.product.Category;
import Model.action.Favourite;
import Model.auth.User;
import context.product.BookDAO;
import context.product.CategoryDAO;
import context.action.FavouriteDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
@WebServlet("/Favourite")
public class FavouriteController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {   
       FavouriteDAO fdao=new FavouriteDAO();
       BookDAO bdao=new BookDAO();
       CategoryDAO cdao=new CategoryDAO();
       if(request.getSession().getAttribute("user") == null){
           response.sendRedirect("./Login");
       }else{
           User user=(User)request.getSession().getAttribute("user");
           int uId=user.getId();
           
           ArrayList<Favourite> list_f= fdao.getAllBook(uId);
           ArrayList<Book> list_b=new ArrayList<>();
           ArrayList<Category> list_c=cdao.getAllCategory();
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
           response.sendRedirect("./Login?origin=./BookDetail?id="+bId);
       }else{
           User user=(User)request.getSession().getAttribute("user");
           int uId=user.getId();
            fdao.addFavourite(uId, bId);
            ArrayList<Favourite> list=fdao.getAllFav(bId);
            int count=list.size();
            fdao.sendFavtoBook(count, bId);
            response.sendRedirect("./BookDetail?id="+bId);
       }
       
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
