package chez1s.assignment.service;

import chez1s.assignment.entity.User;
import chez1s.assignment.repository.UserRepository;
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
 * TC-021 to TC-032: Staff/User management tests
 */
@ExtendWith(MockitoExtension.class)
class StaffServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private StaffService staffService;

    private User existingStaff;

    @BeforeEach
    void setUp() {
        existingStaff = new User();
        existingStaff.setId(1);
        existingStaff.setEmail("staff@test.com");
        existingStaff.setPassword("secret");
        existingStaff.setFullName("John");
        existingStaff.setPhone("0901234567");
        existingStaff.setRole(false);
        existingStaff.setActive(true);
    }

    // TC-021
    @Test
    @DisplayName("TC-021: List all staff accounts")
    void getAllStaff_returnsStaffOnly() {
        when(userRepository.findByRole(false)).thenReturn(Arrays.asList(existingStaff));
        List<User> result = staffService.getAllStaff();
        assertEquals(1, result.size());
        assertFalse(result.get(0).isRole());
    }

    // TC-022
    @Test
    @DisplayName("TC-022: Create new staff with valid data")
    void createStaff_validData_setsRoleFalseAndActiveTrue() {
        User newStaff = new User();
        newStaff.setEmail("new@test.com");
        newStaff.setPassword("pass");
        newStaff.setFullName("Jane");
        newStaff.setRole(true); // will be forced to false

        staffService.createStaff(newStaff);

        assertFalse(newStaff.isRole());
        assertTrue(newStaff.isActive());
        verify(userRepository).create(newStaff);
    }

    // TC-032
    @Test
    @DisplayName("TC-032: Create staff forces role=false")
    void createStaff_roleForced() {
        User managerAttempt = new User();
        managerAttempt.setRole(true);
        staffService.createStaff(managerAttempt);
        assertFalse(managerAttempt.isRole());
    }

    // TC-025
    @Test
    @DisplayName("TC-025: Update staff name and phone")
    void updateStaff_updatesNameAndPhone() {
        when(userRepository.findById(1)).thenReturn(existingStaff);

        User updates = new User();
        updates.setId(1);
        updates.setFullName("Updated Name");
        updates.setPhone("0999999999");
        updates.setActive(true);

        staffService.updateStaff(updates);

        assertEquals("Updated Name", existingStaff.getFullName());
        assertEquals("0999999999", existingStaff.getPhone());
        verify(userRepository).update(existingStaff);
    }

    // TC-031
    @Test
    @DisplayName("TC-031: Update staff preserves password")
    void updateStaff_preservesPassword() {
        when(userRepository.findById(1)).thenReturn(existingStaff);

        User updates = new User();
        updates.setId(1);
        updates.setFullName("New Name");
        updates.setPhone("0901234567");
        updates.setActive(true);

        staffService.updateStaff(updates);

        assertEquals("secret", existingStaff.getPassword());
    }

    // TC-026
    @Test
    @DisplayName("TC-026: Toggle staff to inactive")
    void updateStatus_setInactive() {
        when(userRepository.findById(1)).thenReturn(existingStaff);
        staffService.updateStatus(1, false);
        assertFalse(existingStaff.isActive());
        verify(userRepository).update(existingStaff);
    }

    // TC-027
    @Test
    @DisplayName("TC-027: Toggle staff to active")
    void updateStatus_setActive() {
        existingStaff.setActive(false);
        when(userRepository.findById(1)).thenReturn(existingStaff);
        staffService.updateStatus(1, true);
        assertTrue(existingStaff.isActive());
    }

    // TC-038 (getStaffByEmail)
    @Test
    @DisplayName("TC-023 precondition: getStaffByEmail returns user for duplicate check")
    void getStaffByEmail_exists() {
        when(userRepository.findByEmail("staff@test.com")).thenReturn(existingStaff);
        assertNotNull(staffService.getStaffByEmail("staff@test.com"));
    }

    @Test
    @DisplayName("TC-023 precondition: getStaffByEmail returns null")
    void getStaffByEmail_notExists() {
        when(userRepository.findByEmail("new@test.com")).thenReturn(null);
        assertNull(staffService.getStaffByEmail("new@test.com"));
    }

    @Test
    @DisplayName("TC-029: Get staff by ID")
    void getStaffById_exists() {
        when(userRepository.findById(1)).thenReturn(existingStaff);
        User result = staffService.getStaffById(1);
        assertNotNull(result);
        assertEquals("John", result.getFullName());
    }

    @Test
    @DisplayName("Update non-existent staff does nothing")
    void updateStaff_notExists_noOp() {
        when(userRepository.findById(999)).thenReturn(null);
        User updates = new User();
        updates.setId(999);
        staffService.updateStaff(updates);
        verify(userRepository, never()).update(any());
    }

    @Test
    @DisplayName("Update status of non-existent user does nothing")
    void updateStatus_notExists_noOp() {
        when(userRepository.findById(999)).thenReturn(null);
        staffService.updateStatus(999, true);
        verify(userRepository, never()).update(any());
    }
}
