package com.ctseducare.template.exceptions;

public class ForeignKeyException extends RuntimeException {

  private static final long serialVersionUID = 1L;
  
  public ForeignKeyException(String message) {
    super(message);
  }

}