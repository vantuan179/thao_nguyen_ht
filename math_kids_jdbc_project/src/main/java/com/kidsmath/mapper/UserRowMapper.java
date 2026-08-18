package com.kidsmath.mapper;

import com.kidsmath.model.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRowMapper implements RowMapper<User> {
	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User user = new User();
		user.setId(rs.getInt("id"));
		user.setUsername(rs.getString("username"));
		user.setPassword(rs.getString("password"));
		user.setFullName(rs.getString("full_name"));
		user.setEmail(rs.getString("email"));
		user.setRole(rs.getString("role"));

		try {
			int gradeId = rs.getInt("grade_id");
			if (!rs.wasNull()) {
				user.setGradeId(gradeId);
			}
		} catch (SQLException e) {
			user.setGradeId(null);
		}

		// Thông tin cá nhân
		user.setDateOfBirth(rs.getDate("date_of_birth"));

		// Địa chỉ theo cấu trúc mới
		user.setStreet(rs.getString("street"));
		user.setHamlet(rs.getString("hamlet"));
		user.setCommune(rs.getString("commune"));
		user.setDistrict(rs.getString("district"));
		user.setProvince(rs.getString("province"));

		user.setPhone(rs.getString("phone"));
		user.setGender(rs.getString("gender"));
		user.setAvatar(rs.getString("avatar"));

		user.setMembershipType(rs.getString("membership_type"));
		user.setMembershipStartDate(rs.getTimestamp("membership_start_date"));
		user.setMembershipExpiryDate(rs.getTimestamp("membership_expiry_date"));
		user.setMembershipStatus(rs.getString("membership_status"));
		user.setCreatedAt(rs.getTimestamp("created_at"));
		return user;
	}
}