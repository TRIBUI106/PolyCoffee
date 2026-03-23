package chez1s.assignment.db;

import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;

public class DbMigrationTest {
    @Test
    public void runMigration() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            em.createNativeQuery("CREATE TABLE IF NOT EXISTS vouchers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255) NOT NULL, " +
                    "required_points INT NOT NULL, " +
                    "discount_amount INT NOT NULL" +
                    ") ENGINE=InnoDB;").executeUpdate();

            em.createNativeQuery("CREATE TABLE IF NOT EXISTS guest_vouchers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "guest_id INT NOT NULL, " +
                    "voucher_id INT NOT NULL, " +
                    "is_used BOOLEAN DEFAULT FALSE, " +
                    "FOREIGN KEY (guest_id) REFERENCES guests(id), " +
                    "FOREIGN KEY (voucher_id) REFERENCES vouchers(id)" +
                    ") ENGINE=InnoDB;").executeUpdate();

            try {
                em.createNativeQuery("ALTER TABLE bills ADD COLUMN discount_amount INT DEFAULT 0").executeUpdate();
            } catch (Exception ignore) {}
            
            try {
                em.createNativeQuery("ALTER TABLE bills ADD COLUMN guest_voucher_id INT").executeUpdate();
            } catch (Exception ignore) {}
            
            try {
                em.createNativeQuery("ALTER TABLE bills ADD CONSTRAINT fk_bills_guest_voucher FOREIGN KEY (guest_voucher_id) REFERENCES guest_vouchers(id)").executeUpdate();
            } catch (Exception ignore) {}

            em.getTransaction().commit();
            System.out.println(">>> MIGRATION SUCCESSFUL <<<");
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
    }
}
