package chez1s.assignment.repository;

import chez1s.assignment.entity.CoffeeTable;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class TableRepository {
    public List<CoffeeTable> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT t FROM CoffeeTable t WHERE t.active = true", CoffeeTable.class).getResultList();
        } finally {
            em.close();
        }
    }

    public CoffeeTable findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(CoffeeTable.class, id);
        } finally {
            em.close();
        }
    }

    public CoffeeTable findByCode(String code) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT t FROM CoffeeTable t WHERE t.code = :code", CoffeeTable.class)
                    .setParameter("code", code)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void save(CoffeeTable table) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (table.getId() == null) em.persist(table);
            else em.merge(table);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            CoffeeTable table = em.find(CoffeeTable.class, id);
            if (table != null) {
                table.setActive(false);
                em.merge(table);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
