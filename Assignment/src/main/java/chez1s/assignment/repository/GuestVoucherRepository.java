package chez1s.assignment.repository;

import chez1s.assignment.entity.GuestVoucher;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class GuestVoucherRepository extends BaseRepository<GuestVoucher, Integer> {
    public GuestVoucherRepository() {
        super(GuestVoucher.class);
    }

    public List<GuestVoucher> findUnusedByGuestPhone(String phone) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT gv FROM GuestVoucher gv WHERE gv.guest.phoneNumber = :phone AND gv.isUsed = false", GuestVoucher.class)
                    .setParameter("phone", phone)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
