package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.Product;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    /*save product data in the database*/
    public int saveProduct(Product product, String path) throws IOException {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        //uploading code..
        FileInputStream fis = new FileInputStream(path);

        //reading data
        byte[] data = new byte[fis.available()];

        fis.read(data);
        product.setProductImg(data);

        int pid = (int) session.save(product);

        tx.commit();
        session.close();
        fis.close();
        return pid;
    }

    //get all products
    public List<Product> getAllProducts() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product");
        List<Product> list = query.list();
        return list;
    }

    //get all  products of given category
    public List<Product> getAllProductsByCatId(int cid) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cid);
        List<Product> list = query.list();
        return list;
    }

    /*get product details by product Id*/
    public Product getProductById(int pid) {
        Product pro = null;
        try {

            Session session = this.factory.openSession();
            pro = session.get(Product.class, pid);
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pro;
    }

    /*save product image in database*/
    public int saveFileInDb(Product p, String path) throws IOException {

        //product image save
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        //uploading code..
        FileInputStream fis = new FileInputStream(path);

        //reading data
        byte[] data = new byte[fis.available()];

        fis.read(data);
        p.setProductImg(data);
        int piId = (int) s.save(p);

        tx.commit();
        s.close();
        fis.close();
        return piId;
    }

    /*get 9 products for a page */
    public List<Product> getProductForPage(int x) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product");
        query.setFirstResult(x);
        query.setMaxResults(9);
        List<Product> list = query.list();
        return list;
    }

    /*update product details*/
    public boolean updateProduct(Product p) {
        boolean f = false;
        try {
            //query to delete details
            String pquery = "update Product as p set pName =: pn , pDesc =: pd , pPrice =: pp ,"
                    + " pDiscount =: pdis , pQuantity =: pq , category =: cat where p.pId =: pid";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query pq = session.createQuery(pquery);

            pq.setParameter("pn", p.getpName());
            pq.setParameter("pd", p.getpDesc());
            pq.setParameter("pp", p.getpPrice());
            pq.setParameter("pdis", p.getpDiscount());
            pq.setParameter("pq", p.getpQuantity());
            pq.setParameter("cat", p.getCategory());
            pq.setParameter("pid", p.getpId());

            pq.executeUpdate();
            f = true;
            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    /*update primary product image*/
    public boolean updateProductPic(Product p) {

        boolean f = false;
        try {
            //query to update user details
            String query = "update Product as p set p.productImg =: pi where p.pId =: pid";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query q = session.createQuery(query);

            q.setParameter("pi", p.getProductImg());
            q.setParameter("pid", p.getpId());

            q.executeUpdate();
            f = true;
            tx.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
