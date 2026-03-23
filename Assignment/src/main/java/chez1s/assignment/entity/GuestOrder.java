package chez1s.assignment.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "guest_orders")
public class GuestOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guest_id", nullable = false)
    private Guest guest;

    @Column(name = "code", nullable = false, unique = true)
    private String code;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "total", columnDefinition = "INT DEFAULT 0")
    private Integer total = 0;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", columnDefinition = "ENUM('WAITING', 'FINISHED', 'CANCELLED') DEFAULT 'WAITING'")
    private BillStatus status = BillStatus.WAITING;

    @OneToMany(mappedBy = "guestOrder", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<GuestOrderDetail> details;

    public GuestOrder() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Guest getGuest() {
        return guest;
    }

    public void setGuest(Guest guest) {
        this.guest = guest;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public BillStatus getStatus() {
        return status;
    }

    public void setStatus(BillStatus status) {
        this.status = status;
    }

    public List<GuestOrderDetail> getDetails() {
        return details;
    }

    public void setDetails(List<GuestOrderDetail> details) {
        this.details = details;
    }
}
