package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.User;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    /*save user registration details in database along with user profile picture*/
    public int saveUser(User user, String path) throws FileNotFoundException, IOException {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        FileInputStream fis = new FileInputStream(path);

        //reading data
        byte[] data = new byte[fis.available()];

        fis.read(data);
        user.setUserPic(data);
        int pid = (int) session.save(user);

        tx.commit();
        fis.close();
        return pid;
    }

    //get user by email and encrypted password
    public User getUserByEmailAndPassword(String email, String password) {
        //setting user to null
        User user = null;
        try {
            /*using email and password to get user from database if user exists*/
            String query = "from User where userEmail =: e and userPassword=: p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            user = (User) q.uniqueResult();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    /*get user details by user id*/
    public User getUserById(int uid) {
        User user = null;
        try {

            Session session = this.factory.openSession();
            user = session.get(User.class, uid);
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    /*update user profile picture in database*/
    public boolean updateUserPic(User user) {

        boolean f = false;
        try {
            //query to update user details
            String query = "update User as u set u.userPic =: up , u.userPicName =: upn where u.userId =: uid";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query q = session.createQuery(query);

            //setting query parameters
            q.setParameter("up", user.getUserPic());
            q.setParameter("upn", user.getUserPicName());
            q.setParameter("uid", user.getUserId());

            q.executeUpdate();
            f = true;
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    /*update user details in the database*/
    public boolean updateUser(User user) {

        boolean f = false;

        try {
            //query to update user details
            String query = "update User as u set u.firstName =: fn , u.lastName =: ln , u.userEmail =: em , u.userPhone =: ph "
                    + ", u.userAddress =: ad , u.userPassword =: pass , u.userType =: ut "
                    + " where u.userId =: uid";

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query q = session.createQuery(query);

            //setting query parameters
            q.setParameter("fn", user.getFirstName());
            q.setParameter("ln", user.getLastName());
            q.setParameter("em", user.getUserEmail());
            q.setParameter("ph", user.getUserPhone());
            q.setParameter("ad", user.getUserAddress());
            q.setParameter("pass", user.getUserPassword());
            q.setParameter("ut", user.getUserType());
            q.setParameter("uid", user.getUserId());

            q.executeUpdate();
            f = true;
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    //get all users
    public List<User> getAllUsers() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from User");
        List<User> list = query.list();
        return list;
    }

    //get all users with limits
    public List<User> getAllUsersPerPage(int start) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from User");
        query.setFirstResult(start);
        query.setMaxResults(8);
        List<User> list = query.list();
        return list;
    }
}
