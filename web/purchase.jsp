<%@ page import="vo.Book" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/5/1
  Time: 21:20
  To change this template use File | Settings | File Templates.
  PURCHASE and DETAIL
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PURCHASE</title>

    <link rel="stylesheet" href="css/purchase.css">
    <script type="text/javascript" src="js/jquery-1.7.min.js"></script>

</head>
<body>
<%
    String username = (String)session.getAttribute("username");
    if (username == null || "".equals(username)) { %>
    <script>alert('您还没有登陆，请登陆后尝试!');window.location.href='/FINAL_war_exploded/Login.jsp'</script>
<% } else {

    HashMap<String, Book> books = (HashMap<String, Book>) session.getAttribute("books");
    String idbook = request.getParameter("id");
    Book book = books.get(idbook);
    session.setAttribute("idbook", idbook);
    String bookName = book.getBookname();
    int bookPrice = book.getBookprice();
    String imgurl = book.getImgurl();
%>
<form action="/FINAL_war_exploded/ServletAdd" style="margin-top: 200px">
    <div class="center_con clearfix">
        <div class="main_menu fl"><img src="<%=imgurl%>"></div>
        <div class="goods_detail_list fr">
            <h3><%=bookName%></h3>
            <p style="margin-top: 10px"><%=book.getScripts()%></p>
            <div class="prize_bar">
                <div class="show_prize fl">￥<em id="bookPrice"><%=bookPrice%></em></div>
                <div class="show_unit fl">单位：本</div>
            </div>
            <div class="goods_num clearfix">
                <div class="num_name fl">数量：</div>
                <form action="/FINAL_war_exploded/ServletAdd">
                    <div class="num_add fl">
                        <input type="number" class="num_show fl" value="1" id="number" name="number" oninput="sum(this)">
                    </div>
                </form>
            </div>
            <div class="total">总价：<input type="text" id="sumPrice" class="sum" value="<%=bookPrice%>"></div>
            <div class="operate_btn">
                <a href="index.jsp" class="buy_btn">返回购物</a>
                <%--<a href="" class="btn_addcart">加入购物车</a>--%>
                <%--<a type="button" class="buy_btn"><a href="index.jsp" style="text-decoration: none;">返回购物</a></a>--%>
                <button type="submit" class="buy_btn">加入购物车</button>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    function sum(obj) {
        var bookPrice = <%=bookPrice%>;
        var number = document.getElementById("number");
        var sumPrice = document.getElementById("sumPrice");
        if (number.value > 0) {
            sumPrice.value = number.value * bookPrice;
        }
    }
</script>
<% } %>
</body>

</html>
