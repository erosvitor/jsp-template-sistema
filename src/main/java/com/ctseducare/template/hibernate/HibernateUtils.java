package com.ctseducare.template.hibernate;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.ctseducare.template.model.Profile;
import com.ctseducare.template.model.User;

public class HibernateUtils {

  private static SessionFactory sessionFactory = null;

  private HibernateUtils() {}

  public static SessionFactory getSessionFactory() {
    if (sessionFactory == null) {
      StandardServiceRegistryBuilder registryBuilder = new StandardServiceRegistryBuilder();
      registryBuilder.loadProperties("com/ctseducare/template/hibernate/hibernate.properties");

      StandardServiceRegistry registry = registryBuilder.build();

      try {
        MetadataSources metadataSources = new MetadataSources(registry);
        metadataSources.addAnnotatedClass(Profile.class);
        metadataSources.addAnnotatedClass(User.class);

        sessionFactory = metadataSources.buildMetadata().buildSessionFactory();
      } catch (Exception e) {
        e.printStackTrace();
        StandardServiceRegistryBuilder.destroy(registry);
      }
    }
    return sessionFactory;
  }

  public static void shutdown() {
    sessionFactory.close();
  }

}
