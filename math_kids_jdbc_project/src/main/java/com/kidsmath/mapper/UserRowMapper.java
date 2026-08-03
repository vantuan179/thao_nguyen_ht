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
		user.setRole(rs.getString("role"));
		user.setCreatedAt(rs.getTimestamp("created_at"));
		return user;
	}
}
