<%@ page import="dao.BookDao" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="vo.Book" %><%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/4/29
  Time: 13:13
  To change this template use File | Settings | File Templates.
  SHOW ALL BOOKS
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>FKJ Online BookStore</title>

    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">

    <script type="text/javascript" src="js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
  </head>
  <body id="home" style="height: 1000px;">
  <%
      BookDao bookDao = new BookDao();
      HashMap books = bookDao.getAllBook();
      session.setAttribute("books", books);
      Set set = books.keySet();
      Iterator iter = set.iterator();

      final int E = 6;
      int totalPage = 0;
      int currentPage = 1;
      int totalCount = 0;
      int p = 0;
      int num = 0;

      totalCount = books.size();

      totalPage = ((totalCount%E == 0)?(totalCount/E):(totalCount/E+1)) - 1;

      String inte = request.getParameter("currentPage");
      if (inte == null)
          inte = "1";
      try {
          currentPage = Integer.parseInt(inte);
      } catch (NumberFormatException e) {
          currentPage = 1;
      }

      if (currentPage <= 1)
          currentPage = 1;
      if (currentPage >= totalPage)
          currentPage = totalPage;

      p = (currentPage)*E;

      for (int i = 0; i < p; i++) {
          iter.next();
//            System.out.println("now:" + i);
      }

      while (num < E && iter.hasNext()) {
          num ++;
//            System.out.println("output:" + num);
          String idbook = (String)iter.next();
          Book book = (Book) books.get(idbook);
//      while (iter.hasNext()) {
//          String idbook = (String)iter.next();
//          Book book = (Book) books.get(idbook);
  %>

  <div class="main">
    <div class="manu">
      <ul>
        <li>
          <div id="plist">
            <%--purchase--%>
            <div><a href="#"><img style="width: 250px; height: 350px;" src="<%=book.getImgurl()%>" width="240" height="240"></a> </div>
            <%--detail--%>
            <div class="p-name"><a href="#"><%=book.getBookname()%></a></div>
            <div class="p-price"><strong>￥<%=book.getBookprice()%></strong> <span id="p200"></span></div>
              <div class="btns">
                  <%--<button class="add_cart_large btnCart" onclick="purchase(<%=book.getIdbook()%>)">加入购物车</button>--%>
                  <button><a href="/FINAL_war_exploded/purchase.jsp?id=<%=idbook%>">PURCHASE</a></button>
              </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
  <%
    }
  %>

  <%--遮罩层--%>
  <%--<div id="allLight"></div>--%>

  <%--select page--%>
  <div style="text-align: center;">
      <a href="index.jsp?currentPage=1">首页</a>
      <%
          for (int in = 1; in <= totalPage; in++) {%>
      <br />
      <a href="index.jsp?currentPage=<%=in%>"><%=in%></a>
      <% }
      %>
      <br />
      <a href="index.jsp?currentPage=<%=currentPage-1%>">上一页</a>
      <br />
      <a href="index.jsp?currentPage=<%=currentPage+1%>">下一页</a>
      <br />
      <a href="index.jsp?currentPage=<%=totalPage%>">末页</a>
      <br />
      共<%=totalPage %>页
      <br />
      <%=totalCount %>条记录
      <br />
      <form action="" method="get">
          跳转到第<input type="text" name="currentPage" size="4">页
          <br />
          <input type="submit" name="submit" value="跳转">
      </form>
      <br />
  </div>

  <!--右侧贴边导航quick_links.js控制-->
  <div class="mui-mbar-tabs">
    <div class="quick_link_mian">
      <div class="quick_links_panel">
        <div id="quick_links" class="quick_links">
          <li>
            <a href="#" class="my_qlinks"><img src="img/user.png" class="icon"> </a>
            <div class="ibar_login_box status_login">
              <div class="avatar_box">
                <%
                  String username = (String) session.getAttribute("username");
                  if (username == null || "".equals(username)) {
                %>
                  <div class="login_btnbox">
                    <a class="btn-login" href="Login.jsp">请先登录</a>
                  </div>
                <% } else { %><p class="avatar_imgbox"><img src="img/F.png" style="width: 70px; height: 70px; padding: 10px; padding-left: 25px;"/></p>
                  <ul class="user_info">
                    <li>用户名：<%=username%></li>
                    <div class="login_btnbox">
                        <a href="/FINAL_war_exploded/ServletLogout" class="btn-logout">退出登录</a>
                    </div>
                <% } %>
                  </ul>
              </div>

            </div>
          </li>
          <li id="shopCart">
            <a href="ShoppingCart.jsp" class="message_list" >
              <img src="img/shopping-cart.png" class="icon">
              <span class="span">购物车</span>
                <%
                    HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
                    if (cart == null) {
                %>
                  <span class="cart_num">0</span>
                <% } else {%>
                  <span class="cart_num"><%=cart.size() %></span>
                <%}%>
            </a>
          </li>
          <li>
            <a href="#" class="history_list"><img src="img/bag.png" class="icon"> </a>
            <div class="mp_tooltip" style=" visibility:hidden;">我的资产</div>
          </li>
          <li>
            <a href="#" class="mpbtn_histroy"><img src="img/footprint.png" class="icon"></a>
            <div class="mp_tooltip">我的足迹</div>
          </li>
          <li>
            <a href="#" class="mpbtn_wdsc"><img src="img/mark.png" class="icon"> </a>
            <div class="mp_tooltip">我的收藏</div>
          </li>
          <li>
            <a href="#" class="mpbtn_recharge"><img src="img/withdraw.png" class="icon"> </a>
            <div class="mp_tooltip">我要充值</div>
          </li>
        </div>
        <div class="quick_toggle">
          <li>
            <a href="#"><img src="img/customer.png" class="icon"></a>
            <div class="mp_tooltip">客服中心</div>
          </li>
        </div>
      </div>
      <div id="quick_links_pop" class="quick_links_pop hide"></div>
    </div>
  </div>
  </table>


  <script type="text/javascript" src="js/parabola.js"></script>

  <%--<script type="text/javascript">--%>
      <%--function purchase() {--%>
          <%--document.getElementById("buyIt").style.display = "block";--%>
          <%--document.getElementById("allLight").style.display = "block";--%>
      <%--}--%>
      <%--function cancel() {--%>
          <%--document.getElementById("buyIt").style.display = "none";--%>
          <%--document.getElementById("allLight").style.display = "none";--%>
      <%--}--%>
  <%--</script>--%>


  <script type="text/javascript">
    $(".quick_links_panel li").mouseenter(function(){
      $(this).children(".mp_tooltip").animate({left:-92,queue:true});
      $(this).children(".mp_tooltip").css("visibility","visible");
      $(this).children(".ibar_login_box").css("display","block");
    });
    $(".quick_links_panel li").mouseleave(function(){
      $(this).children(".mp_tooltip").css("visibility","hidden");
      $(this).children(".mp_tooltip").animate({left:-121,queue:true});
      $(this).children(".ibar_login_box").css("display","none");
    });
    $(".quick_toggle li").mouseover(function(){
      $(this).children(".mp_qrcode").show();
    });
    $(".quick_toggle li").mouseleave(function(){
      $(this).children(".mp_qrcode").hide();
    })

    // 绑定点击事件
    if (eleFlyElement && eleShopCart) {

      [].slice.call(document.getElementsByClassName("btnCart")).forEach(function(button) {
        button.addEventListener("click", function(event) {
          // 滚动大小
          var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft || 0,
                  scrollTop = document.documentElement.scrollTop || document.body.scrollTop || 0;
          eleFlyElement.style.left = event.clientX + scrollLeft + "px";
          eleFlyElement.style.top = event.clientY + scrollTop + "px";
          eleFlyElement.style.visibility = "visible";

          // 需要重定位
          myParabola.position().move();
        });
      });
    }
  </script>

  <%--<div style="display:none">--%>
    <%--<script type="text/javascript">--%>
      <%--var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");--%>
      <%--document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F6f798e51a1cd93937ee8293eece39b1a' type='text/javascript'%3E%3C/script%3E"));--%>
    <%--</script>--%>
    <%--<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5718743'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s9.cnzz.com/stat.php%3Fid%3D5718743%26show%3Dpic2' type='text/javascript'%3E%3C/script%3E"));</script>--%>
  <%--</div>--%>

  </body>
</html>
