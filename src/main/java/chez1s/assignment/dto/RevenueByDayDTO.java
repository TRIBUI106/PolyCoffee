package chez1s.assignment.dto;

import lombok.*;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RevenueByDayDTO {
    private Date revenueDate;
    private Long totalBills;
    private Long totalRevenue;
}
