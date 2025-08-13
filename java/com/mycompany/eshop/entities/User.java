package com.mycompany.eshop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;

/*create and define entity or database table name with the class name
for User entity within the database(MySQL) using hibernate*/
@Entity
public class User {

    /*define primary key for User entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    /*define column's size and it's name in the database
    if @Column is not defined the vaiable name is used as the column name*/
    @Column(length = 10, name = "user_id")
    private int userId;
    @Column(length = 100, name = "first_name")
    private String firstName;
    @Column(length = 100, name = "Last_name")
    private String lastName;
    //setting email to unique key
    @Column(length = 100, name = "user_email", unique = true)
    private String userEmail;
    @Column(length = 255, name = "user_password")
    private String userPassword;
    @Column(length = 12, name = "user_phone")
    private String userPhone;
    @Column(length = 1500, name = "user_pic")
    @Lob
    private byte[] userPic;
    private String userPicName;
    @Column(length = 1500, name = "user_address")
    private String userAddress;
    @Column(name = "user_type")
    private String userType;

    /*parameterized constructor for data input and access with userId(primary key)*/
    public User(int userId, String firstName, String lastName, String userEmail, String userPassword, String userPhone, String userPicName, byte[] userPic, String userAddress, String userType) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPicName = userPicName;
        this.userPic = userPic;
        this.userAddress = userAddress;
        this.userType = userType;
    }

    /*parameterized constructor for data input and access without userId(primary key) as it is auto incremented*/
    public User(String firstName, String lastName, String userEmail, String userPassword, String userPhone, String userPicName, byte[] userPic, String userAddress, String userType) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userPicName = userPicName;
        this.userPic = userPic;
        this.userAddress = userAddress;
        this.userType = userType;
    }

    /*default constructor if no value is inserted*/
    public User() {
    }

    /*getters and setters for all the columns in User entity*/
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public byte[] getUserPic() {
        return userPic;
    }

    public void setUserPic(byte[] userPic) {
        this.userPic = userPic;
    }

    public String getUserPicName() {
        return userPicName;
    }

    public void setUserPicName(String userPicName) {
        this.userPicName = userPicName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }//getters and setters till here

    /*toString() method for reeference printing*/
    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", firstName=" + firstName + ", lastName=" + lastName + ", userEmail=" + userEmail + ", userPassword=" + userPassword + ", userPhone=" + userPhone + ", userPic=" + userPic + ", userAddress=" + userAddress + ", userType=" + userType + '}';
    }

}
