package com.ctseducare.template.servlet;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ctseducare.template.dto.ProfileDTO;
import com.ctseducare.template.dto.UserDTO;
import com.ctseducare.template.exceptions.LoginAlreadyExistException;
import com.ctseducare.template.helper.ServletResponseHelper;
import com.ctseducare.template.helper.UserLoggedHelper;
import com.ctseducare.template.json.DatatableJson;
import com.ctseducare.template.model.Profile;
import com.ctseducare.template.model.User;
import com.ctseducare.template.service.UserService;

import br.com.ctseducare.conversion.CTSConversion;

@WebServlet("/servlets/user")
public class UserServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  private UserService userService;

  public UserServlet() {
    userService = new UserService();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    doPost(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    String action = request.getParameter("action");
    switch (action) {
      case "load":
        load(request, response);
        break;
      case "save":
        save(request, response);
        break;
      case "edit":
        edit(request, response);
        break;
      case "remove":
        remove(request, response);
        break;
    }
  }

  private void load(HttpServletRequest request, HttpServletResponse response) {
    int draw = Integer.parseInt(request.getParameter("draw"));
    try {
      List<User> users = userService.listAll();
      DatatableJson json = new DatatableJson();
      json.setDraw(draw);
      json.setRecordsTotal(users.size());
      json.setRecordsFiltered(users.size());
      json.setData(getUsersDTO(users));
      ServletResponseHelper.sendResponseLoadOk(response, json);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  private void save(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String telephone = request.getParameter("telephone");
    String email = request.getParameter("email");
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    String[] profiles = request.getParameterValues("profiles[]");
    String userLogged = UserLoggedHelper.getUsernameLogged(request);
    try {
      userService.insertOrUpdate(id, name, telephone, email, login, password, profiles, userLogged);
      ServletResponseHelper.sendResponseSaveOk(response);
    } catch (LoginAlreadyExistException e) {
      ServletResponseHelper.sendResponseError(response, e.getMessage());
    } catch(Exception e) {
      e.printStackTrace();
    }
  }  

  private void edit(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    try {
      User user = userService.findById(id);
      ServletResponseHelper.sendResponseEditOk(response, transformToDTO(user));
    } catch(Exception e) {
      e.printStackTrace();
    }
  }  

  private void remove(HttpServletRequest request, HttpServletResponse response) { 
    int id = Integer.parseInt(request.getParameter("id"));
    String userLogged = UserLoggedHelper.getUsernameLogged(request);
    try {
      userService.remove(id, userLogged);
      ServletResponseHelper.sendResponseRemoveOk(response);
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  private List<UserDTO> getUsersDTO(List<User> users) {
    List<UserDTO> usersDTO = new ArrayList<>();
    for (User user : users) {
      usersDTO.add(transformToDTO(user));
    }
    return usersDTO;
  }
  
  private UserDTO transformToDTO(User user) {
    UserDTO userDTO = new UserDTO();
    userDTO.setId(user.getId());
    userDTO.setName(user.getName());
    userDTO.setTelephone(CTSConversion.emptyIfNull(user.getTelephone()));
    userDTO.setEmail(CTSConversion.emptyIfNull(user.getEmail()));
    userDTO.setLogin(user.getLogin());
    userDTO.setPassword(user.getPassword());

    Iterator<Profile> it = user.getProfiles().iterator();
    while (it.hasNext()) {
      Profile p = it.next();
      userDTO.getProfiles().add(new ProfileDTO(p.getId(), p.getName()));
    }
    
    return userDTO;
  }
  
}
