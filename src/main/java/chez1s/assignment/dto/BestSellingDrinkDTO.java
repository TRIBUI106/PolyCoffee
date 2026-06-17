package chez1s.assignment.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BestSellingDrinkDTO {
    private Integer drinkId;
    private String drinkName;
    private Long totalQuantitySold;
    private Long totalRevenue;
}
