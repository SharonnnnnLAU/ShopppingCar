package dao;

import vo.User;

import javax.swing.plaf.nimbus.State;
import java.sql.*;
import java.util.HashMap;
import java.util.ResourceBundle;

public class UserDao {
    private static Connection conn = null;
    private static String driverClassName;
    private static String url;
    private static String username;
    private static String password;

    static {
        ResourceBundle resource = ResourceBundle.getBundle("jdbc");
        driverClassName = resource.getString("driverClassName");
        url = resource.getString("url");
        username = resource.getString("username");
        password = resource.getString("password");
    }

    private static Connection initConn() throws Exception  {
        try {
            Class.forName(driverClassName);
            conn = DriverManager.getConnection(url, username, password);
//            System.out.println("-------CONNECTION SUCCESS-------");
        }catch (Exception e) {
//            System.out.println("-------CONNECTION FAIL-------");
            System.out.println(e.getMessage());
        }
        return conn;
    }


    // 验证登录
    public boolean checkLogin(String username, String userpwd) throws Exception {
        boolean isValid = false;
        initConn();

        if (conn != null) {
            String sql = "SELECT * FROM student.user WHERE username='"+username+"' AND userpwd='"+userpwd+"'";
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery(sql);

            if (rs.next()) {
                isValid = true;
            }
            rs.close();
            stat.close();
            conn.close();
        }
        return isValid;
    }

    // 用户注册
    public boolean register(String username, String userpwd) throws Exception {
        initConn();
//        String sql = "INSERT INTO `student`.`user` (`username`, `userpwd`) VALUES ('" + username + "', '" + userpwd + "')";
//        Statement stat = conn.createStatement();
//        stat.executeQuery(sql);
        boolean resSucc = false;
        String sql = "INSERT INTO `student`.`user` (`username`, `userpwd`) VALUES (?,?);";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,username);
        ps.setString(2,userpwd);
        int i = ps.executeUpdate();
        if (i > 0) {
            resSucc = true;
        }
        return resSucc;
    }
}
