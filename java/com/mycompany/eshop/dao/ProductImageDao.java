package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.ProductImage;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductImageDao {

    private SessionFactory factory;

    public ProductImageDao(SessionFactory factory) {
        this.factory = factory;
    }

    /*save product images in database*/
    public int saveFileInDb(ProductImage pi, String path) throws IOException {

        //product image save
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        //uploading code..
        FileInputStream fis = new FileInputStream(path);

        //reading data
        byte[] data = new byte[fis.available()];

        fis.read(data);
        pi.setProductImage(data);
        int piId = (int) s.save(pi);

        tx.commit();
        s.close();

        return piId;
    }

    //get all product Images of given category
    public List<ProductImage> getAllProductImgById(int pId) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from ProductImage as pi where pi.product.pId =: id");
        query.setParameter("id", pId);
        List<ProductImage> list = query.list();
        return list;
    }
}
