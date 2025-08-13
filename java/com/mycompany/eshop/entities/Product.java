package com.mycompany.eshop.entities;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

/*create and define entity or database table name with the class name
for Product entity within the database(MySQL) using hibernate*/
@Entity
public class Product {

    /*define primary key for User entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    /*@Column() defines column's size and it's name in the database
    if @Column is not defined the vaiable name is used as the column name*/
    private int pId;
    private String pName;
    @Column(length = 3000)
    private String pDesc;
    private int pPrice;
    private int pDiscount;
    private int pQuantity;
    @Lob
    private byte[] productImg;
    /*mapping done for Product and Category
    as many products are in one category
    hence used @ManyToOne()*/
    @ManyToOne
    private Category category;
    @OneToMany(mappedBy = "product")
    private List<ProductImage> ProductImages = new ArrayList<>();

    /*parameterized constructor for data input and access with productId(primary key)*/
    public Product(int pId, String pName, String pDesc, int pPrice, int pDiscount, int pQuantity, byte[] productImg, Category category, List<ProductImage> ProductImages) {
        this.pId = pId;
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.productImg = productImg;
        this.category = category;
        this.ProductImages = ProductImages;
    }

    /*parameterized constructor for data input and access without productId(primary key) as it is auto incremented*/
    public Product(String pName, String pDesc, int pPrice, int pDiscount, int pQuantity, byte[] productImg, Category category, List<ProductImage> ProductImages) {
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.productImg = productImg;
        this.category = category;
        this.ProductImages = ProductImages;
    }

    /*default constructor if no value is inserted*/
    public Product() {
    }

    /*getters and setters for all the columns in Product entity*/
    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public int getpPrice() {
        return pPrice;
    }

    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }

    public int getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(int pDiscount) {
        this.pDiscount = pDiscount;
    }

    public int getpQuantity() {
        return pQuantity;
    }

    public void setpQuantity(int pQuantity) {
        this.pQuantity = pQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public byte[] getProductImg() {
        return productImg;
    }

    public void setProductImg(byte[] productImg) {
        this.productImg = productImg;
    }

    public List<ProductImage> getProductImages() {
        return ProductImages;
    }

    public void setProductImages(List<ProductImage> ProductImages) {
        this.ProductImages = ProductImages;
    }//getters and setters till here

    /*toString() method for reeference printing*/
    @Override
    public String toString() {
        return "Product{" + "pId=" + pId + ", pName=" + pName + ", pDesc=" + pDesc + ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + '}';
    }

    //calculate price after discount
    public int getPriceAfterApplyingDiscount() {
        int d = (int) ((this.getpDiscount() / 100.0) * this.getpPrice());
        return this.getpPrice() - d;
    }

}
