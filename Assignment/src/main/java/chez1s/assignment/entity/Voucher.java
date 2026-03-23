package chez1s.assignment.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "vouchers")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(name = "required_points", nullable = false)
    private Integer requiredPoints;

    @Column(name = "discount_amount", nullable = false)
    private Integer discountAmount;
    
    @OneToMany(mappedBy = "voucher", fetch = FetchType.LAZY)
    private List<GuestVoucher> guestVouchers;

    public Voucher() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getRequiredPoints() { return requiredPoints; }
    public void setRequiredPoints(Integer requiredPoints) { this.requiredPoints = requiredPoints; }

    public Integer getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(Integer discountAmount) { this.discountAmount = discountAmount; }
    
    public List<GuestVoucher> getGuestVouchers() { return guestVouchers; }
    public void setGuestVouchers(List<GuestVoucher> guestVouchers) { this.guestVouchers = guestVouchers; }
}
