package dao;

import vo.Book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

public class BookDao {
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

    public HashMap getAllBook() throws Exception {
        HashMap<String, Book> books = new HashMap();
        initConn();
        if (conn != null){
            String sql = "SELECT * FROM student.book";
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery(sql);

            while (rs.next()) {
                Book book = new Book();
                book.setIdbook(rs.getString("idbook"));
                book.setBookname(rs.getString("bookname"));
                book.setBookprice(rs.getInt("bookprice"));
                book.setAuthor(rs.getString("author"));
                book.setScripts(rs.getString("scripts"));
                book.setImgurl(rs.getString("imgurl"));
                books.put(rs.getString("idbook"),book);

            }
            rs.close();
            stat.close();
            conn.close();
        }
        return books;
    }

    public void tooString(HashMap books) {
        Set set = books.keySet();
        Iterator iter = set.iterator();
        //while循环遍历HashMap
        while (iter.hasNext()) {
            String str = (String) iter.next();
            System.out.println(str);
            int i = (int) books.get(str);
            System.out.println(i);
        }
//        System.out.println();
    }
}
