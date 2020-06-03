package Servlet;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;

@WebServlet(name = "ServletRegister", urlPatterns = "/ServletRegister")
public class ServletRegister extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String userpwd = request.getParameter("userpwd");
        UserDao userDao = new UserDao();
        PrintWriter pw = response.getWriter();
        boolean resSucc = false;
        try {
            resSucc = userDao.register(username,userpwd);
            if (resSucc == true) {
                pw.print("<script>alert('注册成功，请登录!');window.location.href='/FINAL_war_exploded/Login.jsp'</script>");
            }
        } catch (Exception E) {
//            pw.println("e");
        }
    }
}
