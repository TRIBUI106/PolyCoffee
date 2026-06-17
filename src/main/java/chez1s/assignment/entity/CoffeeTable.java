package chez1s.assignment.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "coffee_tables")
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "bills")
public class CoffeeTable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "table_number", nullable = false)
    private String tableNumber;

    @Column(nullable = false, unique = true)
    private String code;

    private boolean active = true;

    @OneToMany(mappedBy = "table", fetch = FetchType.LAZY)
    private List<Bill> bills;
}
