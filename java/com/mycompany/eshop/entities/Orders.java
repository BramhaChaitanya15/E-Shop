package com.mycompany.eshop.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Orders {

    /*define primary key for Orders entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    /*@Column() defines column's size and it's name in the database
    if @Column is not defined the vaiable name is used as the column name*/
    private int oId;
    private String userName;
    private String orderId;
    private int amount;
    private String receipt;
    private String status;
    @ManyToOne
    private User user;
    private String paymentId;

    public Orders(String orderId, int amount, String recipt, String status, User user, String userName, String paymentId) {
        this.orderId = orderId;
        this.amount = amount;
        this.receipt = recipt;
        this.status = status;
        this.user = user;
        this.userName = userName;
        this.paymentId = paymentId;
    }

    //default constructor
    public Orders() {
    }

    //getters and setters
    public int getoId() {
        return oId;
    }

    public void setoId(int oId) {
        this.oId = oId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getReceipt() {
        return receipt;
    }

    public void setReceipt(String receipt) {
        this.receipt = receipt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }//end getters and setters

    //to string function
    @Override
    public String toString() {
        return "Orders{" + "oId=" + oId + ", orderId=" + orderId + ", amount=" + amount + ", receipt=" + receipt + ", status=" + status + ", user=" + user + ", userName=" + userName + ", paymentId=" + paymentId + '}';
    }

}
