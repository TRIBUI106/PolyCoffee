package chez1s.assignment.repository;

import chez1s.assignment.entity.Voucher;

public class VoucherRepository extends BaseRepository<Voucher, Integer> {
    public VoucherRepository() {
        super(Voucher.class);
    }
}
