package chez1s.assignment.service;

import chez1s.assignment.dto.CheckoutRequest;
import chez1s.assignment.entity.BillStatus;
import chez1s.assignment.entity.Drink;
import chez1s.assignment.entity.Guest;
import chez1s.assignment.entity.GuestOrder;
import chez1s.assignment.entity.GuestOrderDetail;
import chez1s.assignment.repository.DrinkRepository;
import chez1s.assignment.repository.GuestOrderRepository;
import chez1s.assignment.repository.GuestRepository;

import java.util.ArrayList;
import java.util.List;

public class GuestOrderService {
    private final GuestOrderRepository guestOrderRepository = new GuestOrderRepository();
    private final DrinkRepository drinkRepository = new DrinkRepository();
    private final GuestRepository guestRepository = new GuestRepository();

    public GuestOrder createOrder(Guest guest, CheckoutRequest checkoutRequest) {
        GuestOrder order = new GuestOrder();
        order.setGuest(guest);
        order.setCode("G-ORD-" + System.currentTimeMillis());
        order.setStatus(BillStatus.WAITING);

        List<GuestOrderDetail> details = new ArrayList<>();
        int total = 0;

        for (CheckoutRequest.CartItem itemDto : checkoutRequest.getItems()) {
            Drink drink = drinkRepository.findById(itemDto.getDrinkId());
            if (drink == null) continue;

            GuestOrderDetail detail = new GuestOrderDetail();
            detail.setGuestOrder(order);
            detail.setDrink(drink);
            detail.setQuantity(itemDto.getQuantity());
            detail.setPrice(drink.getPrice());
            detail.setNote(itemDto.getNote());
            details.add(detail);

            total += drink.getPrice() * itemDto.getQuantity();
        }

        order.setDetails(details);
        order.setTotal(total);
        guestOrderRepository.create(order);

        // Add points to guest: total amount / 1000
        int earnedPoints = total / 1000;
        guest.setPoint(guest.getPoint() + earnedPoints);
        guestRepository.update(guest);

        return order;
    }
}
