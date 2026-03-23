package chez1s.assignment.service;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.repository.GuestRepository;

public class GuestService {
    private final GuestRepository guestRepository = new GuestRepository();

    public Guest findOrCreateGuest(String fullname, String phoneNumber) {
        Guest guest = guestRepository.findByPhoneNumber(phoneNumber);
        if (guest == null) {
            guest = new Guest();
            guest.setFullname(fullname);
            guest.setPhoneNumber(phoneNumber);
            // Default point is 0, handled by Entity schema
            guestRepository.create(guest);
        } else if (!guest.getFullname().equals(fullname)) {
            // Update name if different
            guest.setFullname(fullname);
            guestRepository.update(guest);
        }
        return guest;
    }
}
