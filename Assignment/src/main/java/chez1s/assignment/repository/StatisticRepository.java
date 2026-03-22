package chez1s.assignment.repository;

import chez1s.assignment.dto.BestSellingDrinkDTO;
import chez1s.assignment.dto.RevenueByDayDTO;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.Date;
import java.util.List;

public class StatisticRepository {

    public List<BestSellingDrinkDTO> getTop5BestSellingDrinks(Date fromDate, Date toDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT new chez1s.assignment.dto.BestSellingDrinkDTO(d.id, d.name, SUM(bd.quantity), SUM(bd.price * bd.quantity)) " +
                          "FROM BillDetail bd JOIN bd.drink d JOIN bd.bill b " +
                          "WHERE b.status = 'FINISHED' " +
                          (fromDate != null ? "AND b.createdAt >= :fromDate " : "") +
                          (toDate != null ? "AND b.createdAt <= :toDate " : "") +
                          "GROUP BY d.id, d.name " +
                          "ORDER BY SUM(bd.quantity) DESC";

            var query = em.createQuery(jpql, BestSellingDrinkDTO.class);
            if (fromDate != null) query.setParameter("fromDate", fromDate);
            if (toDate != null) query.setParameter("toDate", toDate);
            
            return query.setMaxResults(5).getResultList();
        } finally {
            em.close();
        }
    }

    public List<RevenueByDayDTO> getRevenueByDay(Date fromDate, Date toDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT new chez1s.assignment.dto.RevenueByDayDTO(CAST(b.createdAt AS date), COUNT(b), SUM(b.total)) " +
                          "FROM Bill b " +
                          "WHERE b.status = 'FINISHED' " +
                          (fromDate != null ? "AND b.createdAt >= :fromDate " : "") +
                          (toDate != null ? "AND b.createdAt <= :toDate " : "") +
                          "GROUP BY CAST(b.createdAt AS date) " +
                          "ORDER BY CAST(b.createdAt AS date) ASC";

            var query = em.createQuery(jpql, RevenueByDayDTO.class);
            if (fromDate != null) query.setParameter("fromDate", fromDate);
            if (toDate != null) query.setParameter("toDate", toDate);
            
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long getTotalFinishedCount(Date fromDate, Date toDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(b) FROM Bill b WHERE b.status IN (chez1s.assignment.entity.BillStatus.PAID, chez1s.assignment.entity.BillStatus.FINISHED) " +
                          (fromDate != null ? "AND b.createdAt >= :fromDate " : "") +
                          (toDate != null ? "AND b.createdAt <= :toDate " : "");
            var query = em.createQuery(jpql, Long.class);
            if (fromDate != null) query.setParameter("fromDate", fromDate);
            if (toDate != null) query.setParameter("toDate", toDate);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public long getTotalRevenue(Date fromDate, Date toDate) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(b.total), 0L) FROM Bill b WHERE b.status IN (chez1s.assignment.entity.BillStatus.PAID, chez1s.assignment.entity.BillStatus.FINISHED) " +
                          (fromDate != null ? "AND b.createdAt >= :fromDate " : "") +
                          (toDate != null ? "AND b.createdAt <= :toDate " : "");
            var query = em.createQuery(jpql, Long.class);
            if (fromDate != null) query.setParameter("fromDate", fromDate);
            if (toDate != null) query.setParameter("toDate", toDate);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
