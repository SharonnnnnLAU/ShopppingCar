package vo;

public class Book {
    private String idbook;
    private String bookname;
    private int bookprice;
    private String author;
    private String scripts;
    private String imgurl;

    public void setBookprice(int bookprice) {
        this.bookprice = bookprice;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public void setIdbook(String idbook) {
        this.idbook = idbook;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setScripts(String scripts) {
        this.scripts = scripts;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public String getIdbook() {
        return idbook;
    }

    public String getBookname() {
        return bookname;
    }

    public String getAuthor() {
        return author;
    }

    public int getBookprice() {
        return bookprice;
    }

    public String getImgurl() {
        return imgurl;
    }

    public String getScripts() {
        return scripts;
    }

    public void outPut() {
        System.out.println(this.idbook + this.bookname + this.bookprice + this.author + this.scripts + this.imgurl);
    }
}
