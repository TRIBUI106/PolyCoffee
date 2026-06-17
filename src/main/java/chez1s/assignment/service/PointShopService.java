package chez1s.assignment.service;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.entity.GuestVoucher;
import chez1s.assignment.entity.Voucher;
import chez1s.assignment.repository.GuestRepository;
import chez1s.assignment.repository.GuestVoucherRepository;
import chez1s.assignment.repository.VoucherRepository;

import java.util.List;

public class PointShopService {
    private final VoucherRepository voucherRepo = new VoucherRepository();
    private final GuestVoucherRepository guestVoucherRepo = new GuestVoucherRepository();
    private final GuestRepository guestRepo = new GuestRepository();

    public List<Voucher> getAvailableVouchers() {
        return voucherRepo.findAll();
    }

    public List<GuestVoucher> getGuestVouchers(String phone) {
        return guestVoucherRepo.findUnusedByGuestPhone(phone);
    }

    public void redeemVoucher(String phone, Integer voucherId, int quantity) throws Exception {
        if (quantity <= 0) throw new Exception("Quantity must be greater than zero.");
        
        Guest guest = guestRepo.findByPhoneNumber(phone);
        if (guest == null) {
            throw new Exception("Guest not found. Note: you need to place at least one order to create an account.");
        }

        Voucher voucher = voucherRepo.findById(voucherId);
        if (voucher == null) {
            throw new Exception("Voucher not found.");
        }

        int totalRequiredPoints = voucher.getRequiredPoints() * quantity;
        if (guest.getPoint() < totalRequiredPoints) {
            throw new Exception("Not enough points.");
        }

        // Deduct total points
        guest.setPoint(guest.getPoint() - totalRequiredPoints);
        guestRepo.update(guest);

        // Create guest vouchers
        for (int i = 0; i < quantity; i++) {
            GuestVoucher gv = new GuestVoucher();
            gv.setGuest(guest);
            gv.setVoucher(voucher);
            gv.setIsUsed(false);
            guestVoucherRepo.create(gv);
        }
    }
}
