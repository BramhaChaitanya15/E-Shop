package com.mycompany.eshop.helper;

/*import all requires hibernate classes*/
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {

    /*SessionFactory comes from hibernate.org*/
    private static SessionFactory factory;

    /*function to return SessionFactory to configure and establish connection to database
    this function is a singleton design pattern function*/
    public static SessionFactory getFactory() {
        try {
            if (factory == null) {
                /*Configuration() comes from org.hibernate.cfg 
                after building session factory object we will store it to factory variable
                can be only done if factory has a null value
                path of configuration file must be declared in configure() if the file is somewhere else than resource directory*/
                factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            }
        } /*catch any null pointer exception*/ catch (HibernateException e) {
            e.printStackTrace();
        }
        return factory;
    }
}
