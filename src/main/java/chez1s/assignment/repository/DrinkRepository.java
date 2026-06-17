package chez1s.assignment.repository;

import chez1s.assignment.entity.Drink;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class DrinkRepository extends BaseRepository<Drink, Integer> {
    public DrinkRepository() {
        super(Drink.class);
    }

    @Override
    public List<Drink> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Drink d JOIN FETCH d.category", Drink.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Drink> findByActive(boolean active) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Drink d JOIN FETCH d.category WHERE d.active = :active", Drink.class)
                     .setParameter("active", active)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}
