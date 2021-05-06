package com.ctseducare.template.service;

import com.ctseducare.template.dao.LoginDAO;
import com.ctseducare.template.model.User;

import br.com.ctseducare.cryptography.CTSHashGenerator;

public class LoginService {
  
  private LoginDAO loginDAO;
  
  public LoginService() {
    loginDAO = new LoginDAO();
  }
  
  public User checkUserPassword(String user, String password) {
    String passwordMD5 = CTSHashGenerator.md5(password);
    return loginDAO.checkUserPassword(user, passwordMD5);
  }

}
