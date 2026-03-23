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

    public GuestVoucher redeemVoucher(String phone, Integer voucherId) throws Exception {
        Guest guest = guestRepo.findByPhoneNumber(phone);
        if (guest == null) {
            throw new Exception("Guest not found. Note: you need to place at least one order to create an account.");
        }

        Voucher voucher = voucherRepo.findById(voucherId);
        if (voucher == null) {
            throw new Exception("Voucher not found.");
        }

        if (guest.getPoint() < voucher.getRequiredPoints()) {
            throw new Exception("Not enough points.");
        }

        // Deduct points
        guest.setPoint(guest.getPoint() - voucher.getRequiredPoints());
        guestRepo.update(guest);

        // Create guest voucher
        GuestVoucher gv = new GuestVoucher();
        gv.setGuest(guest);
        gv.setVoucher(voucher);
        gv.setIsUsed(false);
        guestVoucherRepo.create(gv);

        return gv;
    }
}
