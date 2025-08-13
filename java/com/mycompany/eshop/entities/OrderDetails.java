package com.mycompany.eshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class OrderDetails {

    /*define primary key for Orders entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int product_quantity;
    private String user_phno;
    private String user_email;
    //column length large as address can be long
    @Column(length = 1500)
    private String shipping_address;
    private String payment_type;
    @ManyToOne
    private Orders oId;
    private String order_Id;
    @ManyToOne
    private Product pId;

    public OrderDetails(Orders oId, String order_Id, Product pId, int product_quantity, String user_phno, String user_email, String shipping_address, String payment_type) {
        this.oId = oId;
        this.order_Id = order_Id;
        this.pId = pId;
        this.product_quantity = product_quantity;
        this.user_phno = user_phno;
        this.user_email = user_email;
        this.shipping_address = shipping_address;
        this.payment_type = payment_type;
    }

    public OrderDetails() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Orders getoId() {
        return oId;
    }

    public void setoId(Orders oId) {
        this.oId = oId;
    }

    public String getOrder_Id() {
        return order_Id;
    }

    public void setOrder_Id(String order_Id) {
        this.order_Id = order_Id;
    }

    public Product getpId() {
        return pId;
    }

    public void setpId(Product pId) {
        this.pId = pId;
    }

    public int getProduct_quantity() {
        return product_quantity;
    }

    public void setProduct_quantity(int product_quantity) {
        this.product_quantity = product_quantity;
    }

    public String getUser_phno() {
        return user_phno;
    }

    public void setUser_phno(String user_phno) {
        this.user_phno = user_phno;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
    }

    public String getpayment_type() {
        return payment_type;
    }

    public void setpayment_type(String payment_type) {
        this.payment_type = payment_type;
    }

    @Override
    public String toString() {
        return "OrderDetails{" + "id=" + id + ", oId=" + oId + ", order_Id=" + order_Id + ", pId=" + pId + ", product_quantity=" + product_quantity + ", user_phno=" + user_phno + ", user_email=" + user_email + ", shipping_address=" + shipping_address + ", payment_type=" + payment_type + '}';
    }
}
