package com.ctseducare.template.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ctseducare.template.helper.ServletResponseHelper;
import com.ctseducare.template.model.User;
import com.ctseducare.template.service.LoginService;
import com.ctseducare.template.session.SessionData;

@WebServlet("/servlets/login")
public class LoginServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  private LoginService loginService;

  public LoginServlet() {
    this.loginService = new LoginService();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    switch (action) {
      case "login":
        login(request, response);
        break;
      case "logout":
        logout(request, response);
        break;
    }
  }
  
  private void login(HttpServletRequest request, HttpServletResponse response) {
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    try {
      User user = loginService.checkUserPassword(login, password); 
      if (user != null) {
        SessionData sessionData = new SessionData();
        sessionData.setUserId(user.getId());
        sessionData.setUserLogin(user.getLogin());
        request.getSession().setAttribute("sessionData", sessionData);
        ServletResponseHelper.sendResponseOk(response);
      } else {
        ServletResponseHelper.sendResponseLoginError(response);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  private void logout(HttpServletRequest request, HttpServletResponse response) {
    request.getSession().invalidate();
    ServletResponseHelper.sendResponseOk(response);
  }

}
