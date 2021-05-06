package com.ctseducare.template.servlet;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ctseducare.template.dto.ProfileDTO;
import com.ctseducare.template.exceptions.ForeignKeyException;
import com.ctseducare.template.exceptions.ProfileAlreadyExistException;
import com.ctseducare.template.helper.ServletResponseHelper;
import com.ctseducare.template.helper.UserLoggedHelper;
import com.ctseducare.template.json.DatatableJson;
import com.ctseducare.template.model.Profile;
import com.ctseducare.template.service.ProfileService;

@WebServlet("/servlets/profile")
public class ProfileServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  private ProfileService profileService;

  public ProfileServlet() {
    profileService = new ProfileService();
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
      case "loadProfilesFree":
        loadProfilesFree(request, response);
        break;
    }
  }

  private void load(HttpServletRequest request, HttpServletResponse response) {
    int draw = Integer.parseInt(request.getParameter("draw"));
    try {
      List<Profile> profiles = profileService.listAll();
      DatatableJson json = new DatatableJson();
      json.setDraw(draw);
      json.setRecordsTotal(profiles.size());
      json.setRecordsFiltered(profiles.size());
      json.setData(getProfilesDTO(profiles));
      ServletResponseHelper.sendResponseLoadOk(response, json);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void save(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String userLogged = UserLoggedHelper.getUsernameLogged(request);
    try {
      profileService.insertOrUpdate(id, name, userLogged);
      ServletResponseHelper.sendResponseSaveOk(response);
    } catch (ProfileAlreadyExistException e) {
      ServletResponseHelper.sendResponseError(response, e.getMessage());      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void edit(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    try {
      Profile profile = profileService.findById(id);
      ServletResponseHelper.sendResponseEditOk(response, transformToDTO(profile));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void remove(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id"));
    String userLogged = UserLoggedHelper.getUsernameLogged(request);
    try {
      profileService.remove(id, userLogged);
      ServletResponseHelper.sendResponseRemoveOk(response);
    } catch (ForeignKeyException e) {
      ServletResponseHelper.sendResponseError(response, e.getMessage());
    }
  }

  private void loadProfilesFree(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("userId"));
    try {
      List<Profile> profilesFree = profileService.listProfilesFree(id);
      ServletResponseHelper.sendResponseListObject(response, getProfilesDTO(profilesFree));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private List<ProfileDTO> getProfilesDTO(List<Profile> profiles) {
    List<ProfileDTO> profilesDTO = new ArrayList<>();
    for (Profile profile : profiles) {
      profilesDTO.add(transformToDTO(profile));
    }
    return profilesDTO;
  }

  private ProfileDTO transformToDTO(Profile profile) {
    ProfileDTO profileDTO = new ProfileDTO();
    profileDTO.setId(profile.getId());
    profileDTO.setName(profile.getName());
    return profileDTO;
  }

}
