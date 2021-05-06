package com.ctseducare.template.service;

import java.util.List;

import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ctseducare.template.dao.ProfileDAO;
import com.ctseducare.template.dao.UserDAO;
import com.ctseducare.template.exceptions.LoginAlreadyExistException;
import com.ctseducare.template.hibernate.HibernateUtils;
import com.ctseducare.template.model.Profile;
import com.ctseducare.template.model.User;

import br.com.ctseducare.cryptography.CTSHashGenerator;

public class UserService {
  
  private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

  private UserDAO userDAO;

  public UserService() {
    userDAO = new UserDAO();
  }

  public void insertOrUpdate(int id, String name, String telephone, String email, String login, String password, String[] profiles, String usernameLogged) throws Exception {
    User user = new User();
    user.setId(id);
    user.setName(name);
    user.setTelephone(telephone);
    user.setEmail(email);
    user.setLogin(login);
        
    if (profiles != null) {
      ProfileDAO profileDAO = new ProfileDAO();
      for (String profile : profiles) {
        Profile profileTmp = profileDAO.findById(Integer.parseInt(profile));
        user.getProfiles().add(profileTmp);
      }
    }
    
    if (id == 0) {
      if (userDAO.findByLogin(login) == null) {
        user.setPassword(CTSHashGenerator.md5(password));
        userDAO.insert(user);
        LOGGER.info(String.format("O usuário '%s' adicionou o usuário '%s'", usernameLogged, user.getName()));
      } else {
        throw new LoginAlreadyExistException("Já existe um usuário cadastro com este login");
      }
    } else {
      User userTemp = userDAO.findById(id);
      if (userTemp.getPassword().equals(password)) {
        user.setPassword(password);
      } else {  
        user.setPassword(CTSHashGenerator.md5(password));
      }
      userDAO.update(user);
      LOGGER.info(String.format("O usuário '%s' alterou o usuário '%s'", usernameLogged, user.getName()));
    }
  }

  public List<User> listAll() throws Exception {
    return userDAO.listAll();
  }

  public User findById(int id) throws Exception {
    Session session = HibernateUtils.getSessionFactory().openSession();
    try {
      return userDAO.findById(id);
    } finally {
      session.close();
    }
  }

  public void remove(int id, String usernameLogged) throws Exception {
    User userDeleted = userDAO.findById(id);
    userDAO.remove(id);
    LOGGER.info(String.format("O usuário '%s' excluiu o usuário '%s'", usernameLogged, userDeleted.getLogin()));
  }
  
}
