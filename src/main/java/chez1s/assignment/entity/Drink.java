package chez1s.assignment.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "drinks")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Drink {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Column(nullable = false)
    private String name;

    private String description;

    private String image;

    private int price;

    private boolean active = true;
}
