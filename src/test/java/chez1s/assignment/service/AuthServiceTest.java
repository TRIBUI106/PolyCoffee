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

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * TC-001 to TC-007, TC-019, TC-020: Authentication service tests
 */
@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthService authService;

    private User activeManager;
    private User activeStaff;
    private User inactiveUser;

    @BeforeEach
    void setUp() {
        activeManager = new User();
        activeManager.setId(1);
        activeManager.setEmail("admin@test.com");
        activeManager.setPassword("admin123");
        activeManager.setFullName("Admin");
        activeManager.setRole(true);
        activeManager.setActive(true);

        activeStaff = new User();
        activeStaff.setId(2);
        activeStaff.setEmail("staff@test.com");
        activeStaff.setPassword("staff123");
        activeStaff.setFullName("Staff");
        activeStaff.setRole(false);
        activeStaff.setActive(true);

        inactiveUser = new User();
        inactiveUser.setId(3);
        inactiveUser.setEmail("inactive@test.com");
        inactiveUser.setPassword("pass123");
        inactiveUser.setActive(false);
    }

    // TC-001
    @Test
    @DisplayName("TC-001: Login with valid manager credentials")
    void login_validManager_returnsUser() {
        when(userRepository.findByEmail("admin@test.com")).thenReturn(activeManager);
        User result = authService.login("admin@test.com", "admin123");
        assertNotNull(result);
        assertEquals(1, result.getId());
        assertTrue(result.isRole());
    }

    // TC-002
    @Test
    @DisplayName("TC-002: Login with valid staff credentials")
    void login_validStaff_returnsUser() {
        when(userRepository.findByEmail("staff@test.com")).thenReturn(activeStaff);
        User result = authService.login("staff@test.com", "staff123");
        assertNotNull(result);
        assertFalse(result.isRole());
    }

    // TC-003
    @Test
    @DisplayName("TC-003: Login with wrong password")
    void login_wrongPassword_returnsNull() {
        when(userRepository.findByEmail("admin@test.com")).thenReturn(activeManager);
        User result = authService.login("admin@test.com", "wrongpass");
        assertNull(result);
    }

    // TC-004
    @Test
    @DisplayName("TC-004: Login with non-existent email")
    void login_nonExistentEmail_returnsNull() {
        when(userRepository.findByEmail("nobody@test.com")).thenReturn(null);
        User result = authService.login("nobody@test.com", "pass");
        assertNull(result);
    }

    // TC-005
    @Test
    @DisplayName("TC-005: Login with inactive user")
    void login_inactiveUser_returnsNull() {
        when(userRepository.findByEmail("inactive@test.com")).thenReturn(inactiveUser);
        User result = authService.login("inactive@test.com", "pass123");
        assertNull(result);
    }

    // TC-006
    @Test
    @DisplayName("TC-006: Login with empty email")
    void login_emptyEmail_returnsNull() {
        when(userRepository.findByEmail("")).thenReturn(null);
        User result = authService.login("", "pass");
        assertNull(result);
    }

    // TC-007
    @Test
    @DisplayName("TC-007: Login with empty password")
    void login_emptyPassword_returnsNull() {
        when(userRepository.findByEmail("admin@test.com")).thenReturn(activeManager);
        User result = authService.login("admin@test.com", "");
        assertNull(result);
    }

    // TC-019
    @Test
    @DisplayName("TC-019: SQL injection in email field")
    void login_sqlInjectionEmail_returnsNull() {
        String malicious = "' OR 1=1 --";
        when(userRepository.findByEmail(malicious)).thenReturn(null);
        User result = authService.login(malicious, "anything");
        assertNull(result);
    }

    // TC-020
    @Test
    @DisplayName("TC-020: SQL injection in password field")
    void login_sqlInjectionPassword_returnsNull() {
        when(userRepository.findByEmail("admin@test.com")).thenReturn(activeManager);
        User result = authService.login("admin@test.com", "' OR 1=1 --");
        assertNull(result);
    }
}
