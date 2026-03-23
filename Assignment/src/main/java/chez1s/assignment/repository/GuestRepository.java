package chez1s.assignment.repository;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class GuestRepository extends BaseRepository<Guest, Integer> {
    public GuestRepository() {
        super(Guest.class);
    }

    public Guest findByPhoneNumber(String phoneNumber) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT g FROM Guest g WHERE g.phoneNumber = :phone", Guest.class)
                    .setParameter("phone", phoneNumber)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
