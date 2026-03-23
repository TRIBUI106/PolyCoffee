package chez1s.assignment.db;

import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;

public class FixDbTest {
    @Test
    public void runAlter() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createNativeQuery("ALTER TABLE bills MODIFY COLUMN status ENUM('PENDING','WAITING','PAID','FINISHED','CANCELLED') DEFAULT 'WAITING'").executeUpdate();
            em.getTransaction().commit();
            System.out.println(">>> SUCCESSFULLY ALTERED TABLE bills <<<");
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
