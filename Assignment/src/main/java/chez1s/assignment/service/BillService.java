package chez1s.assignment.service;

import chez1s.assignment.entity.*;
import chez1s.assignment.repository.BillDetailRepository;
import chez1s.assignment.repository.BillRepository;
import chez1s.assignment.repository.DrinkRepository;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillService {
    private final BillRepository billRepo = new BillRepository();
    private final BillDetailRepository detailRepo = new BillDetailRepository();
    private final DrinkRepository drinkRepo = new DrinkRepository();

    public List<Bill> getUserBills(Integer userId) {
        return billRepo.findByUserId(userId);
    }

    public List<Bill> getAllBills() {
        return billRepo.findAll();
    }

    public Bill getBill(Integer id, Integer userId) {
        return billRepo.findByIdAndUserId(id, userId);
    }

    public Bill getBillById(Integer id) {
        return billRepo.findById(id);
    }

    /**
     * Creates a new bill or adds a drink to an existing waiting bill.
     */
    public Integer addDrinkToBill(Integer billId, Integer userId, Integer drinkId, User user) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            
            Drink drink = em.find(Drink.class, drinkId);
            Bill bill;
            
            if (billId == null || billId == 0) {
                // Create new bill
                bill = new Bill();
                bill.setUser(user);
                bill.setCode("BILL-" + System.currentTimeMillis());
                bill.setCreatedAt(new Date());
                bill.setStatus(BillStatus.WAITING);
                bill.setTotal(drink.getPrice());
                
                List<BillDetail> details = new ArrayList<>();
                BillDetail detail = new BillDetail();
                detail.setBill(bill);
                detail.setDrink(drink);
                detail.setQuantity(1);
                detail.setPrice(drink.getPrice());
                details.add(detail);
                
                bill.setBillDetails(details);
                em.persist(bill); // Cascades to details
            } else {
                // Add to existing bill
                bill = em.find(Bill.class, billId);
                if (bill == null || bill.getStatus() != BillStatus.WAITING) return 0;
                
                // Check if drink already in bill
                BillDetail existingDetail = bill.getBillDetails().stream()
                        .filter(d -> d.getDrink().getId().equals(drinkId))
                        .findFirst().orElse(null);
                        
                if (existingDetail != null) {
                    existingDetail.setQuantity(existingDetail.getQuantity() + 1);
                } else {
                    BillDetail detail = new BillDetail();
                    detail.setBill(bill);
                    detail.setDrink(drink);
                    detail.setQuantity(1);
                    detail.setPrice(drink.getPrice());
                    bill.getBillDetails().add(detail);
                    em.persist(detail);
                }
                
                updateTotal(bill);
                em.merge(bill);
            }
            
            trans.commit();
            return bill.getId();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void updateQuantity(Integer billId, Integer drinkId, int quantity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Bill bill = em.find(Bill.class, billId);
            if (bill == null || bill.getStatus() != BillStatus.WAITING) return;

            BillDetail detail = bill.getBillDetails().stream()
                    .filter(d -> d.getDrink().getId().equals(drinkId))
                    .findFirst().orElse(null);

            if (detail != null) {
                if (quantity <= 0) {
                    bill.getBillDetails().remove(detail);
                    em.remove(detail);
                } else {
                    detail.setQuantity(quantity);
                }
                updateTotal(bill);
                em.merge(bill);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void updateNote(Integer billId, Integer drinkId, String note) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Bill bill = em.find(Bill.class, billId);
            if (bill == null || bill.getStatus() != BillStatus.WAITING) return;

            BillDetail detail = bill.getBillDetails().stream()
                    .filter(d -> d.getDrink().getId().equals(drinkId))
                    .findFirst().orElse(null);

            if (detail != null) {
                detail.setNote(note);
                em.merge(bill);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void checkout(Integer billId) {
        Bill bill = billRepo.findById(billId);
        if (bill != null && bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
            billRepo.update(bill);
        }
    }

    public void cancel(Integer billId) {
        Bill bill = billRepo.findById(billId);
        if (bill != null && bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.CANCELLED);
            billRepo.update(bill);
        }
    }

    private void updateTotal(Bill bill) {
        int total = bill.getBillDetails().stream()
                .mapToInt(d -> d.getPrice() * d.getQuantity())
                .sum();
        bill.setTotal(total);
    }
}
