package com.kidsmath.mapper;

import com.kidsmath.model.Email;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class EmailRowMapper implements RowMapper<Email> {
	@Override
	public Email mapRow(ResultSet rs, int rowNum) throws SQLException {
		Email email = new Email();
		email.setId(rs.getInt("id"));
		email.setFromEmail(rs.getString("from_email"));
		email.setToEmail(rs.getString("to_email"));
		email.setSubject(rs.getString("subject"));
		email.setContent(rs.getString("content"));
		email.setStatus(rs.getString("status"));
		email.setType(rs.getString("type"));
		email.setSentAt(rs.getTimestamp("sent_at"));
		email.setCreatedAt(rs.getTimestamp("created_at"));
		return email;
	}
}