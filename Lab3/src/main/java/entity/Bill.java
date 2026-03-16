package entity;

import java.util.Date;

public class Bill {
    private int id;
    private int userId;
    private Date createdDate;
    private String status;

    public Bill() {
    }

    public Bill(int id, int userId, Date createdDate, String status) {
        this.id = id;
        this.userId = userId;
        this.createdDate = createdDate;
        this.status = status;
    }

    public Bill(int userId, Date createdDate, String status) {
        this.userId = userId;
        this.createdDate = createdDate;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}