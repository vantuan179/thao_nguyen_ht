package com.kidsmath.mapper;

import com.kidsmath.model.SupportMessage;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SupportMessageRowMapper implements RowMapper<SupportMessage> {
	@Override
	public SupportMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
		SupportMessage message = new SupportMessage();
		message.setId(rs.getInt("id"));
		message.setTicketId(rs.getInt("ticket_id"));
		message.setSenderId(rs.getInt("sender_id"));
		message.setMessage(rs.getString("message"));
		message.setIsRead(rs.getBoolean("is_read"));
		message.setCreatedAt(rs.getTimestamp("created_at"));
		message.setSenderName(rs.getString("sender_name"));
		message.setSenderRole(rs.getString("sender_role"));
		return message;
	}
}