package com.kidsmath.mapper;

import com.kidsmath.model.SupportTicket;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SupportTicketRowMapper implements RowMapper<SupportTicket> {
	@Override
	public SupportTicket mapRow(ResultSet rs, int rowNum) throws SQLException {
		SupportTicket ticket = new SupportTicket();
		ticket.setId(rs.getInt("id"));
		ticket.setUserId(rs.getInt("user_id"));
		ticket.setSubject(rs.getString("subject"));
		ticket.setStatus(rs.getString("status"));
		ticket.setPriority(rs.getString("priority"));
		ticket.setCreatedAt(rs.getTimestamp("created_at"));
		ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
		ticket.setClosedAt(rs.getTimestamp("closed_at"));
		ticket.setUserName(rs.getString("user_name"));
		ticket.setUserEmail(rs.getString("user_email"));
		return ticket;
	}
}