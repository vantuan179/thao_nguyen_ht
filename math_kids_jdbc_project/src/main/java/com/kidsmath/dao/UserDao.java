package com.kidsmath.dao;

import com.kidsmath.mapper.UserRowMapper;
import com.kidsmath.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<User> findAll() {
		String sql = "SELECT id, username, password, full_name, role, created_at FROM users ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper());
	}

	public User findById(Integer id) {
		String sql = "SELECT id, username, password, full_name, role, created_at FROM users WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, new UserRowMapper(), id);
	}

	public User findByUsername(String username) {
		String sql = "SELECT id, username, password, full_name, role, created_at FROM users WHERE username = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), username);
		return users.isEmpty() ? null : users.get(0);
	}

	public int save(User user) {
		String sql = "INSERT INTO users (username, password, full_name, role) VALUES (?, ?, ?, ?)";
		return jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getFullName(), user.getRole());
	}

	public int update(User user) {
		String sql = "UPDATE users SET username = ?, password = ?, full_name = ?, role = ? WHERE id = ?";
		return jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getFullName(), user.getRole(), user.getId());
	}

	public int deleteById(Integer id) {
		String sql = "DELETE FROM users WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public User findByEmail(String email) {
		String sql = "SELECT id, username, password, full_name, email, role, created_at FROM users WHERE email = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), email);
		return users.isEmpty() ? null : users.get(0);
	}
}
