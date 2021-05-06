package com.ctseducare.template.helper;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import com.ctseducare.template.json.ResponseJson;
import com.google.gson.Gson;

public class ServletResponseHelper {

  private ServletResponseHelper() {

  }

  public static void sendResponseLoadOk(HttpServletResponse response, Object obj) {
    sendResponse(response, obj);
  }

  public static void sendResponseOk(HttpServletResponse response) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(true);
    sendResponse(response, json);
  }

  public static void sendResponseLoginError(HttpServletResponse response) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(false);
    json.setMessage("Verifique se o usuário e a senha foram informados corretamente.");
    sendResponse(response, json);
  }

  public static void sendResponseSaveOk(HttpServletResponse response) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(true);
    json.setMessage("Dados do item salvo com sucesso");
    sendResponse(response, json);
  }

  public static void sendResponseEditOk(HttpServletResponse response, Object obj) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(true);
    json.setData(obj);
    sendResponse(response, json);
  }

  public static void sendResponseRemoveOk(HttpServletResponse response) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(true);
    json.setMessage("Item removido com sucesso");
    sendResponse(response, json);
  }

  public static void sendResponseListObject(HttpServletResponse response, Object obj) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(true);
    json.setData(obj);
    sendResponse(response, json);
  }
  
  public static void sendResponseError(HttpServletResponse response, String message) {
    ResponseJson json = new ResponseJson();
    json.setSuccess(false);
    json.setMessage(message);
    sendResponse(response, json);
  }

  private static void sendResponse(HttpServletResponse response, Object json) {
    String buffer = new Gson().toJson(json);
    try {
      OutputStream out = response.getOutputStream();
      out.write(buffer.getBytes("UTF-8"));
      out.flush();
      out.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
