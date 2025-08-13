package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.Orders;
import com.mycompany.eshop.entities.User;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDao {
    private SessionFactory factory;

    public OrderDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    /*save order data in database*/
    public int saveOrder(Orders order) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int oId = (int) session.save(order);
        tx.commit();
        session.close();
        return oId;
    }
    
    /*get list of all order details from the database*/
    public List<Orders> getOrderDetailsByUserId(User u) {
        Session s = this.factory.openSession();
        List<Orders> order = null;
        try {
            Query query = s.createQuery("from Orders as o where o.user =: uid");
            query.setParameter("uid", u);
            order = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        s.close();
        return order;
    }
    
    /*get orders by orderid*/
    public Orders getOrderByOrderId(String oId) {
        Session s = this.factory.openSession();
        Orders order = null;
        try {
            Query query = s.createQuery("from Orders as o where o.orderId =: id");
            query.setParameter("id", oId);
            order = (Orders) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        s.close();
        return order;
    }
    
    /*update order details*/
    public boolean updateOrder(Orders o) {
        boolean f = false;
        try {
            //query to delete details
            String pquery = "update Orders as o set o.status =: st , o.paymentId =: PayID where o.orderId =: oid";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query oq = session.createQuery(pquery);

            oq.setParameter("st", o.getStatus());
            oq.setParameter("PayID", o.getPaymentId());
            oq.setParameter("oid", o.getOrderId());

            oq.executeUpdate();
            f = true;
            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
}
