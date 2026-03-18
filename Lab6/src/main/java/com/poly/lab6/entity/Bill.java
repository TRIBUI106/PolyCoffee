package com.poly.lab6.entity;

import java.util.Date;

public class Bill {

    private int id;
    private int userId;
    private double total;        // 🔥 thêm
    private String status;       // 🔥 thêm
    private Date createdDate;
    private String userName;     // 🔥 thêm (JOIN từ users)

    public Bill() {
    }

    public Bill(int id, int userId, double total, String status, Date createdDate, String userName) {
        this.id = id;
        this.userId = userId;
        this.total = total;
        this.status = status;
        this.createdDate = createdDate;
        this.userName = userName;
    }

    // ===== GET SET =====

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

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}