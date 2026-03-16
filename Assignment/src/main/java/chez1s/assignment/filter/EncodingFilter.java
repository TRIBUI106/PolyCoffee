package chez1s.assignment.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class EncodingFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");

        // Handle Language Switching
        String lang = req.getParameter("lang");
        if (lang != null && !lang.isEmpty()) {
            req.getSession().setAttribute("lang", lang);
            // Set JSTL locale globally for the session
            jakarta.servlet.jsp.jstl.core.Config.set(
                    req.getSession(),
                    jakarta.servlet.jsp.jstl.core.Config.FMT_LOCALE,
                    java.util.Locale.forLanguageTag(lang));
        }

        // Ensure localization context is set globally for the session
        if (req.getSession().getAttribute(jakarta.servlet.jsp.jstl.core.Config.FMT_LOCALIZATION_CONTEXT + ".session") == null) {
            jakarta.servlet.jsp.jstl.core.Config.set(
                    req.getSession(),
                    jakarta.servlet.jsp.jstl.core.Config.FMT_LOCALIZATION_CONTEXT,
                    "messages");
        }

        chain.doFilter(req, res);
    }
}
