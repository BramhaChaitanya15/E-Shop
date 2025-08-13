package com.mycompany.eshop.entities;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/*create and define entity or database table name with the class name
for Category entity within the database(MySQL) using hibernate*/
@Entity
public class Category {
    /*define primary key for User entity*/
    @Id
    /*auto incremantation for id*/
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    /*@Column() defines column's size and it's name in the database
    if @Column is not defined the vaiable name is used as the column name*/
    private int categoryId;
    private String categoryTitle;
    @Column(length = 3000)
    private String categoryDescription;
    /*mapping done for Product and Category
    as one category has many products
    hence used @OneToMany(mappedBy="category")
    used to tell the mapping from the Products foriegn key*/
    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();
    
    /*parameterized constructor for data input and access with categoryId(primary key)*/
    public Category(int categoryId, String categoryTitle, String categoryDescription) {
        this.categoryId = categoryId;
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
    }
    
    /*parameterized constructor for data input and access without categoryId(primary key) as it is auto incremented*/
    public Category(String categoryTitle, String categoryDescription, List<Product> products) {
        this.categoryTitle = categoryTitle;
        this.categoryDescription = categoryDescription;
        this.products = products;
    }
    /*default constructor if no value is inserted*/
    public Category() {
    }
    
    /*getters and setters for all the columns in Category entity*/
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryTitle() {
        return categoryTitle;
    }

    public void setCategoryTitle(String categoryTitle) {
        this.categoryTitle = categoryTitle;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }//getters and setters till here
    
    /*toString() method for reeference printing*/
    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", categoryTitle=" + categoryTitle + ", categoryDescription=" + categoryDescription + '}';
    }
    
    
}
