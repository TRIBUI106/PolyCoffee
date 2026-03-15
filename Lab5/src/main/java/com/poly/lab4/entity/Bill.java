package com.poly.lab4.entity;

import java.util.Date;

public class Bill {

    private int id;
    private int userId;
    private Date createdDate;

    public Bill() {
    }

    public Bill(int id, int userId, Date createdDate) {
        this.id = id;
        this.userId = userId;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}