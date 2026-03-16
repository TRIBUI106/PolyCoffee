package chez1s.assignment.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "bill_details")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BillDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bill_id", nullable = false)
    private Bill bill;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "drink_id", nullable = false)
    private Drink drink;

    private int quantity;

    private int price;

    private String note;
}
