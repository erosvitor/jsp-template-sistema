package com.ctseducare.template.dto;

import java.util.ArrayList;
import java.util.List;

public class UserDTO {

  private Integer id;
  private String name;
  private String telephone;
  private String email;
  private String login;
  private String password;
  private List<ProfileDTO> profiles;
  
  public UserDTO() {
    profiles = new ArrayList<>();
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getTelephone() {
    return telephone;
  }

  public void setTelephone(String telephone) {
    this.telephone = telephone;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getLogin() {
    return login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public List<ProfileDTO> getProfiles() {
    return profiles;
  }

  public void setProfiles(List<ProfileDTO> profiles) {
    this.profiles = profiles;
  }

}
