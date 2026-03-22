package chez1s.assignment.service;

import chez1s.assignment.dto.BestSellingDrinkDTO;
import chez1s.assignment.dto.DashboardDTO;
import chez1s.assignment.dto.RevenueByDayDTO;
import chez1s.assignment.repository.StatisticRepository;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class StatisticService {
    private final StatisticRepository statisticRepository = new StatisticRepository();

    public List<BestSellingDrinkDTO> getTopSellingDrinks(Date from, Date to) {
        return statisticRepository.getTop5BestSellingDrinks(from, to);
    }

    public List<RevenueByDayDTO> getRevenueReport(Date from, Date to) {
        return statisticRepository.getRevenueByDay(from, to);
    }

    public DashboardDTO getDashboardData() {
        DashboardDTO dashboard = new DashboardDTO();
        
        // 1. Today
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date todayStart = cal.getTime();
        
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        Date todayEnd = cal.getTime();
        
        dashboard.setTodayRevenue((int) statisticRepository.getTotalRevenue(todayStart, todayEnd));
        dashboard.setTodayOrders((int) statisticRepository.getTotalFinishedCount(todayStart, todayEnd));
        
        // 2. This Week
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date weekStart = cal.getTime();
        dashboard.setWeekRevenue((int) statisticRepository.getTotalRevenue(weekStart, null));
        
        // 3. Overall
        dashboard.setTotalBills(statisticRepository.getTotalFinishedCount(null, null));
        
        // 4. Trending & Charts
        dashboard.setTopDrinks(statisticRepository.getTop5BestSellingDrinks(null, null));
        dashboard.setRevenueByDay(statisticRepository.getRevenueByDay(null, null));
        
        return dashboard;
    }
}
