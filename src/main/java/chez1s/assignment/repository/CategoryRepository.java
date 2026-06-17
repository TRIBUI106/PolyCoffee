package chez1s.assignment.repository;

import chez1s.assignment.entity.Category;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;

public class CategoryRepository extends BaseRepository<Category, Integer> {
    public CategoryRepository() {
        super(Category.class);
    }

    public long countDrinksInCategory(int categoryId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(d) FROM Drink d WHERE d.category.id = :catId", Long.class)
                     .setParameter("catId", categoryId)
                     .getSingleResult();
        } finally {
            em.close();
        }
    }
}
