package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    /*save category data in database*/
    public int saveCategory(Category cat) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }

    /*get list of categories from the database*/
    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }

    /*get list of 5 categories from the database*/
    public List<Category> getCategoriesPerPage(int start) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        query.setFirstResult(start);
        query.setMaxResults(5);
        List<Category> list = query.list();
        return list;
    }

    /*get category by category id*/
    public Category getCategoryById(int cid) {
        Category cat = null;
        try {
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    /*function to update category details in the database*/
    public boolean updateCategory(Category cat) {
        boolean f = false;
        try {
            //query to update category details
            String query = "update Category as c set c.categoryTitle =: ct , c.categoryDescription =: cd where c.categoryId =: cid";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query q = session.createQuery(query);

            q.setParameter("ct", cat.getCategoryTitle());
            q.setParameter("cd", cat.getCategoryDescription());
            q.setParameter("cid", cat.getCategoryId());

            q.executeUpdate();
            f = true;
            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
