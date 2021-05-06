package com.ctseducare.template.session;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class SessionFilter implements Filter {

  public SessionFilter() {
    
  }

  public void init(FilterConfig fConfig) throws ServletException {
    
  }

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse res = (HttpServletResponse) response;
    
    String uri = req.getRequestURI();
    String pageLogin = req.getContextPath() + "/login.jsp";
    String resourcesStatic = req.getContextPath() + "/static";
    String servletLogin = req.getContextPath() + "/servlets/login";
    
    if (uri.equals(pageLogin) || uri.startsWith(resourcesStatic) || uri.equals(servletLogin) ) {
      chain.doFilter(request, response);
    } else {  
      SessionData sessionData = (SessionData)req.getSession().getAttribute("sessionData");
      if (sessionData == null) {
        res.sendRedirect(request.getServletContext().getContextPath() + "/login.jsp");
      } else {
        chain.doFilter(request, response);
      }
    }
  }

  public void destroy() {
    
  }

}
