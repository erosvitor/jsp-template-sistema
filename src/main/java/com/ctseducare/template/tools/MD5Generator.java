package com.ctseducare.template.tools;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.xml.bind.DatatypeConverter;

public class MD5Generator {

  public static void main(String[] args) {
    String password = "admin";
    System.out.println(md5(password));
  }
  
  public static String md5(String value) {
    if (value == null || value.isBlank()) {
      return null;
    }
    String hashMD5 = null;
    try {
      MessageDigest md = MessageDigest.getInstance("MD5");
      md.update(value.getBytes());
      byte[] digest = md.digest();
      hashMD5 = DatatypeConverter.printHexBinary(digest).toLowerCase();
    } catch (NoSuchAlgorithmException e) {
    }
    return hashMD5;
  }

}
