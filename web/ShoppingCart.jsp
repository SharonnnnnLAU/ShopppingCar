<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="vo.Book" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/5/1
  Time: 21:32
  To change this template use File | Settings | File Templates.
  SHOPPING CART
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SHOPPINGCAR</title>
    <link rel="stylesheet" href="css/ShoppingCart.css">

    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">

    <script type="text/javascript" src="js/jquery-1.7.min.js"></script>
    <script type="text/javascript" src="js/Calculation.js"></script>
    <script type="text/javascript" src="js/common.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            // 全选
            $(".allSelect").click(function () {
                // alert("in");
                $(".cart_tb2 input[name=newslist]").each(function () {
                    $(this).attr("checked", true);
                    // $(this).next().css({ "background-color": "#3366cc", "color": "#ffffff" });
                });
                GetCount();
                $(".allSelect").attr("checked", false);

            });

            //反选
            $("#invert").click(function () {
                // alert("in2");
                $(".cart_tb2 input[name=newslist]").each(function () {
                    if ($(this).attr("checked")) {
                        $(this).attr("checked", false);
                        //$(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
                    } else {
                        $(this).attr("checked", true);
                        //$(this).next().css({ "background-color": "#3366cc", "color": "#000000" });
                    }
                });
                GetCount();
                $("#invert").attr("checked", false);
            });

            //取消
            $("#cancel").click(function () {
                $(".cart_tb2 input[name=newslist]").each(function () {
                    $(this).attr("checked", false);
                    // $(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
                });
                GetCount();
                $("#cancel").attr("checked", false);
            });

            // 所有复选(:checkbox)框点击事件
            $(".cart_tb2 input[name=newslist]").click(function () {
                if ($(this).attr("checked")) {
                    //$(this).next().css({ "background-color": "#3366cc", "color": "#ffffff" });
                } else {
                    // $(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
                }
            });

            // 输出
            $(".cart_tb2 input[name=newslist]").click(function () {
                // $("#total2").html() = GetCount($(this));
                GetCount();
                //alert(conts);
            });
        });
        //******************
        function GetCount() {
            var conts = 0;
            var aa = 0;
            $(".cart_tb2 input[name=newslist]").each(function () {
                if ($(this).attr("checked")) {
                    for (var i = 0; i < $(this).length; i++) {
                        conts += parseInt($(this).val());
                        aa += 1;
                    }
                }
            });
            $("#count").text(aa);
            $("#money").html((conts).toFixed(2));
            $("#jz1").css("display", "none");
            $("#jz2").css("display", "block");
        }
    </script>

</head>

