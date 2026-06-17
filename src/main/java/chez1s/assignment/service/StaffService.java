package chez1s.assignment.service;

import chez1s.assignment.entity.User;
import chez1s.assignment.repository.UserRepository;
import java.util.List;

public class StaffService {
    private final UserRepository userRepository = new UserRepository();

    public List<User> getAllStaff() {
        return userRepository.findByRole(false);
    }

    public void createStaff(User user) {
        user.setRole(false);
        user.setActive(true);
        userRepository.create(user);
    }

    public void updateStaff(User user) {
        User existing = userRepository.findById(user.getId());
        if (existing != null) {
            existing.setFullName(user.getFullName());
            existing.setPhone(user.getPhone());
            existing.setActive(user.isActive());
            userRepository.update(existing);
        }
    }

    public void updateStatus(Integer userId, boolean active) {
        User user = userRepository.findById(userId);
        if (user != null) {
            user.setActive(active);
            userRepository.update(user);
        }
    }

    public User getStaffByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User getStaffById(Integer id) {
        return userRepository.findById(id);
    }
}
