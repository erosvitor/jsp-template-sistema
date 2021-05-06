package com.ctseducare.template.exceptions;

public class LoginAlreadyExistException extends RuntimeException {

  private static final long serialVersionUID = 1L;
  
  public LoginAlreadyExistException(String message) {
    super(message);
  }

}
