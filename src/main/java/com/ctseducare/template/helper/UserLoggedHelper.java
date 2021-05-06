package com.ctseducare.template.helper;

import javax.servlet.http.HttpServletRequest;

import com.ctseducare.template.session.SessionData;

public class UserLoggedHelper {
  
  private UserLoggedHelper() {
    
  }
  
  public static String getUsernameLogged(HttpServletRequest request) {
    String usernameLogged;
    SessionData sessionData = (SessionData)request.getSession().getAttribute("sessionData");
    if (sessionData == null) {
      usernameLogged = "not_logged";
    } else {
      usernameLogged = sessionData.getUserLogin();
    }
    return usernameLogged;
  }

}
