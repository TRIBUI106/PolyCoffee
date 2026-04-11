package chez1s.assignment.service;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.repository.GuestRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * TC-106 to TC-110: Guest management tests
 */
@ExtendWith(MockitoExtension.class)
class GuestServiceTest {

    @Mock
    private GuestRepository guestRepository;

    @InjectMocks
    private GuestService guestService;

    private Guest existingGuest;

    @BeforeEach
    void setUp() {
        existingGuest = new Guest();
        existingGuest.setId(1);
        existingGuest.setFullname("Nguyen Van A");
        existingGuest.setPhoneNumber("0901234567");
        existingGuest.setPoint(100);
    }

    // TC-108
    @Test
    @DisplayName("TC-108: Create guest on first order")
    void findOrCreateGuest_newGuest_creates() {
        when(guestRepository.findByPhoneNumber("0909999999")).thenReturn(null);
        guestService.findOrCreateGuest("New Guest", "0909999999");
        verify(guestRepository).create(argThat(g ->
                g.getFullname().equals("New Guest") &&
                g.getPhoneNumber().equals("0909999999")));
    }

    // TC-109
    @Test
    @DisplayName("TC-109: findOrCreate updates name if changed")
    void findOrCreateGuest_nameChanged_updates() {
        when(guestRepository.findByPhoneNumber("0901234567")).thenReturn(existingGuest);
        Guest result = guestService.findOrCreateGuest("New Name", "0901234567");
        assertEquals("New Name", existingGuest.getFullname());
        verify(guestRepository).update(existingGuest);
    }

    // TC-110
    @Test
    @DisplayName("TC-110: findOrCreate returns existing if same name")
    void findOrCreateGuest_sameName_noUpdate() {
        when(guestRepository.findByPhoneNumber("0901234567")).thenReturn(existingGuest);
        Guest result = guestService.findOrCreateGuest("Nguyen Van A", "0901234567");
        verify(guestRepository, never()).update(any());
        verify(guestRepository, never()).create(any());
    }
}
