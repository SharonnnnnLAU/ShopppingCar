<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/5/1
  Time: 21:45
  To change this template use File | Settings | File Templates.
--%>

<%--log: 判定输入数据逻辑有问题--%>
<%--log: 对应的servlet还没写--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>REGISTER</title>
    <link href="css/register.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #eee;">
    <div class="container">
        <form method="get" action="/FINAL_war_exploded/ServletRegister" class="form-register">
            <h2>User Register</h2>
            <div>
                <p id="zhushi_user" class="form-tips">用户名由3-8个字符组成</p>
                <input type="text" onBlur="usernameMethod()" id="input_user" class="form-control" placeholder="User ID" name="username">
                <p id="zhushi_pass1" class="form-tips">请输入4-12位密码</p>
                <input type = "password" onBlur="userpwdMethod()" id="input_pass1" class="form-control" placeholder="Password" name="userpwd">
                <p id="zhushi_pass2" class="form-tips">两次密码不一致</p>
                <input type = "password" onBlur="userpwdMethod2()" id="input_pass2" class="form-control" placeholder="Password Again">
                <div class="form-vali">
                    <div style="float: left; width: 67%;">
                        <input type="text" class="form-control2" name="code" size="10" placeholder="Code" required>
                    </div>
                    <div>
                        <img name="imgValidata" border="0" src="validata.jsp" class="form-valiimg" onclick="refresh()">
                    </div>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top: 5px" onclick="checkAll()">Register</button>
            </div>
        </form>
    </div>
</body>
<script type="text/javascript">
    function usernameMethod() {
        var flag = 0;
        var user = document.getElementById("input_user").value;
        if(user.length>8 || user.length<3) {
            document.getElementById("zhushi_user").style.color="red";
            flag = 1;
        } else{
            document.getElementById("zhushi_user").style.color="green";
            flag = 2;
        }
    }
    function userpwdMethod() {
        var pass = document.getElementById("input_pass1").value;
        if(pass.length>12 || pass.length<4) {
            document.getElementById("zhushi_pass1").style.color="red";
            flag = 1;
        } else {
            document.getElementById("zhushi_pass1").style.color="green";
        }
    }
    function userpwdMethod2() {
        var pass1 = document.getElementById("input_pass1").value;
        var pass2 = document.getElementById("input_pass2").value;
        if(pass1 != pass2) {
            document.getElementById("zhushi_pass2").style.color="red";
            flag = 1;
        } else {
            document.getElementById("zhushi_pass2").style.color="green";
        }
    }
    function refresh() {
        loginForm.imgValidata.src = "validata.jsp?id=" + Math.random();
    }
    function checkAll() {
        usernameMethod();
        userpwdMethod();
        userpwdMethod2();
    }
</script>
</html>
