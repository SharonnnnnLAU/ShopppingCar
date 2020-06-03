package controller;

import dao.BookDao;
import vo.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ServletAdd", urlPatterns = "/ServletAdd")
public class ServletAdd extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String number = request.getParameter("number");
        HttpSession session = request.getSession();
        String idbook = (String) session.getAttribute("idbook");
        int num = Integer.parseInt(number);

        HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<String, Integer>();
            session.setAttribute("cart", cart);
        }
        if (cart.containsKey(idbook)) {
            cart.put(idbook, cart.get(idbook)+ num);
        } else {
            cart.put(idbook, num);
        }

//        HashMap<String, Book> books = (HashMap<String, Book>) session.getAttribute("books");
//        Book book = books.get(idbook);
//        int bookPrice = book.getBookprice();
//        int sumPrice = num*bookPrice;

        PrintWriter pw = response.getWriter();
        pw.print("<script>alert('加购成功');window.location.href='/FINAL_war_exploded/index.jsp'</script>");
//        pw.println("您购买的图书总价为：" + sumPrice);
//        pw.println("<button><a href=\"ShoppingCart.jsp\">查看购物车</a></button>");
//        pw.println("<button><a href=\"index.jsp\">返回购物</a></button>");
    }
}
