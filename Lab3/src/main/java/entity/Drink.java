package entity;

public class Drink {
    private int id;
    private String name;
    private double price;
    private int categoryId;
    private boolean active;

    public Drink() {
    }

    public Drink(int id, String name, double price, int categoryId, boolean active) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.active = active;
    }

    public Drink(String name, double price, int categoryId, boolean active) {
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.active = active;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}