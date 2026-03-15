package com.poly.lab4.entity;

public class BillDetail {

    private int id;
    private int billId;
    private int drinkId;
    private int quantity;
    private double price;

    public BillDetail() {
    }

    public BillDetail(int id, int billId, int drinkId, int quantity, double price) {
        this.id = id;
        this.billId = billId;
        this.drinkId = drinkId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }


    public int getDrinkId() {
        return drinkId;
    }

    public void setDrinkId(int drinkId) {
        this.drinkId = drinkId;
    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}