<%
    HashMap<String, Book> books = (HashMap<String, Book>) session.getAttribute("books");
    HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
    String username = (String)session.getAttribute("username");
    if (username == null || "".equals(username)) {
%>
<script>alert('你还没有登陆!');window.location.href='/FINAL_war_exploded/Login.jsp'</script>

<%} else if (cart == null) { %>
<script>alert('你还什么都没买呢!');window.location.href='/FINAL_war_exploded/index.jsp'</script>

<%} else {%>

<body>

<div class="cart" style=" margin:auto;">
    <h2 class="cart-title"><%=username %>的购物车</h2>
    <table cellpadding="0" cellspacing="0" class="cart_tb1">
        <tr>
            <td class="tb1_td1"><input id="Checkbox1" type="checkbox" id="allSelect" class="allSelect"></td>
            <td class="tb1_td1">全选</td>
            <td class="tb1_td3">商品</td>
            <td class="tb1_td4">作者</td>
            <td class="tb1_td5">数量</td>
            <td class="tb1_td6">单价</td>
            <td class="tb1_td7">操作</td>
        </tr>
    </table>

<%--循环 in--%>
<%
    Set set = cart.keySet();
    Iterator iter = set.iterator();
    while (iter.hasNext()) {
        String idbook = (String)iter.next();
        Book book = (Book) books.get(idbook);
%>
    <!---add min sum---->
    <script type="text/javascript">
        $(function () {
            var t = $("#text_box<%=book.getIdbook()%>");
            $("#add<%=book.getIdbook()%>").click(function () {
                t.val(parseInt(t.val()) + 1)
                setTotal(); GetCount();
            })
            $("#min<%=book.getIdbook()%>").click(function () {
                t.val(parseInt(t.val()) - 1)
                setTotal(); GetCount();
            })
            function setTotal() {
                $("#total<%=book.getIdbook()%>").html((parseInt(t.val()) * <%=book.getBookprice()%>));
                $("#newslist-1").val(parseInt(t.val()) * <%=book.getBookprice()%>);
            }
            setTotal();
        })
    </script>

    <table cellpadding="0" cellspacing="0" class="cart_tb2">
        <tr>
            <td class="tb2_td1"><input type="checkbox" value="1" name="newslist"></td>
            <td class="tb2_td2"><a href="#"><img src="<%=book.getImgurl()%>"></a></td>
            <td class="tb2_td3"><a href="#"><%=book.getBookname()%></a></td>
            <td class="tb1_td4"><%=book.getAuthor()%></td>
            <td class="tb1_td5">
                <input id="min<%=book.getIdbook()%>" name=""  style=" width:20px; height:18px;border:1px solid #ccc;" type="button" value="-" />
                <input id="text_box<%=book.getIdbook()%>" name="" type="text" value="<%=cart.get(idbook)%>" style=" width:30px; text-align:center; border:1px solid #ccc;" />
                <input id="add<%=book.getIdbook()%>" name="" style=" width:20px; height:18px;border:1px solid #ccc;" type="button" value="+" />
            </td>
            <td class="tb1_td6"><label id="total<%=book.getIdbook()%>>" class="tot" style="color:#ff5500;font-size:14px; font-weight:bold;"><%=book.getBookprice()%></label></td>
            <td class="tb1_td7"><a href="#">删除</a></td>
        </tr>
    </table>
<% }%>
<%--循环 out--%>

    <!---全选---->
    <script type="text/javascript">
        $(function () {
            // $("#checkAll").click(function () {
                // setTotal();
                //alert($(lens[0]).text());
            // });
            function setTotal() {
                var len = $(".tot");
                var num = 0;
                for (var i = 0; i < len.length; i++) {
                    num = parseInt(num) + parseInt($(len[i]).text());
                }
                //alert(len.length);
                $("#money").text(parseInt(num).toFixed(2));
                $("#count").text(len.length);
            }
            //setTotal();
        })
    </script>

    <table cellpadding="0" cellspacing="0" class="cart_tb3">
        <tr>
            <td class="tb3_td1">
                <span><input id="invert" type="checkbox" />反选</span>
                <span><input id="cancel" type="checkbox" />取消</span>
            </td>
            <td class="tb3_td2">已选商品 <label id="count" style="color:#ff5500;font-size:14px; font-weight:bold;">0</label> 件</td>
            <td class="tb3_td3">合计(不含运费):<span>￥</span><span style="color:#ff5500;"><label id="money" style="color:#ff5500;font-size:14px; font-weight:bold;"></label></span></td>
            <td class="tb3_td4"><span id="jz1">结算</span><a href="#" style=" display:none;"  class="jz2" id="jz2">结算</a></td>
        </tr>
    </table>
</div>

<%}%>

<div class="mui-mbar-tabs">
    <div class="quick_link_mian">
        <div class="quick_links_panel">
            <div id="quick_links" class="quick_links">
                <li>
                    <a href="#" class="my_qlinks"><img src="img/user.png" class="icon"> </a>
                    <div class="ibar_login_box status_login">
                        <div class="avatar_box">
                            <p class="avatar_imgbox"><img src="img/F.png" style="width: 70px; height: 70px; padding: 10px; padding-left: 25px;"/></p>
                            <ul class="user_info">
                                <li>用户名：<%=username%></li>
                                <li>级别：普通用户</li>
                            </ul>
                        </div>
                        <div class="login_btnbox">
                            <a href="#" class="login_order">我的订单</a>
                            <a href="#" class="login_favorite">我的收藏</a>
                        </div>
                    </div>
                </li>
                <li id="shopCart">
                    <a href="index.jsp" class="message_list" >
                        <%--<img src="img/shopping-cart.png" class="icon">--%>
                        <span style="color: white; padding-top: 22px;" class="span">返回购物</span>
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

</body>

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
    });
</script>
</html>
