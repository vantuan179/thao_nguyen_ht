package com.kidsmath.dao;

import com.kidsmath.mapper.SupportMessageRowMapper;
import com.kidsmath.model.SupportMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class SupportMessageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<SupportMessage> findByTicketId(Integer ticketId) {
		String sql = "SELECT m.*, u.full_name as sender_name, u.role as sender_role " + "FROM public.support_messages m " + "LEFT JOIN public.users u ON m.sender_id = u.id " + "WHERE m.ticket_id = ? " + "ORDER BY m.created_at ASC";
		return jdbcTemplate.query(sql, new SupportMessageRowMapper(), ticketId);
	}

	public SupportMessage findById(Integer id) {
		String sql = "SELECT m.*, u.full_name as sender_name, u.role as sender_role " + "FROM public.support_messages m " + "LEFT JOIN public.users u ON m.sender_id = u.id " + "WHERE m.id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new SupportMessageRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public int save(SupportMessage message) {
		String sql = "INSERT INTO public.support_messages (ticket_id, sender_id, message) " + "VALUES (?, ?, ?)";
		return jdbcTemplate.update(sql, message.getTicketId(), message.getSenderId(), message.getMessage());
	}

	public int markAsRead(Integer messageId) {
		String sql = "UPDATE public.support_messages SET is_read = true WHERE id = ?";
		return jdbcTemplate.update(sql, messageId);
	}

	public int markAllAsRead(Integer ticketId, Integer userId) {
		String sql = "UPDATE public.support_messages SET is_read = true " + "WHERE ticket_id = ? AND sender_id != ? AND is_read = false";
		return jdbcTemplate.update(sql, ticketId, userId);
	}

	public int countUnreadByTicket(Integer ticketId, Integer userId) {
		String sql = "SELECT COUNT(*) FROM public.support_messages " + "WHERE ticket_id = ? AND sender_id != ? AND is_read = false";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, ticketId, userId);
		return count != null ? count : 0;
	}
}