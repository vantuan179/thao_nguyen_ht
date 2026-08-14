package com.kidsmath.dao;

import com.kidsmath.mapper.EmailRowMapper;
import com.kidsmath.model.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class EmailDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Email> findAll() {
		String sql = "SELECT id, from_email, to_email, subject, content, status, type, sent_at, created_at " + "FROM public.email_history ORDER BY created_at DESC";
		return jdbcTemplate.query(sql, new EmailRowMapper());
	}

	public List<Email> findRecent(int limit) {
		String sql = "SELECT id, from_email, to_email, subject, content, status, type, sent_at, created_at " + "FROM public.email_history ORDER BY created_at DESC LIMIT ?";
		return jdbcTemplate.query(sql, new EmailRowMapper(), limit);
	}

	public Email findById(Integer id) {
		String sql = "SELECT id, from_email, to_email, subject, content, status, type, sent_at, created_at " + "FROM public.email_history WHERE id = ?";
		try {
			return jdbcTemplate.queryForObject(sql, new EmailRowMapper(), id);
		} catch (Exception e) {
			return null;
		}
	}

	public List<Email> findByEmail(String email) {
		String sql = "SELECT id, from_email, to_email, subject, content, status, type, sent_at, created_at " + "FROM public.email_history WHERE to_email = ? ORDER BY created_at DESC";
		return jdbcTemplate.query(sql, new EmailRowMapper(), email);
	}

	public int save(Email email) {
		String sql = "INSERT INTO public.email_history (from_email, to_email, subject, content, status, type, sent_at) " + "VALUES (?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, email.getFromEmail(), email.getToEmail(), email.getSubject(), email.getContent(), email.getStatus() != null ? email.getStatus() : "SENT", email.getType(), email.getSentAt() != null ? email.getSentAt() : Timestamp.valueOf(LocalDateTime.now()));
	}

	public int deleteById(Integer id) {
		String sql = "DELETE FROM public.email_history WHERE id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public int countAll() {
		String sql = "SELECT COUNT(*) FROM public.email_history";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}

	public int countToday() {
		String sql = "SELECT COUNT(*) FROM public.email_history WHERE DATE(sent_at) = CURRENT_DATE";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count != null ? count : 0;
	}
}