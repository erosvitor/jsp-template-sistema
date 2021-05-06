package com.ctseducare.template.dao;

import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import org.hibernate.Session;

import com.ctseducare.template.hibernate.HibernateUtils;
import com.ctseducare.template.model.Profile;

public class ProfileDAO extends DAO<Profile>{

  public ProfileDAO() {
    super(Profile.class);
  }
  
  public List<Profile> listProfilesFree(int iduser) {
    StringBuilder sql = new StringBuilder();
    sql.append("SELECT p.id, p.name ");
    sql.append("FROM profiles p ");
    sql.append("WHERE p.id NOT IN (SELECT up.id_profile FROM users_profiles up WHERE id_user = :iduser)");
    
    Session session = HibernateUtils.getSessionFactory().openSession();
    TypedQuery<Profile> query = session.createNativeQuery(sql.toString(), Profile.class);
    query.setParameter("iduser", iduser);
    List<Profile> profiles = query.getResultList();
    session.close();
    
    return profiles;
  }
  
  public Profile findByName(String name) {
    String hql = "FROM Profile WHERE name = :name";
    
    Session session = HibernateUtils.getSessionFactory().openSession();
    TypedQuery<Profile> query = session.createQuery(hql, Profile.class);
    query.setParameter("name", name);

    Profile profile = null;
    try {
      profile = query.getSingleResult();
    } catch (NoResultException e) {
    }
    
    session.close();
    
    return profile;
  }
  
}
