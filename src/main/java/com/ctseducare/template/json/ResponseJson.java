package com.ctseducare.template.json;

public class ResponseJson {

  private boolean success;
  private String message;
  private Object data;

  public ResponseJson() {
    this.success = false;
    this.message = null;
    this.data = null;
  }

  public boolean isSuccess() {
    return success;
  }

  public void setSuccess(boolean success) {
    this.success = success;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public Object getData() {
    return data;
  }

  public void setData(Object data) {
    this.data = data;
  }

}
