package chez1s.assignment.listener;

import chez1s.assignment.util.JpaUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Closes the JPA EntityManagerFactory when the application shuts down.
 */
@WebListener
public class JpaListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("System starting... Initializing and warming up Database Connection...");
        jakarta.persistence.EntityManager em = null;
        try {
            // This triggers the static initializer in JpaUtil and creates the EntityManagerFactory,
            // which pulls the metadata, applies constraints, and setups the connection pool.
            em = JpaUtil.getEntityManager();
            // Optional: run a simple query to validate connection and open the first real connection
            em.createNativeQuery("SELECT 1").getResultList();
            System.out.println("Database warmed up successfully! Application is ready.");
        } catch (Exception e) {
            System.err.println("Could not establish early database connection: " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JpaUtil.close();
    }
}
