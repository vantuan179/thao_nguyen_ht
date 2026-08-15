package com.kidsmath.dao;

import com.kidsmath.mapper.UserRowMapper;
import com.kidsmath.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<User> findAll() {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper());
	}

	public User findById(Integer id) {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public User findByUsername(String username) {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE username = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), username);
		return users.isEmpty() ? null : users.get(0);
	}

	public User findByEmail(String email) {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE email = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), email);
		return users.isEmpty() ? null : users.get(0);
	}

	public boolean existsByUsername(String username) {
		String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
		return count != null && count > 0;
	}

	public boolean existsByEmail(String email) {
		String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
		return count != null && count > 0;
	}

	public int save(User user) {
		String sql = "INSERT INTO users (username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		return jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getFullName(), user.getEmail(), user.getRole() != null ? user.getRole() : "USER", user.getMembershipType() != null ? user.getMembershipType() : "trial", user.getMembershipStartDate(), user.getMembershipExpiryDate(), user.getMembershipStatus() != null ? user.getMembershipStatus() : "active", now);
	}

	public int update(User user) {
		String sql = "UPDATE users SET username = ?, password = ?, full_name = ?, email = ?, role = ?, membership_type = ?, membership_start_date = ?, membership_expiry_date = ?, membership_status = ? WHERE id = ?";
		return jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getFullName(), user.getEmail(), user.getRole(), user.getMembershipType(), user.getMembershipStartDate(), user.getMembershipExpiryDate(), user.getMembershipStatus(), user.getId());
	}

	public int deleteById(Integer id) {
		String sql = "DELETE FROM users WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public int updateLastLogin(Integer id) {
		String sql = "UPDATE users SET last_login = ? WHERE id = ?";
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		return jdbcTemplate.update(sql, now, id);
	}

	public long countByRole(String role) {
		String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, role);
		return count != null ? count : 0;
	}

	public List<User> findByRole(String role) {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE role = ? ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper(), role);
	}

	public List<User> searchByUsername(String keyword) {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE LOWER(username) LIKE LOWER(?) OR LOWER(full_name) LIKE LOWER(?) ORDER BY id";
		String searchKeyword = "%" + keyword + "%";
		return jdbcTemplate.query(sql, new UserRowMapper(), searchKeyword, searchKeyword);
	}

	public long countByMembershipType(String membershipType) {
		String sql = "SELECT COUNT(*) FROM users WHERE membership_type = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, membershipType);
		return count != null ? count : 0;
	}

	public List<User> findExpiredMemberships() {
		String sql = "SELECT id, username, password, full_name, email, role, membership_type, membership_start_date, membership_expiry_date, membership_status, created_at FROM users WHERE membership_type = 'premium' AND membership_expiry_date < CURRENT_TIMESTAMP AND membership_status = 'active'";
		return jdbcTemplate.query(sql, new UserRowMapper());
	}
}