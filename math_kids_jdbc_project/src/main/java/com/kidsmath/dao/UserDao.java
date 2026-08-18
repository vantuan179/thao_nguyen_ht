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

	// ===== FIND ALL =====
	public List<User> findAll() {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper());
	}

	// ===== FIND BY ID =====
	public User findById(Integer id) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	// ===== FIND BY USERNAME =====
	public User findByUsername(String username) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE username = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), username);
		return users.isEmpty() ? null : users.get(0);
	}

	// ===== FIND BY EMAIL =====
	public User findByEmail(String email) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE email = ?";
		List<User> users = jdbcTemplate.query(sql, new UserRowMapper(), email);
		return users.isEmpty() ? null : users.get(0);
	}

	// ===== EXISTS BY USERNAME =====
	public boolean existsByUsername(String username) {
		String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
		return count != null && count > 0;
	}

	// ===== EXISTS BY EMAIL =====
	public boolean existsByEmail(String email) {
		String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
		return count != null && count > 0;
	}

	// ===== SAVE =====
	public int save(User user) {
		String sql = "INSERT INTO users (username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		return jdbcTemplate.update(sql,
				// Thông tin đăng nhập (6)
				user.getUsername(), user.getPassword(), user.getFullName(), user.getEmail(), user.getRole() != null ? user.getRole() : "USER", user.getGradeId(),
				// Thông tin cá nhân (8)
				user.getDateOfBirth(), user.getStreet(), user.getHamlet(), user.getCommune(), user.getDistrict(), user.getProvince(), user.getPhone(), user.getGender(),
				// Thông tin thành viên (6)
				user.getAvatar(), user.getMembershipType() != null ? user.getMembershipType() : "trial", user.getMembershipStartDate(), user.getMembershipExpiryDate(), user.getMembershipStatus() != null ? user.getMembershipStatus() : "active", now);
	}

	// ===== UPDATE =====
	public int update(User user) {
		String sql = "UPDATE users SET " + "username = ?, password = ?, full_name = ?, email = ?, role = ?, grade_id = ?, " + "date_of_birth = ?, street = ?, hamlet = ?, commune = ?, district = ?, province = ?, " + "phone = ?, gender = ?, avatar = ?, " + "membership_type = ?, membership_start_date = ?, membership_expiry_date = ?, membership_status = ? " + "WHERE id = ?";
		return jdbcTemplate.update(sql,
				// Thông tin đăng nhập (6)
				user.getUsername(), user.getPassword(), user.getFullName(), user.getEmail(), user.getRole(), user.getGradeId(),
				// Thông tin cá nhân (8)
				user.getDateOfBirth(), user.getStreet(), user.getHamlet(), user.getCommune(), user.getDistrict(), user.getProvince(), user.getPhone(), user.getGender(), user.getAvatar(),
				// Thông tin thành viên (5)
				user.getMembershipType(), user.getMembershipStartDate(), user.getMembershipExpiryDate(), user.getMembershipStatus(),
				// WHERE clause
				user.getId());
	}

	// ===== DELETE BY ID =====
	public int deleteById(Integer id) {
		String sql = "DELETE FROM users WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	// ===== UPDATE LAST LOGIN =====
	public int updateLastLogin(Integer id) {
		String sql = "UPDATE users SET last_login = ? WHERE id = ?";
		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
		return jdbcTemplate.update(sql, now, id);
	}

	// ===== COUNT BY ROLE =====
	public long countByRole(String role) {
		String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, role);
		return count != null ? count : 0;
	}

	// ===== COUNT BY MEMBERSHIP TYPE =====
	public long countByMembershipType(String membershipType) {
		String sql = "SELECT COUNT(*) FROM users WHERE membership_type = ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, membershipType);
		return count != null ? count : 0;
	}

	// ===== COUNT ALL =====
	public int countAll() {
		String sql = "SELECT COUNT(*) FROM users";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}

	// ===== COUNT ACTIVE =====
	public int countActive() {
		String sql = "SELECT COUNT(*) FROM users WHERE active = true";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}

	// ===== FIND BY ROLE =====
	public List<User> findByRole(String role) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE role = ? ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper(), role);
	}

	// ===== FIND BY MEMBERSHIP TYPE =====
	public List<User> findByMembershipType(String membershipType) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE membership_type = ? ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper(), membershipType);
	}

	// ===== FIND EXPIRED MEMBERSHIPS =====
	public List<User> findExpiredMemberships() {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE membership_type = 'premium' AND membership_expiry_date < CURRENT_TIMESTAMP AND membership_status = 'active'";
		return jdbcTemplate.query(sql, new UserRowMapper());
	}

	// ===== FIND BY GRADE ID =====
	public List<User> findByGradeId(Integer gradeId) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE grade_id = ? ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper(), gradeId);
	}

	// ===== SEARCH BY USERNAME OR FULLNAME =====
	public List<User> searchByUsername(String keyword) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE LOWER(username) LIKE LOWER(?) OR LOWER(full_name) LIKE LOWER(?) ORDER BY id";
		String searchKeyword = "%" + keyword + "%";
		return jdbcTemplate.query(sql, new UserRowMapper(), searchKeyword, searchKeyword);
	}

	// ===== SEARCH BY EMAIL =====
	public List<User> searchByEmail(String email) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE LOWER(email) LIKE LOWER(?) ORDER BY id";
		String searchKeyword = "%" + email + "%";
		return jdbcTemplate.query(sql, new UserRowMapper(), searchKeyword);
	}

	// ===== FIND BY PHONE =====
	public List<User> findByPhone(String phone) {
		String sql = "SELECT id, username, password, full_name, email, role, grade_id, " + "date_of_birth, street, hamlet, commune, district, province, phone, gender, avatar, " + "membership_type, membership_start_date, membership_expiry_date, membership_status, created_at " + "FROM users WHERE phone = ? ORDER BY id";
		return jdbcTemplate.query(sql, new UserRowMapper(), phone);
	}

	// ===== UPDATE PASSWORD =====
	public int updatePassword(Integer userId, String newPassword) {
		String sql = "UPDATE users SET password = ? WHERE id = ?";
		return jdbcTemplate.update(sql, newPassword, userId);
	}

	// ===== UPDATE MEMBERSHIP =====
	public int updateMembership(Integer userId, String membershipType, Timestamp startDate, Timestamp expiryDate, String status) {
		String sql = "UPDATE users SET membership_type = ?, membership_start_date = ?, membership_expiry_date = ?, membership_status = ? WHERE id = ?";
		return jdbcTemplate.update(sql, membershipType, startDate, expiryDate, status, userId);
	}

	// ===== UPDATE GRADE =====
	public int updateGrade(Integer userId, Integer gradeId) {
		String sql = "UPDATE users SET grade_id = ? WHERE id = ?";
		return jdbcTemplate.update(sql, gradeId, userId);
	}

	// ===== UPDATE PROFILE =====
	public int updateProfile(Integer userId, String fullName, String email, String phone, String street, String hamlet, String commune, String district, String province) {
		String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, street = ?, hamlet = ?, commune = ?, district = ?, province = ? WHERE id = ?";
		return jdbcTemplate.update(sql, fullName, email, phone, street, hamlet, commune, district, province, userId);
	}
}