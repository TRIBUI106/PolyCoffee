package chez1s.assignment.repository;

import chez1s.assignment.entity.User;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;

public class UserRepository extends BaseRepository<User, Integer> {
    public UserRepository() {
        super(User.class);
    }

    public User findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<User> findByRole(boolean role) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.role = :role", User.class)
                     .setParameter("role", role)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}
