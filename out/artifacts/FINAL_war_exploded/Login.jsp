<%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/4/29
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>LOGIN</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Login.css" rel="stylesheet">
</head>

<script type="text/javascript">
    function refresh() {
        loginForm.imgValidata.src = "validata.jsp?id=" + Math.random();
    }
</script>

<body>
    <div>
        <form class="form-signin" role="form" action="/FINAL_war_exploded/ServletLogin" method="post" name="loginForm">
            <h2>Please sign in</h2>
            <input type="text" class="form-control" placeholder="User ID" name="username" required autofocus>
            <input type="password" class="form-control" placeholder="Password" name="userpwd" required>
            <div class="form-vali">
                <div style="float: left; width: 67%;">
                    <input type="text" class="form-control2" name="code" size="10" placeholder="code" required>
                </div>
                <div>
                    <img name="imgValidata" border="0" src="validata.jsp" class="form-valiimg" onclick="refresh()">
                </div>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            <div>If u want to Register, plz click <a href="register.jsp">here...</a></div>
        </form>
    </div>
</body>
</html>
