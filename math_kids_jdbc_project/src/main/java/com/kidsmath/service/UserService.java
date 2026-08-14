package com.kidsmath.service;

import com.kidsmath.dao.UserDao;
import com.kidsmath.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	public List<User> findAll() {
		return userDao.findAll();
	}

	public User findById(Integer id) {
		return userDao.findById(id);
	}

	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}

	public User findByEmail(String email) {
		return userDao.findByEmail(email);
	}

	// ===== THÊM PHƯƠNG THỨC NÀY =====
	public boolean existsByUsername(String username) {
		return userDao.existsByUsername(username);
	}

	// ===== THÊM PHƯƠNG THỨC NÀY =====
	public boolean existsByEmail(String email) {
		return userDao.existsByEmail(email);
	}

	public void save(User user) {
		userDao.save(user);
	}

	public void update(User user) {
		userDao.update(user);
	}

	public void deleteById(Integer id) {
		userDao.deleteById(id);
	}

	public void updateLastLogin(Integer id) {
		userDao.updateLastLogin(id);
	}

	public long countByRole(String role) {
		return userDao.countByRole(role);
	}

	public List<User> findByRole(String role) {
		return userDao.findByRole(role);
	}

	public boolean changePassword(String username, String oldPassword, String newPassword) {
		User user = findByUsername(username);
		if (user != null && user.getPassword().equals(oldPassword)) {
			user.setPassword(newPassword);
			userDao.update(user);
			return true;
		}
		return false;
	}

	public List<String> getAllEmails() {
		List<User> users = userDao.findAll();
		List<String> emails = new ArrayList<>();
		for (User user : users) {
			if (user.getEmail() != null && !user.getEmail().isEmpty()) {
				emails.add(user.getEmail());
			}
		}
		return emails;
	}

	public List<User> searchByUsername(String keyword) {
		return userDao.searchByUsername(keyword);
	}
}