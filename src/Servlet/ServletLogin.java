package Servlet;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.SessionCookieConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ServletLogin", urlPatterns = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String userpwd = request.getParameter("userpwd");
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        String randStr = (String)session.getAttribute("randStr");
        PrintWriter pw = response.getWriter();

        session.setAttribute("username", username);

        pw.println("IN!");
        UserDao userDao = new UserDao();
        try {
            boolean isValid = userDao.checkLogin(username, userpwd);
            boolean validata = code.equals(randStr);

            if (isValid && validata) {
                session.setAttribute("username", username);
                response.sendRedirect("/FINAL_war_exploded/");
            } else if (isValid == false) {
                pw.print("<script>alert('账号或密码输入错误 请检查后重试!');window.location.href='/FINAL_war_exploded/Login.jsp'</script>");
            } else {
                pw.println("<script>alert('验证码输入错误 请检查后重试!');window.location.href='/FINAL_war_exploded/Login.jsp'</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
