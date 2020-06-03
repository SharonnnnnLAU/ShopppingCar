import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "EncodingFilter", urlPatterns = "/*")
public class EncodingFilter implements Filter {
    private String defaultCharset = "UTF-8";
    private FilterConfig config = null;
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        String charset = config.getInitParameter("charset");
        if (charset == null) {
            charset = defaultCharset;
        }
        req.setCharacterEncoding(charset);
        resp.setCharacterEncoding(defaultCharset);
        resp.setContentType("text/html;charset=" + charset);
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
        this.config = config;
    }

}
