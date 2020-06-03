<%--
  Created by IntelliJ IDEA.
  User: Sharon Lau
  Date: 2020/4/29
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page language="java"
         import = "javax.imageio.ImageIO"
         import = "java.awt.*"
         import = "java.awt.image.BufferedImage"
         import = "java.util.Random"
%>

<%
    response.setHeader("Cache-Control", "no-cache");

    // init image
    int width = 60, height = 22;
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

    // get brush
    Graphics g = image.getGraphics();
    // set bgcolor
    g.setColor(new Color(200,200,200));
    g.fillRect(0, 0, width, height);

    // 4
    Random rnd = new Random();
    int randNum = rnd.nextInt(8999) + 1000;
    String randStr = String.valueOf(randNum);

    // save to session
    session.setAttribute("randStr", randStr);

    // display to img
    g.setColor(Color.BLACK);
    g.setFont(new Font("", Font.PLAIN, 20));
    g.drawString(randStr, 10,17);

    // 干扰
    for (int i = 0; i<100 ; i++) {
        int x = rnd.nextInt(width);
        int y = rnd.nextInt(height);
        g.drawOval(x, y, 1,1);
    }

    // output
    ImageIO.write(image, "JPEG", response.getOutputStream());
    out.clear();
    out = pageContext.pushBody();
%>
</body>
</html>
