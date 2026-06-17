package chez1s.assignment.repository;

import chez1s.assignment.entity.BillDetail;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import java.util.List;

public class BillDetailRepository extends BaseRepository<BillDetail, Integer> {
    public BillDetailRepository() {
        super(BillDetail.class);
    }

    public List<BillDetail> findByBillId(Integer billId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT bd FROM BillDetail bd WHERE bd.bill.id = :billId", BillDetail.class)
                     .setParameter("billId", billId)
                     .getResultList();
        } finally {
            em.close();
        }
    }
}
