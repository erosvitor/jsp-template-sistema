package com.ctseducare.template.exceptions;

public class ProfileAlreadyExistException extends RuntimeException {

  private static final long serialVersionUID = 1L;
  
  public ProfileAlreadyExistException(String message) {
    super(message);
  }

}
