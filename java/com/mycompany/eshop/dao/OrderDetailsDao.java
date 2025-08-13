package com.mycompany.eshop.dao;

import com.mycompany.eshop.entities.OrderDetails;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDetailsDao {
    private SessionFactory factory;

    public OrderDetailsDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    /*save order details data in database*/
    public int saveOrder(OrderDetails order) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int odId = (int) session.save(order);
        tx.commit();
        session.close();
        return odId;
    }
    
    /*get list of order details*/
    public List<OrderDetails> getOrderDetailsByOrderId(String oId) {
        Session s = this.factory.openSession();
        List<OrderDetails> order = null;
        try {
            Query query = s.createQuery("from OrderDetails as od where od.order_Id =: id");
            query.setParameter("id", oId);
            order = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        s.close();
        return order;
    }
    
    /*update order details after payment or cod*/
    public boolean updateOrderDetails(OrderDetails o) {
        boolean f = false;
        try {
            //query to delete details
            String pquery = "update OrderDetails as o set o.oId =: oid , o.order_Id =: id , o.pId =: p ,"
                    + " o.product_quantity =: pq , o.user_phno =: ph , o.user_email =: em , o.shipping_address =: sa ,"
                    + " o.payment_type =: ty where o.id =: i";
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Query pq = session.createQuery(pquery);

            pq.setParameter("oid", o.getoId());
            pq.setParameter("id", o.getOrder_Id());
            pq.setParameter("p", o.getpId());
            pq.setParameter("pq", o.getProduct_quantity());
            pq.setParameter("ph", o.getUser_phno());
            pq.setParameter("em", o.getUser_email());
            pq.setParameter("sa", o.getShipping_address());
            pq.setParameter("ty", o.getpayment_type());
            pq.setParameter("i", o.getId());

            pq.executeUpdate();
            f = true;
            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
}
