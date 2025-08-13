package com.mycompany.eshop.entities;

import java.util.Arrays;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

/*create and define entity or database table name with the class name
for ProductImage entity within the database(MySQL) using hibernate*/
@Entity
public class ProductImage {
    /*define primary key for User entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ProductImgId;
    /*@Column() defines column's size and it's name in the database
    if @Column is not defined the vaiable name is used as the column name*/
    @Lob   
    private byte[] ProductImage;
    @ManyToOne
    private Product product;

    /*parameterized constructor for data input and access with productImgId(primary key)*/

    public ProductImage(int ProductImgId, byte[] ProductImage, Product product) {
        this.ProductImgId = ProductImgId;
        this.ProductImage = ProductImage;
        this.product = product;
    }
    

    /*parameterized constructor for data input and access without productImgId(primary key) as it is auto incremented*/
    public ProductImage(byte[] ProductImage, Product product) {
        this.ProductImage = ProductImage;
        this.product = product;
    }

    /*default constructor if no value is inserted*/
    public ProductImage() {
    }

    /*getters and setters for all the columns in ProductImage entity*/ 

    public int getProductImgId() {
        return ProductImgId;
    }

    public void setProductImgId(int ProductImgId) {
        this.ProductImgId = ProductImgId;
    }

    public byte[] getProductImage() {
        return ProductImage;
    }

    public void setProductImage(byte[] ProductImgName) {
        this.ProductImage = ProductImgName;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }//getters and setters till here

    /*toString() method for reeference printing*/
    @Override
    public String toString() {
        return "ProductImage{" + "ProductImgId=" + ProductImgId + ", ProductImgName=" + Arrays.toString(ProductImage) + ", product=" + product + '}';
    }
    
    
}
