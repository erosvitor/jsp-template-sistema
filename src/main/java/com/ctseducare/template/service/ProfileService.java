package com.ctseducare.template.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ctseducare.template.dao.ProfileDAO;
import com.ctseducare.template.exceptions.ForeignKeyException;
import com.ctseducare.template.exceptions.ProfileAlreadyExistException;
import com.ctseducare.template.model.Profile;

public class ProfileService {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(ProfileService.class);

  private ProfileDAO profileDAO;

  public ProfileService() {
    profileDAO = new ProfileDAO();
  }

  public void insertOrUpdate(int id, String name, String userLooged) throws Exception {
    Profile profile = new Profile(id, name);
    if (id == 0) {
      if (profileDAO.findByName(name) == null) {
        profileDAO.insert(profile);
        LOGGER.info(String.format("O usuário '%s' adicionou o perfil '%s'", userLooged, profile.getName()));
      } else {
        throw new ProfileAlreadyExistException("Já existe um perfil cadastrado com este nome");
      }
    } else {
      profileDAO.update(profile);
      LOGGER.info(String.format("O usuário '%s' alterou o perfil '%s'", userLooged, profile.getName()));
    }
  }

  public List<Profile> listAll() throws Exception {
    return profileDAO.listAll();
  }

  public Profile findById(int id) throws Exception {
    return profileDAO.findById(id);
  }

  public void remove(int id, String userLogged) throws ForeignKeyException { 
    try {
      Profile profileDeleted = profileDAO.findById(id);
      profileDAO.remove(id);
      LOGGER.info(String.format("O usuário '%s' excluiu o perfil '%s'", userLogged, profileDeleted.getName()));
    } catch (ForeignKeyException e) {
      throw new ForeignKeyException(e.getMessage());
    } catch (Exception e) {
    }
  }

  public List<Profile> listProfilesFree(int iduser) {
    return profileDAO.listProfilesFree(iduser);
  }

}
