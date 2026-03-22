package chez1s.assignment.dto;

import lombok.Data;
import java.util.List;

@Data
public class DashboardDTO {
    private int todayRevenue;
    private int todayOrders;
    private int weekRevenue;
    private long totalBills;
    private List<BestSellingDrinkDTO> topDrinks;
    private List<RevenueByDayDTO> revenueByDay;
}
