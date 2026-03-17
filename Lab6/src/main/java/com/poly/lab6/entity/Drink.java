package com.poly.lab6.entity;

public class Drink {

    private int id;
    private String name;
    private double price;
    private String image;
    private int categoryId;

    public Drink() {
    }

    public Drink(int id, String name, double price, String image, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.categoryId = categoryId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }


    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    private boolean status; // true: Còn hàng, false: Hết hàng

    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}