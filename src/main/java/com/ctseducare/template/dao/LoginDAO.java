package com.ctseducare.template.dao;

import javax.persistence.NoResultException;
import javax.persistence.Query;

import org.hibernate.Session;

import com.ctseducare.template.hibernate.HibernateUtils;
import com.ctseducare.template.model.User;

public class LoginDAO {
  
  public User checkUserPassword(String login, String password) {
    String hql = "FROM User WHERE login = :login AND password = :password";
    
    Session session = HibernateUtils.getSessionFactory().openSession();
    Query query = session.createQuery(hql, User.class);
    query.setParameter("login", login);
    query.setParameter("password", password);
    
    User user = null;
    try {
      user = (User)query.getSingleResult();
    } catch (NoResultException e) {
    }
    
    session.close();
    
    return user;
  }

}
