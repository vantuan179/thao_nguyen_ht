package com.kidsmath.dao;

import com.kidsmath.mapper.SupportTicketRowMapper;
import com.kidsmath.model.SupportTicket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class SupportTicketDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<SupportTicket> findAll() {
		String sql = "SELECT t.*, u.full_name as user_name, u.email as user_email " + "FROM public.support_tickets t " + "LEFT JOIN public.users u ON t.user_id = u.id " + "ORDER BY t.created_at DESC";
		return jdbcTemplate.query(sql, new SupportTicketRowMapper());
	}

	public List<SupportTicket> findByUserId(Integer userId) {
		String sql = "SELECT t.*, u.full_name as user_name, u.email as user_email " + "FROM public.support_tickets t " + "LEFT JOIN public.users u ON t.user_id = u.id " + "WHERE t.user_id = ? " + "ORDER BY t.created_at DESC";
		return jdbcTemplate.query(sql, new SupportTicketRowMapper(), userId);
	}

	public List<SupportTicket> findByStatus(String status) {
		String sql = "SELECT t.*, u.full_name as user_name, u.email as user_email " + "FROM public.support_tickets t " + "LEFT JOIN public.users u ON t.user_id = u.id " + "WHERE t.status = ? " + "ORDER BY t.created_at DESC";
		return jdbcTemplate.query(sql, new SupportTicketRowMapper(), status);
	}

	public SupportTicket findById(Integer id) {
		String sql = "SELECT t.*, u.full_name as user_name, u.email as user_email " + "FROM public.support_tickets t " + "LEFT JOIN public.users u ON t.user_id = u.id " + "WHERE t.id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new SupportTicketRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public int save(SupportTicket ticket) {
		String sql = "INSERT INTO public.support_tickets (user_id, subject, status, priority) " + "VALUES (?, ?, ?, ?)";
		return jdbcTemplate.update(sql, ticket.getUserId(), ticket.getSubject(), ticket.getStatus() != null ? ticket.getStatus() : "open", ticket.getPriority() != null ? ticket.getPriority() : "normal");
	}

	public int updateStatus(Integer ticketId, String status) {
		String sql = "UPDATE public.support_tickets SET status = ?, updated_at = ? WHERE id = ?";
		return jdbcTemplate.update(sql, status, Timestamp.valueOf(LocalDateTime.now()), ticketId);
	}

	public int updatePriority(Integer ticketId, String priority) {
		String sql = "UPDATE public.support_tickets SET priority = ?, updated_at = ? WHERE id = ?";
		return jdbcTemplate.update(sql, priority, Timestamp.valueOf(LocalDateTime.now()), ticketId);
	}

	public int closeTicket(Integer ticketId) {
		String sql = "UPDATE public.support_tickets SET status = 'closed', closed_at = ?, updated_at = ? WHERE id = ?";
		return jdbcTemplate.update(sql, Timestamp.valueOf(LocalDateTime.now()), Timestamp.valueOf(LocalDateTime.now()), ticketId);
	}

	public int countUnreadByUser(Integer userId) {
		String sql = "SELECT COUNT(*) FROM public.support_messages m " + "INNER JOIN public.support_tickets t ON m.ticket_id = t.id " + "WHERE t.user_id = ? AND m.is_read = false AND m.sender_id != ?";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, userId);
		return count != null ? count : 0;
	}
}