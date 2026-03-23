package chez1s.assignment.repository;

import chez1s.assignment.entity.GuestOrder;

public class GuestOrderRepository extends BaseRepository<GuestOrder, Integer> {
    public GuestOrderRepository() {
        super(GuestOrder.class);
    }
}
