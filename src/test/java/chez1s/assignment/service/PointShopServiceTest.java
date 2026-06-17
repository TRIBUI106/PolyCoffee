package chez1s.assignment.service;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.entity.GuestVoucher;
import chez1s.assignment.entity.Voucher;
import chez1s.assignment.repository.GuestRepository;
import chez1s.assignment.repository.GuestVoucherRepository;
import chez1s.assignment.repository.VoucherRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * TC-111 to TC-117: Point shop & voucher tests
 */
@ExtendWith(MockitoExtension.class)
class PointShopServiceTest {

    @Mock
    private VoucherRepository voucherRepo;
    @Mock
    private GuestVoucherRepository guestVoucherRepo;
    @Mock
    private GuestRepository guestRepo;

    @InjectMocks
    private PointShopService pointShopService;

    private Guest guest;
    private Voucher voucher;

    @BeforeEach
    void setUp() {
        guest = new Guest();
        guest.setId(1);
        guest.setFullname("Test Guest");
        guest.setPhoneNumber("0901234567");
        guest.setPoint(100);

        voucher = new Voucher();
        voucher.setId(1);
        voucher.setName("10K Discount");
        voucher.setRequiredPoints(50);
        voucher.setDiscountAmount(10000);
    }

    // TC-111
    @Test
    @DisplayName("TC-111: List available vouchers")
    void getAvailableVouchers() {
        when(voucherRepo.findAll()).thenReturn(Arrays.asList(voucher));
        List<Voucher> result = pointShopService.getAvailableVouchers();
        assertEquals(1, result.size());
        assertEquals("10K Discount", result.get(0).getName());
    }

    // TC-112
    @Test
    @DisplayName("TC-112: Get guest vouchers by phone")
    void getGuestVouchers() {
        GuestVoucher gv = new GuestVoucher();
        gv.setId(1);
        gv.setGuest(guest);
        gv.setVoucher(voucher);
        gv.setIsUsed(false);
        when(guestVoucherRepo.findUnusedByGuestPhone("0901234567")).thenReturn(Arrays.asList(gv));
        List<GuestVoucher> result = pointShopService.getGuestVouchers("0901234567");
        assertEquals(1, result.size());
        assertFalse(result.get(0).getIsUsed());
    }

    // TC-114
    @Test
    @DisplayName("TC-114: Redeem voucher with sufficient points")
    void redeemVoucher_sufficientPoints() throws Exception {
        when(guestRepo.findByPhoneNumber("0901234567")).thenReturn(guest);
        when(voucherRepo.findById(1)).thenReturn(voucher);

        pointShopService.redeemVoucher("0901234567", 1, 1);

        assertEquals(50, guest.getPoint()); // 100 - 50
        verify(guestRepo).update(guest);
        verify(guestVoucherRepo).create(any(GuestVoucher.class));
    }

    // TC-114b - redeem multiple
    @Test
    @DisplayName("TC-114b: Redeem 2 vouchers deducts double points")
    void redeemVoucher_multipleQuantity() throws Exception {
        when(guestRepo.findByPhoneNumber("0901234567")).thenReturn(guest);
        when(voucherRepo.findById(1)).thenReturn(voucher);

        pointShopService.redeemVoucher("0901234567", 1, 2);

        assertEquals(0, guest.getPoint()); // 100 - (50*2)
        verify(guestVoucherRepo, times(2)).create(any(GuestVoucher.class));
    }

    // TC-115
    @Test
    @DisplayName("TC-115: Redeem voucher with insufficient points")
    void redeemVoucher_insufficientPoints() {
        guest.setPoint(10);
        when(guestRepo.findByPhoneNumber("0901234567")).thenReturn(guest);
        when(voucherRepo.findById(1)).thenReturn(voucher);

        Exception ex = assertThrows(Exception.class, () ->
                pointShopService.redeemVoucher("0901234567", 1, 1));
        assertEquals("Not enough points.", ex.getMessage());
    }

    // TC-116
    @Test
    @DisplayName("TC-116: Redeem voucher - guest not found")
    void redeemVoucher_guestNotFound() {
        when(guestRepo.findByPhoneNumber("0000000000")).thenReturn(null);

        Exception ex = assertThrows(Exception.class, () ->
                pointShopService.redeemVoucher("0000000000", 1, 1));
        assertTrue(ex.getMessage().contains("Guest not found"));
    }

    // TC-116b
    @Test
    @DisplayName("TC-116b: Redeem voucher - voucher not found")
    void redeemVoucher_voucherNotFound() {
        when(guestRepo.findByPhoneNumber("0901234567")).thenReturn(guest);
        when(voucherRepo.findById(999)).thenReturn(null);

        Exception ex = assertThrows(Exception.class, () ->
                pointShopService.redeemVoucher("0901234567", 999, 1));
        assertEquals("Voucher not found.", ex.getMessage());
    }

    // TC-117
    @Test
    @DisplayName("TC-117: Redeem voucher - quantity <= 0")
    void redeemVoucher_zeroQuantity() {
        Exception ex = assertThrows(Exception.class, () ->
                pointShopService.redeemVoucher("0901234567", 1, 0));
        assertEquals("Quantity must be greater than zero.", ex.getMessage());
    }

    @Test
    @DisplayName("TC-117b: Redeem voucher - negative quantity")
    void redeemVoucher_negativeQuantity() {
        Exception ex = assertThrows(Exception.class, () ->
                pointShopService.redeemVoucher("0901234567", 1, -1));
        assertEquals("Quantity must be greater than zero.", ex.getMessage());
    }
}
