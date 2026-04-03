package chez1s.assignment.repository;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;

public class BillRepository extends BaseRepository<Bill, Integer> {
    public BillRepository() {
        super(Bill.class);
    }

    public List<Bill> findByUserId(Integer userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM Bill b WHERE b.user.id = :userId ORDER BY b.createdAt DESC", Bill.class)
                     .setParameter("userId", userId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public Bill findByIdWithDetails(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            List<Bill> results = em.createQuery(
                "SELECT DISTINCT b FROM Bill b LEFT JOIN FETCH b.billDetails bd LEFT JOIN FETCH bd.drink WHERE b.id = :id",
                Bill.class)
                .setParameter("id", id)
                .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    public Bill findByIdAndUserId(Integer id, Integer userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT DISTINCT b FROM Bill b LEFT JOIN FETCH b.billDetails bd LEFT JOIN FETCH bd.drink WHERE b.id = :id AND b.user.id = :userId", Bill.class)
                     .setParameter("id", id)
                     .setParameter("userId", userId)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Bill> searchBills(String query, String status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT b FROM Bill b LEFT JOIN FETCH b.user WHERE 1=1");
            if (query != null && !query.isEmpty()) {
                jpql.append(" AND (LOWER(b.code) LIKE LOWER(:query) OR LOWER(b.user.fullName) LIKE LOWER(:query))");
            }
            if (status != null && !status.isEmpty() && !status.equals("ALL")) {
                jpql.append(" AND b.status = :status");
            }
            jpql.append(" ORDER BY b.createdAt DESC");

            var q = em.createQuery(jpql.toString(), Bill.class);
            if (query != null && !query.isEmpty()) {
                q.setParameter("query", "%" + query.toLowerCase() + "%");
            }
            if (status != null && !status.isEmpty() && !status.equals("ALL")) {
                q.setParameter("status", chez1s.assignment.entity.BillStatus.valueOf(status));
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Bill> searchUserBills(Integer userId, String query, String status) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT b FROM Bill b WHERE b.user.id = :userId");
            if (query != null && !query.isEmpty()) {
                jpql.append(" AND LOWER(b.code) LIKE LOWER(:query)");
            }
            if (status != null && !status.isEmpty() && !status.equals("ALL")) {
                jpql.append(" AND b.status = :status");
            }
            jpql.append(" ORDER BY b.createdAt DESC");

            var q = em.createQuery(jpql.toString(), Bill.class);
            q.setParameter("userId", userId);
            if (query != null && !query.isEmpty()) {
                q.setParameter("query", "%" + query.toLowerCase() + "%");
            }
            if (status != null && !status.isEmpty() && !status.equals("ALL")) {
                q.setParameter("status", chez1s.assignment.entity.BillStatus.valueOf(status));
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}
