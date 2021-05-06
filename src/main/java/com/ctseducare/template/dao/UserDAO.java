package com.ctseducare.template.dao;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import org.hibernate.Session;

import com.ctseducare.template.hibernate.HibernateUtils;
import com.ctseducare.template.model.User;

public class UserDAO extends DAO<User> {

  public UserDAO() {
    super(User.class);
  }
  
  public User findByLogin(String login) {
    String hql = "FROM User WHERE login = :login";
    
    Session session = HibernateUtils.getSessionFactory().openSession();
    TypedQuery<User> query = session.createQuery(hql, User.class);
    query.setParameter("login", login);

    User user = null;
    try {
      user = query.getSingleResult();
    } catch (NoResultException e) {
    }
    
    session.close();
    
    return user;
  }

}
